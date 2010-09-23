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
    $(".image").aeImageResize({height: new_height, width: new_width} );
    $(".image").each(function(){
      $(this).css("margin-left", -$(this).width()/2)
      $(this).css("margin-top", -$(this).height()/2)
    });
    
    // resize scrollbar
    $(".thumbnails_container").css("width", (new_width - 270))
  };
  
  var movePicture = function(dir){
    current = $(".current");
    images_container = current.parent().children();
    
    // moving right
    if(dir>0){
      try{  
        next = current.next();
      } catch (err) {
        // start over at the beginning
        next = images_container.first();
      }
      if(next.size() == 0){
        next = images_container.first();
      }
    // moving left
    } else {
      try{
        next = current.prev();
      } catch (err) {                 
        // start over at the end      
        next = images_container.last();
      }                               
      if(next.size() == 0){           
        next = images_container.last();
      }
    }
    
    showImage(next);
  };
  
  var moveLeft = function(e){
    e.preventDefault();
    movePicture(-1);
  };
  
  var moveRight = function(e){
    e.preventDefault();
    movePicture(1);
  };
  
  // Loop through 3 prior and 3 ahead and build image tags for those missing theirs
  var buildSurroundingImageTags = function(img_container){
    var pos = getCurrentPosition(img_container);
    
    var start_pos = pos - 3;
    if(start_pos < 0){
      start_pos = 0;
    }
    
    var end_pos = pos + 3;
    if(end_pos > (img_container.parent().children().size() - 1)){
      end_pos = img_container.parent().children().size() - 1;
    }
    for (var i = start_pos; i <= end_pos; i++){
      buildImage(img_container.parent().children()[i]);
    };
    
    resizeImages();
  };
  
  var buildImage = function(img_container){
    if ($(img_container).html() == ""){ 
      var src = $(img_container).attr("image_src"),
        alt = $(img_container).attr("image_alt"),
        width = $(img_container).attr("image_width"),
        height = $(img_container).attr("image_height"),
        id = $(img_container).attr("image_id");

     
      $(img_container).html("<img id='" + id + "' class='image' src='" + src + "' alt='" + alt + "'  width=" + width + "  height=" + height + " />");
    }
  };
  
  // loops through all items under parent and find this element and return element location
  var getCurrentPosition = function(element){
    siblings = $(element).parent().children();
    count = 0;
    for( var i = 0; i <= (siblings.size()-1); i++){
      if($(siblings[i]).attr("id") == $(element).attr("id")){
        break;
      }
      count ++;
    };
    return count;
  };
  
  var showImage = function(new_image_container){
    current = $(".current");
    var timing = 500;
    
    // hide current
    current.animate({opacity: 0}, {queue:false, duration:timing});
    // show next
    new_image_container.animate({opacity: 1}, {queue:false, duration:timing});
    
    current.removeClass("current");

    buildSurroundingImageTags(new_image_container);

    new_image_container.addClass("current");
  };
  
  var thumbnailClicked = function(e){
    e.preventDefault();
    
    new_image = $("#" + $(this).attr("href"));
    showImage(new_image);
  };
  
  var openThumbnails = function(e){
    e.preventDefault();
    $(".thumbnails_background").css("display", "block").animate({opacity: 1}, {queue:false, duration:500});
  };
  
  var hideThumbnails = function(e){
    e.preventDefault();
    
    $(".thumbnails_background").animate({opacity: 0}, {queue:false, duration:500}).css("display", "hidden");
  };
  
  var bootstrapRotation = function(){
    // $(".loading .c").rotateAnimation(-25);
    for (var i = 0; i <= 360; i++){
      $(".loading .c").rotateAnimation(i);
      if(i > 359){
        i = 0;
      }
    };
  };
  
  var showTextWrapper = function(body, size){

    $('.text_wrapper .text_body').html($(body).clone()).css("height", size).show();
    $('.text_wrapper').css("height", size).show().animate({opacity: '1'}, {queue:false, duration: 500});
    
                            // .animate({opacity: '1', height: size}, {queue:false, duration: 500});
  };
  
  var hideTextWrapper = function(){
    $('.text_wrapper').animate({opacity: '0'}).hide();
    $('.text_wrapper .text_body').html("");
  };
  
  // var loadURL = function(url) {
  //        $("#area").load(url);
  // };
  
  var loadMenuItem = function(menu_id){
    $(".hidden_images").load("home/images?id=" + menu_id.toString(), function(data){
      resizeImages();
    });
  };
  
  var bootstrap = function() {
    // BBQ
    
    
    // Menu Items
    $('.menu .contact').click( function(e){ 
      
    });
    
//     $('.menu .contact a, .menu .pricing a').click( function(e){
//       e.preventDefault();
//       showTextWrapper($(this).attr("href"), $(this).attr("menu_size"));
//       
//     })
    
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
    
    $(".thumbnails_container .thumbnails a").live("click", thumbnailClicked);
    
    
    $(".show_thumbnails, .hide_thumbnails").hover(openThumbnails, hideThumbnails);
    // $(".show_thumbnails, .show_thumbnails canvas").hover(openThumbnails);
    // $(".thumbnails_hover_panel, .header, .menu_item").hover(openThumbnails);
    
    $(".close_menu").live("click", function(e){
      e.preventDefault();  
      hideTextWrapper();
    });
  };
  
  return {
    bootstrap: bootstrap,
    resizeImages: resizeImages,
    loadMenuItem: loadMenuItem,
    showTextWrapper: showTextWrapper,
    hideTextWrapper: hideTextWrapper
  };
}());