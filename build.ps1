# require 3.0

param(
    # What do you want to run
    [Parameter(Mandatory=$true)]
    [string]
    [ValidateSet('Setup', 'Build', 'UnitTests', 'IntegrationTests', 'Package')]
    $Target
)

$fakeDir = ".fake"

if ($Target -eq 'Setup') {
    $toolsDir = "tools"
    $nuget = "$toolsDir\nuget.exe"
    . $nuget "Install" "xunit.runner.console" "-OutputDirectory" $toolsDir "-ExcludeVersion" -Version 2.2.0
    . $nuget "Install" OpenCover -Version 4.6.519 -ExcludeVersion "-OutputDirectory" $toolsDir
    dotnet tool install fake-cli --tool-path ./$fakeDir
} else {
    . "$fakeDir/fake.exe" run ./build.fsx target $Target
}
