// some simple and cool JS you can use for forms

$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them
  appendCoolForm();
  submitCoolForm();
  giveMeAGif();
  chageTab();


});
//when write blog link is clicked
//hide write blog button and
//append blog form in its place
//You would click a "enter a new post button"
//the button will be replaced with a form partial
//the form partial when filled out will append a new partial containing the new element you created
//the "enter a new post button will return"
//the form partial will disappear

function appendCoolForm(){
  $(document).on('click', 'a.button', function(e){
    e.preventDefault();
    var route = $(this).attr('href')
    var request = $.ajax({
      url: route,
      method: 'get'
    })
    request.done(function(response){
      $('#form').prepend(response);
      $('a.button').hide();
    })
  })
}

var submitCoolForm = function(){
  $(document).on('submit', 'form#new-blog-form', function(e){
    e.preventDefault();
    var route = "/templates";
    var submitData = $(this).serialize();
    var request = $.ajax({
      url: route,
      method: 'post',
      data: submitData
    })
    request.done(function(response){
      $('div#new-form-page').hide();
      $('ul.entries-list').prepend(response);
      $('a.button').show();
    })
  })
}

function giveMeAGif() {
  $(document).on('click', 'a#random-gif', function(e){
    e.preventDefault();
    var current_id = $('.current-gif').attr('id')
    deleteLastGif(current_id);
    $('.current-gif').remove();
    $.ajax({
      url: "/giphy",
      method: 'post',
      dataType: 'JSON'
    })
    .done(function(response){
      var urls = {
        img_url: response.data.image_url,
        url: response.data.url
      }
      $.ajax({
        url: '/messages',
        method: 'post',
        data: urls
      })
      .done(function(response){
        $('#current-gif-list').append(response)
      })
    })
    var new_id = $('.current-gif').attr('id')
  })
}

function deleteLastGif(id) {
  $.ajax({
      url: "/messages/" + id,
      type: 'delete'
    })
    .done(function(response){
      })
}



function chageTab() {
  $(document).on("click", ".tab", function(e){
    e.preventDefault();
    $(".tab").removeClass("active");
    $(this).addClass("active");
    var newSheet = $(this).children("a").attr("href")
    $('.sheet').hide();
    $("#" + newSheet).show().removeClass("hidden");
  })
}

function logOut() {
  $(document).on("click", "a.logout", function(e){
    e.preventDefault();
    var log_id = $(this).attr('id');

    $.ajax({
      url: "/sessions/" + log_id,
      method: "get"
    })
    .done(function(response){
      $('body').append(response)
    })
  })
}



