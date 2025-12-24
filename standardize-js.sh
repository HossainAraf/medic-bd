#!/bin/bash

echo "Standardizing JavaScript structure..."

# Check current setup
if [ -d "app/assets/javascript" ] && [ ! -d "app/javascript" ]; then
  echo "Migrating from app/assets/javascript to app/javascript..."
  mkdir -p app/javascript
  mv app/assets/javascript/* app/javascript/ 2>/dev/null || true
  rm -rf app/assets/javascript
  
  # Update manifest
  cat > app/assets/config/manifest.js << 'MANIFEST'
//= link_tree ../images
//= link application.css
//= link_tree ../../javascript .js
MANIFEST
  
elif [ -d "app/javascript" ] && [ -d "app/assets/javascript" ]; then
  echo "Both directories exist. Merging..."
  cp -r app/assets/javascript/* app/javascript/ 2>/dev/null || true
  rm -rf app/assets/javascript
  
  # Update manifest
  cat > app/assets/config/manifest.js << 'MANIFEST'
//= link_tree ../images
//= link application.css
//= link_tree ../../javascript .js
MANIFEST
  
else
  echo "Using app/javascript (modern convention)"
  
  # Ensure directory exists
  mkdir -p app/javascript/controllers
  
  # Update manifest
  cat > app/assets/config/manifest.js << 'MANIFEST'
//= link_tree ../images
//= link application.css
//= link_tree ../../javascript .js
MANIFEST
fi

echo "✅ Done! JavaScript is now in app/javascript/"
