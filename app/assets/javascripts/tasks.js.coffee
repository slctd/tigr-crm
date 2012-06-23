jQuery ->
  input = $('#task_contact')
  input.tokenInput '/contacts.json'
    theme: 'facebook'
    prePopulate: input.data('pre')    
    tokenLimit: 1
    propertyToSearch: "name"    
    tokenValue: "id_with_class_name"