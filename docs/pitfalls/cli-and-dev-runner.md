# CLI and Dev-Runner Pitfalls

## 1) `grep` appears to hang forever

### Symptom
Command shows shell continuation prompt (`>`) and does not finish.

### Root Cause
Unclosed quote in command, for example:

```bash
grep -n "stylesheet_link_tag
```

### Fix
1. Cancel with `Ctrl+C`.
2. Re-run with closed quotes and target path:

```bash
grep -R -n "stylesheet_link_tag" app/views
```

---

## 2) `bin/dev` fails with `exec: foreman: not found`

### Symptom
`bin/dev` exits with code 127 and reports missing `foreman`.

### Root Cause
`foreman` executable is not available on current shell `PATH` even when gem state looks installed.

### Fix
1. Install foreman:

```bash
gem install foreman
```

2. If using rbenv, refresh shims:

```bash
rbenv rehash
```

3. Retry:

```bash
bin/dev
```

### Note
`bin/dev` is for running Rails + Tailwind watcher together. If watcher is not needed, `rails s` can run app server only.
