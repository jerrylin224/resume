(function($) {          
    $(document).ready(function(){                    
        $(window).scroll(function(){                          
            if ($(this).scrollTop() > 600) {
                // $('.ha-header-show').fadeOut(500);
            // } else {
                $('.ha-header-subshow').fadeIn(500);
            }
        });
    });
})(jQuery);



$(document).ready(function(){
          $('[data-toggle="tooltip"]').tooltip();   
      });

$(function() {
  $('a[href*="#"]:not([href="#"])').click(function() {
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