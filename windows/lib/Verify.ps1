function Test-DevCommand ($cmd, $name, $expectedVersion) {
    if (Get-Command $cmd -ErrorAction SilentlyContinue) {
        $ver = ""
        try {
            switch ($cmd) {
                "git" { $ver = (git --version 2>$null) }
                "php" { $ver = (php -v 2>$null | Select-Object -First 1) }
                "composer" { $ver = (composer --version 2>$null | Select-Object -First 1) }
                "node" { $ver = (node -v 2>$null) }
                "npm" { $ver = (npm -v 2>$null) }
                Default { $ver = "" }
            }
        } catch {
            $ver = ""
        }

        if ($expectedVersion) {
            Write-Success "$name está instalado: $ver (Requerida: $expectedVersion)"
        } else {
            Write-Success "$name está instalado: $ver"
        }
    } else {
        Write-Error-Msg "$name NO está instalado o no está en el PATH"
    }
}

function Verify-WindowsEnvironment {
    Test-DevCommand "git" "Git" $global:GIT_REQUIRED_VERSION
    Test-DevCommand "php" "PHP" $global:PHP_REQUIRED_VERSION
    Test-DevCommand "composer" "Composer" $global:COMPOSER_REQUIRED_VERSION
    Test-DevCommand "node" "Node.js" $global:NODE_REQUIRED_VERSION
    Test-DevCommand "npm" "NPM" $global:NPM_REQUIRED_VERSION
}