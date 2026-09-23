use anyhow::{Context, Error, Result, anyhow};
use clap::Parser;
use indexmap::IndexSet;
use std::env;
use std::os::unix::prelude::CommandExt;
use std::process::Command;

#[derive(Parser, Debug)]
struct Cli {
    /// The application or binary to run
    app: String,

    /// Arguments to forward to the target binary
    #[arg(trailing_var_arg = true, allow_hyphen_values = true)]
    args: Vec<String>,
}

fn main() -> Result<()> {
    let cli = Cli::parse();

    // Get image / env
    let image = env::var("SANDBOX_IMAGE").with_context(|| anyhow!("No SANDBOX_IMAGE specified"))?;
    let env = get_env_list("SANDBOX_ENV");

    // Get path_ro and path_rw
    let mut path_ro = get_path("", &cli.app);
    let mut path_rw = get_path("_RW", &cli.app);
    path_ro.retain(|path| !path_rw.contains(path)); // Ensure that path_rw entries are not in path_ro

    // Get cwd
    let cwd = env::current_dir()
        .with_context(|| anyhow!("Failed to get current directory"))?
        .to_string_lossy()
        .into_owned();

    // Remove cwd from path_ro and insert into path_rw
    path_ro.shift_remove(&cwd);
    path_rw.insert(cwd.clone());

    // Build basic podman args
    let mut podman_args = vec![
        "run".into(),
        "--rm".into(),
        "-it".into(),
        "--userns=keep-id".into(),
        "--security-opt=label=disable".into(),
        "--cap-drop=ALL".into(),
        "--security-opt=no-new-privileges".into(),
        "--pids-limit=2048".into(),
        format!("--workdir={cwd}"),
    ];

    // Add environment variables to podman args
    for key in env {
        podman_args.push(format!("--env={key}"));
    }

    // Add mounts to podman args
    for path in path_ro {
        podman_args.push("-v".into());
        podman_args.push(format!("{path}:{path}:ro"));
    }
    for path in path_rw {
        podman_args.push("-v".into());
        podman_args.push(format!("{path}:{path}:rw"));
    }

    // Add entrypoint, image name, and args to podman args
    podman_args.push(format!("--entrypoint={}", cli.app));
    podman_args.push(image.clone());
    podman_args.extend(cli.args);

    if env::var("SANDBOX_DRY_RUN").is_ok() {
        println!("podman {}", podman_args.join(" "));
        return Ok(());
    }

    Err(
        Error::from(Command::new("podman").args(podman_args.into_iter()).exec())
            .context("Failed to spawn podman command"),
    )
}

fn get_path(suffix: &str, app: &str) -> IndexSet<String> {
    let app = app.replace("-", ".");
    let mut result = get_env_list(&format!("SANDBOX_PATH{suffix}"));
    result.extend(get_env_list(&format!("SANDBOX_PATH{suffix}_{app}")));
    result
        .into_iter()
        .map(|s| shellexpand::tilde(&s).to_string())
        .collect()
}

fn get_env_list(var: &str) -> IndexSet<String> {
    env::var(var)
        .unwrap_or_default()
        .split(':')
        .filter(|s| !s.is_empty())
        .map(ToString::to_string)
        .collect()
}
