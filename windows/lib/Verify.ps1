function Test-DevCommand ($cmd, $name) {
    if (Get-Command $cmd -ErrorAction SilentlyContinue) {
        Write-Success "$name está disponible"
    } else {
        Write-Error-Msg "$name NO está instalado o no está en el PATH"
    }
}

function Verify-WindowsEnvironment {
    Test-DevCommand "git" "Git"
    Test-DevCommand "php" "PHP"
    Test-DevCommand "composer" "Composer"
    Test-DevCommand "node" "Node.js"
    Test-DevCommand "npm" "NPM"
}