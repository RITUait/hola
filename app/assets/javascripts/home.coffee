# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  index = 0
  $("#add_textarea").click ->
     index = index + 1
     t = $(".row:first").html()
     $(".contents").append("<div class='row' id='#{index}'>" + t + "</div>")
     return

  $(document).on "click", ".save_as_template", ->
    #v = $(this).parent().find("textarea").val()
    #console.log("yeee", v)
    #$('.templates').append("<option value=" + v + ">" + v + "</option>")
    #return
    content = $(this).parent().find("textarea").val()
    console.log("#{content}")
    $("#myModal").val(content)
    console.log("#{content}")
    $("#myModal").modal()
    return 

  $("#modal_submit").click  ->
    heading = $("#Heading").val()
    ans = $("#myModal").val()
    $.ajax({
      url: "/templates",
      data: {template: {title:"#{heading}",description:"#{ans}"} },
      type: "post",
      dataType: "script"
    })
    #$.post("/templates",{template:{title:"#{heading}",description:"#{ans}"}})
    return

  $("#template").change ->
    selectedid = $(this).find("option:selected").val()
    $.ajax({
      url: "/templates/"+selectedid
      type: "get"
      dataType: "script"
    })
    #$(this).parent().parent().find("textarea").val(@template.description)
    return
return


