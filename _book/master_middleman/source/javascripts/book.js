// Declare your book-specific javascript overrides in this file.
//= require 'waypoints/waypoint'
//= require 'waypoints/context'
//= require 'waypoints/group'
//= require 'waypoints/noframeworkAdapter'
//= require 'waypoints/sticky'
//= require 'vendor/mermaid'
//= require 'page_initializers/documentation'

window.onload = function() {
  Bookbinder.boot();
  var sticky = new Waypoint.Sticky({
    element: document.querySelector('#js-to-top'),
    wrapper: '<div class="sticky-wrapper" />',
    stuckClass: 'sticky',
    offset: 100
  });
}
