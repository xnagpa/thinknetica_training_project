# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->  
  $('.edit-answer-link').click (e) ->
   	e.preventDefault();
    
    form_id= $(this).data('answerId');
    $(this).hide();    
    $('#edit-answer-'+form_id).show();    
    return 
 
  $('[data-is-best="true"]').addClass 'best_answer'
  
  return



