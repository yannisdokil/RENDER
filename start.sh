#!/bin/bash
set -e

echo "=== Lampac build detected — OK ==="

# -------------------------------------------------------
# PERSISTENT DISK CACHE (Render mount)
# -------------------------------------------------------
if [ ! -d "/persistent/modules" ]; then
    echo "=== First run: cloning Ukraine modules ==="
    git clone https://github.com/lampac-ukraine/lampac-ukraine.git /persistent/modules
else
    echo "=== Updating Ukraine modules ==="
    cd /persistent/modules
    git pull || true
fi

echo "=== Copying modules to runtime ==="
rm -rf /app/module
mkdir -p /app/module
cp -r /persistent/modules/* /app/module/

echo "=== Starting Lampac ==="
cd /app
exec dotnet Lampac.dll
