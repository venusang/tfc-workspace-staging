# Optional: look up a Project by name (only used if project_name is provided)
data "tfe_project" "target" {
  count        = var.project_name == null ? 0 : 1
  organization = var.organization
  name         = var.project_name
}

resource "tfe_workspace" "this" {
  organization = var.organization
  name         = var.workspace_name

  # If you provided project_name, attach the workspace to that Project
  project_id = var.project_name == null ? null : data.tfe_project.target[0].id

  description    = "Created via Terraform (staging)"
  auto_apply     = false
  queue_all_runs = true

  # Connect to GitHub repository
  vcs_repo {
    identifier     = var.vcs_repo_identifier # e.g., "hashicorp/my-repo"
    oauth_token_id = var.vcs_oauth_token_id
    branch         = var.vcs_branch # Optional: defaults to the repo's default branch
  }
}
