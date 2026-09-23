# AI Prompt: Working on the Academi Theme (Basilica Bio)

You are helping maintain a Moodle theme plugin at `public/theme/academi/`. Follow these rules on every request.

## 1. Read `CHANGESBYBB.md` first

Before making any edits, open and read `public/theme/academi/CHANGESBYBB.md`. It is the single source of truth for what has already been customized, in what order, and why. You MUST understand the current state before making new changes so you:

- do not re-apply an edit that already exists,
- do not revert an earlier Basilica Bio customization by accident,
- know which files and selectors are typically involved for each area of the UI.

If the user describes a change and you cannot tell from `CHANGESBYBB.md` whether it has already been done, ask before editing.

## 2. Know the codebase layout

Plugin root: `public/theme/academi/`

- `scss/` — SCSS partials (`header.scss`, `footer.scss`, `frontpage.scss`, `typography.scss`, `standard.scss`, etc.). `theme.scss` is the entry.
- `templates/` — Mustache templates (`navbar.mustache`, `footer.mustache`, `course_blocks.mustache`, `my_courses_block.mustache`, `guest_login_widget.mustache`, etc.).
- `templates/core/` — overrides of core Moodle templates (e.g., `user_menu.mustache`). Prefer creating overrides here over modifying core files outside the theme.
- `classes/output/core/course_renderer.php` — custom PHP renderer. Holds the My Courses block, Guest Login widget, course tags/summary wiring, and frontpage layout overrides.
- `amd/src/` — editable JS sources.
- `amd/build/` — minified JS that Moodle actually loads at runtime. Must be kept in sync with `amd/src/`.
- `lib.php` — theme callbacks, SCSS resolvers (includes `[[setting:fontwww]]` replacement).
- `settings.php`, `lang/en/theme_academi.php`, `config.php`, `version.php` — the usual Moodle theme scaffolding.
- `fonts/` — font files, referenced in SCSS via `[[setting:fontwww]]`, NOT Moodle core's `[[font:theme|...]]` syntax.

## 3. How to apply a change

For every request:

1. **Identify the right files.** Think about whether it's a style change (SCSS), a markup change (template), a behavior change (PHP or JS), or a text change (lang file). Most frontpage visual changes live in `scss/frontpage.scss`, `scss/header.scss`, `scss/footer.scss`, or the relevant mustache under `templates/`.
2. **Scope CSS correctly.** Site-wide background or layout rules should be scoped under `body.pagelayout-frontpage` when they are meant for the home page only, so other pages keep their native look.
3. **Make the minimum change needed.** Do not restructure unrelated code. Do not reformat files. Keep diffs small and reviewable.
4. **Annotate every edit with a `@bb` comment.** This is how Basilica Bio customizations are distinguished from the original theme code. Use the appropriate syntax for the file:

   - SCSS: `/* Changes by @bb: <what and why> */`
   - PHP: `// Changes by @bb: <what and why>`
   - Mustache: `{{! Changes by @bb: <what and why> }}`
   - JS: `// Changes by @bb: <what and why>`

   Put the comment right next to the changed line, not just at the top of the file. Short but specific — "match logo height to title", "pass course summary to template", "move search box into the All Courses h2".

5. **Keep `amd/src/` and `amd/build/` in sync when you touch JS.** Moodle loads ONLY the minified files at `amd/build/*.min.js` at runtime — it does not serve `amd/src/*.js` directly, even when `$CFG->cachejs = false`. If you edit a source file and do not update its build counterpart, nothing changes on the site.

   This project does not have an active JS build pipeline. When you edit a `amd/src/` file, you MUST also hand-edit the corresponding `amd/build/*.min.js` to apply the same change. Prior entries in `CHANGESBYBB.md` list both files under "Files Modified" as a reminder. Always do the same.

6. **Never push to remote or force-push.** Respect the repository integrity rules in the user's global guidance — no force push, no history rewriting, no destructive git operations without explicit approval.

## 4. Update `CHANGESBYBB.md`

After implementing any change, append a new section at the TOP of `public/theme/academi/CHANGESBYBB.md`. Follow the existing pattern exactly:

```markdown
## YYYY-MM-DD — Short title

### Files Modified
- path/one
- path/two

### Changes

**Short heading — one line summary**
- Bullet detail 1 (specific: name selectors, file sections, and values where useful)
- Bullet detail 2
```

Rules for the change log:

- Use the actual date (YYYY-MM-DD) the change is being made.
- Title should be 3-7 words. Not a sentence.
- List every file you touched under **Files Modified**, including build artifacts like `amd/build/*.min.js`.
- Use a `**bold short heading**` per logical change, followed by bulleted details. One section can cover multiple related changes — group them if they belong together.
- Mention selectors, font families, pixel values, colors, and template paths explicitly so a future reader can find the change quickly.
- If you removed an earlier customization, note that explicitly — do not silently delete history.

## 5. Communication

- If the user's brief is ambiguous (for example, "make it bigger" without a target size), ask one concise clarifying question before editing.
- If a Figma CSS snippet is pasted, match the values exactly: font-family, font-weight, font-size, line-height, letter-spacing, colors, paddings, radii. Paraphrased approximations are not acceptable when the user provided exact values.
- After editing, briefly summarize what changed and which files were touched, and remind the user to purge Moodle caches (**Site administration → Development → Purge all caches**) and hard-refresh the browser.

## 6. What NOT to do

- Do NOT edit files outside `public/theme/academi/` unless the user explicitly asks you to (for example, `config.php` at the Moodle root was touched once for `themedesignermode`, but that is an exception, not the rule).
- Do NOT touch language packs outside the theme's own `lang/` folder.
- Do NOT add `// TODO` comments or leave code half-finished. If you need more information, ask.
- Do NOT strip or rewrite existing `@bb` comments — those record the history of prior customizations.
- Do NOT use Moodle core's `[[font:theme|...]]` syntax for font URLs in this theme. Use `[[setting:fontwww]]`, which is resolved by `theme_academi_pre_css_set_fontwww()` in `lib.php`.
- Do NOT restyle content that was not in the user's brief. Stay focused.

---

By following this prompt you will produce clean, traceable, reversible changes that keep the Academi theme maintainable over time.
