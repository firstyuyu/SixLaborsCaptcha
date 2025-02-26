#!/bin/bash

PROJECT_NAME=SixLaborsCaptcha.Mvc.Core

PAKCAGE_ID=$(cat $PROJECT_NAME.csproj | egrep 'PackageId' | sed -E 's/^.+<.+>([^<]+).+/\1/g')
VERSION=$(cat $PROJECT_NAME.csproj | egrep '<Version>' | sed -E 's/^.+<.+>([^<]+).+/\1/g')

echo "NuGet API Key: "
read -s API_KEY

echo "Building the project..."
dotnet build --configuration Release

if [[ $? -gt 0 ]]; then
    exit $?
fi

echo ""
echo "Publishing the library to NuGet"
cd bin/Release
dotnet nuget push "$PAKCAGE_ID.$VERSION.nupkg" -k $API_KEY -s https://api.nuget.org/v3/index.json
cd ../..