
/*! Backstretch - v2.0.4 - 2013-06-19
 * http://srobbin.com/jquery-plugins/backstretch/
 * Copyright (c) 2013 Scott Robbin; Licensed MIT */
(function (a, d, p) {
    a.fn.backstretch = function (c, b) {
        (c === p || 0 === c.length) && a.error("No images were supplied for Backstretch");
        0 === a(d).scrollTop() && d.scrollTo(0, 0);
        return this.each(function () {
            var d = a(this), g = d.data("backstretch");
            if (g) {
                if ("string" == typeof c && "function" == typeof g[c]) {
                    g[c](b);
                    return
                }
                b = a.extend(g.options, b);
                g.destroy(!0)
            }
            g = new q(this, c, b);
            d.data("backstretch", g)
        })
    };
    a.backstretch = function (c, b) {
        return a("body").backstretch(c, b).data("backstretch")
    };
    a.expr[":"].backstretch = function (c) {
        return a(c).data("backstretch") !== p
    };
    a.fn.backstretch.defaults = {centeredX: !0, centeredY: !0, duration: 5E3, fade: 0};
    var r = {
        left: 0,
        top: 0,
        overflow: "hidden",
        margin: 0,
        padding: 0,
        height: "100%",
        width: "100%",
        zIndex: -999999
    }, s = {
        position: "absolute",
        display: "none",
        margin: 0,
        padding: 0,
        border: "none",
        width: "auto",
        height: "auto",
        maxHeight: "none",
        maxWidth: "none",
        zIndex: -999999
    }, q = function (c, b, e) {
        this.options = a.extend({}, a.fn.backstretch.defaults, e || {});
        this.images = a.isArray(b) ? b : [b];
        a.each(this.images, function () {
            a("<img />")[0].src = this
        });
        this.isBody = c === document.body;
        this.$container = a(c);
        this.$root = this.isBody ? l ? a(d) : a(document) : this.$container;
        c = this.$container.children(".backstretch").first();
        this.$wrap = c.length ? c : a('<div class="backstretch"></div>').css(r).appendTo(this.$container);
        this.isBody || (c = this.$container.css("position"), b = this.$container.css("zIndex"), this.$container.css({
            position: "static" === c ? "relative" : c,
            zIndex: "auto" === b ? 0 : b,
            background: "none"
        }), this.$wrap.css({zIndex: -999998}));
        this.$wrap.css({position: this.isBody && l ? "fixed" : "absolute"});
        this.index = 0;
        this.show(this.index);
        a(d).on("resize.backstretch", a.proxy(this.resize, this)).on("orientationchange.backstretch", a.proxy(function () {
            this.isBody && 0 === d.pageYOffset && (d.scrollTo(0, 1), this.resize())
        }, this))
    };
    q.prototype = {
        resize: function () {
            try {
                var a = {
                    left: 0,
                    top: 0
                }, b = this.isBody ? this.$root.width() : this.$root.innerWidth(), e = b, g = this.isBody ? d.innerHeight ? d.innerHeight : this.$root.height() : this.$root.innerHeight(), j = e / this.$img.data("ratio"), f;
                j >= g ? (f = (j - g) / 2, this.options.centeredY && (a.top = "-" + f + "px")) : (j = g, e = j * this.$img.data("ratio"), f = (e - b) / 2, this.options.centeredX && (a.left = "-" + f + "px"));
                this.$wrap.css({width: b, height: g}).find("img:not(.deleteable)").css({width: e, height: j}).css(a)
            } catch (h) {
            }
            return this
        }, show: function (c) {
            if (!(Math.abs(c) > this.images.length - 1)) {
                var b = this, e = b.$wrap.find("img").addClass("deleteable"), d = {relatedTarget: b.$container[0]};
                b.$container.trigger(a.Event("backstretch.before", d), [b, c]);
                this.index = c;
                clearInterval(b.interval);
                b.$img = a("<img />").css(s).bind("load", function (f) {
                    var h = this.width || a(f.target).width();
                    f = this.height || a(f.target).height();
                    a(this).data("ratio", h / f);
                    a(this).fadeIn(b.options.speed || b.options.fade, function () {
                        e.remove();
                        b.paused || b.cycle();
                        a(["after", "show"]).each(function () {
                            b.$container.trigger(a.Event("backstretch." + this, d), [b, c])
                        })
                    });
                    b.resize()
                }).appendTo(b.$wrap);
                b.$img.attr("src", b.images[c]);
                return b
            }
        }, next: function () {
            return this.show(this.index < this.images.length - 1 ? this.index + 1 : 0)
        }, prev: function () {
            return this.show(0 === this.index ? this.images.length - 1 : this.index - 1)
        }, pause: function () {
            this.paused = !0;
            return this
        }, resume: function () {
            this.paused = !1;
            this.next();
            return this
        }, cycle: function () {
            1 < this.images.length && (clearInterval(this.interval), this.interval = setInterval(a.proxy(function () {
                this.paused || this.next()
            }, this), this.options.duration));
            return this
        }, destroy: function (c) {
            a(d).off("resize.backstretch orientationchange.backstretch");
            clearInterval(this.interval);
            c || this.$wrap.remove();
            this.$container.removeData("backstretch")
        }
    };
    var l, f = navigator.userAgent, m = navigator.platform, e = f.match(/AppleWebKit\/([0-9]+)/), e = !!e && e[1], h = f.match(/Fennec\/([0-9]+)/), h = !!h && h[1], n = f.match(/Opera Mobi\/([0-9]+)/), t = !!n && n[1], k = f.match(/MSIE ([0-9]+)/), k = !!k && k[1];
    l = !((-1 < m.indexOf("iPhone") || -1 < m.indexOf("iPad") || -1 < m.indexOf("iPod")) && e && 534 > e || d.operamini && "[object OperaMini]" === {}.toString.call(d.operamini) || n && 7458 > t || -1 < f.indexOf("Android") && e && 533 > e || h && 6 > h || "palmGetResource" in d && e && 534 > e || -1 < f.indexOf("MeeGo") && -1 < f.indexOf("NokiaBrowser/8.5.0") || k && 6 >= k)
})(jQuery, window);

