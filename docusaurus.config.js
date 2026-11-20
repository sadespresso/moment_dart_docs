// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

import { themes as prismThemes } from "prism-react-renderer";

const baseUrl = "/";

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "moment_dart docs",
  tagline: "Documentation for moment_dart",
  favicon: "img/favicon.ico",

  // Set the production url of your site here
  url: "https://v5.moment-dart.dev.gege.mn/",
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: baseUrl,
  scripts: [
    {
      src: `${baseUrl}demo/flutter.js`,
    },
  ],

  trailingSlash: true,

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: "sadespresso", // Usually your GitHub org/user name.
  projectName: "moment_dart_docs", // Usually your repo name.

  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "throw",

  deploymentBranch: "gh-pages",

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl: "https://github.com/sadespresso/moment_dart_docs/tree/v5/",
          routeBasePath: "/",
          lastVersion: "current",
          versions: {
            current: {
              label: "5.3.4",
            },
          },
        },
        // blog: {
        //   showReadingTime: true,
        //   // Please change this to your repo.
        //   // Remove this to remove the "edit this page" links.
        //   editUrl:
        //     'https://github.com/sadespresso/moment_dart_docs/tree/main/',
        // },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      // Replace with your project's social card
      announcementBar: {
        id: "v5-archive",
        content:
          'These are the docs for moment_dart 5.x. For the latest version, see <a href="https://moment-dart.dev.gege.mn">moment-dart.dev.gege.mn</a> and <a href="https://moment-dart.dev.gege.mn/upgrading">upgrading to 6.0</a>.',
        isCloseable: false,
      },
      navbar: {
        title: "moment_dart",
        logo: {
          alt: "Dart language logo",
          src: "img/dart.svg",
        },
        items: [
          {
            type: "docSidebar",
            sidebarId: "docs",
            position: "left",
            label: "Docs",
          },
          {
            to: "/demo",
            position: "left",
            label: "Demo",
            "aria-label": "Flutter Web Demo",
          },
          {
            href: "https://moment-dart.dev.gege.mn",
            position: "right",
            label: "6.x docs",
          },
          {
            href: "https://pub.dev/packages/moment_dart",
            position: "right",
            className: "header-pubdev-link",
            "aria-label": "pub.dev package",
          },
          {
            href: "https://github.com/sadespresso/moment_dart",
            position: "right",
            className: "header-github-link",
            "aria-label": "GitHub repository",
          },
        ],
      },
      footer: {
        style: "dark",
        links: [
          {
            title: "Docs",
            items: [
              {
                label: "Documentation",
                to: "/",
              },
            ],
          },

          {
            title: "More",
            items: [
              {
                label: "Docs on GitHub",
                href: "https://github.com/sadespresso/moment_dart_docs",
              },
              {
                label: "moment_dart on GitHub",
                href: "https://github.com/sadespresso/moment_dart",
              },
              {
                label: "moment_dart on pub.dev",
                href: "https://pub.dev/packages/moment_dart",
              },
            ],
          },
        ],
        copyright: `Built with Docusaurus.`,
      },
      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
        additionalLanguages: ["dart", "bash", "yaml"],
      },
    }),
};

module.exports = config;
