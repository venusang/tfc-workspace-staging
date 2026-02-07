variable "organization" {
  type        = string
  description = "Terraform Cloud organization name (in staging)"
}

variable "workspace_name" {
  type        = string
  description = "Workspace name to create"
}

variable "project_name" {
  type        = string
  description = "Optional: existing Project name to place the workspace into"
  default     = null
}

variable "vcs_repo_identifier" {
  type        = string
  description = "GitHub repository identifier (format: 'owner/repo')"
  default     = null
}

variable "vcs_oauth_token_id" {
  type        = string
  description = "OAuth token ID for GitHub VCS connection"
  default     = null
}

variable "vcs_branch" {
  type        = string
  description = "Git branch to track (defaults to repo's default branch)"
  default     = null
}
