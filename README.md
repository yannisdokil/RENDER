# Lampac Render Deployment

Ready-to-deploy version for Render.com  
Clones Lampac dynamically at startup, updates UA modules, caches them on Render Disk.

## Deploy steps

1. Create Repo: `lampac-render`
2. Upload:
   - Dockerfile
   - start.sh
   - README.md
3. Go to Render → New Web Service
4. Connect repository
5. Add Disk:

6. Deploy

The service will:
- Download Lampac on each start
- Build it
- Clone/update Ukrainian modules
- Start server on port 8080
