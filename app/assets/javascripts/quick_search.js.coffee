jQuery ->
  $('a#quick_search').on 'click', (e) ->
    if $('div#quick_search').css('display') == 'none'
      $('div#quick_search').css('display', 'block')
      $('#search').focus()
    else
      $('div#quick_search').css('display', 'none')
    e.preventDefault()