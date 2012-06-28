#jQuery ->
#  $('#connect_with').change ->
#    connect_with = $(this).find('option:selected').val()
#    if connect_with == "сделка"
#      marker = $('<span />').insertBefore($('#history_deal_id'))
#      $('#history_deal_id').detach().attr('type', 'text').insertAfter(marker).focus()
#      alert($('#history_deal_id').nearest('div').nearest('div'))
#      #.css = "class: control-group"
#      marker.remove()