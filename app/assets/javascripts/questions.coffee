# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('.edit-question-link').click (e) ->
   	e.preventDefault();
    #alert $(this).data('questionId');
    form_id= $(this).data('questionId');
    $(this).hide();    
    $('#edit-question-'+form_id).show();
    return
  return