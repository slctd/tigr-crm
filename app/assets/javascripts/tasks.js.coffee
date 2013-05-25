jQuery ->
  $.datepicker.setDefaults $.datepicker.regional["ru"]
  $("#task_deadline_date").datepicker
    dateFormat: "dd.mm.yy"
    showOn: "button"
    buttonImage: "/assets/calendar.gif"
    buttonImageOnly: true

  $(document).ready ->
    input = $("#task_contact")
    input.tokenInput "/contacts.json",
      theme: "facebook"
      prePopulate: input.data("pre")
      tokenLimit: 1
      propertyToSearch: "name"
      tokenValue: "id_with_class_name"