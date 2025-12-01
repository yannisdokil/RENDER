#!/bin/bash
set -e

echo "=== Fetching Lampac source ==="

rm -rf /app/lampac
mkdir -p /app/lampac

wget -O /app/lampac.zip https://github.com/lampame/lampac/archive/refs/heads/main.zip

echo "=== Unzipping ==="
unzip /app/lampac.zip -d /app/
mv /app/lampac-main /app/lampac
rm /app/lampac.zip

echo "=== Building Lampac ==="
cd /app/lampac
dotnet publish Lampac.csproj -c Release -o /app/run

# ============================
# MODULE CACHE ON RENDER DISK
# ============================

if [ ! -d "/persistent/modules" ]; then
    echo "=== First download of UA modules ==="
    git clone https://github.com/lampac-ukraine/lampac-ukraine.git /persistent/modules
else
    echo "=== Updating UA modules ==="
    cd /persistent/modules
    git pull || true
fi

echo "=== Copying modules ==="
rm -rf /app/run/module
mkdir -p /app/run/module
cp -r /persistent/modules/* /app/run/module/

echo "=== Starting Lampac ==="
cd /app/run
exec dotnet Lampac.dll
