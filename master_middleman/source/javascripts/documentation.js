var CFDocs = {};
Elemental.addNamespace(CFDocs);

$(document).ready(function() {
    Elemental.load(document);
});

CFDocs.normalizeUrl = function(url) {
    var match;
    if (match = url.match("^(.*)index.html$")) {
        return match[1];
    } else {
        return url;
    }
}

$(function () {

    var normalizedCurrentUrl = CFDocs.normalizeUrl(window.location.pathname);

    function isCurrentPage(link) {
        var originalLinkHref = link.attr('href').toString();
        var normalizedLinkHref = normalizeUrl(originalLinkHref);

        var currentLinkIsHome = link.attr('id') == "home-nav-link";
        var windowLocationIsExactMatch = normalizedCurrentUrl == normalizedLinkHref;

        if (currentLinkIsHome) {
            if (windowLocationIsExactMatch) return true;
        } else {
            if (normalizedCurrentUrl.match("^" + normalizedLinkHref)) return true;
        }
        return false;
    }

	if (document.location.pathname.indexOf('/pivotalax/') > -1 ||
        document.location.pathname.indexOf('/chorus/') > -1) {
		document.location.href = "https://alpine.atlassian.net/wiki/display/DOC/Alpine+Overview";
	}

    // For main search
    $('#click-to-search').click(function () {
        $('#search-dropdown-box').show();
        $('html,body').scrollTop(0);
    });

    $('.search-dropdown--container .close-menu-large').click(function() {
        $('#search-dropdown-box').hide();
    });


  $('.js-deep-nav .hasSubMenuClosed').siblings('ul').hide();
  $('.js-deep-nav .hasSubMenuClosed').click(function() {
    $(this).toggleClass('hasSubMenuOpened');
    $(this).siblings('ul').slideToggle();
  });

});

// Accordion
(function() {
    $('#accordion-1').dcAccordion({
      eventType: 'click',
      autoClose: true,
      saveState: true,
      disableLink: false,
      speed: 'fast',
      classActive: 'test',
      showCount: false
    });
});

//Global Google Search
(function() {
    var cx = '005804290371689664731:n1ix15a_ysy';
    var gcse = document.createElement('script');
    gcse.type = 'text/javascript';
    gcse.async = true;
    gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
        '//www.google.com/cse/cse.js?cx=' + cx;
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(gcse, s);
})();

$(function () {
  window.addEventListener("orientationchange", function() {
    var deviceHeight = jQuery(window).height();
    var openDrawer = jQuery(".js-open-nav-drawer.js-slide-right");
    if (!openDrawer.length) {
      return;
    } else {
      jQuery(".viewport").height(deviceHeight).addClass("constrained");
    }
  }, false);

  $(".js-open-nav-drawer").click(function() {
    $(".navigation-drawer--container").addClass("js-open");
    $(".mobile-nav, .body--container, .homepage--body").addClass("js-slide-right");

    var deviceHeight = jQuery(window).height();
    $(".viewport").height(deviceHeight).addClass("constrained");
    $("#scrim").addClass("js-show js-open-mobile-nav");
    $("#scrim").click(function() {
      $(".navigation-drawer--container").removeClass("js-open");
      $(".mobile-nav, .body--container, .homepage--body").removeClass("js-slide-right");
      $(".viewport").removeClass("constrained");
    });
  });
});

// NAVIGATION
$(function() {
    var headerHeight = 45;
    // Smooth scrolling for all jump links
    $('a[href*=#]:not([href=#])').click(function() {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
            if (target.length) {
                $('html,body').animate({
                    scrollTop: target.offset().top - headerHeight
                }, 600);
            // return false;
            }
        }
    });

    var currentUrl = window.location.pathname;
    var $activeNavLink = $(".js-sidenav a[href='" + currentUrl + "']");

    if ($activeNavLink.length) {
        // Highlight side navigation link that matches current url path
        $activeNavLink.attr('class', "active");
        $activeParent = $activeNavLink.parents('.js-menu-item');

        $activeParent.addClass('is-clicked');

        $activeNavLink.parents('.js-menu-content').slideDown(function() {
            // Scroll to active side navigation link
            $('.js-sidenav').animate({
            scrollTop: $activeNavLink.offset().top - (headerHeight * 2)
            }, 100);
        });
    }

    // Show and hide back to top
    if(jQuery().waypoint) {
        $('#js-to-top').waypoint('sticky', {
          wrapper: '<div class="sticky-wrapper" />',
          stuckClass: 'sticky',
          offset: 100
        });
    }
});


// Collapse and expand menu content
// @requires class="collapsible" data-behavior="Collapsible"
CFDocs.Collapsible = function(element) {
    var $el = $(element);
    var $clickableTitle = $el.find('.js-menu-title');

    $clickableTitle.click(function() {
        var $content = $(this).siblings('.js-menu-content');
        var $parent = $(this).parents('.js-menu-item');

        $content.slideToggle();
        $parent.toggleClass('is-clicked');
    });
}

// Show and hide search form
CFDocs.Search = function(element) {
    var $el = $(element);
    $el.click(function() {
        $('.js-searchbar').toggleClass('active');
    });
}


// Show and hide main navigation mobile menu
CFDocs.MenuMobile = function(element) {
    var $el = $(element);
    $el.click(function() {
        $('.js-bar-links').toggleClass('menu-active');
    });
}

// Show and hide side navigation mobile menu
CFDocs.SubMenuMobile = function(element) {
    var $el = $(element);
    $el.click(function() {
        $('.js-sidenav').toggleClass('active');
    });
}





