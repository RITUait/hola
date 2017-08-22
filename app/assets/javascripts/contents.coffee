# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  index = 0
  $("#add_textarea").click ->
     index = index + 1
     t = $(".row:first").html()
     console.log(t)
     $(".contents").append("<div class='row' id='temp#{index}'>" + t+ "</div>")
  $(document).on 'click', '#remove', ->
    alert 'do you want to remove'
    $($(this).parent()).parent().remove()
    index--
    return

  $(document).on "click", ".save_as_template", ->
    #v = $(this).parent().find("textarea").val()
    #console.log("yeee", v)
    #$('.templates').append("<option value=" + v + ">" + v + "</option>")
    #return
    description = $(this).parent().find("textarea").val()
    console.log("#{description}")
    $("#myModal").val(description)
    console.log("#{description}")

    $("#myModal").modal()
    return 

  $("#modal_submit").click  ->
    heading = $("#Heading").val()
    ans = $("#myModal").val()

    $('.templates').append("<option>#{heading}</option>")
    $.ajax({
      url: "/templates",
      data: {template: {title:"#{heading}",description:"#{ans}"} },
      type: "post",
      dataType: "script"
    })
    #$.post("/templates",{template:{title:"#{heading}",description:"#{ans}"}})
    return
  $('#fs').change ->
    #alert($(this).val());
    $('.description').css 'font-family', $(this).val()
    $('#email_greeting').css 'font-family', $(this).val()
    return
  
  $('#size').change ->
    $('.description').css 'font-size', $(this).val() + 'px'
    return
  $('#jBold').click ->
    document.execCommand 'bold'
    return
  $('#jitalic').click ->
    document.execCommand 'italic'
    return

  $(document).on "change", "#template", ->
    selectedid = $(this).find("option:selected").val()
    obj = $(this).parent().parent().find('.description')
    $.ajax "/templates/"+selectedid,
      type: "get"
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        console.log(data["description"])
        obj.val(data["description"])


    return
  return

getSelText = ->
  txt = ''
  if window.getSelection
    txt = window.getSelection()
  else if document.getSelection
    txt = document.getSelection()
  else if document.selection
    txt = document.selection.createRange().text
  else
    return
  txt

  $('.boldtrigger').click ->
   selection = getSelText()
   console.log 'selected value', selection
   range = selection.getRangeAt(0)
   if selection.toString().length > 2
     newNode = document.createElement('span')
     newNode.setAttribute 'class', 'selectedText'
     range.surroundContents newNode
   return



