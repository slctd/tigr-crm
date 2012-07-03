jQuery ->
  # Set callback on Add email button
  $('form').on 'click', '.add_email_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    new_elem = $(this).data('fields').replace(regexp, time)
    $(this).before(new_elem)
    event.preventDefault()
    
  # Set callback on Remove email button
  $('form').on 'click', '.remove_email_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  # Set callback on Add email button
  $('form').on 'click', '.add_phone_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    new_elem = $(this).data('fields').replace(regexp, time)
    $(this).before(new_elem)
    event.preventDefault()
    
  # Set callback on Remove email button
  $('form').on 'click', '.remove_phone_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()
    
  $('#person_id').tokenInput '/people.json'
    theme: 'facebook'      
    tokenLimit: 1