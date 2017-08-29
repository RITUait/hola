# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("#email_greeting").val("Dear " + $("#contact_name").text())
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
  
  

  $("#next").click ->
    i++
    #document.getElementById("next").innerHTML = contacts[i];
    contact = $("#next").val()
    $("#contact_name").html(contacts[i].name)
    $("#contact_email").html(contacts[i].email)
    $("#contact_company").html(contacts[i].company)
    $("#email_contact_id").val(contacts[i].id)
    $("#email_greeting").val("Dear"+"" + $("#contact_name").text())
    return

  $("#prev").click ->
    i--
    $("#contact_name").html(contacts[i].name)
    $("#contact_email").html(contacts[i].email)
    $("#contact_company").html(contacts[i].company)
    $("#email_contact_id").val(contacts[i].id)
    $("#email_greeting").val("Dear"+"" + $("#contact_name").text())
    return
  $("#preview").click ->
    $('#myModal1').find('.signature_email').text($("#email_Add_signature"))
    $('#myModal1').find('.contact_email').text($("#contact_email").text())
    $('#myModal1').find('.greeting').text($("#email_greeting").val())
    $('#myModal1').find('.subject').html($("#email_subject").val())
    #descriptions = $(".sig-description")
    data = []
    for i in [0..$(".description").length-1]
      arr1 = $($(".description")[i]).val().split("\n")
      for j in [0..arr1.length - 1]
        data.push(arr1[j] + "<br>")

     $('#myModal1').find('.description').html(data.join(''))
     $("#myModal1").modal()
     return

  $("#test_mail").click (e) ->
    alert 'Do you want send test mail.'
    $('#form').attr('action','/self_email')
    e.preventDefault()
    $('#form').submit()
    return

  

  
  $("#send").click ->
    subject = $("#email_subject").val()
    greeting = $("#email_greeting").val()
    contact_id = $("#email_contact_id").val()
    console.log(contact_id+ "888888888")
    console.log(contacts)
    signature = $("#email_signature").val()
    context = $("#email_tag").val()
    data = []
    for i in [0..$(".description").length-1]
      arr1 = $($(".description")[i]).val().split("\n")
      for j in [0..arr1.length - 1]
        data.push(arr1[j] + "<br>")
    description = $("#description_").val()
    $.ajax ({
      url:"/send_email"
      data: {email: {subject:"#{subject}",greeting: "#{greeting}",contact_id:"#{contact_id}",signature: "#{signature}"},context: "#{context}",description: "#{description}" },
      type: "post",
      dataType: "json",
      success: (data) ->

        console.log(data)
        console.log i

        # $("#table").html(data)
        # data contains html with updated values
        # use jquery selector for id table
        contact = data['contacts']
        console.log(contact, contact.length, i)
        if(contact.length is 0)
          console.log("test")
          window.location.href = "/"
        else
          console.log(contact[0])
          $("#contact_name").text(contact[0].name)
          $("#contact_email").text(contact[0].email)
          $("#contact_company").text(contact[0].company)
          $("#email_contact_id").val(contact[0].id)
          $("#contact_status").text(contact[0].status)
          $("#email_greeting").val("Dear"+"" + $("#contact_name").text())
        # replace the contents of above table tag with "data"
          
      error: (data)->
        console.log(data)
    })
    
    return

  $(document).on "click", "#modal_submit", ->
    heading = $("#Heading").val()
    $("#mySelect").append('<option value="#{heading}">' + heading + '</option>')
    console.log($("#Heading").val())
    $('#mySelect').trigger("chosen:updated")
    return
return



