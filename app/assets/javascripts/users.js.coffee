jQuery ->
  # Set callback on Add user contact button
  $('form').on 'click', '.add_user_contact_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    new_elem = $(this).data('fields').replace(regexp, time)
    $(this).before(new_elem)
    event.preventDefault()
    
  # Set callback on Remove user contact button
  $('form').on 'click', '.remove_user_contact_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()