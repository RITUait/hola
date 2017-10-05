# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  
  $("#email_greeting").val("Dear " + $("#contact_name").text())
  if(contacts.length is 1)
    $("#prev").hide()
    $("#next").hide()
  if(i is 0)
    console.log("test")
    $("#prev").hide()

  $('.next-step').click (e) ->
    $active = $('.wizard .nav-tabs li.active')
    $active.next().removeClass 'disabled'
    nextTab $active
    return
  
  maildeliver = ->
    
    e.preventDefault()
    textBox = $("#email_subject").val()
    textBox1 = $(".description").val()
    if ((textBox == '')||(textBox1 == ''))
      alert 'your text field is empty'
    else
      
      subject = $("#email_subject").val()
      greeting = $("#email_greeting").val()
      contact_id = $("#email_contact_id").val()
      signature = $("#email_signature").val()
      context = $("#email_tag").val()
      data = []
      for a of CKEDITOR.instances
        arr1 = CKEDITOR.instances[a].getData()
        for j in [0..arr1.length - 1]
          data.push(arr1[j] + "<br>" )


   setvalue = ->
    
    console.log(i)
    $("#contact_name").html(contacts[i].name)
    $("#contact_email").html(contacts[i].email)
    $("#contact_company").html(contacts[i].company)
    $("#email_contact_id").val(contacts[i].id)
    $("#email_greeting").val("Dear"+"" + $("#contact_name").text())
  
    return

  $("#next").click ->
    i++
    contact = $("#next").val()
    setvalue()
    if(i > 0)
      console.log("test")
      $("#prev").show()
    if((contacts.length) - 1)
      console.log("test")
      $("#next").hide()
    return

  $("#prev").click ->

    i-- 
    console.log(i)
    setvalue()
    if(i is 0)
      console.log("test")
      $("#next").show()
      $("#prev").hide()
    return
  
  $("#preview").click ->
    $('#myModal1').find('.signature_email').text($("#email_Add_signature"))
    $('#myModal1').find('.contact_email').text($("#contact_email").text())
    #$('#myModal1').find('.greeting').text($("#email_greeting").val())
    $('#myModal1').find('.subject').html($("#email_subject").val())
    data = []
    for a of CKEDITOR.instances
      console.log(CKEDITOR.instances[a].getData())
      arr1 = CKEDITOR.instances[a].getData().split("\n")
      for j in [0..arr1.length - 1]
        data.push(arr1[j] + "<br>")
    $('#myModal1').find('.description').html(data.join(''))
    $("#myModal1").modal()
    return

  $("#test_mail").on 'click', (e) ->
      maildeliver()
      $.ajax ({
        url:"/self_email"
        data: {email: {subject:"#{subject}",greeting: "#{greeting}",contact_id:"#{contact_id}",signature: "#{signature}"},context: "#{context}",description: data },
        type: "post",
        dataType: "json",
        success: (data) ->

       })
      
      alert "email sent"
      return

  $("#send").on "click", (e)->
      maildeliver()
      $.ajax ({
        url:"/send_email"
        data: {email: {subject:"#{subject}",greeting: "#{greeting}",contact_id:"#{contact_id}",signature: "#{signature}"},context: "#{context}",description: data },
        type: "post",
        dataType: "json",
        success: (data) ->
          
          if(contacts.length is 1)
            window.location.href = "/"
          else
            alert 'Email sent.'
            $("#contact_name").text(contact[0].name)
            $("#contact_email").text(contact[0].email)
            $("#contact_company").text(contact[0].company)
            $("#email_contact_id").val(contact[0].id)
            $("#contact_status").text(contact[0].status)
            $("#email_greeting").val("Dear"+"" + $("#contact_name").text())
          # replace the contents of above table tag with "data"
          
        error: (data)->
          alert "Email not delivered"

        })
    
      return

  $(document).on "click", "#modal_submit", ->
    heading = $("#Heading").val()
    $("#mySelect").append('<option value="#{heading}">' + heading + '</option>')
    console.log($("#Heading").val())
    $('#mySelect').trigger("chosen:updated")
    return
return



