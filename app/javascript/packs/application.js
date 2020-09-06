// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// https://github.com/rails/webpacker/issues/1207

import Rails from '@rails/ujs';
Rails.start();
window.Rails = Rails;

import Turbolinks from 'turbolinks';
Turbolinks.start();

import * as ActiveStorage from "@rails/activestorage";
ActiveStorage.start();

// Bootstrap JS
import $ from "jquery";
window.$ = $;
import("bootstrap");

// Bootstrap CSS with customizations
require("css/site");


// Custom JS files
import("js/add_to_homescreen");
import("js/fontawesome");
import("js/tagsinput");
import("js/stimulus_extra");
import("js/post_url_input_handler");
import("js/new_post_modal");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      console.log(reg);
    });
}

// src/application.js
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
