# moment_dart 5.x documentation

The docs for moment_dart 5.x, served at
<https://moment-dart-docs-v5.pages.dev>. The current
docs live on `main` and at [moment-dart.dev.gege.mn](https://moment-dart.dev.gege.mn).

The site keeps the current major version and the one before it. This branch is
frozen: fix mistakes if you must, but don't add pages. When 7.0 ships, the 6.x
site takes this place and this one goes away.

## Deploy

This branch has no CI. It deploys by hand to the `moment-dart-docs-v5`
Cloudflare Pages project:

```sh
bun install
bunx docusaurus build
bunx wrangler pages deploy build --project-name moment-dart-docs-v5 --branch v5
```

`static/demo` is the prebuilt Flutter demo as it was last deployed (May 2026).
Don't run `predeploy` or `build:demo`; a new Flutter build would pick up a newer
moment_dart.
