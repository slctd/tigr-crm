jQuery ->
  $('#deal_stage_id').change ->
    stage_id = $(this).find('option:selected').val()
    $.getJSON "/stages/#{stage_id}.json", (stage) ->
      $('#deal_success_probability').val(stage.success_probability)

  $(document).ready ->  
    $('#participant').tokenInput '/contacts.json'
      theme: 'facebook'      
      tokenLimit: 1
      propertyToSearch: "name"    
      tokenValue: "id_with_class_name"
      
    input = $('#deal_contact')
    input.tokenInput '/contacts.json'
      theme: 'facebook'
      prePopulate: input.data('pre')    
      tokenLimit: 1
      propertyToSearch: "name"
      tokenValue: "id_with_class_name"