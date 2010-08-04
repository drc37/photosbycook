; PBC = (function() {
  
  var getClientSize = function() {
    var width = 0, height = 0;

    if(typeof(window.innerWidth) == 'number') {
          width = window.innerWidth;
          height = window.innerHeight;
    } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
          width = document.documentElement.clientWidth;
          height = document.documentElement.clientHeight;
    } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
          width = document.body.clientWidth;
          height = document.body.clientHeight;
    }

    return {width: width, height: height};
  };
  
  var resizeImages = function(){
    var size = getClientSize();
    var new_width = size.width;
    var new_height = size.height;
// console.log( "width: " + new_width + "  height: " + new_height)
    $(".image").aeImageResize({height: new_height, width: new_width} );
    $(".image").each(function(){
      $(this).css("margin-left", -$(this).width()/2)
      $(this).css("margin-top", -$(this).height()/2)
    });
  };
  
  var movePicture = function(dir){
    current = $(".current");
    
    if(dir>0){
      try{  
        next = current.next();
      } catch (err) {
        // start over at the beginning
        next = current.parent().children().first();
      }
      if(next.size() == 0){
        next = current.parent().children().first();
      }
    } else {
      try{
        next = current.prev();
      } catch (err) {
        // start over at the end
        next = current.parent().children().last();
      }
      if(next.size() == 0){
        next = current.parent().children().last();
      }
    }
    
    var timing = 500;
    // hide current
    current.animate({opacity: 0}, {queue:false, duration:timing});
    // show next
    next.animate({opacity: 1}, {queue:false, duration:timing});
    current.removeClass("current");
    next.addClass("current");
console.log(next);    
  };
  
  var moveLeft = function(e){
    e.preventDefault();
    movePicture(-1);
  };
  
  var moveRight = function(e){
    e.preventDefault();
    movePicture(1);
  };
  
  var bootstrap = function() {
    $(".js-left_arrow").live("click", moveLeft);
    $(".js-right_arrow").live("click", moveRight);
    
    resizeImages();
    
    $(window).resize(resizeImages);
   
    var isCtrl = false;$(document).keyup(function (e) {
    if(e.which == 17) isCtrl=false;
    }).keydown(function (e) {
        if(e.which == 17) isCtrl=true;
        // left
        if(e.which == 37) {
            movePicture(-1);;
         	return false;
         }
       if(e.which == 38) {
           movePicture(-1);;
        	return false;
        }
        //  right
       if(e.which == 39) {
           movePicture(1);;
        	return false;
        }
        if(e.which == 40) {
            movePicture(1);;
         	return false;
         }
    });
  };
  
  return {
    bootstrap: bootstrap,
    resizeImages: resizeImages
  };
}());