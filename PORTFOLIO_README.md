# Eskinder Kassahun - Portfolio

This is my personal portfolio website built with React, TypeScript, and Vite, deployed to GitHub Pages.

## 🚀 Technologies Used

- **React** - Frontend library
- **TypeScript** - Type-safe JavaScript
- **Vite** - Build tool and dev server
- **GitHub Actions** - CI/CD deployment
- **GitHub Pages** - Hosting

## 🏗️ Project Structure

```
/
├── src/
│   ├── App.tsx          # Main React component
│   ├── App.css          # Component styles
│   ├── main.tsx         # React entry point
│   └── index.css        # Global styles
├── public/              # Static assets
├── .github/workflows/   # GitHub Actions workflows
│   └── deploy.yml       # Deployment workflow
├── vite.config.ts       # Vite configuration
├── tsconfig.json        # TypeScript configuration
└── package.json         # Dependencies and scripts
```

## 🛠️ Development

### Prerequisites
- Node.js 18 or 20
- npm

### Installation
```bash
npm install
```

### Development Server
```bash
npm run dev
```
Opens at `http://localhost:5173/eportfolio/`

### Build
```bash
npm run build
```
Creates production build in `dist/` directory.

### Deploy
```bash
npm run deploy
```
Deploys to GitHub Pages using gh-pages package.

## 🚢 Deployment

The project is automatically deployed to GitHub Pages when code is pushed to the main branch using GitHub Actions.

**Live Site**: [https://eskinder185.github.io/eportfolio](https://eskinder185.github.io/eportfolio)

### Deployment Workflow

The `.github/workflows/deploy.yml` workflow:
1. Checks out the code
2. Sets up Node.js 20
3. Installs dependencies with `npm ci`
4. Builds the project with `npm run build`
5. Deploys to GitHub Pages using `actions/deploy-pages`

### Configuration

- **Base Path**: `/eportfolio/` (configured in `vite.config.ts`)
- **Build Output**: `dist/` directory
- **Deployment Branch**: Uses GitHub Pages deployment action
- **Node Version**: 20

## 📝 Notes

This portfolio is part of the GitHub profile repository and is deployed as a subdirectory to maintain the profile README functionality while hosting the portfolio.