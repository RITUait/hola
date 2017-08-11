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



