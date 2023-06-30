$PSStyle.FileInfo.Directory = "`e[38;2;255;255;255m"

function prompt {
    $path = Get-Location
    $directory = Split-Path -Leaf $path
    $gitBranch = & git rev-parse --abbrev-ref HEAD 2>$null
    $gitStatus = & git status --porcelain 2>$null

    $promptColor = "White"
    $directoryColor = "Cyan"
    $gitBranchColor = "Yellow"
    $gitStatusColor = "Red"

    $promptString = "$directory"

    if ($gitBranch) {
        $promptString += " <$gitBranch>"
        if ($gitStatus) {
            $unsavedChanges = ($gitStatus | Measure-Object).Count
            $promptString += " [$unsavedChanges]"
        }
    }

    $promptColorCode = "1;$([int]($promptColor -as [System.ConsoleColor]))"
    $directoryColorCode = "1;$([int]($directoryColor -as [System.ConsoleColor]))"
    $gitBranchColorCode = "1;$([int]($gitBranchColor -as [System.ConsoleColor]))"
    $gitStatusColorCode = "1;$([int]($gitStatusColor -as [System.ConsoleColor]))"

    $promptString = "`e[0;${promptColorCode}m`n`n$promptString"
    $promptString += "`e[0;${promptColorCode}m # `e[0m"

    Write-Host -NoNewLine $promptString

    return " "
}
