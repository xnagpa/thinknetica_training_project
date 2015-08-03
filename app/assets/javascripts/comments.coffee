# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->  
  $('.create_comment').click (e) ->
   	e.preventDefault();
    form_id= $(this).data('commentableId');
    form_type= $(this).data('commentableType').toLowerCase();
    $(this).hide();    
    $('#comment-'+form_type+'-'+form_id).show();    

