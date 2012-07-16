jQuery ->
  $.datepicker.setDefaults($.datepicker.regional['ru'])
  $('#history_date').datepicker
    dateFormat: 'dd.mm.yy'
    showOn: 'button'
    buttonImage: '/assets/calendar.gif'
    buttonImageOnly: true