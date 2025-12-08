# Branch Protection Setup Guide

This guide explains how to configure GitHub branch protection rules to prevent merging to the `build` branch while workflows are running.

## Overview

The repository now has three GitHub Actions workflows:

1. **CI Workflow** (`.github/workflows/ci.yml`): Runs on pull requests to validate code quality and builds
2. **Check Build Branch Status** (`.github/workflows/check-build-branch.yml`): Prevents merging if any workflows are running on the `build` branch
3. **Release Workflow** (`.github/workflows/release.yml`): Runs on pushes to `build` branch to create releases

## Setting Up Branch Protection Rules

Follow these steps to require CI checks before merging to the `build` branch:

### Step 1: Navigate to Branch Protection Settings

1. Go to your GitHub repository
2. Click on **Settings** (top navigation)
3. In the left sidebar, click **Branches** (under "Code and automation")
4. Under "Branch protection rules", click **Add rule** or **Add branch protection rule**

### Step 2: Configure Protection for 'build' Branch

1. **Branch name pattern**: Enter `build`

2. **Protect matching branches** - Enable these settings:

   ✅ **Require a pull request before merging**
   - This ensures all changes go through PR review
   - Optional: Set "Require approvals" to 1 or more if you want human review

   ✅ **Require status checks to pass before merging**
   - This is the key setting that blocks merging until CI passes
   - Enable: **Require branches to be up to date before merging**
   
   ✅ **Status checks that are required** - Add these checks:
   - `test` (from CI workflow)
   - `build_check` (from CI workflow)
   - `all_checks_passed` (from CI workflow)
   - `check_running_workflows` (from Check Build Branch Status workflow)
   - `check_queued_workflows` (from Check Build Branch Status workflow)
   - `all_clear` (from Check Build Branch Status workflow)
   
   > **Note**: These status checks will only appear in the list after the workflows have run at least once. Create a test PR first if they don't show up.

   ✅ **Require conversation resolution before merging** (Optional)
   - Ensures all PR comments are resolved

   ✅ **Do not allow bypassing the above settings** (Recommended)
   - Prevents admins from bypassing these rules
   - Uncheck if you need emergency override capability

3. Click **Create** or **Save changes**

### Step 3: Test the Configuration

1. Create a new branch from `main` or `develop`:
   ```bash
   git checkout -b test-branch-protection
   ```

2. Make a small change (e.g., update README.md)

3. Commit and push:
   ```bash
   git add .
   git commit -m "test: verify branch protection"
   git push origin test-branch-protection
   ```

4. Create a pull request targeting the `build` branch

5. Observe that:
   - The CI workflow starts automatically
   - The merge button is disabled with message "Merging is blocked"
   - After CI completes successfully, the merge button becomes enabled
   - If CI fails, the merge button remains disabled

## Workflow Details

### CI Workflow (`.github/workflows/ci.yml`)

Validates code quality and builds on pull requests:

**1. Test Job**
- Checks out code
- Sets up Flutter
- Runs `dart format --set-exit-if-changed` (formatting check)
- Runs `flutter analyze` (static analysis)
- Runs `flutter test` (unit tests)

**2. Build Check Job**
- Validates that the app can build successfully
- Builds APK for Android
- Builds Web version
- Uses test environment variables (no secrets needed)

**3. All Checks Passed Job**
- Final gate that ensures all previous jobs succeeded

### Check Build Branch Status (`.github/workflows/check-build-branch.yml`)

**Purpose**: Prevents merging when workflows are running on the `build` branch

This is the **key workflow** that addresses your requirement: it blocks merging if any workflows are currently running or queued on the `build` branch.

**1. Check Running Workflows Job**
- Uses GitHub API to query all workflows with status `in_progress` on the `build` branch
- Excludes the current check itself
- **Fails if any workflows are running**, displaying their names and links
- **Passes if no workflows are running**

**2. Check Queued Workflows Job**
- Uses GitHub API to query all workflows with status `queued` on the `build` branch
- Excludes the current check itself
- **Fails if any workflows are queued**, displaying their names and links
- **Passes if no workflows are queued**

**3. All Clear Job**
- Final gate that ensures both checks passed
- Only succeeds when no workflows are running or queued on `build` branch

### How It Works

**Scenario 1: Release workflow is running on `build` branch**
1. Someone opens a PR to merge into `build`
2. The "Check Build Branch Status" workflow runs
3. It detects the release workflow is in progress
4. ❌ The check **fails** with message: "Cannot merge: 1 workflow(s) currently running on 'build' branch"
5. ❌ Merge button is **disabled**
6. ✅ After the release workflow completes, the check can be re-run and will pass

**Scenario 2: No workflows running on `build` branch**
1. Someone opens a PR to merge into `build`
2. The "Check Build Branch Status" workflow runs
3. It finds no running or queued workflows on `build`
4. ✅ The check **passes** with message: "All clear: no workflows running on build branch"
5. ✅ Merge button becomes **enabled** (if all other checks also pass)

