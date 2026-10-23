#!/bin/bash

# GitHub Pages Vite React Setup Script
# Usage: ./setup.sh YOUR_REPO_NAME

set -e

REPO_NAME="$1"

if [ -z "$REPO_NAME" ]; then
    echo "❌ Usage: ./setup.sh YOUR_REPO_NAME"
    echo "   Example: ./setup.sh QuizForge"
    exit 1
fi

echo "🚀 Setting up GitHub Pages deployment for: $REPO_NAME"

# Create .github/workflows directory
echo "📁 Creating workflow directory..."
mkdir -p .github/workflows

# Copy and configure deploy.yml
echo "⚙️  Setting up deployment workflow..."
cp "$(dirname "$0")/deploy.yml" .github/workflows/deploy.yml

# Configure vite.config.ts
echo "🔧 Configuring Vite..."
cp "$(dirname "$0")/vite.config.ts" vite.config.ts.new
sed -i "s/YOUR_REPO_NAME/$REPO_NAME/g" vite.config.ts.new

if [ -f "vite.config.ts" ]; then
    echo "⚠️  vite.config.ts already exists. New config saved as vite.config.ts.new"
    echo "   Please manually merge the base path configuration:"
    echo "   base: '/$REPO_NAME/',"
else
    mv vite.config.ts.new vite.config.ts
    echo "✅ Created vite.config.ts"
fi

# Add .gitattributes
echo "📝 Adding .gitattributes..."
cp "$(dirname "$0")/.gitattributes" .gitattributes

# Update package.json homepage
if [ -f "package.json" ]; then
    echo "📦 Updating package.json homepage..."
    if command -v jq > /dev/null; then
        jq ".homepage = \"https://eskinder185.github.io/$REPO_NAME\"" package.json > package.json.tmp
        mv package.json.tmp package.json
        echo "✅ Updated package.json homepage"
    else
        echo "⚠️  jq not found. Please manually add to package.json:"
        echo "   \"homepage\": \"https://eskinder185.github.io/$REPO_NAME\""
    fi
else
    echo "⚠️  package.json not found. Please create it with the template."
fi

# Optional: Copy 404.html for SPA routing
read -p "🤔 Does your app use client-side routing? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp "$(dirname "$0")/404.html" public/404.html
    sed -i "s/YOUR_REPO_NAME/$REPO_NAME/g" public/404.html
    echo "✅ Added 404.html for SPA routing"
fi

echo ""
echo "🎉 Setup complete! Next steps:"
echo ""
echo "1. 📋 Review and commit these changes:"
echo "   - .github/workflows/deploy.yml"
echo "   - vite.config.ts (check base path: /$REPO_NAME/)"
echo "   - .gitattributes"
echo "   - package.json (homepage field)"
echo ""
echo "2. ⚙️  Go to GitHub repo Settings → Pages:"
echo "   - Set 'Build and deployment' to 'GitHub Actions'"
echo ""
echo "3. 🚀 Push to main branch to trigger deployment"
echo ""
echo "4. ✅ Validate deployment:"
echo "   node $(dirname "$0")/validate-deployment.js $REPO_NAME"
echo ""
echo "📍 Your site will be at: https://eskinder185.github.io/$REPO_NAME/"