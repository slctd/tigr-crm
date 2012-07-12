jQuery ->
  $('a#recent_actions_options').on 'click', (e) ->
    if $('div#recent_actions_options').css('display') == 'none'
      $('div#recent_actions_options').css('display', 'block')
      $('#recent_actions_options_icon').attr('class', 'icon-chevron-down')
    else
      $('div#recent_actions_options').css('display', 'none')
      $('#recent_actions_options_icon').attr('class', 'icon-chevron-right')      
    e.preventDefault()