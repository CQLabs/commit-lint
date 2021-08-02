
# Dart Commit Lint

**Note:** This project is in active development stage and is not ready for any kind of usage! ⚠️⚠️⚠️⚠️⚠️

## What is commit lint

Commit lint checks if your commit messages meet the [conventional commit format](https://conventionalcommits.org).

In general the pattern mostly looks like this:

```sh
type(scope?): subject  #scope is optional; multiple scopes are supported (current delimiter options: "/", "\" and ",")
```

Real world examples can look like this:

```sh
chore: run tests on travis ci
```

```sh
fix(server): send cors headers
```

```sh
feat(blog): add comment section
```

Common types:

- build
- ci
- chore
- docs
- feat
- fix
- perf
- refactor
- revert
- style
- test

___

Inspired by [TS commitlint](https://github.com/conventional-changelog/commitlint)