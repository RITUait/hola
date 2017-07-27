# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  index = 1
  $("#add_textarea").click ->
    $("#template_description").after("<textarea as='text' class='form-control added' name='template[description][#{index}]' id='template_description'></textarea>")
    index = index + 1
    return
     

  
  $("#add_info").click ->    
    #$("#mySelect").html('')
    #content = $("[name='template[category][#{index}]']").val()
    #$("#mySelect").append('<option value="#{content}">' + content + '</option>')
    #console.log('tyhiss')
    #$.each $('textarea'), (text, value) ->
      #console.log(text, $(value).val(), value)
      #$("#mySelect").append("<option value='#{$(value).val()}'>" + $(value).val() + "</option>")
    $("#myModal").modal() 
    return
    
  
  $(document).on "click", "#modal_submit", ->
    heading = $("#Heading").val()
    $("#mySelect").append('<option value="#{heading}">' + heading + '</option>')
    console.log($("#Heading").val())
    $('#mySelect').trigger("chosen:updated")
    return
  return  
