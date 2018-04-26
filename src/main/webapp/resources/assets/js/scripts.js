/* ---------------------------------------------
 common scripts
 --------------------------------------------- */
(function ($) {
    "use strict"; // use strict to start

// Countdown
    if ($('.countdown[data-countdown]').length) {

        $('.countdown[data-countdown]').each(function () {

            var $this = $(this),
                finalDate = $(this).data('countdown');

            $this.countdown(finalDate, function (event) {

                $this.html(event.strftime(
                    '<div class="counter-container"><div class="box"><div class="number">%-D</div><span>Day%!d</span></div><div class="box"><div class="number">%H</div><span>Hours</span></div><div class="box"><div class="number">%M</div><span>Minutes</span></div><div class="box"><div class="number">%S</div><span>Seconds</span></div></div>'
                ));
            });
        });
    }

    // Placeholder
    $('input, textarea').placeholder();

    //Progress bar
    var bar = $('.progress-bar');
    $(function () {
        $(bar).each(function () {
            var bar_width = $(this).attr('aria-valuenow');
            $(this).width(bar_width + '%');
        })
    });
    // Fullscreen Elements
    function getWindowWidth() {
        return Math.max($(window).width(), window.innerWidth);
    }

    function getWindowHeight() {
        return Math.max($(window).height(), window.innerHeight);
    }

    function fullscreenElements() {
        $('.section').each(function () {
            $(this).css('min-height', getWindowHeight());
        });
    }

    fullscreenElements();

    if ($('body').hasClass('youtube-background')) {
        $(document).ready(function () {
            ytbg("jEnd8JIMii4", 300, 600, 0);
        });
    }
    /*vQWlNALvbhE*/
    if ($('body').hasClass('img-bg')) {
        $(document).ready(function () {
            // backstretch
            $("body").backstretch([
                "resources/assets/images/travel1.jpg",
                "resources/assets/images/travel2.jpg",
                "resources/assets/images/travel3.jpg"
            ], {duration: 3000, fade: 750});
        });
    }
    if ($('body').hasClass('particles')) {
        particlesJS("particles-js", {
            "particles": {
                "number": {"value": 200, "density": {"enable": true, "value_area": 800}},
                "color": {"value": "#ffffff"},
                "shape": {
                    "type": "circle",
                    "stroke": {"width": 0, "color": "#000000"},
                    "polygon": {"nb_sides": 5}
                    //"image": {"src": "img/github.svg", "width": 100, "height": 100}
                },
                "opacity": {
                    "value": 1,
                    "random": true,
                    "anim": {"enable": true, "speed": 1, "opacity_min": 0, "sync": false}
                },
                "size": {
                    "value": 3,
                    "random": true,
                    "anim": {"enable": false, "speed": 4, "size_min": 0.3, "sync": false}
                },
                "line_linked": {"enable": true, "distance": 150, "color": "#ffffff", "opacity": 0.4, "width": 1},
                "move": {
                    "enable": true,
                    "speed": 10,
                    "direction": "none",
                    "random": true,
                    "straight": false,
                    "out_mode": "out",
                    "bounce": false,
                    "attract": {"enable": false, "rotateX": 600, "rotateY": 600}
                }
            },
            "interactivity": {
                "detect_on": "canvas",
                "events": {
                    "onhover": {"enable": true, "mode": "repulse"},
                    "onclick": {"enable": true, "mode": "repulse"},
                    "resize": true
                },
                "modes": {
                    "grab": {"distance": 400, "line_linked": {"opacity": 1}},
                    "bubble": {"distance": 250, "size": 0, "duration": 2, "opacity": 0, "speed": 8},
                    "repulse": {"distance": 400, "duration": 0.4},
                    "push": {"particles_nb": 4},
                    "remove": {"particles_nb": 2}
                }
            },
            "retina_detect": true
        });
    }
    if ($('body').hasClass('snowfall')) {
        particlesJS("particles-js", {
            "particles": {
                "number": {"value": 400, "density": {"enable": true, "value_area": 800}},
                "color": {"value": "#ffffff"},
                "shape": {
                    "type": "circle",
                    "stroke": {"width": 0, "color": "#000000"},
                    "polygon": {"nb_sides": 5}
                    //"image": {"src": "img/github.svg", "width": 100, "height": 100}
                },
                "opacity": {
                    "value": 0.5,
                    "random": true,
                    "anim": {"enable": true, "speed": 1, "opacity_min": 0, "sync": false}
                },
                "size": {
                    "value": 3,
                    "random": true,
                    "anim": {"enable": false, "speed": 40, "size_min": 0.1, "sync": false}
                },
                "line_linked": {"enable": false, "distance": 500, "color": "#ffffff", "opacity": 0.4, "width": 2},
                "move": {
                    "enable": true,
                    "speed": 10,
                    "direction": "bottom",
                    "random": true,
                    "straight": false,
                    "out_mode": "out",
                    "bounce": false,
                    "attract": {"enable": false, "rotateX": 600, "rotateY": 600}
                }
            },
            "interactivity": {
                "detect_on": "canvas",
                "events": {
                    "onhover": {"enable": true, "mode": "repulse"},
                    "onclick": {"enable": true, "mode": "repulse"},
                    "resize": true
                },
                "modes": {
                    "grab": {"distance": 400, "line_linked": {"opacity": 1}},
                    "bubble": {"distance": 250, "size": 0, "duration": 2, "opacity": 0, "speed": 8},
                    "repulse": {"distance": 400, "duration": 0.4},
                    "push": {"particles_nb": 4},
                    "remove": {"particles_nb": 2}
                }
            },
            "retina_detect": true
        });
    }
    if ($('body').hasClass('snow-solid')) {
        particlesJS("particles-js", {
            "particles": {
                "number": {"value": 400, "density": {"enable": true, "value_area": 800}},
                "color": {"value": "#ffffff"},
                "shape": {
                    "type": "circle",
                    "stroke": {"width": 0, "color": "#000000"},
                    "polygon": {"nb_sides": 5}
                    //"image": {"src": "img/github.svg", "width": 100, "height": 100}
                },
                "opacity": {
                    "value": 0.5,
                    "random": true,
                    "anim": {"enable": true, "speed": 1, "opacity_min": 0, "sync": false}
                },
                "size": {
                    "value": 3,
                    "random": true,
                    "anim": {"enable": false, "speed": 40, "size_min": 0.1, "sync": false}
                },
                "line_linked": {"enable": false, "distance": 500, "color": "#ffffff", "opacity": 0.4, "width": 2},
                "move": {
                    "enable": true,
                    "speed": 10,
                    "direction": "bottom",
                    "random": true,
                    "straight": false,
                    "out_mode": "out",
                    "bounce": false,
                    "attract": {"enable": false, "rotateX": 600, "rotateY": 600}
                }
            },
            "interactivity": {
                "detect_on": "canvas",
                "events": {
                    "onhover": {"enable": true, "mode": "repulse"},
                    "onclick": {"enable": true, "mode": "repulse"},
                    "resize": true
                },
                "modes": {
                    "grab": {"distance": 400, "line_linked": {"opacity": 1}},
                    "bubble": {"distance": 250, "size": 0, "duration": 2, "opacity": 0, "speed": 8},
                    "repulse": {"distance": 400, "duration": 0.4},
                    "push": {"particles_nb": 4},
                    "remove": {"particles_nb": 2}
                }
            },
            "retina_detect": true
        });
    }
    if ($('body').hasClass('zoom-out')) {
        $(function () {
            $("#element").kenburnsy({
                fullscreen: true
            });
        });
    }
    /*Contact Form*/
    /* ---------------------------------------------- /*
     * Ajax Forms
     /* ---------------------------------------------- */

    (function () {
        // E-mail validation via regular expression
        function isValidEmailAddress(emailAddress) {
            var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
            return pattern.test(emailAddress);
        };

        // Ajax mailchimp
        // Example MailChimp url: http://xxx.xxx.list-manage.com/subscribe/post?u=xxx&id=xxx
        $('#subscribe').ajaxChimp({
            language: 'es',
            url: 'http://shapedtheme.us10.list-manage.com/subscribe/post?u=2f3361cab4a29b896e4803625&amp;id=ff8e85ec10'
        });

        // Mailchimp translation
        //
        // Defaults:
        //'submit': 'Submitting...',
        //  0: 'We have sent you a confirmation email',
        //  1: 'Please enter a value',
        //  2: 'An email address must contain a single @',
        //  3: 'The domain portion of the email address is invalid (the portion after the @: )',
        //  4: 'The username portion of the email address is invalid (the portion before the @: )',
        //  5: 'This email address looks fake or invalid. Please enter a real email address'

        $.ajaxChimp.translations.es = {
            'submit': 'Submitting...',
            0: '<i class="fa fa-check"></i> We will be in touch soon!',
            1: '<i class="fa fa-warning"></i> You must enter a valid e-mail address.',
            2: '<i class="fa fa-warning"></i> E-mail address is not valid.',
            3: '<i class="fa fa-warning"></i> E-mail address is not valid.',
            4: '<i class="fa fa-warning"></i> E-mail address is not valid.',
            5: '<i class="fa fa-warning"></i> E-mail address is not valid.'
        }

    }());


})(jQuery);


