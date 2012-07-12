jQuery ->
  $('a#recent_actions_options').on 'click', (e) ->
    if $('div#recent_actions_options').css('display') == 'none'
      $('div#recent_actions_options').css('display', 'block')
    else
      $('div#recent_actions_options').css('display', 'none')
    e.preventDefault()