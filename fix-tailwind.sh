#!/bin/bash
echo "Fixing Tailwind CSS setup..."

# Clean up
rm -rf node_modules package-lock.json
rm -f tailwind.config.js postcss.config.js

# Install correct versions
echo "Installing dependencies..."
npm install -D tailwindcss@3.3.6 postcss@8.4.32 autoprefixer@10.4.16
npm install @hotwired/stimulus@3.2.1 @hotwired/turbo-rails@7.3.0
npm install @tailwindcss/forms@0.5.7 @tailwindcss/typography@0.5.10

# Initialize configs
echo "Creating config files..."
npx tailwindcss init

cat > postcss.config.js << 'POSTCSS'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}
POSTCSS

# Configure tailwind
cat > tailwind.config.js << 'TAILWIND'
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/components/**/*.{rb,erb}',
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
}
TAILWIND

# Create CSS structure
mkdir -p app/assets/{stylesheets,builds}
cat > app/assets/stylesheets/application.tailwind.css << 'CSS'
@tailwind base;
@tailwind components;
@tailwind utilities;
CSS

# Update package.json scripts
cat > package.json << 'PKG'
{
  "name": "medic-bd-api",
  "private": true,
  "scripts": {
    "build:css": "tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify",
    "watch:css": "tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --watch"
  },
  "devDependencies": {
    "autoprefixer": "^10.4.16",
    "postcss": "^8.4.32",
    "tailwindcss": "^3.3.6"
  },
  "dependencies": {
    "@hotwired/stimulus": "^3.2.1",
    "@hotwired/turbo-rails": "^7.3.0",
    "@tailwindcss/forms": "^0.5.7",
    "@tailwindcss/typography": "^0.5.10"
  }
}
PKG

# Build CSS
echo "Building CSS..."
npx tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify

echo "✅ Done! Tailwind CSS v3 is now set up."
echo "Run 'npm run watch:css' to start watching for changes."
