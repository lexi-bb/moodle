# Academi Theme Change Log

## 2026-04-14 — Match top header to Amplify (Basilica Bio) site

### Files Modified
- `scss/header.scss`

### Changes

**Top header — align logo, title, and nav links with the canonical Basilica Bio (Amplify) site**
- Source: pulled CSS from https://main.dyrzqyj6qucqw.amplifyapp.com/ for the top-header logo (`._1y4aoyz2`), wordmark (`._1y4aoyz3`), and nav links (`._1y4aoyz7`). Cross-checked against `scss/header.scss` `.top-header-bar` and applied the deltas.

**`.top-header-logo img` — 30x30 fixed square (was 33px tall / auto width / 60px max-width)**
- Amplify renders the leaf icon at exactly 30×30. Changed `height: 33px → 30px`, replaced `width: auto; max-width: 60px` with `width: 30px; max-width: 30px`. Other rules (`object-fit: contain`, `display: block`) are unchanged.

**`.top-header-title` (BASILICA BIO wordmark) — typography overhaul**
- `color: #3d3a2e → #302F26` (matches academi's existing global text color from 2026-04-12; the same dark olive-brown that the rest of the theme already uses).
- `letter-spacing: 1px → -1.5px` — Amplify uses very tight tracking on the wordmark; the previous +1px tracking made it look airy/loose by comparison.
- Added `line-height: 1` so the 30px title doesn't introduce extra leading inside the bar.
- Added `text-transform: uppercase` (relying on the markup being uppercase was fragile; the rule is now declarative).
- Added `margin-bottom: -3px` to lift the wordmark optically, matching how Amplify aligns the BASILICA BIO baseline against the leaf icon.

**`.top-header-nav a` (HOME / RESOURCES / PROGRAMS / LEARN links) — typography + permanent underline**
- `color: #3d3a2e → #302F26`.
- `letter-spacing: 1px → -0.8px` — Amplify uses tight tracking on the nav links too.
- Added `text-transform: uppercase` for declarative consistency.
- Replaced `padding-bottom: 2px; border-bottom: 2px solid transparent;` plus a `&:hover, &.active { border-bottom-color: #3d3a2e }` block with a permanent **4px** underline: `padding: 6px 0; border-bottom: 4px solid currentColor;`. Amplify shows the 4px underline on EVERY link as part of the wordmark's visual treatment — it's not a hover state. Removed the `:hover`/`.active` colorize rules since the border is always rendered now.
- `currentColor` keeps the underline tied to the link's `color`, mirroring how Amplify reuses `var(--_1ql0rhg4)` for both.

**Assumptions / unknowns documented for future tuning**
- Amplify resolves nav padding through `var(--_1ql0rhgh) var(--_1ql0rhgi)` — the exact values aren't visible in DevTools without dumping `getComputedStyle(document.documentElement)`. Used `padding: 6px 0` as a sensible default (parent `gap: 30px` already handles horizontal spacing). If the resolved values come back later, this is the one line to re-tune.
- Amplify font-weight resolves through `var(--_1ql0rhgg)`. Confirmed visually as 900; left existing `font-weight: 900` unchanged.

**Mobile (≤767px) inherits the new typography**
- The existing `@media (max-width: 767px)` block only overrides `font-size` (title 22px, nav 13px) and white-space — letter-spacing, color, line-height, text-transform, padding, and the 4px border now cascade from the desktop rules. No mobile-specific changes needed.

## 2026-04-14 — Expose course-index drawer + push drawer panels below stacked headers on desktop

### Files Modified
- `scss/standard.scss`

### Changes

**`.drawer-toggles .drawer-toggler` — push the open-drawer button below stacked headers on tablet+desktop**
- Boost positions the open-drawer button (`.drawer-toggler`) at `position: fixed; top: calc($navbar-height + 0.7rem)` ≈ 61px from the top of the viewport. The academi theme has two stacked fixed headers (BB top bar ~70px + lower olive `#header.fixed-top` ~60px = ~130px combined), and the lower header has Bootstrap's `$zindex-fixed: 1030` versus the toggler's `z-index: 2` — so the toggler was being painted UNDERNEATH the lower header and was effectively unreachable. Users on AWS could not open the course-index drawer because the open button was hidden.
- Added an `@media (min-width: 768px)` override in `scss/standard.scss` setting `.drawer-toggles .drawer-toggler { top: 138px }` — clears top bar (70px) + lower header (~60px) + 8px gap, putting the toggler just below the lower header where it is visible and clickable.
- Mobile (≤767px) is intentionally NOT overridden — Boost already moves the toggler to the bottom of the viewport on small viewports (`top: calc(99vh - $navbar-height * 2.5)`), which is fine.
- The toggler's existing `z-index: 2` is left untouched. At its new `top: 138px` it no longer overlaps the lower header (header bottom = 130px), so no z-index escalation is needed.

**`.drawer-left`, `.drawer-right` — extend the panel-position fix to desktop (was tablet+mobile only)**
- The previous fix from 2026-04-13 (Fix course-index drawer overlapping headers on mobile) only scoped the panel-top override to `@media (max-width: 991px)`. On desktop (≥992px) the panels still inherited Boost's `top: 0; height: 100vh`, which slid the top ~130px of the drawer (drawer header + first section title) under the stacked fixed headers. Reported when the user tested on AWS desktop after the toggler was exposed.
- Removed the `@media (max-width: 991px)` upper bound so `.drawer-left, .drawer-right { top: 130px !important; margin-top: 0 !important; height: calc(100vh - 130px) !important }` now applies at all viewport widths ≥768px (desktop + tablet).
- The `@media (max-width: 767px)` mobile override (top: 138px / height: calc(100vh - 138px)) is unchanged — its higher `!important` placement later in source still wins on mobile where the BB top bar is taller (78px vs 70px).
- Net result: drawer panels and the open-drawer button now both clear the stacked headers at every breakpoint. The drawer header, first section title, and full content are visible and scrollable independently of the page.

## 2026-04-13 — Quiz question background to match page

### Files Modified
- `scss/course.scss`

### Changes

**`.que .formulation` — override Boost's blue background to match page**
- Boost styles every quiz question's `.que .formulation` block with a light-blue background derived from `$info` (`shift-color($info, $alert-bg-scale)`), which produced the prominent baby-blue panel inside the otherwise-beige theme.
- Appended an override to `scss/course.scss`: `.que .formulation { background-color: #FBF6E8; border-color: #E0DACB; color: #302F26 }` so question content blends into the theme's main page background (#FBF6E8) with a subtle tan border.

## 2026-04-13 — Fix course-index drawer overlapping headers on mobile

### Files Modified
- `scss/standard.scss`
- `scss/header.scss`

### Changes

**Drawers — push course-index / blocks drawers below the stacked headers**
- The Moodle drawers (`.drawer-left` and `.drawer-right`) are `position: fixed` and were offset only `60px` from the top — sized for the original single-header design. With the new top bar + lower header stack on mobile (78px + ~60px = 138px), drawers slid up underneath the top bar and the course-index list overlapped the headers.
- Updated `scss/standard.scss`:
  - At `≤991px` (tablet), set `.drawer-left, .drawer-right { top: 130px; margin-top: 0; height: calc(100vh - 130px) }` to clear desktop top-bar (70px) + lower header (~60px).
  - At `≤767px` (mobile), set both left and right drawers to `top: 138px; margin-top: 0; height: calc(100vh - 138px); max-height: calc(100vh - 138px)` to clear the mobile top bar (78px) + lower header (~60px).
  - Used `top:` (not `margin-top:`) since the drawers are `position: fixed`. Explicitly setting `margin-top: 0` overrides any stale margin-based offsets so the two values don't stack.
- Updated `scss/header.scss`:
  - At `≤575px`, bumped `#header.moodle-based-header ~ .drawer-right { margin-top: 60px → 138px }` to match.
- Drawers now sit flush below the lower header on every viewport, with the height clamped so they don't extend below the bottom of the viewport.

## 2026-04-13 — Mobile gap between header and page content

### Files Modified
- `scss/header.scss`

### Changes

**Reduced `#page-wrapper { margin-top }` on mobile to remove double-counted top spacing**
- The body already has `padding-top: 78px` on mobile (set by the same media query) to clear the fixed top-bar. Adding `margin-top: 138px` on `#page-wrapper` (78 top bar + 60 lower header) double-counted the top-bar height, leaving an unnecessary 78px gap between the lower olive-green header and the page content.
- Reduced the value to `margin-top: 60px`, which only accounts for the lower header height — the top-bar is already covered by the body padding.
- Result: on mobile the lower header now sits flush against the page content with no visible gap.

## 2026-04-13 — My Courses container math now matches All Courses (desktop + mobile)

### Files Modified
- `templates/my_courses_block.mustache`
- `scss/frontpage.scss`

### Changes

**My Courses — wrap rows in Bootstrap `.row > .col-md-12` to mirror All Courses**
- The All Courses block renders inside `.container > .row > .col-md-12 > .course-slider`. The Bootstrap row adds horizontal negative margins and the col adds horizontal padding, which together change the inner content width that slick (or our flex row) measures from.
- The My Courses block previously skipped the `.row > .col-md-12` wrapper, so its `.my-courses-row` measured against a slightly different baseline width — making cards visually narrower or wider than the All Courses cards even though both lived inside the same Bootstrap `.container`.
- Updated `templates/my_courses_block.mustache` to wrap `.my-courses-row` in `<div class="row"><div class="col-md-12">…</div></div>`, matching the All Courses structure exactly.

**My Courses — switch from CSS `gap` to per-child `margin-right` so card widths match slick math exactly**
- Slick (`amd/src/slick.js` line 2078) computes each slide's width as `Math.ceil(listWidth / slidesToShow) - margin-right` — a full `margin-right` is subtracted from EVERY slide (including the last; its margin extends past the visible track into the overflow). For 3 cards in a 1296px parent: `1296/3 - 15 = 417`.
- CSS flex with `gap: 15px` and `flex: 1 1 0` distributes the gap budget across only the (N-1) gaps between siblings, giving `(1296 - 30) / 3 = 422`. That's the 5px-per-card discrepancy you saw.
- Replaced `.my-courses-row { gap: 15px }` and `> * { flex: 1 1 0 }` with `gap: 0` and `> * { flex: 0 0 calc(100% / 3 - 15px); margin-right: 15px }`. Critically, the `:last-child` margin-right is NOT zeroed — slick lets the last margin overflow, and the basis math accounts for that.
- Same change applied to the mobile horizontal-scroll rule: `gap: 0`, `flex: 0 0 calc(100% / 1.15 - 12px)`, `margin-right: 12px` per child (no last-child override) — mirrors slick's `listWidth / slidesToShow(1.15) - margin` math on mobile, where the trailing margin extends past the visible viewport.

## 2026-04-13 — Match My Courses card width to All Courses on mobile

### Files Modified
- `scss/frontpage.scss`

### Changes

**My Courses cards — same width and gap as All Courses on mobile**
- The All Courses slick slider uses `slidesToShow: 1.15` on mobile, which renders each card at approximately `(parent_width / 1.15) − margin-right` ≈ `86.96% − 12px`.
- Updated the My Courses CSS scroll: `> * { flex: 0 0 calc(86.96% - 12px) }` and `gap: 12px` at both `≤767px` and `≤575px` breakpoints. The `calc()` keeps the math device-agnostic — it scales with the parent container's width on any phone size.
- Both sections now compute the same visible card width and the same inter-card gap from a percentage of their parent, so they remain consistent across all viewport widths.

## 2026-04-13 — All Courses card peek on mobile

### Files Modified
- `amd/src/frontpage.js`
- `amd/build/frontpage.min.js`

### Changes

**All Courses slick slider — show next-card peek on mobile (≤767px)**
- Changed `slidesToShow` from `1` to `1.15` for both the `breakpoint: 767` and `breakpoint: 575` settings of the `.course-slider` slick instance in `availablecourses()`.
- The fractional value makes one card fill the visible area while ~15% of the next card peeks in from the right edge — a visual cue that the carousel can be swiped, replacing the previously-hidden navigation arrows.
- `slidesToScroll` stays at `1` so swipes still advance one card at a time.
- Restored a `margin-right: 12px` between slick slides at `≤575px` (was `0`) so cards have a visible gap between them on mobile.
- Updated both the source (`amd/src/frontpage.js`) and the minified build (`amd/build/frontpage.min.js`) so the change actually takes effect at runtime.

## 2026-04-13 — Hide All Courses slider arrows on mobile

### Files Modified
- `scss/frontpage.scss`

### Changes

**All Courses slick slider — hide arrows on mobile (≤767px)**
- Added `@media (max-width: 767px) { .available-courses .available-block .course-slider .slick-arrow { display: none !important } }` at the end of `frontpage.scss`.
- The default slick prev/next arrows looked out of place on phones (square dark blocks overlapping the soft pill-shaped tan card design). Touch users swipe naturally, so the arrows are hidden below 768px and the carousel relies on swipe/scroll.
- Desktop layout is unchanged — arrows still appear there.

## 2026-04-13 — All Courses heading + search bar on mobile

### Files Modified
- `scss/frontpage.scss`

### Changes

**All Courses heading + search bar — stack vertically on mobile (≤767px)**
- On desktop the search box is `position: absolute` inside the `<h2>`, pinned to the right edge of the heading row. On narrow viewports the 300px-wide search overlapped the title text ("All Courses" → "All Cou…").
- Added a `@media (max-width: 767px)` block at the end of `frontpage.scss` that:
  - Turns the h2 into a `display: flex; flex-direction: column; gap: 12px` container
  - Resets the search box to `position: static; transform: none; max-width: 320px; margin-right: auto` so it flows naturally below the title and aligns to the left edge of the heading row (not stretched full width).
- Pure CSS, no JS or template change needed — the JS still injects the search box into the h2; the layout just reflows.

## 2026-04-13 — My Courses horizontal swipe-scroll on mobile

### Files Modified
- `scss/frontpage.scss`

### Changes

**My Courses row — horizontal swipe-scroll on mobile (≤767px)**
- Replaced the previous vertical stack on small viewports with a horizontal CSS-scroll layout that mirrors the All Courses behavior on mobile.
- `.my-courses-row` becomes `display: flex; flex-direction: row; flex-wrap: nowrap; overflow-x: auto` with `scroll-snap-type: x mandatory`.
- Each direct child (`.my-courses-stats`, `.my-course-card`, `.my-course-empty`) gets `flex: 0 0 85% / width: 85%` so one card is fully visible and the next peeks in to hint at swipe.
- Stats card now stacks "Lessons completed" + "Lessons saved" vertically inside a single card via `.my-courses-stats { flex-direction: column }` — matching the design where the entire stats column is one swipeable card.
- Hidden the horizontal scrollbar (`scrollbar-width: none` plus the WebKit hack) for a cleaner look — users still get native momentum-swipe.
- Added a slight `padding-bottom: 8px` so the cards' shadows aren't clipped by the scroll container edge.
- Below 575px the per-slide width tightens to `88%` so a touch more of the next card peeks through on small phones.
- Pure CSS, no JS — keeps `amd/src/` and `amd/build/` untouched.

## 2026-04-13 — Mobile responsive top header (Plan 2)

### Files Modified
- `scss/header.scss`

### Changes

**Top header — wrap nav links below title on mobile (≤767px)**
- Added a `@media (max-width: 767px)` block in `header.scss` that switches `.top-header-inner` from a horizontal flex row to a vertical stack: row 1 holds the logo and title, row 2 holds the four BB nav links wrapping inline.
- Reduced `.top-header-bar` horizontal padding from `12px 40px` to `10px 16px` to fit narrower viewports.
- Reduced logo height from `33px` to `28px` and title font-size from `30px` to `22px` on mobile.
- Reduced `.top-header-nav a` font-size from `16px` to `13px` and gap from `30px` to `8px 16px` (row-gap col-gap).
- Right-aligned the nav row using `.top-header-nav { justify-content: flex-end }` so the four links sit against the right edge of the screen.
- Set `align-items: stretch` on `.top-header-inner` so each row spans the full bar width, letting their own `justify-content` rules do the alignment.
- Set `white-space: nowrap` on `.top-header-title` so the wordmark "BASILICA BIO" never breaks across two lines.
- Bumped `#header.fixed-top { top }` and `body { padding-top }` from `70px` to `78px`, and `#page-wrapper { margin-top }` from `130px` to `138px` — values measured from the actual mobile top-bar height (8px top + 8px bottom padding + 28px logo + 4px gap + 20px nav line ≈ 78px).
- Forced the lower header on mobile: `.container-fluid.navbar-nav { justify-content: space-between; flex-wrap: nowrap; padding: 0 12px }` and `#usernavigation { flex: 1 1 auto; flex-direction: row; justify-content: space-between }` so the edit-mode switch sits left, the avatar sits flush right with `12px` breathing room from the screen edge, and the hamburger/usernavigation row fills the lower-header width (was previously squeezed to the middle by the desktop `flex-direction: row-reverse`).
- Added an extra `@media (max-width: 374px)` block that shrinks the title to `20px` and nav links to `12px` for very narrow phones (iPhone SE, older Android).
- This keeps a single code path (no JS needed) so guests and logged-in users both reach HOME / RESOURCES / PROGRAMS / LEARN on mobile.

## 2026-04-13 — My Courses card image: show top of image instead of center

### Files Modified
- `scss/frontpage.scss`

### Changes

**`.my-course-img` — `background-position: top center`**
- Changed `background-position` from `center` to `top center` on `.my-course-img` so when the card height truncates the image, the top portion of the picture is visible instead of the middle.
- `background-size: cover` is unchanged so the image still fills the card width.

## 2026-04-13 — Extend page background color to course pages

### Files Modified
- `scss/typography.scss`
- `scss/standard.scss`

### Changes

**Background color #FBF6E8 — extended to course view pages**
- Previously only `body.pagelayout-frontpage` got the beige `#FBF6E8` background.
- Added `body.pagelayout-course`, `body.pagelayout-incourse`, and `body.pagelayout-coursecategory` to the same selector list in both `typography.scss` (the `body` background) and `standard.scss` (the `#page`, `#region-main`, `.main-inner`, and `#page.drawers` overrides) so the main course page, activity-within-a-course pages, and category pages now share the same background as the home page.
- Other pages (login, admin, etc.) still keep their native backgrounds.

## 2026-04-12 — Page Background Color, Global Text Color & Header Background

### Files Modified
- `scss/typography.scss`
- `scss/header.scss`
- `scss/standard.scss`
- `scss/frontpage.scss`
- `scss/footer.scss`
- `templates/core/user_menu.mustache` (new)
- `templates/course_blocks.mustache`
- `templates/footer.mustache`
- `templates/navbar.mustache`
- `templates/my_courses_block.mustache` (new)
- `templates/guest_login_widget.mustache` (new)
- `classes/output/core/course_renderer.php`
- `amd/src/theme.js`
- `amd/build/theme.min.js`

### Changes

**Body — set page background color to #FBF6E8 (frontpage only)**
- Added `background-color: #FBF6E8` (warm beige) on `body.pagelayout-frontpage` so only the home page gets the custom background. Other pages retain their native backgrounds (including background images like login).

**Body — set global text color to #302F26**
- Changed `body` `color` from `$color_storm_dust_approx` to `#302F26` (dark olive-brown).
- Changed `h1`–`h6` heading `color` from `$secondary` to `#302F26` to match.

**Lower header — set background color to #ADB185**
- Changed `#header` `background` from `$primary` to `#ADB185` (muted olive-green).

**Guest login message — replace with "Create an account or Log in to save your progress"**
- Created `templates/core/user_menu.mustache` as a theme override of the core template.
- Replaced the "You are currently using guest access" text and separate "Log in" link with a single message: "Create an account or Log in to save your progress".
- "Create an account" links to `/login/signup.php` and "Log in" links to `/login/index.php`, both underlined.

**"Available courses" heading — renamed to "All Courses"**
- Changed `get_string('availablecourses')` to hardcoded `'All Courses'` in `course_renderer.php`.

**Top header title — Epilogue Black 900, 30px**
- Added `@font-face` declaration for Epilogue (weight 900/Black) from `fonts/Epilogue/static/Epilogue-Black.ttf` in `header.scss`.
- Updated `.top-header-title` to use `font-family: 'Epilogue'`, `font-weight: 900`, `font-size: 30px`.
- Updated `.top-header-nav a` links to use `font-family: 'Epilogue'`, `font-weight: 900`, `font-size: 16px`.

**Search bar — repositioned inline with "All Courses" heading**
- Moved the search box from a full-width centered position above the course list to a right-aligned compact (300px) search bar that sits on the same line as the "All Courses" heading.
- Added JS in `amd/src/theme.js` (and minified build) that moves the search box DOM node into `#frontpage-available-course-list` on page load, so it sits next to the "All Courses" title — not the "My courses" title above it.
- Search box is `position: absolute` anchored to the top-right of `#frontpage-available-course-list`.

**Search bar — pill-shape Figma style**
- Restyled the search bar to match the Figma mock: pill-shape (`border-radius: 999px`), tan/beige background (`#E0DACB`), left-aligned FontAwesome magnifier icon drawn via `::before` pseudo-element.
- Removed the border and default submit button (search still works via Enter key).
- Input padded to leave room for the icon on the left.

**Course cards — default "Self paced course" tag when no tags are set**
- Updated `course_blocks.mustache` and `my_courses_block.mustache` to show a single `"Self paced course"` pill when the course has no tags in Moodle. Gives users a meaningful descriptor while matching the Figma design's example tag.

**Top header — align logo height with title**
- Increased the top-header logo image height from `30px` to `38px` so it visually balances with the `BASILICA BIO` title (Epilogue 900, 30px).
- Added `max-width: 60px` and `object-fit: contain` on the logo `<img>` as a safety cap for unusual logo dimensions.
- Wrapped logo in `inline-flex` with `line-height: 0` so the anchor's inline baseline doesn't add vertical space around the image.
- Logo is aligned to the **top** of the row (`align-self: flex-start`) rather than vertically centered — the title is also aligned to the top (`align-self: flex-start`) so their top edges line up.
- Added `margin-top: 4px` on the logo so it sits slightly below the very top of the inner box, visually matching the title's top-leading space.
- The overall top-bar height is unchanged (title line-box was already the tallest element), so no adjustments needed to `#header.fixed-top { top }`, `body { padding-top }`, or `#page-wrapper { margin-top }`.

**"All Courses" heading — Averia Serif Libre Light, 36px**
- Added `@font-face` for Averia Serif Libre (weight 300/Light) from `fonts/Averia_Serif_Libre/AveriaSerifLibre-Light.ttf` in `header.scss`.
- Styled `#frontpage-available-course-list h2` with `font-family: 'Averia Serif Libre'`, `font-weight: 300`, `font-size: 36px`.

**Course card fonts — tags, title, description**
- Added `@font-face` for Epilogue Regular (400) and Averia Serif Libre Regular (400) in `header.scss`.
- Tags (`.course-tag`): Epilogue 400, 12px, color #302F26.
- Title (`.title-block h6`): Averia Serif Libre 400, 24px, color #000.
- Description (`.desc-block p`): Epilogue 400, 15px, color #000.

**Course card — entire card clickable**
- Wrapped each course card in an `<a class="available-content-link">` in `course_blocks.mustache` so the entire card is a hyperlink to the course.
- Removed individual `<a>` tags from the image and "Take course" button.
- Removed the "Take course" button entirely from the card.
- Added `.available-content-link` styles to preserve card appearance (no underline, inherit colors).

**Font loading fix — use `[[setting:fontwww]]` instead of `[[font:theme|...]]`**
- The academi theme uses `[[setting:fontwww]]` (resolved by `theme_academi_pre_css_set_fontwww()` in `lib.php`) for font URLs, not Moodle's `[[font:theme|...]]` syntax. All `@font-face` declarations updated accordingly.

**Footer — redesigned to match Figma spec**
- Rewrote `templates/footer.mustache` to produce a clean two-section layout: left (logo + "BASILICA BIO" + italic copyright line) and right (two link columns: "Keep in touch" and "People").
- Added `@font-face` declarations for Epilogue Bold (700) and Averia Serif Libre Italic (400).
- New `.footer-main.footer-custom` styles in `footer.scss`:
  - Background `#E0DACB`, min-height `228px`, padding `48px 32px`.
  - Brand text: Epilogue 700, 18px, uppercase, letter-spacing -0.45px, `#302F26`.
  - Copyright line: Averia Serif Libre Italic, 12px, uppercase, letter-spacing 1.2px, `#302F26`.
  - Column titles: Epilogue 900, 10px, uppercase, `#7A776B`.
  - Links: Averia Serif Libre 300, 14px, underlined, `#302F26`.
- Hidden the old `.footer-bottom` copyright strip when using the custom footer.
- Added responsive styles to stack columns on mobile (≤767px).

**My Courses section — new section above "All Courses"**
- Added a new template `templates/my_courses_block.mustache` rendered as a separate frontpage section *above* the Available Courses block (not nested inside it).
- New `academi_my_courses_block()` method in `course_renderer.php` renders this block just before `FRONTPAGEALLCOURSELIST`.
- Section heading: Averia Serif Libre 300, 36px, color `#313C0A`.
- Three equal-width columns in a flex row:
  1. Two stacked stat cards ("Lessons completed", "Lessons saved") — background `#E0DACB`, rounded 10px, with number in Averia Serif Libre 700 72px, colored icon badges (green/blue), and a bottom link with bottom-border accent.
  2. Up to two enrolled course progress cards — background image, rounded 10px with shadow, showing course title (Averia Serif Libre 24px), short description, and a 13px-tall rounded progress bar with percentage label.
- Wired up to real Moodle data:
  - **Lessons completed** = count of courses where the user's progress (`\core_completion\progress::get_course_progress_percentage()`) is 100%. This matches exactly what the progress bars on each course card show, avoiding reliance on `{course_completions}.timecompleted` which can lag behind until cron aggregation runs.
  - **Lessons saved** = count of favorited courses via `core_favourites\service_factory`.
  - **Course cards** = up to 2 enrolled courses ordered by `{user_lastaccess}.timeaccess DESC`; fallback to `enrol_get_my_courses()` when no lastaccess records exist.
  - **Progress** = `\core_completion\progress::get_course_progress_percentage()` (returns 0–100 or null).
  - **Course image** = course overview file, falling back to the theme's `no-image` pix.
  - **Course tags** = `\core_tag_tag::get_item_tags_array('core', 'course', $course->id)` — real Moodle course tags shown as pills above the title; "No tags" fallback if the course has none.
- Section is **hidden entirely for guests and not-logged-in users**, who instead see a compact login/signup widget above "All Courses" (see next entry).
- Empty state (logged in but no enrolled courses): shows a "You're not enrolled in any courses yet" card with a link to the All Courses section.
- Aligned My Courses card visuals to match All Courses cards: `border-radius: 10px`, `gap: 15px` between cards, matching `box-shadow`, and no forced min-height (cards stretch naturally to match row height).
- **Progress bar always renders** on My Courses cards (removed the `{{#hasprogress}}` conditional from the template). When the course has no completion tracking enabled, the bar shows 0% with an empty fill.

**All Courses card — image now fills the whole card as background**
- Changed `.available-content` structure so the course image is absolutely positioned and fills the entire card, with the text block (`tags-block`, `title-block`, `desc-block`) overlaid at the bottom with a semi-transparent white background.
- Fixed card `height: 450px` so every card is exactly the same size regardless of description length (was `min-height: 400px`, which allowed cards to grow to fit long content and resulted in uneven heights).
- Matches the My Courses card style for visual consistency.

**All Courses card — description uniform height with ellipsis truncation**
- Added CSS line-clamp on `.desc-block p` (`-webkit-line-clamp: 3`) so the description is clipped to 3 lines with a trailing ellipsis if the text would otherwise overflow.
- Added `min-height: calc(15px * 1.25 * 3)` (≈56px) on `.desc-block` so the description area reserves the full 3-line height even when the description is shorter — keeping all card footers aligned.
- The template truncates the summary at 300 characters via `{{#shortentext}}`; the line clamp is a safety layer so cards in the same row keep uniform visible heights regardless of viewport width.

**Course card tag color — unified to olive-green `#ADB185`**
- All Courses tag pills were peach (`#f5d6c8`), My Courses tag pills were olive-green (`#ADB185`). Changed the All Courses tag background to `#ADB185` so both sections share the same tag style (also matches the lower header color for theme cohesion).

**Guest login widget — new login/signup card for not-logged-in users**
- Added a new `templates/guest_login_widget.mustache` rendered by `academi_guest_login_widget()` in `course_renderer.php`.
- Shows above "All Courses" ONLY for guests / not-logged-in users (in place of the My Courses block).
- Contains:
  - Heading "Log in to see and save your progress:"
  - Username and password fields (POST to `/login/index.php` with `logintoken` CSRF)
  - "Create account" outline button (links to `/login/signup.php`, shown only if self-registration is enabled)
  - "Log in" primary button
- Styled in `scss/frontpage.scss` under "Guest login widget" — rounded inputs with beige pill background, dark olive primary button, responsive stacked layout on small screens.

**External hyperlinks wired up**
- Top header nav:
  - HOME → `https://basilicabio.org/`
  - RESOURCES → `https://basilicabio.org/resource-hub`
  - PROGRAMS → `https://basilicabio.org/get-involved`
  - LEARN → stays on the Moodle site
- Footer:
  - Newsletter → `https://basilicabio.org/newsletter`
  - Our team → `https://basilicabio.org/our-team-2`
  - Volunteer interest form → `https://basilicabio.org/contact-us`
- All external links open in a new tab (`target="_blank" rel="noopener"`).

**#page main content area — set background to #FBF6E8 (frontpage only)**
- Added `background-color: #FBF6E8` on `#page`, `#region-main`, `.main-inner`, and `#page.drawers` — but **scoped to `body.pagelayout-frontpage`** only in `standard.scss` and `typography.scss`.
- Other pages (login, course pages, admin, etc.) retain their native backgrounds (including background images).
- Changed `#frontpage-available-course-list` and `#site-news-forum` background from `$white` to `#FBF6E8` in `frontpage.scss` (already scoped under `.pagelayout-frontpage`).
- Changed `#frontpage-available-course-list` and `#site-news-forum` background from `$white` to `#FBF6E8` in `frontpage.scss`.

## 2026-03-15 — Header Layout & Footer Adjustments

### Files Modified
- `scss/header.scss`
- `scss/footer.scss`

### Changes

**Header — Right-align site navigation**
- Added flexbox rules to `.container-fluid.navbar-nav` so the logo stays left-aligned and `.primary-navigation` + `#usernavigation` sit together on the right side of the header.

**Header — Active tab styling**
- Replaced the default background-color highlight on the active/selected nav link with green text (`#2e7d32`) and bold font weight. Background is now transparent.

**Footer — Reduce logo size**
- Reduced `.footer-logo` max-width from 200px to 80px and image max-height from 150px to 60px, making the footer shorter overall.

**Footer — Right-align social media icon, line style**
- Right-aligned the `.social-media` section using `text-align: right` and `justify-content: flex-end`.
- Removed the 60×60px box, border-radius, background-color, and hover animation from social media icons so they render as plain line icons without a surrounding box.

## 2026-03-15 — Reduce Footer Height & Revert Instagram Icon Shape

### Files Modified
- `scss/footer.scss`

### Changes

**Footer — Reduce overall height**
- Reduced `.footer-main` padding from `30px 0 54px` to `15px 0 20px`.
- Reduced `.infoarea`, `.foot-links`, `.contact-info`, and `.social-media` top padding from 25px to 10px.

**Footer — Revert Instagram icon to original boxed shape, remove background only**
- Restored the 60×60px box, border-radius, hover animation, and full icon structure from the original theme.
- Changed `background-color` on the icon link from the original solid color to `transparent`, removing the filled background while keeping the boxed icon shape.

## 2026-03-15 — Match Footer Logo & Social Media Icon Size and Position

### Files Modified
- `scss/footer.scss`

### Changes

**Footer logo — resize and position top-left**
- Set `.footer-logo` to 50×50px (`max-width: 50px`, `img` width/height both 50px) and removed bottom margin so it sits at the top-left corner of its column.

**Social media icon — resize and position top-right**
- Changed icon `li` size from 60×60px to 50×50px to match the footer logo.
- Removed extra margin (`margin-right: 0`, `margin-bottom: 0`) so it sits cleanly at the top-right corner.
- The `ul` already uses `justify-content: flex-end` to right-align.

## 2026-03-15 — Vertically Center Social Media Icon in Footer

### Files Modified
- `scss/footer.scss`

### Changes

**Social media — vertical centering**
- Made `.social-media` a flex container with `align-items: center` and `justify-content: flex-end` so the Instagram icon is vertically centered within its `.col-md-6` column while staying right-aligned.
- Set `height: 100%` on `.social-media` so it fills the column height.
- Added `align-items: stretch` on the footer `.row` so both columns share equal height, enabling the vertical centering to work.

## 2026-03-15 — Remove Gap Between Primary Navigation and User Navigation

### Files Modified
- `scss/header.scss`

### Changes

**Header — close gap before usernavigation**
- The `#usernavigation` element has Bootstrap's `ml-auto` class in the HTML, which adds `margin-left: auto` and pushes it far to the right, creating a visual gap from `.primary-navigation`.
- Added `margin-left: 0 !important` on `#usernavigation` inside the `#header.navbar.fixed-top` scope to override this and keep it adjacent to the primary navigation.

## 2026-03-15 — Remove ::before Pseudo-element on #usernavigation

### Files Modified
- `scss/header.scss`

### Changes

**Header — hide phantom ::before element**
- Added `display: none` on `#usernavigation::before` to remove a ~170px-wide pseudo-element (likely a Bootstrap/Moodle core flexbox hack) that was creating extra space before the user navigation icons.

## 2026-03-15 — Reduce Header Left/Right Padding

### Files Modified
- `scss/header.scss`

### Changes

**Header — minimize horizontal padding**
- Reduced `#header.fixed-top` padding from `0 40px` to `0 10px` in the `@media (min-width: 992px)` block, making the left and right padding minimal.

## 2026-03-15 — Remove Inner Padding on Header Container

### Files Modified
- `scss/header.scss`

### Changes

**Header — remove container-fluid inner padding**
- Added `padding-left: 0; padding-right: 0` on `.container-fluid.navbar-nav` inside `#header.navbar.fixed-top` to eliminate the gap between the `<nav>` element and its inner container.
- Reverted the earlier `#header.fixed-top` padding change back to the original `0 40px` since that wasn't the source of the gap.

## 2026-03-15 — Config.php: Disable Theme Designer Mode, Restore Debug

### Files Modified
- `config.php`

### Changes

**Disable themedesignermode**
- Set `$CFG->themedesignermode = false` to stop Moodle from showing debug overlays (red dashed borders) on page elements. This also enables CSS caching — purge caches after SCSS changes.

**Restore debug settings**
- Reverted `$CFG->debug` back to `E_ALL` and `$CFG->debugdisplay` back to `1` for development logging.

## 2026-03-15 — Add Attribution Comments to All Changed Files

### Files Modified
- `scss/header.scss`
- `scss/footer.scss`
- `config.php`

### Changes

**Attribution comments**
- Added `// Changes by @bb` or `/* Changes by @bb */` comments at every code change point across all modified files for traceability.

## 2026-03-15 — Redesign Available Course Cards

### Files Modified
- `templates/course_blocks.mustache`
- `scss/frontpage.scss`

### Changes

**Template — new course card structure**
- Added `.tags-block` section with placeholder tags ("Self paced course", "45 minutes") — tag logic is not yet implemented, this is UI scaffolding only.
- Added `.desc-block` for course summary/description text (was already in template but only shown when summary exists).
- Added `.action-block` with a "Take course" button linking to the course page.

**SCSS — new card styling**
- Changed card background from the dark `$primary` bar to a white card with rounded corners and subtle box shadow.
- Added `.tags-block` styles: pill-shaped tags with peach background (`#f5d6c8`), flex layout with gap.
- Changed `.title-block h6` to bold 20px black text instead of white on dark background.
- Added `.desc-block` with grey 14px text for course descriptions.
- Added `.btn-take-course` button: peach background, black border, bold text, hover transitions to primary color.
- Increased border-radius from 5px to 10px for a softer card appearance.

## 2026-03-15 — Course Card Refinements

### Files Modified
- `templates/course_blocks.mustache`
- `scss/frontpage.scss`

### Changes

**Template fixes**
- Title is now plain text (no link) — the "Take course" button is the only clickable action.
- Added placeholder description text when no course summary exists.
- Tags area now has multiple placeholder pills (Self paced course, Beginner, 45 minutes, Environmental Justice).

**SCSS fixes**
- `.available-info` changed to `flex-direction: column` for vertical stacking of tags, title, description, and button.
- `.tags-block` changed to `flex-wrap: nowrap` with `overflow-x: auto` for horizontal scrolling when tags overflow. Hidden scrollbar for clean look.
- `.course-tag` items use `flex-shrink: 0` to prevent pill compression.
- Removed `a` wrapper from `.title-block h6` styling — title is now plain black bold text.

## 2026-03-15 — Equal Height Course Cards

### Files Modified
- `scss/frontpage.scss`

### Changes

**Course cards — equal height**
- Set `.slick-slide` to `height: auto !important` and inner `> div` to `height: 100%` so Slick slider allows equal-height cards.
- Made `.available-content` a flex column with `height: 100%` to fill the slide.
- Added `flex-grow: 1` on `.available-info` so the info section expands to fill remaining space.
- Changed `.action-block` to `margin-top: auto` to pin the "Take course" button to the bottom of every card regardless of content length.

## 2026-03-15 — Wider Course Cards (3 Per Row)

### Files Modified
- `amd/src/frontpage.js`
- `amd/build/frontpage.min.js`

### Changes

**Slick slider — reduce slides per row for wider cards**
- Desktop: `slidesToShow` changed from 4 to 3.
- Tablet (≤991px): changed from 3 to 2.
- Mobile (≤767px): changed from 2 to 1.
- Mobile (≤575px): remains 1.
- Both source and minified JS updated to stay in sync.

## 2026-03-15 — Pass Course Summary to Card Template

### Files Modified
- `classes/output/core/course_renderer.php`

### Changes

**Course renderer — include summary in template data**
- The `available_coursebox()` method was only passing `name`, `link`, and `imgurl` to the mustache template. Added `$data['summary'] = $course->summary` so the course summary from Moodle is now available in the template.
- This allows the `{{#summary}}` block in `course_blocks.mustache` to render the actual course description instead of the hardcoded placeholder.

## 2026-03-15 — Dynamic Course Tags from Moodle Settings

### Files Modified
- `classes/output/core/course_renderer.php`
- `templates/course_blocks.mustache`

### Changes

**PHP renderer — fetch real course tags**
- Added `\core_tag_tag::get_item_tags_array('core', 'course', $course->id)` to retrieve tags set on each course in Moodle.
- Passes `tags` (array of `{tagname}` objects) and `hastags` (boolean) to the template.

**Template — replace hardcoded tags with dynamic ones**
- Replaced the four hardcoded placeholder pills with a `{{#tags}}` loop that renders each real tag as a `<span class="course-tag">`.
- Shows "No tags" pill as fallback when a course has no tags set.
- Tags are managed via: Course settings → Tags field, or Site Administration → Courses → Manage courses → edit a course → Tags.

### Taller Card Image
- Increased `.available-img` height from 250px to 350px for taller course cards.

## 2026-03-15 — Footer Logo and Text Side by Side

### Files Modified
- `scss/footer.scss`

### Changes

**Footer — inline logo and text**
- Made `.infoarea` a flex row with `align-items: center` and `gap: 15px` so the footer logo and the text paragraph sit next to each other horizontally instead of stacking vertically.
- Added `flex-shrink: 0` on `.footer-logo` to prevent the logo from shrinking.

## 2026-03-15 — Add Top Header Bar

### Files Modified
- `templates/navbar.mustache`
- `scss/header.scss`

### Changes

**Template — top header bar**
- Added a new `#top-header` div above the existing `<nav id="header">` containing:
  - Logo icon (reuses the theme logo)
  - "BASILICA BIO" title text
  - Four navigation links: HOME, RESOURCES, PROGRAMS, LEARN
- The existing Moodle header becomes the lower bar with edit mode, user menu, notifications, etc.

**SCSS — top header styling**
- Light beige background (`#f5f0e8`) with subtle border.
- Fixed position at top with `z-index: 1041` (above the main header).
- Flex layout: logo + title on the left, nav links on the right.
- Active/hover state shows underline on links.
- Pushed `#header.fixed-top` down by 54px and added `body` padding-top to account for the new bar.

## 2026-03-15 — Move Primary Nav Links into User Dropdown & Hide from Lower Header

### Files Modified
- `scss/header.scss`
- `amd/src/theme.js`
- `amd/build/theme.min.js`

### Changes

**SCSS — hide primary navigation and logo from lower header**
- Added `display: none !important` on `.primary-navigation` inside `#header.fixed-top` since those links are now in the user dropdown.
- Added `display: none` on `.navbar-brand` to hide the logo (now shown in the top bar).

**JS — inject nav links into user dropdown**
- On page load, the primary navigation links (Home, Dashboard, My courses, Site administration) are extracted and prepended as dropdown items into the user menu (`#carousel-item-main`), separated by a divider from the existing items (Preferences, Switch role, Log out).

## 2026-03-15 — Move Notifications & Messaging into User Dropdown

### Files Modified
- `amd/src/theme.js`
- `amd/build/theme.min.js`

### Changes

**JS — move notification bell and messaging icon into user dropdown**
- On page load, "Notifications" and "Messages" items are prepended to the user dropdown menu (`#carousel-item-main`) with icons.
- Clicking them triggers the original popover/drawer toggle so functionality is preserved.
- The original notification and messaging elements in the header bar are hidden with `d-none`.

## 2026-03-15 — Edit Mode Left, User Menu Right in Lower Header

### Files Modified
- `scss/header.scss`

### Changes

**Lower header layout — edit mode left, user menu right**
- Made `#usernavigation` full width with `justify-content: space-between` and `flex-direction: row-reverse`.
- `.editmode-switch-form` gets `order: -1` and `margin-right: auto` to pin it to the left.
- `.usermenu-container` gets `margin-left: auto` to pin it to the right.
- Removed the old `margin-left: 10px` on `.editmode-switch-form`.
