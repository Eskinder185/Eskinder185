# GitHub Pages Deployment Template for Vite + React

This template provides a complete solution for deploying Vite + React applications to GitHub Pages using GitHub Actions. It fixes common deployment issues and ensures reliable, automated deployments.

## 🎯 What This Template Fixes

- ✅ **Permission denied errors** (`vite: Permission denied`, `/usr/bin/env: node\r`)
- ✅ **404 errors** due to incorrect base paths
- ✅ **Line ending issues** on different operating systems
- ✅ **Missing GitHub Actions permissions**
- ✅ **Failed deployments** with outdated workflow patterns

## 📋 Quick Setup Checklist

### 1. Workflow Configuration
Copy `deploy.yml` → `.github/workflows/deploy.yml`

### 2. Vite Configuration  
Copy `vite.config.ts` and update the repo name:
```typescript
const repo = 'YOUR_REPO_NAME' // Must match GitHub repo name EXACTLY (case-sensitive)
```

### 3. Package.json Updates
- Ensure you have the required scripts: `dev`, `build`, `preview`
- Update `homepage` field: `"https://eskinder185.github.io/YOUR_REPO_NAME"`
- Remove any `gh-pages` dependency if present
- Remove any `deploy` script using `gh-pages -d dist`

### 4. Line Ending Fix
Copy `.gitattributes` to your repo root

### 5. Repository Settings
- Go to Settings → Pages
- Set "Build and deployment" to **"GitHub Actions"** (not "Deploy from a branch")

## 🔧 Detailed Setup Instructions

### Step 1: Create/Replace Workflow File

Create `.github/workflows/deploy.yml` with the template content. This workflow:
- Triggers on pushes to `main` branch
- Sets proper permissions for GitHub Pages
- Uses Node 20 with npm caching
- Fixes permission issues with `chmod +x`
- Uses official GitHub Pages actions

### Step 2: Configure Vite Base Path

The `base` path in `vite.config.ts` **must match your repository name exactly**:

```typescript
// ✅ Correct examples:
const repo = 'QuizForge'        // for repo: Eskinder185/QuizForge
const repo = 'neon-meme-machine' // for repo: Eskinder185/neon-meme-machine  
const repo = 'CodeRush'         // for repo: Eskinder185/CodeRush

// ❌ Wrong - will cause 404s:
const repo = 'quizforge'        // incorrect case
const repo = 'Quiz-Forge'       // incorrect format
```

### Step 3: Update Package.json

Ensure your `package.json` has:

```json
{
  "homepage": "https://eskinder185.github.io/YOUR_REPO_NAME",
  "scripts": {
    "dev": "vite",
    "build": "vite build", 
    "preview": "vite preview"
  },
  "devDependencies": {
    "vite": "^5",
    "@vitejs/plugin-react": "^4"
  }
}
```

**Remove these if present:**
- `"deploy": "gh-pages -d dist"` script
- `"gh-pages"` dependency

### Step 4: Fix Line Endings

Add `.gitattributes` to normalize line endings and prevent `node\r` errors:

```
* text=auto
*.sh text eol=lf
```

### Step 5: Enable GitHub Pages

1. Go to your repository Settings
2. Navigate to "Pages" in the sidebar  
3. Under "Build and deployment":
   - Select **"GitHub Actions"** 
   - NOT "Deploy from a branch"

## 🚀 Deployment Process

After setup, every push to `main` will:

1. **Build** your Vite app with correct base path
2. **Upload** build artifacts to GitHub Pages
3. **Deploy** to `https://eskinder185.github.io/YOUR_REPO_NAME`

## ✅ Validation Checklist

After deployment, verify:

- [ ] Workflow runs successfully (check Actions tab)
- [ ] Site loads at `https://eskinder185.github.io/YOUR_REPO_NAME`
- [ ] CSS and JS assets load correctly (no 404s in browser dev tools)
- [ ] No console errors related to missing resources
- [ ] Client-side routing works (if applicable)

## 🐛 Troubleshooting

### Site Returns 404
- Check that `base` in `vite.config.ts` matches repo name exactly
- Verify GitHub Pages is set to "GitHub Actions" not "Deploy from a branch"
- Ensure workflow completed successfully

### Permission Denied Errors
- Verify `chmod +x node_modules/.bin/* || true` is in workflow
- Check that `.gitattributes` file is present

### Assets Not Loading (CSS/JS 404s)  
- Verify `base` path in `vite.config.ts` is correct
- Check browser dev tools for 404 errors on asset requests
- Ensure `homepage` in `package.json` matches the base path

### Workflow Fails
- Check that all required permissions are set in workflow
- Verify Node version (template uses Node 20)
- Ensure `npm ci` can install dependencies successfully

## 📂 SPA Fallback (Optional)

If your app uses client-side routing, add a `404.html` file that's a copy of `index.html` to handle direct URL access.

## 🎯 Repositories to Apply This Template

Based on the current setup, apply this template to:

1. **QuizForge** ✅ (Already working - validation successful)
   - URL: https://eskinder185.github.io/QuizForge/
   - Base: `/QuizForge/`

2. **neon-meme-machine** 
   - Base: `/neon-meme-machine/`
   - URL: https://eskinder185.github.io/neon-meme-machine/

3. **CodeRush**
   - Base: `/CodeRush/`  
   - URL: https://eskinder185.github.io/CodeRush/

## 📝 Success Criteria

✅ **Deployment Complete When:**
- GitHub Actions workflow shows green checkmark
- Site loads without 404 errors
- All assets (CSS, JS) load correctly
- No permission denied or line ending errors in logs

---

*This template was validated against the successfully deployed QuizForge repository. All configurations are battle-tested and production-ready.*