$Extensions = @(
    "bmewburn.vscode-intelephense-client",
    "onecentlin.laravel-blade",
    "onecentlin.laravel5-snippets",
    "amiralizadeh9480.laravel-extra-intellisense",
    "esbenp.prettier-vscode",
    "eamodio.gitlens"
)

function Install-VSCodeExtensions-Win {
    if (Get-Command code -ErrorAction SilentlyContinue) {
        Write-Info "Instalando extensiones de VS Code"
        foreach ($ext in $Extensions) {
            code --install-extension $ext --force | Out-Null
            Write-Success "Extensión '$ext' instalada"
        }
    } else {
        Write-Warning "El comando 'code' no está en el PATH de Windows.
    }
}