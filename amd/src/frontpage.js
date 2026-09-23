define(['jquery', 'theme_academi/slick'], function($) {
    'use strict';
    var RTL = ($('body').hasClass('dir-rtl')) ? true : false;
    return {
        init: function() {
        },
        // Available course block slider. Changes by @bb: reduced slidesToShow for wider cards.
        availablecourses: function() {
            $(".course-slider").slick({
                arrows: true,
                swipe: true,
                infinite: false,
                slidesToShow: 3,
                slidesToScroll: 3,
                rtl: RTL,
                responsive: [
                    {
                        breakpoint: 991,
                        settings: {
                            slidesToShow: 2,
                            slidesToScroll: 2,
                        }
                    },
                    {
                        breakpoint: 767,
                        settings: {
                            // Changes by @bb: 1.15 shows ~15% of the next card peeking, signaling swipe is possible
                            slidesToShow: 1.15,
                            slidesToScroll: 1,
                        }
                    },
                    {
                        breakpoint: 575,
                        settings: {
                            // Changes by @bb: same peek pattern on phones
                            slidesToShow: 1.15,
                            slidesToScroll: 1,
                        }
                    }
                ],

            });

            var prow = $(".course-slider").attr("data-crow");
            prow = parseInt(prow);
            if (prow < 2) {
                $("#available-courses .pagenav").hide();
            }
        },
        // Promoted course block slider.
        promotedcourse: function() {
            $(".promatedcourse-slider").slick({
                arrows: false,
                dots: true,
                swipe: true,
                infinite: false,
                slidesToShow: 4,
                slidesToScroll: 4,
                rtl: RTL,
                responsive: [
                    {
                        breakpoint: 991,
                        settings: {
                            slidesToShow: 3,
                            slidesToScroll: 3,
                        }
                    },
                    {
                        breakpoint: 767,
                        settings: {

                            slidesToShow: 2,
                            slidesToScroll: 2,
                        }
                    },
                    {
                        breakpoint: 575,
                        settings: {
                            slidesToShow: 1,
                            slidesToScroll: 1,
                        }
                    }
                ],

            });

            var prow = $(".promatedcourse-slider").attr("data-crow");
            prow = parseInt(prow);
            if (prow < 2) {
                $("#promoted-courses .pagenav").hide();
            }
        },
    };
});
