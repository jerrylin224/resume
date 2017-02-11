$(document).ready(function(){
          $('[data-toggle="tooltip"]').tooltip();   
      });

$(function() {
  $('a[href*="#"]:not([href="#"], [href="#1"], [href="#2"], [href="#3"], [href="#4"])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html, body').animate({
          scrollTop: target.offset().top
        }, 500);
        return false;
      }
    }
  });
});