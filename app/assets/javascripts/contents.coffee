# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



jQuery ->
  index = 0
  $("#add_textarea").click ->
    index++
    $("#remove").show()
    CKEDITOR.instances.description_.destroy()
    t = $(".row:first").html()
    $(".contents").append("<div class='row' id='temp#{index}'>" + t+ "</div>")
    $(".row:last").find("#description_").attr("id","editor"+index)
    CKEDITOR.replace("description_")
    CKEDITOR.replace("editor"+index)
    return

  $(document).on 'click', '#remove', ->
    if(index > 0)
      $($(this).parent()).parent().remove()
      index--
    return

    
  $(document).on "click", ".save_as_template", ->
    textarea = CKEDITOR.instances.description_.getData()
    description = CKEDITOR.instances.description_.getData()
    console.log("#{description}")
    if("#{description}")
      $("#myModal").val(description)
      console.log(description)
      $("#myModal").modal()
    else
      alert "the field is empty"
    return 

  

  $(document).on "submit", "#modal_form", (e)  ->
    e.preventDefault()
    heading = $("#Heading").val()
    ans = $("#myModal").val()
    $('.templates').append("<option>#{heading}</option>")
    $.ajax({
      url: "/templates",
      data: {template: {title:"#{heading}",description:"#{ans}"} },
      type: "post",
      dataType: "script"
      success: (data)->
        $("#myModal").modal('hide')
      error: (data)->
        alert("Title already exists")
    })
    
    return

  
  $(document).on "change", "#template", ->
    selectedid = $(this).find("option:selected").val()
    obj = $(this).parent().parent().find('.description')
    #obj.atrr("id")
    console.log(obj.attr("id"))
    console.log(obj)
    console.log(" This: ", this )
    $.ajax "/templates/"+selectedid,
      type: "get"
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        console.log(data["description"])
        #debugger
        console.log(obj.attr("id"))
        content = obj.val(data["description"])
        CKEDITOR.instances[obj.attr('id')].setData(content)

    return


  nextTab = (elem) ->
    $(elem).next().find('a[data-toggle="tab"]').click()
    return

  prevTab = (elem) ->
    $(elem).prev().find('a[data-toggle="tab"]').click()
    return
 
  $('.nav-tabs > li a[title]').tooltip()
 
  $('a[data-toggle="tab"]').on 'show.bs.tab', (e) ->
    $target = $(e.target)
    if $target.parent().hasClass('disabled')
      return false
    return

  $('#btn1').click ->
    $('#btn1').hide()
    return

  $('#btn2').click ->
    $('#btn2').hide()
    return

  $('#form_1').submit (e) ->
    $active = $('.wizard .nav-tabs li.active')
    $active.next().removeClass 'disabled'
    nextTab $active
    return

  $('#form_2').submit (e) ->
    $active = $('.wizard .nav-tabs li.active')
    $active.next().removeClass 'disabled'
    nextTab $active
    return

  $('.nextcontent').click (e) ->
    $active = $('.wizard .nav-tabs li.active')
    $active.next().removeClass 'disabled'
    nextTab $active

    return

  $('a[data-toggle="tab"]').on 'show.bs.tab', (e) ->
    $target = $(e.target)
    if $target.parent().hasClass('disabled')
      return false
    return

  $('.prev-step').click (e) ->
    $active = $('.wizard .nav-tabs li.active')
    prevTab $active
    return
return




