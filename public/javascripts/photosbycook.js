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
  }
  
  var resizeImages = function(){
    var size = getClientSize();
    var new_width = size.width;
    var new_height = size.height;
console.log( "width: " + new_width + "  height: " + new_height)
    $(".image").aeImageResize({height: new_height, width: new_width} );
  };
  
  var bootstrap = function() {
    resizeImages();
  };
  
  return {
    bootstrap: bootstrap,
    resizeImages: resizeImages
  };
}());