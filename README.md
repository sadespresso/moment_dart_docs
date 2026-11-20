# moment_dart docs

The documentation site for [moment_dart](https://pub.dev/packages/moment_dart),
live at <https://moment-dart.dev.gege.mn>. It's a Flutter web app: every code
example runs against the real package in the reader's browser, so the outputs
shown are always the library's actual behavior.

Docs for 5.x and earlier (the old Docusaurus site) are on the
[`archive-pre-v6`](https://github.com/sadespresso/moment_dart_docs/tree/archive-pre-v6)
branch.

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
