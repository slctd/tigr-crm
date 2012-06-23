jQuery ->
  $(document).ready ->
    if location.hash != ''
      $('a[href="'+location.hash+'"]').tab('show')
  
  $('a[data-toggle="tab"]').on 'shown', (e) ->
    location.hash = $(e.target).attr('href').substr(1)