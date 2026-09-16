#!/usr/bin/env node

/**
 * Deployment Validation Script
 * Run this after deployment to verify everything is working correctly
 * Usage: node validate-deployment.js YOUR_REPO_NAME
 */

import https from 'https';
import process from 'process';

const repoName = process.argv[2];
if (!repoName) {
  console.error('❌ Usage: node validate-deployment.js YOUR_REPO_NAME');
  process.exit(1);
}

const baseUrl = `https://eskinder185.github.io/${repoName}`;

console.log(`🔍 Validating deployment for: ${repoName}`);
console.log(`🌐 Checking URL: ${baseUrl}`);

// Check if site is accessible
https.get(baseUrl, (res) => {
  if (res.statusCode === 200) {
    console.log('✅ Site is accessible');
    
    let body = '';
    res.on('data', (chunk) => body += chunk);
    res.on('end', () => {
      // Basic validation checks
      const checks = [
        { test: body.includes('<div id="root">'), message: 'React root element found' },
        { test: body.includes('<script'), message: 'JavaScript files included' },
        { test: !body.includes('404'), message: 'No 404 errors in content' },
        { test: body.includes(`/${repoName}/`), message: 'Correct base path in assets' }
      ];
      
      checks.forEach(check => {
        console.log(check.test ? `✅ ${check.message}` : `❌ ${check.message}`);
      });
      
      console.log('\n📋 Manual Verification Steps:');
      console.log(`1. Open ${baseUrl} in browser`);
      console.log('2. Check browser dev tools for 404 errors');
      console.log('3. Verify CSS and JS assets load correctly');
      console.log('4. Test navigation (if using client-side routing)');
    });
  } else {
    console.log(`❌ HTTP ${res.statusCode}: Site not accessible`);
    console.log('🔧 Troubleshooting:');
    console.log('   - Check GitHub Actions workflow completed successfully');
    console.log('   - Verify Pages is set to "GitHub Actions" deployment');
    console.log('   - Ensure base path in vite.config.ts matches repo name');
  }
}).on('error', (err) => {
  console.log(`❌ Connection error: ${err.message}`);
  console.log('🔧 The site might still be deploying. Wait a few minutes and try again.');
});