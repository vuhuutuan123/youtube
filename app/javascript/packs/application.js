// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require ('jquery')
global.$ = require('jquery')
require('@coreui/coreui/dist/js/coreui.bundle.min')
require('@fortawesome/fontawesome-free/js/all.min')

$(document).ready(function() {
  let recentMovieId = undefined
  $(window).on('scroll', function() {
    if($(window).scrollTop() == $(document).height() - $(window).height()) {
      if(recentMovieId != $('.movie-detail').last().data('movieId')) {
        recentMovieId = $('.movie-detail').last().data('movieId')
        $.getScript('/?movie_id=' + recentMovieId)
      }
    }
  });
});
