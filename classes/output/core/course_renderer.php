<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Course renderer.
 *
 * @package theme_academi
 * @copyright 2023 onwards LMSACE Dev Team (http://www.lmsace.com)
 * @author LMSACE Dev Team
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

namespace theme_academi\output\core;

use html_writer;
use moodle_url;
use lang_string;
use stdClass;
use context_course;

/**
 * The core course renderer.
 *
 * Can be retrieved with the following:
 * $renderer = $PAGE->get_renderer('core','course');
 */
class course_renderer extends \core_course_renderer {

    /**
     * Call the frontpage slider js.
     * @param string $blockid
     * @return void
     */
    public function include_frontslide_js($blockid) {
        $this->page->requires->js_call_amd('theme_academi/frontpage', $blockid, []);
    }


    /**
     * Returns HTML to print list of available courses for the frontpage.
     *
     * @return string
     */
    public function frontpage_available_courses() {
        global $CFG;
        $displayoption = theme_academi_get_setting('availablecoursetype');
        if ($displayoption != '1') {
            return parent::frontpage_available_courses();
        }

        $chelper = new \coursecat_helper();
        $chelper->set_show_courses(self::COURSECAT_SHOW_COURSES_EXPANDED)->set_courses_display_options(
                [
                    'recursive' => true,
                    'limit' => $CFG->frontpagecourselimit,
                    'viewmoreurl' => new moodle_url('/course/index.php'),
                    'viewmoretext' => new lang_string('fulllistofcourses'),
                ]);

        $chelper->set_attributes(['class' => 'frontpage-course-list-all']);
        $courses = \core_course_category::top()->get_courses($chelper->get_courses_display_options());
        $totalcount = \core_course_category::top()->get_courses_count($chelper->get_courses_display_options());
        if (!$totalcount && !$this->page->user_is_editing() &&
            has_capability('moodle/course:create', \context_system::instance())) {
            // Print link to create a new course, for the 1st available category.
            return $this->add_new_course_button();
        }
        if (!empty($courses)) {
            $data = [];
            $attributes = $chelper->get_and_erase_attributes('courses');
            $content = \html_writer::start_tag('div', $attributes);
            foreach ($courses as $course) {
                $data[] = $this->available_coursebox($chelper, $course);
            }
            $totalcourse = count($data);
            $content .= $this->render_template('availablecourses', ['courses' => $data, 'totalavacount' => $totalcourse]);
            $content .= \html_writer::end_tag('div');
            $this->include_frontslide_js('availablecourses');
            return $content;
        }
    }

    /**
     * Return contents for the available course block on the frontpage.
     *
     * @param coursecat_helper $chelper course helper.
     * @param array $course course detials.
     *
     * @return array $data available course data.
     */
    public function available_coursebox(\coursecat_helper $chelper, $course) {
        global $CFG;
        $coursename = $chelper->get_course_formatted_name($course);
        $data['name'] = $coursename;
        $data['link'] = new \moodle_url('/course/view.php', ['id' => $course->id]);
        $noimgurl = $this->output->image_url('no-image', 'theme');
        foreach ($course->get_course_overviewfiles() as $file) {
            $isimage = $file->is_valid_image();
            $imgurl = moodle_url::make_file_url("$CFG->wwwroot/pluginfile.php",
                '/' . $file->get_contextid() . '/' . $file->get_component() . '/' .
                $file->get_filearea() . $file->get_filepath() . $file->get_filename(), !$isimage);
            if (!$isimage) {
                $imgurl = $noimgurl;
            }
        }
        if (empty($imgurl)) {
            $imgurl = $noimgurl;
        }
        $data['imgurl'] = $imgurl;
        // Changes by @bb: pass course summary to template for description block.
        $data['summary'] = $course->summary;
        // Changes by @bb: pass course tags to template.
        $tags = \core_tag_tag::get_item_tags_array('core', 'course', $course->id);
        $data['tags'] = [];
        foreach ($tags as $tag) {
            $data['tags'][] = ['tagname' => $tag];
        }
        $data['hastags'] = !empty($tags);
        return $data;
    }

    /**
     * Render the template.
     *
     * @param string $template name of the template.
     * @param array $data Data.
     *
     * @return string.
     */
    public function render_template($template, $data) {
        $data[$template] = 1;
        $data['ouput'] = $this->output;
        return $this->output->render_from_template('theme_academi/course_blocks', $data);
    }

    /**
     * Render the custom "My Courses" block.
     * Changes by @bb — shows enrolled courses with progress for logged-in users,
     * and a signup/login widget for guests / not-logged-in users.
     *
     * @return string
     */
    public function academi_my_courses_block() {
        global $USER, $CFG;

        // Guests / not logged in: show a signup/login widget instead.
        if (!isloggedin() || isguestuser()) {
            return $this->academi_guest_login_widget();
        }

        require_once($CFG->libdir . '/enrollib.php');
        require_once($CFG->libdir . '/completionlib.php');

        $data = [
            'lessonscompleted' => $this->academi_count_completed_modules($USER->id),
            'lessonssaved' => $this->academi_count_favourite_courses($USER->id),
            'mycoursesurl' => (new moodle_url('/my/courses.php'))->out(),
            'courses' => $this->academi_get_my_courses_with_progress($USER->id, 2),
            'hascourses' => false,
        ];
        $data['hascourses'] = !empty($data['courses']);

        return $this->output->render_from_template('theme_academi/my_courses_block', $data);
    }

    /**
     * Render the signup/login widget shown above All Courses for guests.
     * Changes by @bb.
     *
     * @return string
     */
    protected function academi_guest_login_widget() {
        global $CFG;
        $data = [
            'loginurl' => (new moodle_url('/login/index.php'))->out(),
            'signupurl' => (new moodle_url('/login/signup.php'))->out(),
            'logintoken' => \core\session\manager::get_login_token(),
            'cansignup' => !empty($CFG->registerauth) && $CFG->registerauth !== 'none',
        ];
        return $this->output->render_from_template('theme_academi/guest_login_widget', $data);
    }

    /**
     * Count fully completed courses for the user — defined as courses where
     * \core_completion\progress::get_course_progress_percentage() == 100.
     * This matches what is shown on the progress bars of each course card.
     * Changes by @bb.
     *
     * @param int $userid
     * @return int
     */
    protected function academi_count_completed_modules($userid) {
        global $CFG;
        require_once($CFG->libdir . '/enrollib.php');
        require_once($CFG->libdir . '/completionlib.php');

        $courses = enrol_get_all_users_courses($userid, true, 'id, shortname, fullname, enablecompletion');
        if (empty($courses)) {
            return 0;
        }
        $count = 0;
        foreach ($courses as $course) {
            $progress = \core_completion\progress::get_course_progress_percentage($course, $userid);
            if (!is_null($progress) && (int) floor($progress) >= 100) {
                $count++;
            }
        }
        return $count;
    }

    /**
     * Count favourited (saved) courses for the user via core_favourites service.
     * Changes by @bb.
     *
     * @param int $userid
     * @return int
     */
    protected function academi_count_favourite_courses($userid) {
        try {
            $usercontext = \context_user::instance($userid);
            $ufservice = \core_favourites\service_factory::get_service_for_user_context($usercontext);
            $favourites = $ufservice->find_favourites_by_type('core_course', 'courses');
            return is_array($favourites) ? count($favourites) : 0;
        } catch (\Exception $e) {
            return 0;
        }
    }

    /**
     * Get up to $limit enrolled courses for the user, ordered by last access,
     * with progress percentage attached.
     * Changes by @bb.
     *
     * @param int $userid
     * @param int $limit
     * @return array list of course view-model arrays for the mustache template
     */
    protected function academi_get_my_courses_with_progress($userid, $limit = 2) {
        global $DB, $CFG;

        // Get enrolled courses ordered by most recently accessed.
        $sql = 'SELECT c.*, l.timeaccess
                FROM {user_lastaccess} l
                INNER JOIN {course} c ON c.id = l.courseid
                INNER JOIN {enrol} e ON e.courseid = c.id
                INNER JOIN {user_enrolments} ue ON ue.enrolid = e.id AND ue.userid = l.userid
                WHERE l.courseid > 1 AND l.userid = :userid
                ORDER BY l.timeaccess DESC';
        $courses = $DB->get_records_sql($sql, ['userid' => $userid], 0, $limit);

        // Fallback: if no lastaccess data yet, use enrol_get_my_courses directly.
        if (empty($courses)) {
            $courses = enrol_get_my_courses('*', 'visible DESC, sortorder ASC', $limit);
        }

        $data = [];
        foreach ($courses as $course) {
            $courseurl = new moodle_url('/course/view.php', ['id' => $course->id]);
            $progress = \core_completion\progress::get_course_progress_percentage($course, $userid);
            $progresspct = !is_null($progress) ? (int) floor($progress) : 0;

            // Course image (use same logic as available_coursebox).
            $imgurl = $this->academi_get_course_image_url($course);

            // Truncate summary.
            $summary = strip_tags(format_text($course->summary ?? '', $course->summaryformat ?? FORMAT_HTML));
            $summary = shorten_text($summary, 100, true);

            // Course tags.
            $coursetags = \core_tag_tag::get_item_tags_array('core', 'course', $course->id);
            $tags = [];
            foreach ($coursetags as $tag) {
                $tags[] = ['tagname' => $tag];
            }

            $data[] = [
                'name' => format_string($course->fullname, true, ['context' => context_course::instance($course->id)]),
                'url' => $courseurl->out(),
                'imgurl' => $imgurl,
                'summary' => $summary,
                'hassummary' => !empty($summary),
                'hasprogress' => !is_null($progress),
                'progress' => $progresspct,
                'tags' => $tags,
                'hastags' => !empty($tags),
            ];
        }

        return $data;
    }

    /**
     * Get a course image URL, falling back to the theme's no-image placeholder.
     * Changes by @bb.
     *
     * @param \stdClass $course
     * @return string
     */
    protected function academi_get_course_image_url($course) {
        global $CFG;
        $courseinlist = new \core_course_list_element($course);
        foreach ($courseinlist->get_course_overviewfiles() as $file) {
            if ($file->is_valid_image()) {
                $imgurl = moodle_url::make_file_url(
                    "$CFG->wwwroot/pluginfile.php",
                    '/' . $file->get_contextid() . '/' . $file->get_component() . '/' .
                        $file->get_filearea() . $file->get_filepath() . $file->get_filename(),
                    !$file->is_valid_image()
                );
                return $imgurl->out();
            }
        }
        // Fallback to theme's no-image.
        $noimg = $this->page->theme->image_url('no-image', 'theme');
        return $noimg->out();
    }

    /**
     * Promoted course content for the theme front page.
     *
     * @return string
     */
    public function promoted_courses() {
        global $CFG, $DB;

        $pcoursestatus = theme_academi_get_setting('pcoursestatus');
        $promotedtitle = theme_academi_get_setting('promotedtitle', 'format_html');
        $promotedtitle = theme_academi_lang($promotedtitle);
        $promotedcoursedesc = theme_academi_lang(theme_academi_get_setting('promotedcoursedesc'));
        $featuredids = theme_academi_get_setting('promotedcourses');
        $promotedcontent = empty($promotedtitle) && empty($promotedcoursedesc) ? false : true;
        $blockisempty = empty($promotedtitle) && empty($promotedcoursedesc) && empty($featuredids) ? false : $pcoursestatus;
        $blocks = [];
        if (!empty($featuredids)) {
            /* Get Featured courses id from DB */
            $rcourseids = (!empty($featuredids)) ? explode(",", $featuredids) : [];
            $helperobj = new \theme_academi\helper();
            $hcourseids = $helperobj->hidden_courses_ids();

            if (!empty($hcourseids)) {
                foreach ($rcourseids as $key => $val) {
                    if (in_array($val, $hcourseids)) {
                        unset($rcourseids[$key]);
                    }
                }
            }

            foreach ($rcourseids as $key => $val) {
                $ccourse = $DB->get_record('course', ['id' => $val]);
                if (empty($ccourse)) {
                    unset($rcourseids[$key]);
                    continue;
                }
            }

            $fcourseids = $rcourseids;
            $totalfcourse = count($fcourseids);
            if (!empty($fcourseids)) {
                $i = 0;
                foreach ($fcourseids as $courseid) {
                    $info = [];
                    $course = get_course($courseid);
                    $noimgurl = $this->output->image_url('no-image', 'theme');
                    $courseurl = new moodle_url('/course/view.php', ['id' => $courseid]);

                    if ($course instanceof stdClass) {
                        $course = new \core_course_list_element($course);
                    }

                    $imgurl = '';
                    $summary = $helperobj->strip_html_tags($course->summary);
                    $summary = $helperobj->course_trim_char($summary, 75);
                    foreach ($course->get_course_overviewfiles() as $file) {
                        $isimage = $file->is_valid_image();
                        $imgurl = \moodle_url::make_file_url("$CFG->wwwroot/pluginfile.php",
                        '/' . $file->get_contextid() . '/' . $file->get_component() . '/' .
                        $file->get_filearea() . $file->get_filepath() . $file->get_filename(), !$isimage);
                        if (!$isimage) {
                            $imgurl = $noimgurl;
                        }
                    }
                    if (empty($imgurl)) {
                        $imgurl = $noimgurl;
                    }
                    $info['courseurl'] = $courseurl;
                    $info['imgurl'] = $imgurl;
                    $info['coursename'] = $course->get_formatted_name();
                    $info['active'] = ($i == 1) ? true : false;
                    $blocks[] = $info;
                    $i++;
                }
            }
            $template['totalfcourse'] = $totalfcourse;
        }
        $template['coursestatus'] = !empty($featuredids) ? true : false;
        $template['courses'] = array_chunk($blocks, 5);
        $template['promatedcourse'] = $pcoursestatus;
        $template['blockisempty'] = $blockisempty;
        if (!$blockisempty) {
            $template['isblockempty'] = is_siteadmin() || $this->page->user_is_editing() ? true : false;
        }
        $template['promotedcontent'] = $promotedcontent;
        $template['promotedtitle'] = $promotedtitle;
        $template['promotedcoursedesc'] = $promotedcoursedesc;
        $this->include_frontslide_js('promotedcourse');
        return $this->output->render_from_template("theme_academi/course_blocks", $template);
    }

    /**
     * Outputs contents for frontpage as configured in $CFG->frontpage or $CFG->frontpageloggedin
     *
     * @return string
     */
    public function frontpage() {
        global $CFG, $SITE;

        $output = '';
        $themeblocks = new \theme_academi\academi_blocks();
        $beforelayout = [FRONTPAGEPROMOTEDCOURSE, FRONTPAGESITEFEATURES, FRONTPAGEMARKETINGSPOT];
        $afterlayout = [FRONTPAGEJUMBOTRON];
        if (isloggedin() && !isguestuser() && isset($CFG->frontpageloggedin)) {
            $frontpagelayout = explode(",", $CFG->frontpageloggedin);
        } else {
            $frontpagelayout = explode(",", $CFG->frontpage);
        }
        $academifrontpagelayout = array_merge($beforelayout, $frontpagelayout, $afterlayout);
        foreach ($academifrontpagelayout as $a) {
            switch($a) {
                // Display the main part of the front page.
                case FRONTPAGENEWS:
                    if ($SITE->newsitems) {
                        // Print forums only when needed.
                        require_once($CFG->dirroot .'/mod/forum/lib.php');
                        if (($newsforum = forum_get_course_forum($SITE->id, 'news')) &&
                                ($forumcontents = $this->frontpage_news($newsforum))) {
                            $newsforumcm = get_fast_modinfo($SITE)->instances['forum'][$newsforum->id];
                            $output .= $this->frontpage_part('skipsitenews', 'site-news-forum',
                                $newsforumcm->get_formatted_name(), $forumcontents);
                        }
                    }
                    break;

                case FRONTPAGEENROLLEDCOURSELIST:
                    $mycourseshtml = $this->frontpage_my_courses();
                    if (!empty($mycourseshtml)) {
                        $output .= $this->frontpage_part('skipmycourses', 'frontpage-course-list',
                            get_string('mycourses'), $mycourseshtml);
                    }
                    break;

                case FRONTPAGEALLCOURSELIST:
                    // Changes by @bb — prepend custom "My Courses" block before the All Courses block.
                    $output .= $this->academi_my_courses_block();
                    $availablecourseshtml = $this->frontpage_available_courses();
                    $output .= $this->frontpage_part('skipavailablecourses', 'frontpage-available-course-list',
                        'All Courses', $availablecourseshtml); // Changes by @bb — renamed from "Available courses"
                    break;

                case FRONTPAGECATEGORYNAMES:
                    $output .= $this->frontpage_part('skipcategories', 'frontpage-category-names',
                        get_string('categories'), $this->frontpage_categories_list());
                    break;

                case FRONTPAGECATEGORYCOMBO:
                    $output .= $this->frontpage_part('skipcourses', 'frontpage-category-combo',
                        get_string('courses'), $this->frontpage_combo_list());
                    break;

                case FRONTPAGECOURSESEARCH:
                    $output .= $this->box($this->course_search_form(''), 'd-flex justify-content-center');
                    break;
                case FRONTPAGEPROMOTEDCOURSE:
                    $output .= $this->promoted_courses();
                    break;
                case FRONTPAGESITEFEATURES:
                    $output .= $themeblocks->sitefeatures();
                    break;
                case FRONTPAGEMARKETINGSPOT:
                    $output .= $themeblocks->marketingspot();
                    break;
                case FRONTPAGEJUMBOTRON:
                    $output .= $themeblocks->jumbotron();
                    break;
            }
            $output .= '<br />';
        }
        return $output;
    }

    /**
     * Returns HTML to display a course category as a part of a tree
     *
     * This is an internal function, to display a particular category and all its contents.
     *
     * @param coursecat_helper $chelper various display options
     * @param core_course_category $coursecat
     * @param int $depth depth of this category in the current tree
     * @return string
     */
    protected function coursecat_category(\coursecat_helper $chelper, $coursecat, $depth) {
        // Open category tag.
        $classes = ['category'];
        if (empty($coursecat->visible)) {
            $classes[] = 'dimmed_category';
        }
        if ($chelper->get_subcat_depth() > 0 && $depth >= $chelper->get_subcat_depth()) {
            // Do not load content.
            $categorycontent = '';
            $classes[] = 'notloaded';
            if ($coursecat->get_children_count() ||
                    ($chelper->get_show_courses() >= self::COURSECAT_SHOW_COURSES_COLLAPSED && $coursecat->get_courses_count())) {
                $classes[] = 'with_children';
                $classes[] = 'collapsed';
            }
        } else {
            // Load category content.
            $categorycontent = $this->coursecat_category_content($chelper, $coursecat, $depth);
            $classes[] = 'loaded';
            if (!empty($categorycontent)) {
                $classes[] = 'with_children';
                // Category content loaded with children.
                $this->categoryexpandedonload = true;
            }
        }
        $combolistboxtype = (theme_academi_get_setting('comboListboxType') == 1) ? true : false;
        if ($combolistboxtype) {
            $classes[] = 'collapsed';
        }

        // Make sure JS file to expand category content is included.
        $this->coursecat_include_js();

        $content = html_writer::start_tag('div', [
            'class' => join(' ', $classes),
            'data-categoryid' => $coursecat->id,
            'data-depth' => $depth,
            'data-showcourses' => $chelper->get_show_courses(),
            'data-type' => self::COURSECAT_TYPE_CATEGORY,
        ]);

        // Category name.
        $categoryname = $coursecat->get_formatted_name();
        $categoryname = html_writer::link(new moodle_url('/course/index.php',
                ['categoryid' => $coursecat->id]),
                $categoryname);
        if ($chelper->get_show_courses() == self::COURSECAT_SHOW_COURSES_COUNT
                && ($coursescount = $coursecat->get_courses_count())) {
            $categoryname .= html_writer::tag('span', ' ('. $coursescount.')',
                    ['title' => get_string('numberofcourses'), 'class' => 'numberofcourse']);
        }
        $content .= html_writer::start_tag('div', ['class' => 'info']);

        $content .= html_writer::tag(($depth > 1) ? 'h4' : 'h3', $categoryname, ['class' => 'categoryname aabtn']);
        $content .= html_writer::end_tag('div'); // Info.

        // Add category content to the output.
        $content .= html_writer::tag('div', $categorycontent, ['class' => 'content']);

        $content .= html_writer::end_tag('div'); // Category.

        // Return the course category tree HTML.
        return $content;
    }

    /**
     * Returns HTML to display a tree of subcategories and courses in the given category
     *
     * @param coursecat_helper $chelper various display options
     * @param core_course_category $coursecat top category (this category's name and description will NOT be added to the tree)
     * @return string
     */
    protected function coursecat_tree(\coursecat_helper $chelper, $coursecat) {
        // Reset the category expanded flag for this course category tree first.
        $this->categoryexpandedonload = false;
        $categorycontent = $this->coursecat_category_content($chelper, $coursecat, 0);
        if (empty($categorycontent)) {
            return '';
        }

        // Start content generation.
        $content = '';
        $attributes = $chelper->get_and_erase_attributes('course_category_tree clearfix');
        $content .= html_writer::start_tag('div', $attributes);

        if ($coursecat->get_children_count()) {
            $classes = [
                'collapseexpand',
                'aabtn',
            ];

            // Check if the category content contains subcategories with children's content loaded.
            $combolistboxtype = (theme_academi_get_setting('comboListboxType') == 1) ? true : false;
            if ($this->categoryexpandedonload && !$combolistboxtype) {
                $classes[] = 'collapse-all';
                $linkname = get_string('collapseall');
            } else {
                $linkname = get_string('expandall');
            }

            // Only show the collapse/expand if there are children to expand.
            $content .= html_writer::start_tag('div', ['class' => 'collapsible-actions']);
            $content .= html_writer::link('#', $linkname, ['class' => implode(' ', $classes)]);
            $content .= html_writer::end_tag('div');
            $this->page->requires->strings_for_js(['collapseall', 'expandall'], 'moodle');
        }

        $content .= html_writer::tag('div', $categorycontent, ['class' => 'content']);

        $content .= html_writer::end_tag('div');

        return $content;
    }
}
