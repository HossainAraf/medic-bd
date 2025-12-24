#!/bin/bash
echo "Testing Tailwind CSS build..."

# Clean previous builds
rm -f app/assets/builds/test.css

# Try to build
node ./node_modules/tailwindcss/lib/cli.js -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/test.css 2>&1

# Check result
if [ -f "app/assets/builds/test.css" ]; then
  echo "✅ SUCCESS! CSS file created."
  echo "File size: $(wc -l < app/assets/builds/test.css) lines"
  
  # Check for Tailwind content
  if grep -q "\.container" app/assets/builds/test.css; then
    echo "✅ Contains Tailwind utility classes"
  fi
  if grep -q "\.test-red" app/assets/builds/test.css; then
    echo "✅ Contains custom test class"
  fi
  
  # Show first 5 lines
  echo "First 5 lines:"
  head -5 app/assets/builds/test.css
else
  echo "❌ FAILED: CSS file not created"
  echo "Check the error output above"
fi
