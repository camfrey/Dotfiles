$ErrorActionPreference = "Stop"

$CONFIG_DIR="configs"
$CONFIG="${CONFIG_DIR}/install_win.conf.yaml"
$DOTBOT_DIR="dotbot"

$DOTBOT_BIN = "bin/dotbot"
$BASEDIR = $PSScriptRoot

Set-Location $BASEDIR

git submodule update --init --recursive
foreach ($PYTHON in ('python', 'python3')) {
    # Python redirects to Microsoft Store in Windows 10 when not installed
    if (& { $ErrorActionPreference = "SilentlyContinue"
            ![string]::IsNullOrEmpty((&$PYTHON -V))
            $ErrorActionPreference = "Stop" }) {
        &$PYTHON $(Join-Path $BASEDIR -ChildPath $DOTBOT_DIR | Join-Path -ChildPath $DOTBOT_BIN) -d $BASEDIR -c $CONFIG $Args
        return
    }
}
Write-Error "Error: Cannot find Python."
