//= require jquery-lightbox/js/baguetteBox.min
//= require jquery-lightbox/js/highlight.min

$(function() {
  baguetteBox.run('.img-gallery', {
      onChange: function() {
      },
      filter: /(.*)/
  });
})
