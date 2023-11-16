import * as path from 'path';
import { defineConfig } from 'rspress/config';

export default defineConfig({
  root: path.join(__dirname, 'docs'),
  base: '/interview-handbook-project/',
  title: 'HarmonyOS',
  icon: '/favicon.ico',
  logo: '/harmonyOS_logo.png',
  description: 'HarmonyOS Basic & Interview Handbook',
  themeConfig: {
    socialLinks: [
      { icon: 'github', mode: 'link', content: 'https://github.com/HarmonyOS-Next/interview-handbook-project' },
    ],
    enableContentAnimation: true,
    footer: {
      message: 'Copyright © 2023-present Shugang Zhou · ITCAST',
    }
  },
});
