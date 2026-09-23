# How to Update the Academi Theme Plugin

## Overview

The Academi theme is a Moodle theme plugin installed at: `public/theme/academi/`

Basilica Bio customizations live on top of the base theme. This guide explains how to make a change and get it live on the site safely.

## File Layout

Plugin root: `public/theme/academi/`

- `config.php` — theme registration, layouts, parent theme, which SCSS to include.
- `lib.php` — callbacks, pre/post SCSS processing, settings resolvers.
- `settings.php` — admin-facing theme settings (shows up under Site administration → Appearance → Themes → Academi).
- `version.php` — plugin version and Moodle version requirements.
- `README.md`, `CHANGESBYBB.md` — human documentation.

### SCSS (`scss/`)

- `theme.scss` — entry point included by Moodle.
- `header.scss`, `footer.scss`, `frontpage.scss`, `typography.scss`, `standard.scss`, `login.scss`, `course.scss`, `blocks.scss`, `carousel.scss`, `colors.scss`, `includes.scss` — section-level partials.
- `preset/` — preset variables and overrides.

### Templates (`templates/`)

- `navbar.mustache`, `footer.mustache`, `frontpage.mustache`, `drawers.mustache`, `columns1/2.mustache`, `header.mustache`, `login.mustache`, `course_blocks.mustache`, `my_courses_block.mustache`, `guest_login_widget.mustache`, etc.
- `templates/core/` — overrides of core Moodle templates (e.g., `user_menu.mustache`).

### PHP classes (`classes/`)

- `classes/output/core/course_renderer.php` — custom renderer that overrides core course rendering. This is where the My Courses block, Guest Login widget, dynamic tags, and course summary wiring live.

### JavaScript (`amd/`)

- `amd/src/` — editable source (`theme.js`, `frontpage.js`, etc.).
- `amd/build/` — minified builds consumed by Moodle at runtime.

### Fonts and images

- `fonts/` — font files referenced from SCSS via `[[setting:fontwww]]`.
- `pix/` — theme images, including fallback course image.

### Language

- `lang/en/theme_academi.php` — string definitions for the UI.

## Set Up a Local Dev Environment

- Go to [https://download.moodle.org/macosx/](https://download.moodle.org/macosx/). Download and install the Moodle local instance running with MAMP.
- Run a local Moodle instance by running application: **MAMP**.
- Go to [http://localhost:8888/](http://localhost:8888/) to review the Moodle website.
- Default admin username and password are: `admin`, `12345`.

## Make a Change

This theme is maintained with the help of an AI coding assistant (e.g., Kiro, Claude, Cursor). Each change follows the same lightweight flow:

1. **Kick off the session with the prompt below.** Open the `academi/` folder in your AI tool and send the kick-off message once per session. It points the AI at `BB-PROMPT.md` and `CHANGESBYBB.md`, which together define the rules and the current state of the theme.
2. **Describe what you want to change.** Combine any of:
   - a plain-text description ("Make the All Courses heading 28px and left-aligned"),
   - screenshots (drag-and-drop into the chat; annotate the element if helpful), or
   - a Figma CSS export (copy from the Figma "Code" panel, paste verbatim — the AI will translate the values into SCSS).
3. **Let the AI implement the change.** The AI is responsible for finding the right files, annotating every edit with a `@bb` comment, updating `CHANGESBYBB.md`, and keeping `amd/src/` and `amd/build/` in sync when JS is touched — all of that is defined in the prompt file.
4. **Review the diff, then move to Test.** Read what changed and compare it to your brief before purging caches and reloading.

### Kick-off prompt (copy-paste at the start of every session)

```
Open the academi theme plugin folder.

Read `BB-PROMPT.md` and follow every rule it defines for the rest of this session — in particular: annotating every edit with a `@bb` comment, keeping `amd/src/` and `amd/build/` in sync whenever JS is touched, and appending a new entry at the top of `CHANGESBYBB.md` after every change.

Read `CHANGESBYBB.md` so you understand the current state of the theme — what has already been customized, in what order, and why. Do not re-apply or revert any existing Basilica Bio customization.

When you are done reading, briefly confirm:
- which Moodle version / theme parent this plugin targets,
- the three or four biggest customization areas so far,
- and then wait for my change request.
```

Tips for better results:

- The more specific the brief, the fewer iterations are needed. Exact selectors, sizes, colors, and layout descriptions help.
- If the AI proposes something you do not want, push back before it applies the change. Reverts are easy, but avoiding extra work is easier.
- When the Figma design specifies a font, color, or spacing value, prefer pasting the Figma CSS as-is — the AI can read the exact numbers and match them.

## Test

Test locally first. Once the change is made on your MAMP instance:

1. **Purge Moodle's caches** so the SCSS, templates, and language strings recompile:
   - Admin UI: **Site administration → Development → Purge all caches**, or
   - Direct URL: `http://localhost:8888/<your-moodle-path>/admin/purgecaches.php`.
2. **Hard-refresh the browser** (Cmd+Shift+R) to bypass browser-side caches.
3. Visit [http://localhost:8888/](http://localhost:8888/) — the new theme changes should now be visible.
4. Spot-check the affected pages (frontpage, a course, login, a guest view) before moving on to upload.

## Upload

Once the change looks right locally, package the theme and install it on the AWS instance.

1. **Locate the local theme folder**: `public/theme/academi/` (inside your MAMP Moodle root, e.g., `/Applications/MAMP/htdocs2/moodle501/public/theme/academi/`).
2. **Compress it to a zip**. The zip's **root folder must be named exactly `academi`** — Moodle uses that folder name to identify the plugin. If the folder inside the zip is named anything else (e.g., `academi-copy`, `public`, `theme`), the install will fail.
   - On macOS: right-click the `academi` folder in Finder → **Compress "academi"**. This produces `academi.zip` with `academi/` as the root.
3. **Log in to the AWS Moodle instance** as an admin account.
4. **Install the zip**: go to **Site administration → Plugins → Install plugins**.
   - Drag-and-drop `academi.zip` into the **ZIP package** field, or click **Choose a file...** and pick it.
   - Click **Install plugin from the ZIP file**.
   - Follow the on-screen prompts to confirm the upgrade and continue.
5. After the install completes, **purge caches on the AWS instance** (**Site administration → Development → Purge all caches**) and hard-refresh to verify the changes are live.
