$(function () {

    var normalizedCurrentUrl = normalizeUrl(window.location.pathname);

    function normalizeUrl(url) {
        var match;
        if (match = url.match("^(.*)index.html$")) {
            return match[1];
        } else {
            return url;
        }
    }

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

    $('#sub-nav .js-maintopic a').each(function () {
        var $thisLink = $(this);
        if (isCurrentPage($thisLink)) {
            $thisLink.attr('class', "active");
        }
    });
});