**Scenario 3: Multiple PRs trying to merge simultaneously**
1. First PR merges → triggers release workflow on `build`
2. Second PR's check detects the running release workflow
3. ❌ Second PR's merge is **blocked** until first release completes
4. This prevents conflicts and ensures releases happen sequentially

## What Happens When Checks Fail?

**If CI checks fail:**
1. ❌ The merge button will be **disabled**
2. ❌ A red X appears next to the failed check
3. ❌ GitHub shows "All checks have failed" or "Some checks were not successful"
4. ✅ You can click "Details" to see the failure logs
5. ✅ Fix the issue, commit, and push - checks will re-run automatically

**If workflows are running on `build` branch:**
1. ❌ The "Check Build Branch Status" check **fails**
2. ❌ Error message shows which workflows are running with links
3. ❌ Merge button is **disabled**
4. ⏳ Wait for the running workflows to complete
5. ✅ Re-run the check (or push a new commit to trigger it)
6. ✅ Once workflows complete, the check will pass

## What Happens When All Checks Pass?

If all checks pass AND no workflows are running on `build`:

1. ✅ Green checkmarks appear next to all checks
2. ✅ GitHub shows "All checks have passed"
3. ✅ The merge button becomes **enabled**
4. ✅ You can now safely merge the PR to the `build` branch
5. ✅ After merge, the Release workflow automatically runs
6. 🔒 Any subsequent PRs will be blocked until this release completes

## Additional Recommendations

### For the 'main' or 'develop' Branch

Consider applying similar protection rules to your main development branches:

1. Require pull requests
2. Require CI checks to pass
3. Require 1+ approvals for production branches
4. Enable "Require linear history" to keep clean git history

### For Better CI Performance

1. **Enable caching**: The CI workflow already caches Flutter and pub dependencies
2. **Parallel jobs**: Test and build_check run in parallel for faster feedback
3. **Fail fast**: CI fails immediately on first error to save time

### Notifications

Configure GitHub notifications to alert you when:
- CI checks fail on your PRs
- PRs are ready for review (all checks passed)
- Someone requests your review

Go to: **Settings** → **Notifications** → **Actions**

## Troubleshooting

### "Required status checks not found"

**Problem**: The status checks don't appear in the branch protection settings.

**Solution**: 
1. The CI workflow must run at least once before checks appear
2. Create a test PR to trigger the workflow
3. After it runs, the checks will be available in the dropdown

### "Merge button still enabled despite failing checks"

**Problem**: Branch protection isn't working.

**Solution**:
1. Verify the branch name pattern is exactly `build`
2. Ensure "Require status checks to pass before merging" is checked
3. Confirm the correct status checks are selected
4. Check if "Do not allow bypassing" is enabled

### "CI workflow not triggering"

**Problem**: Opening a PR doesn't start the workflows.

**Solution**:
1. Check that workflow files exist in the base branch:
   - `.github/workflows/ci.yml`
   - `.github/workflows/check-build-branch.yml`
2. Verify workflows have `pull_request` trigger for the `build` branch
3. Check GitHub Actions are enabled: **Settings** → **Actions** → **General**

### "Check says workflows are running but I don't see any"

**Problem**: The check fails saying workflows are running, but you don't see them.

**Solution**:
1. Go to the **Actions** tab in your repository
2. Filter by branch: `build`
3. Look for workflows with status "In progress" or "Queued"
4. These might be:
   - Release workflows from a recent merge
   - Stuck workflows that need to be cancelled
   - Workflows triggered by automated commits (like version bumps)
5. Wait for them to complete or cancel them if they're stuck

### "I need to merge urgently but workflows are running"

**Problem**: Emergency fix needed but release workflow is blocking merge.

**Solution**:
1. **Option 1 (Recommended)**: Wait for the workflow to complete
2. **Option 2**: Cancel the running workflow:
   - Go to **Actions** tab
   - Find the running workflow
   - Click "Cancel workflow"
   - Re-run the check on your PR
3. **Option 3**: Temporarily disable branch protection (not recommended):
   - Only for true emergencies
   - Remember to re-enable it after merging

## Summary

With branch protection configured:

✅ **Before**: Anyone could merge to `build` without checks  
✅ **After**: Merges blocked until all checks pass  

✅ **Before**: Multiple merges could trigger conflicting releases  
✅ **After**: Only one release runs at a time  

✅ **Before**: Broken code could reach production  
✅ **After**: Code quality validated before merge  

✅ **Before**: Manual coordination needed to avoid conflicts  
✅ **After**: Automatic prevention of concurrent releases  

✅ **Before**: Manual testing required  
✅ **After**: Automated testing on every PR  

This ensures:
1. The `build` branch always contains working, tested code
2. Releases happen sequentially without conflicts
3. No merge can happen while a release is in progress
4. Clear feedback when merging is blocked and why
