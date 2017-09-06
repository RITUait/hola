# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).ready ->
  navListItems = $('div.setup-panel div a')
  allWells = $('.setup-content')
  allNextBtn = $('.nextBtn')
  allWells.hide()
  navListItems.click (e) ->
    e.preventDefault()
    $target = $($(this).attr('href'))
    $item = $(this)
    if !$item.hasClass('disabled')
      navListItems.removeClass('btn-primary').addClass 'btn-default'
      $item.addClass 'btn-primary'
      allWells.hide()
      $target.show()
      $target.find('input:eq(0)').focus()
    return
  allNextBtn.click ->
    curStep = $(this).closest('.setup-content')
    curStepBtn = curStep.attr('id')
    nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children('a')
    curInputs = curStep.find('input[type=\'text\'],input[type=\'url\']')
    isValid = true
    $('.form-group').removeClass 'has-error'
    i = 0
    while i < curInputs.length
      if !curInputs[i].validity.valid
        isValid = false
        $(curInputs[i]).closest('.form-group').addClass 'has-error'
      i++
    if isValid
      nextStepWizard.removeAttr('disabled').trigger 'click'
    return
  $('div.setup-panel div a.btn-primary').trigger 'click'
  return
