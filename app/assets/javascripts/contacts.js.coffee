jQuery ->
  $(document).ready ->
    if location.hash != ''
      $('a[href="'+location.hash+'"]').tab('show')
  
  $('a[data-toggle="tab"]').on 'shown', (e) ->
    location.hash = $(e.target).attr('href').substr(1)
    
  $('a#upload_image').on 'click', (e) ->
    $('#user_image').attr('size', 2);
    $('.upload_image_form').css('display', 'block')
    $('a#upload_image').css('display', 'none')
    e.preventDefault()
    
  $('a#close_upload_image_form').on 'click', (e) ->
    $('.upload_image_form').css('display', 'none')
    $('a#upload_image').css('display', 'inline')    
    e.preventDefault()