/*!-----------------------------------------------------------------------------
 * Vegas - Fullscreen Backgrounds and Slideshows.
 * v2.2.0 - built 2016-01-18
 * Licensed under the MIT License.
 * http://vegas.jaysalvat.com/
 * ----------------------------------------------------------------------------
 * Copyright (C) 2010-2016 Jay Salvat
 * http://jaysalvat.com/
 * --------------------------------------------------------------------------*/
!function (t) {
    "use strict";
    var s = {
            slide: 0,
            delay: 5e3,
            preload: !1,
            preloadImage: !1,
            preloadVideo: !1,
            timer: !0,
            overlay: !1,
            autoplay: !0,
            shuffle: !1,
            cover: !0,
            color: null,
            align: "center",
            valign: "center",
            transition: "fade",
            transitionDuration: 1e3,
            transitionRegister: [],
            animation: null,
            animationDuration: "auto",
            animationRegister: [],
            init: function () {
            },
            play: function () {
            },
            pause: function () {
            },
            walk: function () {
            },
            slides: []
        },
        i = {},
        e = function (i, e) {
            this.elmt = i, this.settings = t.extend({}, s, t.vegas.defaults, e), this.slide = this.settings.slide, this.total = this.settings.slides.length, this.noshow = this.total < 2, this.paused = !this.settings.autoplay || this.noshow, this.$elmt = t(i), this.$timer = null, this.$overlay = null, this.$slide = null, this.timeout = null, this.transitions = ["fade", "fade2", "blur", "blur2", "flash", "flash2", "negative", "negative2", "burn", "burn2", "slideLeft", "slideLeft2", "slideRight", "slideRight2", "slideUp", "slideUp2", "slideDown", "slideDown2", "zoomIn", "zoomIn2", "zoomOut", "zoomOut2", "swirlLeft", "swirlLeft2", "swirlRight", "swirlRight2"], this.animations = ["kenburns", "kenburnsLeft", "kenburnsRight", "kenburnsUp", "kenburnsUpLeft", "kenburnsUpRight", "kenburnsDown", "kenburnsDownLeft", "kenburnsDownRight"], this.settings.transitionRegister instanceof Array == !1 && (this.settings.transitionRegister = [this.settings.transitionRegister]), this.settings.animationRegister instanceof Array == !1 && (this.settings.animationRegister = [this.settings.animationRegister]), this.transitions = this.transitions.concat(this.settings.transitionRegister), this.animations = this.animations.concat(this.settings.animationRegister), this.support = {
                objectFit: "objectFit" in document.body.style,
                transition: "transition" in document.body.style || "WebkitTransition" in document.body.style,
                video: t.vegas.isVideoCompatible()
            }, this.settings.shuffle === !0 && this.shuffle(), this._init()
        };
    e.prototype = {
        _init: function () {
            var s, i, e, n = "BODY" === this.elmt.tagName,
                o = this.settings.timer,
                a = this.settings.overlay,
                r = this;
            this._preload(), n || (this.$elmt.css("height", this.$elmt.css("height")), s = t('<div class="vegas-wrapper">').css("overflow", this.$elmt.css("overflow")).css("padding", this.$elmt.css("padding")), this.$elmt.css("padding") || s.css("padding-top", this.$elmt.css("padding-top")).css("padding-bottom", this.$elmt.css("padding-bottom")).css("padding-left", this.$elmt.css("padding-left")).css("padding-right", this.$elmt.css("padding-right")), this.$elmt.clone(!0).children().appendTo(s), this.elmt.innerHTML = ""), o && this.support.transition && (e = t('<div class="vegas-timer"><div class="vegas-timer-progress">'), this.$timer = e, this.$elmt.prepend(e)), a && (i = t('<div class="vegas-overlay">'), "string" == typeof a && i.css("background-image", "url(" + a + ")"), this.$overlay = i, this.$elmt.prepend(i)), this.$elmt.addClass("vegas-container"), n || this.$elmt.append(s), setTimeout(function () {
                r.trigger("init"), r._goto(r.slide), r.settings.autoplay && r.trigger("play")
            }, 1)
        },
        _preload: function () {
            var t, s;
            for (s = 0; s < this.settings.slides.length; s++)(this.settings.preload || this.settings.preloadImages) && this.settings.slides[s].src && (t = new Image, t.src = this.settings.slides[s].src), (this.settings.preload || this.settings.preloadVideos) && this.support.video && this.settings.slides[s].video && (this.settings.slides[s].video instanceof Array ? this._video(this.settings.slides[s].video) : this._video(this.settings.slides[s].video.src))
        },
        _random: function (t) {
            return t[Math.floor(Math.random() * (t.length - 1))]
        },
        _slideShow: function () {
            var t = this;
            this.total > 1 && !this.paused && !this.noshow && (this.timeout = setTimeout(function () {
                t.next()
            }, this._options("delay")))
        },
        _timer: function (t) {
            var s = this;
            clearTimeout(this.timeout), this.$timer && (this.$timer.removeClass("vegas-timer-running").find("div").css("transition-duration", "0ms"), this.paused || this.noshow || t && setTimeout(function () {
                s.$timer.addClass("vegas-timer-running").find("div").css("transition-duration", s._options("delay") - 100 + "ms")
            }, 100))
        },
        _video: function (t) {
            var s, e, n = t.toString();
            return i[n] ? i[n] : (t instanceof Array == !1 && (t = [t]), s = document.createElement("video"), s.preload = !0, t.forEach(function (t) {
                e = document.createElement("source"), e.src = t, s.appendChild(e)
            }), i[n] = s, s)
        },
        _fadeOutSound: function (t, s) {
            var i = this,
                e = s / 10,
                n = t.volume - .09;
            n > 0 ? (t.volume = n, setTimeout(function () {
                i._fadeOutSound(t, s)
            }, e)) : t.pause()
        },
        _fadeInSound: function (t, s) {
            var i = this,
                e = s / 10,
                n = t.volume + .09;
            1 > n && (t.volume = n, setTimeout(function () {
                i._fadeInSound(t, s)
            }, e))
        },
        _options: function (t, s) {
            return void 0 === s && (s = this.slide), void 0 !== this.settings.slides[s][t] ? this.settings.slides[s][t] : this.settings[t]
        },
        _goto: function (s) {
            function i() {
                f._timer(!0), setTimeout(function () {
                    y && (f.support.transition ? (h.css("transition", "all " + _ + "ms").addClass("vegas-transition-" + y + "-out"), h.each(function () {
                        var t = h.find("video").get(0);
                        t && (t.volume = 1, f._fadeOutSound(t, _))
                    }), e.css("transition", "all " + _ + "ms").addClass("vegas-transition-" + y + "-in")) : e.fadeIn(_));
                    for (var t = 0; t < h.length - 4; t++) h.eq(t).remove();
                    f.trigger("walk"), f._slideShow()
                }, 100)
            }

            "undefined" == typeof this.settings.slides[s] && (s = 0), this.slide = s;
            var e, n, o, a, r, h = this.$elmt.children(".vegas-slide"),
                d = this.settings.slides[s].src,
                l = this.settings.slides[s].video,
                g = this._options("delay"),
                u = this._options("align"),
                c = this._options("valign"),
                p = this._options("cover"),
                m = this._options("color") || this.$elmt.css("background-color"),
                f = this,
                v = h.length,
                y = this._options("transition"),
                _ = this._options("transitionDuration"),
                w = this._options("animation"),
                b = this._options("animationDuration");
            "repeat" !== p && (p === !0 ? p = "cover" : p === !1 && (p = "contain")), ("random" === y || y instanceof Array) && (y = y instanceof Array ? this._random(y) : this._random(this.transitions)), ("random" === w || w instanceof Array) && (w = w instanceof Array ? this._random(w) : this._random(this.animations)), ("auto" === _ || _ > g) && (_ = g), "auto" === b && (b = g), e = t('<div class="vegas-slide"></div>'), this.support.transition && y && e.addClass("vegas-transition-" + y), this.support.video && l ? (a = l instanceof Array ? this._video(l) : this._video(l.src), a.loop = void 0 !== l.loop ? l.loop : !0, a.muted = void 0 !== l.mute ? l.mute : !0, a.muted === !1 ? (a.volume = 0, this._fadeInSound(a, _)) : a.pause(), o = t(a).addClass("vegas-video").css("background-color", m), this.support.objectFit ? o.css("object-position", u + " " + c).css("object-fit", p).css("width", "100%").css("height", "100%") : "contain" === p && o.css("width", "100%").css("height", "100%"), e.append(o)) : (r = new Image, n = t('<div class="vegas-slide-inner"></div>').css("background-image", "url(" + d + ")").css("background-color", m).css("background-position", u + " " + c), "repeat" === p ? n.css("background-repeat", "repeat") : n.css("background-size", p), this.support.transition && w && n.addClass("vegas-animation-" + w).css("animation-duration", b + "ms"), e.append(n)), this.support.transition || e.css("display", "none"), v ? h.eq(v - 1).after(e) : this.$elmt.prepend(e), f._timer(!1), a ? (4 === a.readyState && (a.currentTime = 0), a.play(), i()) : (r.src = d, r.onload = i)
        },
        shuffle: function () {
            for (var t, s, i = this.total - 1; i > 0; i--) s = Math.floor(Math.random() * (i + 1)), t = this.settings.slides[i], this.settings.slides[i] = this.settings.slides[s], this.settings.slides[s] = t
        },
        play: function () {
            this.paused && (this.paused = !1, this.next(), this.trigger("play"))
        },
        pause: function () {
            this._timer(!1), this.paused = !0, this.trigger("pause")
        },
        toggle: function () {
            this.paused ? this.play() : this.pause()
        },
        playing: function () {
            return !this.paused && !this.noshow
        },
        current: function (t) {
            return t ? {
                slide: this.slide,
                data: this.settings.slides[this.slide]
            } : this.slide
        },
        jump: function (t) {
            0 > t || t > this.total - 1 || t === this.slide || (this.slide = t, this._goto(this.slide))
        },
        next: function () {
            this.slide++, this.slide >= this.total && (this.slide = 0), this._goto(this.slide)
        },
        previous: function () {
            this.slide--, this.slide < 0 && (this.slide = this.total - 1), this._goto(this.slide)
        },
        trigger: function (t) {
            var s = [];
            s = "init" === t ? [this.settings] : [this.slide, this.settings.slides[this.slide]], this.$elmt.trigger("vegas" + t, s), "function" == typeof this.settings[t] && this.settings[t].apply(this.$elmt, s)
        },
        options: function (i, e) {
            var n = this.settings.slides.slice();
            if ("object" == typeof i) this.settings = t.extend({}, s, t.vegas.defaults, i);
            else {
                if ("string" != typeof i) return this.settings;
                if (void 0 === e) return this.settings[i];
                this.settings[i] = e
            }
            this.settings.slides !== n && (this.total = this.settings.slides.length, this.noshow = this.total < 2, this._preload())
        },
        destroy: function () {
            clearTimeout(this.timeout), this.$elmt.removeClass("vegas-container"), this.$elmt.find("> .vegas-slide").remove(), this.$elmt.find("> .vegas-wrapper").clone(!0).children().appendTo(this.$elmt), this.$elmt.find("> .vegas-wrapper").remove(), this.settings.timer && this.$timer.remove(), this.settings.overlay && this.$overlay.remove(), this.elmt._vegas = null
        }
    }, t.fn.vegas = function (t) {
        var s, i = arguments,
            n = !1;
        if (void 0 === t || "object" == typeof t) return this.each(function () {
            this._vegas || (this._vegas = new e(this, t))
        });
        if ("string" == typeof t) {
            if (this.each(function () {
                    var e = this._vegas;
                    if (!e) throw new Error("No Vegas applied to this element.");
                    "function" == typeof e[t] && "_" !== t[0] ? s = e[t].apply(e, [].slice.call(i, 1)) : n = !0
                }), n) throw new Error('No method "' + t + '" in Vegas.');
            return void 0 !== s ? s : this
        }
    }, t.vegas = {}, t.vegas.defaults = s, t.vegas.isVideoCompatible = function () {
        return !/(Android|webOS|Phone|iPad|iPod|BlackBerry|Windows Phone)/i.test(navigator.userAgent)
    }
}(window.jQuery || window.Zepto);
//# sourceMappingURL=vegas.min.js.map


