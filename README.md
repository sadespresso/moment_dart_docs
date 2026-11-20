# moment_dart docs

The documentation site for [moment_dart](https://pub.dev/packages/moment_dart),
live at <https://moment-dart.dev.gege.mn>. It's a Flutter web app: every code
example runs against the real package in the reader's browser, so the outputs
shown are always the library's actual behavior.

## Versions

The site keeps two major versions: the current one, here on `main`, and the
one before it. The 5.x docs (the old Docusaurus site, frozen) are on the
[`v5`](https://github.com/sadespresso/moment_dart_docs/tree/v5) branch and at
<https://moment-dart-docs-v5.pages.dev>, deployed by hand to their own Cloudflare
Pages project; that branch's README says how. Older docs aren't served; their
source is on
[`archive-pre-v6`](https://github.com/sadespresso/moment_dart_docs/tree/archive-pre-v6).

When 7.0 ships: copy this site to a `v6` branch, deploy it to a
`moment-dart-docs-v6` project (served at `moment-dart-docs-v6.pages.dev`), point
`previousDocsUrl` in `lib/widgets/shell.dart` at it, and delete the v5
project.

## Run it

```sh
flutter pub get
flutter run -d chrome
```

## Write a page

Pages live in `lib/pages/`, one file each, and are listed in
`lib/docs/registry.dart` (order there is sidebar order). A page is a list of
blocks from `lib/docs/model.dart`:

```dart
Live([
  c("final posted = Moment.now() - Duration(minutes: 42);"),
  l("posted.fromNow()", () {
    final posted = Moment.now() - const Duration(minutes: 42);
    return posted.fromNow();
  }),
]),
```

`l(code, () => value)` shows `code` and prints the closure's result as a
trailing comment, re-evaluated every second and whenever the reader switches
the language. Keep the code string and the closure identical: readers copy the
string. `t(...)` marks a line that is meant to throw.

## Check it

```sh
dart format lib test
flutter analyze
flutter test              # evaluates every live example, renders every page
```

## Deploy

Pushing to `main` runs `.github/workflows/deploy.yml`: it tests, builds
`build/web` and publishes it to the `gh-pages` branch, which Cloudflare Pages
serves. Without a `404.html`, Cloudflare treats the site as a single-page app,
so deep links like `/formatting` load the app.
