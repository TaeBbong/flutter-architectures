# Flutter Architectures Monorepo

This repository is the single Git remote for multiple Flutter architecture samples. Each project lives in its own directory and is tracked as a `git subtree`, which preserves its history while letting everything share one remote.

## Repository Layout

- `riverpod_data_fetch/` – imported via `git subtree` from the original standalone repo (history retained).
- Future projects will be added in sibling directories using the same subtree workflow.

## Daily Workflow

1. Check the current status and history:
   ```bash
   git status -sb
   git log --oneline --graph --decorate --max-count=20
   ```
2. Stage, commit, and push changes from any subproject:
   ```bash
   git add .
   git commit -m "<meaningful message>"
   git push -u origin main
   ```
3. Pull updates from the remote:
   ```bash
   git pull --rebase origin main
   ```

## Adding a New Subproject as a Subtree

Assuming the new project already exists as a separate Git repository (locally or remotely):

1. Add a temporary remote that points to the standalone project:
   ```bash
   git remote add <alias> <path-or-url>
   git fetch <alias> <branch>
   ```
2. Make sure no directory with the same name exists in the monorepo. If it does, move or remove it temporarily.
3. Import the project history into a subdirectory:
   ```bash
   git subtree add --prefix=<directory-name> <alias>/<branch>
   ```
4. Remove the temporary remote (optional but keeps the config tidy):
   ```bash
   git remote remove <alias>
   ```

## Updating an Existing Subtree from Its Source

If you need to sync with upstream changes:

1. Re-add the remote if it was removed and fetch the latest branch:
   ```bash
   git remote add <alias> <path-or-url>   # skip if already present
   git fetch <alias> <branch>
   ```
2. Merge the updates into the subdirectory:
   ```bash
   git subtree pull --prefix=<directory-name> <alias> <branch>
   ```
3. Commit and push the merge if needed (Git handles the commit automatically, but you still need to push).

## Exporting a Subtree Back Out

If someone else needs a standalone repository containing only one subproject:

```bash
git subtree split --prefix=<directory-name> -b <temp-branch>
git push <new-remote> <temp-branch>:<target-branch>
git branch -D <temp-branch>          # optional cleanup
```

## Useful Tips

- Run `git remote -v` to verify which remotes are configured.
- Use `git subtree --help` for detailed documentation on advanced options.
- Keep commit messages scoped to the project or change you touched; subtree merges will add their own summary lines.
- If conflicts occur during a subtree pull, resolve them within the subdirectory, stage the fixes, and continue with `git commit`.

With this workflow, every project keeps its own history, while contributors only need to interact with a single remote repository.