/* HTML5 Placeholder jQuery Plugin - v2.3.1
 * Copyright (c)2015 Mathias Bynens
 * 2015-12-16
 */
!function (a) {
    "function" == typeof define && define.amd ? define(["jquery"], a) : a("object" == typeof module && module.exports ? require("jquery") : jQuery)
}(function (a) {
    function b(b) {
        var c = {},
            d = /^jQuery\d+$/;
        return a.each(b.attributes, function (a, b) {
            b.specified && !d.test(b.name) && (c[b.name] = b.value)
        }), c
    }

    function c(b, c) {
        var d = this,
            f = a(this);
        if (d.value === f.attr(h ? "placeholder-x" : "placeholder") && f.hasClass(n.customClass))
            if (d.value = "", f.removeClass(n.customClass), f.data("placeholder-password")) {
                if (f = f.hide().nextAll('input[type="password"]:first').show().attr("id", f.removeAttr("id").data("placeholder-id")), b === !0) return f[0].value = c, c;
                f.focus()
            } else d == e() && d.select()
    }

    function d(d) {
        var e, f = this,
            g = a(this),
            i = f.id;
        if (!d || "blur" !== d.type || !g.hasClass(n.customClass))
            if ("" === f.value) {
                if ("password" === f.type) {
                    if (!g.data("placeholder-textinput")) {
                        try {
                            e = g.clone().prop({
                                type: "text"
                            })
                        } catch (j) {
                            e = a("<input>").attr(a.extend(b(this), {
                                type: "text"
                            }))
                        }
                        e.removeAttr("name").data({
                            "placeholder-enabled": !0,
                            "placeholder-password": g,
                            "placeholder-id": i
                        }).bind("focus.placeholder", c), g.data({
                            "placeholder-textinput": e,
                            "placeholder-id": i
                        }).before(e)
                    }
                    f.value = "", g = g.removeAttr("id").hide().prevAll('input[type="text"]:first').attr("id", g.data("placeholder-id")).show()
                } else {
                    var k = g.data("placeholder-password");
                    k && (k[0].value = "", g.attr("id", g.data("placeholder-id")).show().nextAll('input[type="password"]:last').hide().removeAttr("id"))
                }
                g.addClass(n.customClass), g[0].value = g.attr(h ? "placeholder-x" : "placeholder")
            } else g.removeClass(n.customClass)
    }

    function e() {
        try {
            return document.activeElement
        } catch (a) {
        }
    }

    var f, g, h = !1,
        i = "[object OperaMini]" === Object.prototype.toString.call(window.operamini),
        j = "placeholder" in document.createElement("input") && !i && !h,
        k = "placeholder" in document.createElement("textarea") && !i && !h,
        l = a.valHooks,
        m = a.propHooks,
        n = {};
    j && k ? (g = a.fn.placeholder = function () {
        return this
    }, g.input = !0, g.textarea = !0) : (g = a.fn.placeholder = function (b) {
        var e = {
            customClass: "placeholder"
        };
        return n = a.extend({}, e, b), this.filter((j ? "textarea" : ":input") + "[" + (h ? "placeholder-x" : "placeholder") + "]").not("." + n.customClass).not(":radio, :checkbox, [type=hidden]").bind({
            "focus.placeholder": c,
            "blur.placeholder": d
        }).data("placeholder-enabled", !0).trigger("blur.placeholder")
    }, g.input = j, g.textarea = k, f = {
        get: function (b) {
            var c = a(b),
                d = c.data("placeholder-password");
            return d ? d[0].value : c.data("placeholder-enabled") && c.hasClass(n.customClass) ? "" : b.value
        },
        set: function (b, f) {
            var g, h, i = a(b);
            return "" !== f && (g = i.data("placeholder-textinput"), h = i.data("placeholder-password"), g ? (c.call(g[0], !0, f) || (b.value = f), g[0].value = f) : h && (c.call(b, !0, f) || (h[0].value = f), b.value = f)), i.data("placeholder-enabled") ? ("" === f ? (b.value = f, b != e() && d.call(b)) : (i.hasClass(n.customClass) && c.call(b), b.value = f), i) : (b.value = f, i)
        }
    }, j || (l.input = f, m.value = f), k || (l.textarea = f, m.value = f), a(function () {
        a(document).delegate("form", "submit.placeholder", function () {
            var b = a("." + n.customClass, this).each(function () {
                c.call(this, !0, "")
            });
            setTimeout(function () {
                b.each(d)
            }, 10)
        })
    }), a(window).bind("beforeunload.placeholder", function () {
        var b = !0;
        try {
            "javascript:void(0)" === document.activeElement.toString() && (b = !1)
        } catch (c) {
        }
        b && a("." + n.customClass).each(function () {
            this.value = ""
        })
    }))
});


