# ============================================
# Suspend Multiple Users in 1Password via CLI
# ============================================
# Requires:
# 1. 1Password CLI installed
# 2. Signed in using: op signin
# 3. Admin permissions

$Users = @(
    "user1@company.com",
    "user2@company.com",
    "user3@company.com"
)

foreach ($User in $Users) {
    Write-Host "Suspending $User ..." -ForegroundColor Yellow
    try {
        $UserObj = op user get $User --format json | ConvertFrom-Json

        if (-not $UserObj) {
            Write-Host "User $User not found in 1Password. Skipping." -ForegroundColor Red
            continue
        }

        op user suspend $UserObj.id
        Write-Host "$User suspended successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to suspend $User : $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Bulk suspension completed." -ForegroundColor Cyan
