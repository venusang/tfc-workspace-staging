# Session Notes - TFC Workspace Setup

## Issues Resolved

### 1. Terraform Version Conflict
**Problem:** Terraform 1.0.11 installed, but project requires >= 1.5.0

**Solution:**
- Installed `tfenv` for version management: `brew install tfenv`
- Created `.terraform-version` file with `1.5.0`
- Updated `~/.zshrc` to prioritize tfenv in PATH:
  ```bash
  export PATH="/opt/homebrew/opt/tfenv/bin:$PATH"
  ```
- tfenv now automatically uses correct version per-project

**Key Insight:** The issue was that `/Users/vang/cloud-makefiles/bin/terraform` was ahead of tfenv in PATH. Adding tfenv to the front of PATH fixed it.

## What Was Built

### Workspace Management Code
Created Terraform configuration to manage TFC workspaces:

**Files:**
- `main.tf` - Workspace resource with optional VCS connection
- `variables.tf` - Input variables including VCS settings
- `versions.tf` - Terraform and provider version requirements
- `provider.tf` - TFE provider configuration
- `terraform.tfvars` - Your actual values (gitignored)
- `terraform.tfvars.example` - Template for others
- `.terraform-version` - Ensures Terraform 1.5.0 is used
- `.gitignore` - Protects sensitive files

### GitHub Integration Added

The workspace can now connect to a GitHub repository via VCS.

**Variables added:**
```hcl
vcs_repo_identifier = "owner/repo-name"  # The repo to connect to
vcs_oauth_token_id  = "ot-xxxxx"         # OAuth token from TFC
vcs_branch          = "main"              # Optional: specific branch
```

**To connect workspace to a GitHub repo:**

1. **Get OAuth Token ID** (one of these methods):
   - Run the helper: `terraform apply` with `oauth-lookup.tf` in place
   - Or find in TFC UI: Settings → VCS Providers → GitHub → Token ID
   - Or use TFC API

2. **Update terraform.tfvars:**
   ```hcl
   vcs_repo_identifier = "venusang/my-infrastructure-repo"
   vcs_oauth_token_id  = "ot-xxxxx"
   vcs_branch          = "main"  # optional
   ```

3. **Apply changes:**
   ```bash
   terraform apply
   ```

## Repository Created

**GitHub Repo:** https://github.com/venusang/tfc-workspace-staging

This repo contains the workspace management code (meta-level).

**Important:** This is NOT the repo your workspace will connect to. This is the code that *creates* the workspace. You'll need a separate repo for your actual infrastructure code.

## Next Steps

1. **Create or identify infrastructure repo**
   - Create a new repo for your Terraform infrastructure code, OR
   - Use an existing repo with Terraform configurations

2. **Set up OAuth connection in TFC**
   - If not already done, connect GitHub to your TFC organization
   - Settings → VCS Providers → Add VCS Provider

3. **Get OAuth Token ID**
   - Use the `oauth-lookup.tf` helper or check TFC UI

4. **Connect workspace to repo**
   - Update `terraform.tfvars` with VCS settings
   - Run `terraform apply`

5. **Clean up helper file** (optional)
   ```bash
   rm oauth-lookup.tf
   git add .
   git commit -m "Remove OAuth lookup helper"
   ```

## Useful Commands

```bash
# Check Terraform version
terraform version

# Switch Terraform version (if needed)
tfenv install 1.6.0
tfenv use 1.6.0

# Apply workspace changes
terraform apply

# See current workspace in TFC
# Go to: https://app.terraform.io/app/venus-org-oct182025/workspaces
```

## tfenv Tips

- Place `.terraform-version` in any project to auto-switch versions
- `tfenv list` - See installed versions
- `tfenv install <version>` - Install a specific version
- `tfenv use <version>` - Switch global version

## Troubleshooting

**If terraform still shows old version:**
1. Close and reopen terminal
2. Or run: `source ~/.zshrc`
3. Verify: `which terraform` should show `/opt/homebrew/opt/tfenv/bin/terraform`