/*!
 * The Final Countdown for jQuery v2.1.0 (http://hilios.github.io/jQuery.countdown/)
 * Copyright (c) 2015 Edson Hilios
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
!function (a) {
    "use strict";
    "function" == typeof define && define.amd ? define(["jquery"], a) : a(jQuery)
}(function (a) {
    "use strict";

    function b(a) {
        if (a instanceof Date) return a;
        if (String(a).match(g)) return String(a).match(/^[0-9]*$/) && (a = Number(a)), String(a).match(/\-/) && (a = String(a).replace(/\-/g, "/")), new Date(a);
        throw new Error("Couldn't cast `" + a + "` to a date object.")
    }

    function c(a) {
        var b = a.toString().replace(/([.?*+^$[\]\\(){}|-])/g, "\\$1");
        return new RegExp(b)
    }

    function d(a) {
        return function (b) {
            var d = b.match(/%(-|!)?[A-Z]{1}(:[^;]+;)?/gi);
            if (d)
                for (var f = 0, g = d.length; g > f; ++f) {
                    var h = d[f].match(/%(-|!)?([a-zA-Z]{1})(:[^;]+;)?/),
                        j = c(h[0]),
                        k = h[1] || "",
                        l = h[3] || "",
                        m = null;
                    h = h[2], i.hasOwnProperty(h) && (m = i[h], m = Number(a[m])), null !== m && ("!" === k && (m = e(l, m)), "" === k && 10 > m && (m = "0" + m.toString()), b = b.replace(j, m.toString()))
                }
            return b = b.replace(/%%/, "%")
        }
    }

    function e(a, b) {
        var c = "s",
            d = "";
        return a && (a = a.replace(/(:|;|\s)/gi, "").split(/\,/), 1 === a.length ? c = a[0] : (d = a[0], c = a[1])), 1 === Math.abs(b) ? d : c
    }

    var f = [],
        g = [],
        h = {
            precision: 100,
            elapse: !1
        };
    g.push(/^[0-9]*$/.source), g.push(/([0-9]{1,2}\/){2}[0-9]{4}( [0-9]{1,2}(:[0-9]{2}){2})?/.source), g.push(/[0-9]{4}([\/\-][0-9]{1,2}){2}( [0-9]{1,2}(:[0-9]{2}){2})?/.source), g = new RegExp(g.join("|"));
    var i = {
            Y: "years",
            m: "months",
            n: "daysToMonth",
            w: "weeks",
            d: "daysToWeek",
            D: "totalDays",
            H: "hours",
            M: "minutes",
            S: "seconds"
        },
        j = function (b, c, d) {
            this.el = b, this.$el = a(b), this.interval = null, this.offset = {}, this.options = a.extend({}, h), this.instanceNumber = f.length, f.push(this), this.$el.data("countdown-instance", this.instanceNumber), d && ("function" == typeof d ? (this.$el.on("update.countdown", d), this.$el.on("stoped.countdown", d), this.$el.on("finish.countdown", d)) : this.options = a.extend({}, h, d)), this.setFinalDate(c), this.start()
        };
    a.extend(j.prototype, {
        start: function () {
            null !== this.interval && clearInterval(this.interval);
            var a = this;
            this.update(), this.interval = setInterval(function () {
                a.update.call(a)
            }, this.options.precision)
        },
        stop: function () {
            clearInterval(this.interval), this.interval = null, this.dispatchEvent("stoped")
        },
        toggle: function () {
            this.interval ? this.stop() : this.start()
        },
        pause: function () {
            this.stop()
        },
        resume: function () {
            this.start()
        },
        remove: function () {
            this.stop.call(this), f[this.instanceNumber] = null, delete this.$el.data().countdownInstance
        },
        setFinalDate: function (a) {
            this.finalDate = b(a)
        },
        update: function () {
            if (0 === this.$el.closest("html").length) return void this.remove();
            var b, c = void 0 !== a._data(this.el, "events"),
                d = new Date;
            b = this.finalDate.getTime() - d.getTime(), b = Math.ceil(b / 1e3), b = !this.options.elapse && 0 > b ? 0 : Math.abs(b), this.totalSecsLeft !== b && c && (this.totalSecsLeft = b, this.elapsed = d >= this.finalDate, this.offset = {
                seconds: this.totalSecsLeft % 60,
                minutes: Math.floor(this.totalSecsLeft / 60) % 60,
                hours: Math.floor(this.totalSecsLeft / 60 / 60) % 24,
                days: Math.floor(this.totalSecsLeft / 60 / 60 / 24) % 7,
                daysToWeek: Math.floor(this.totalSecsLeft / 60 / 60 / 24) % 7,
                daysToMonth: Math.floor(this.totalSecsLeft / 60 / 60 / 24 % 30.4368),
                totalDays: Math.floor(this.totalSecsLeft / 60 / 60 / 24),
                weeks: Math.floor(this.totalSecsLeft / 60 / 60 / 24 / 7),
                months: Math.floor(this.totalSecsLeft / 60 / 60 / 24 / 30.4368),
                years: Math.abs(this.finalDate.getFullYear() - d.getFullYear())
            }, this.options.elapse || 0 !== this.totalSecsLeft ? this.dispatchEvent("update") : (this.stop(), this.dispatchEvent("finish")))
        },
        dispatchEvent: function (b) {
            var c = a.Event(b + ".countdown");
            c.finalDate = this.finalDate, c.elapsed = this.elapsed, c.offset = a.extend({}, this.offset), c.strftime = d(this.offset), this.$el.trigger(c)
        }
    }), a.fn.countdown = function () {
        var b = Array.prototype.slice.call(arguments, 0);
        return this.each(function () {
            var c = a(this).data("countdown-instance");
            if (void 0 !== c) {
                var d = f[c],
                    e = b[0];
                j.prototype.hasOwnProperty(e) ? d[e].apply(d, b.slice(1)) : null === String(e).match(/^[$A-Z_][0-9A-Z_$]*$/i) ? (d.setFinalDate.call(d, e), d.start()) : a.error("Method %s does not exist on jQuery.countdown".replace(/\%s/gi, e))
            } else new j(this, b[0], b[1])
        })
    }
});


/*jshint browser:true */
/*!
 * FitVids 1.1
 *
 * Copyright 2013, Chris Coyier - http://css-tricks.com + Dave Rupert - http://daverupert.com
 * Credit to Thierry Koblentz - http://www.alistapart.com/articles/creating-intrinsic-ratios-for-video/
 * Released under the WTFPL license - http://sam.zoy.org/wtfpl/
 *
 */
