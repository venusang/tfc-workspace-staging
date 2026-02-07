# Connecting Workspace to GitHub

## Step 1: Get your OAuth Token ID

First, you need to find your GitHub OAuth token ID. Run this command:

```bash
# List all OAuth clients for your organization
terraform console
```

Then in the console, type:
```
data.tfe_oauth_client.github
```

Or use the TFC CLI/API to find it, or add this data source to your code temporarily:

```hcl
data "tfe_oauth_client" "github" {
  organization     = var.organization
  service_provider = "github"
}

output "github_oauth_token_id" {
  value = data.tfe_oauth_client.github.oauth_token_id
}
```

## Step 2: Update terraform.tfvars

Add these lines to your `terraform.tfvars`:

```hcl
vcs_repo_identifier = "hashicorp/your-repo-name"  # Change to your repo
vcs_oauth_token_id  = "ot-xxxxx"                  # Get from Step 1
vcs_branch          = "main"                       # Optional: specify branch
```

## Step 3: Apply

```bash
terraform apply
```

## Alternative: Find OAuth Token ID in the UI

1. Go to https://app.terraform.io
2. Navigate to your organization settings
3. Click "VCS Providers"
4. Find your GitHub connection
5. The OAuth Token ID will be shown there (starts with "ot-")
