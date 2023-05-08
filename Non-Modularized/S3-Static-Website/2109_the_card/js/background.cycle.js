/*
 * The MIT License
 *
 * Copyright March 17 2014 Guus van Lankveld.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

var currentImageIndex = -1;
var imageIds = new Array();
var fadeSpeed;

//Sizing constants. these determine the value of the CSS property 'background-size' of the selected container
var SCALING_MODE_NONE = 0; //Uses the original image size
var SCALING_MODE_STRETCH = 1; //Sets 'background-size' to '100% 100%'. This stretches the background image to fill the container, discarding the images aspect ratio.
var SCALING_MODE_COVER = 2; //Sets 'background-size' to 'cover'. This makes the background images fill the entire container while retaining its aspect ratio.
var SCALING_MODE_CONTAIN = 3; //Sets 'background-size' to 'contain'. This scales the bakcground image to the largest size such that both its width and its height can fit inside the content area

/**
 * Adds a cycling (fading) background to the selected element
 * @param {Object} options Options for tweaking the cycle setings.
 * imageUrls: an array of strings representing urls to the images to cycle through
 * duration: the nr of miliseconds between two fades.
 * fadeSpeed: the nr of miliseconds it takes for one image to fade out to another.
 * backgroundSize: specify a value for the css3 property 'background size' or one of the following constants; SCALING_MODE_NONE, SCALING_MODE_STRETCH, SCALING_MODE_COVER, SCALING_MODE_CONTAIN
 */
$.fn.backgroundCycle = function(options) {
  var settings = $.extend(
    {
      imageUrls: [],
      duration: 5000,
      fadeSpeed: 1000,
      backgroundSize: SCALING_MODE_NONE
    },
    options
  );

  fadeSpeed = settings.fadeSpeed;

  var marginTop = this.css("margin-top");
  var marginRight = this.css("margin-right");
  var marginBottom = this.css("margin-bottom");
  var marginLeft = this.css("margin-left");

  if (!this.is("body")) {
    this.css({
      position: "relative"
    });
  }

  var contents = $(document.createElement("div"));

  var children = this.children().detach();
  contents.append(children);

  imageIds = new Array();

  for (var i = 0; i < settings.imageUrls.length; i++) {
    var id = "bgImage" + i;
    var src = settings.imageUrls[i];
    var cssClass = "cycle-bg-image";

    var image = $(document.createElement("div"));
    image.attr("id", id);
    image.attr("class", cssClass);

    var sizeMode;

    switch (settings.backgroundSize) {
      default:
        sizeMode = settings.backgroundSize;
        break;
      case SCALING_MODE_NONE:
        sizeMode = "auto";
        break;
      case SCALING_MODE_STRETCH:
        sizeMode = "100% 100%";
        break;
      case SCALING_MODE_COVER:
        sizeMode = "cover";
        break;
      case SCALING_MODE_CONTAIN:
        sizeMode = "contain";
        break;
    }

    image.css({
      "background-image": "url('" + src + "')",
      "background-repeat": "no-repeat",
      "background-position": "bottom",
      "background-size": sizeMode,
      "-moz-background-size": sizeMode,
      "-webkit-background-size": sizeMode,
      position: "fixed",
      left: marginLeft,
      top: marginTop,
      right: marginRight,
      bottom: marginBottom
    });

    this.append(image);

    imageIds.push(id);
  }

  contents.css({
    position: "absolute",
    left: marginLeft,
    top: marginTop,
    right: marginRight,
    bottom: marginBottom
  });

  this.append(contents);
  $(".cycle-bg-image").hide();
  $("#" + imageIds[0]).fadeIn();

  if (settings.duration > 0) {
    setInterval(cycleToNextImage, settings.duration);
  }

  return {
    cycleToNextImage: function(previousImageIndex, currentImageIndex) {
      if (previousImageIndex === currentImageIndex) return;

      var previousImageId = imageIds[previousImageIndex];

      if (currentImageIndex >= imageIds.length) {
        currentImageIndex = 0;
      }

      var options = {
        duration: fadeSpeed,
        queue: true
      };

      $("#" + previousImageId).fadeOut(options);
      $("#" + imageIds[currentImageIndex]).fadeIn(options);
    }
  };
};
