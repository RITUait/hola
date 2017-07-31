# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  $("#add_textarea").click ->
     t = $(".row:first").html()
     $(".contents").append("<div class='row'>" + t + "</div>")
     return

  $(document).on "click", ".save_as_template", ->
    #v = $(this).parent().find("textarea").val()
    #console.log("yeee", v)
    #$('.templates').append("<option value=" + v + ">" + v + "</option>")
    #return
    #content = $(this).parent().find("textarea".val())
    $("#myModal").modal()
    return content

  $("#modal_submit").click  ->
    heading = $("#Heading").val()
    $.post("/templates",{template:{title:"#{heading}",description:"sir"}})
    return
return