!function ($) {
    "use strict";
    $.fn.fitVids = function (options) {
        var settings = {
            customSelector: null
        };
        if (!document.getElementById("fit-vids-style")) {
            var head = document.head || document.getElementsByTagName("head")[0],
                css = ".fluid-width-video-wrapper{width:100%;position:relative;padding:0;}.fluid-width-video-wrapper iframe,.fluid-width-video-wrapper object,.fluid-width-video-wrapper embed {position:absolute;top:0;left:0;width:100%;height:100%;}",
                div = document.createElement("div");
            div.innerHTML = '<p>x</p><style id="fit-vids-style">' + css + "</style>", head.appendChild(div.childNodes[1])
        }
        return options && $.extend(settings, options), this.each(function () {
            var selectors = ["iframe[src*='player.vimeo.com']", "iframe[src*='youtube.com']", "iframe[src*='youtube-nocookie.com']", "iframe[src*='kickstarter.com'][src*='video.html']", "object", "embed"];
            settings.customSelector && selectors.push(settings.customSelector);
            var $allVideos = $(this).find(selectors.join(","));
            $allVideos = $allVideos.not("object object"), $allVideos.each(function () {
                var $this = $(this);
                if (!("embed" === this.tagName.toLowerCase() && $this.parent("object").length || $this.parent(".fluid-width-video-wrapper").length)) {
                    $this.css("height") || $this.css("width") || !isNaN($this.attr("height")) && !isNaN($this.attr("width")) || ($this.attr("height", 9), $this.attr("width", 16));
                    var height = "object" === this.tagName.toLowerCase() || $this.attr("height") && !isNaN(parseInt($this.attr("height"), 10)) ? parseInt($this.attr("height"), 10) : $this.height(),
                        width = isNaN(parseInt($this.attr("width"), 10)) ? $this.width() : parseInt($this.attr("width"), 10),
                        aspectRatio = height / width;
                    if (!$this.attr("id")) {
                        var videoID = "fitvid" + Math.floor(999999 * Math.random());
                        $this.attr("id", videoID)
                    }
                    $this.wrap('<div class="fluid-width-video-wrapper"></div>').parent(".fluid-width-video-wrapper").css("padding-top", 100 * aspectRatio + "%"), $this.removeAttr("height").removeAttr("width")
                }
            })
        })
    }
}(window.jQuery || window.Zepto);

