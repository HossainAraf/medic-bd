#!/usr/bin/env node
const { execSync } = require('child_process');
const fs = require('fs');

console.log('Building CSS with Tailwind...');

const inputFile = './app/assets/stylesheets/application.tailwind.css';
const outputFile = './app/assets/builds/application.css';

// Check if input file exists
if (!fs.existsSync(inputFile)) {
  console.error(`Error: Input file ${inputFile} not found!`);
  process.exit(1);
}

// Create output directory if it doesn't exist
const outputDir = './app/assets/builds';
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

try {
  // Try different command formats
  let command;
  
  // Option 1: Direct node execution
  command = `node ./node_modules/tailwindcss/lib/cli.js -i ${inputFile} -o ${outputFile}`;
  
  console.log(`Executing: ${command}`);
  execSync(command, { stdio: 'inherit' });
  
  console.log(`✅ CSS built successfully: ${outputFile}`);
  
} catch (error) {
  console.error('Failed with direct CLI, trying alternative...');
  
  // Option 2: Use the Tailwind API directly
  const tailwind = require('tailwindcss');
  const postcss = require('postcss');
  const autoprefixer = require('autoprefixer');
  const fs = require('fs');
  
  const css = fs.readFileSync(inputFile, 'utf8');
  const config = require('../tailwind.config.js');
  
  postcss([tailwind(config), autoprefixer])
    .process(css, { from: inputFile, to: outputFile })
    .then(result => {
      fs.writeFileSync(outputFile, result.css);
      console.log(`✅ CSS built using API: ${outputFile}`);
    })
    .catch(err => {
      console.error('API build failed:', err.message);
      process.exit(1);
    });
}
