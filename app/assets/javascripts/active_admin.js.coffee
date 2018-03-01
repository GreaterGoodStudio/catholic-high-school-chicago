#= require active_admin/base
#= require active_admin/active_admin_globalize
#= require activeadmin-orderable
#= require flatpickr/dist/flatpickr
#= require flatpickr/dist/plugins/confirmDate/confirmDate
#= require trix
#= require_self

$ ->
  $startsAt = $('.datetime_start')
  $endsAt = $('.datetime_end')

  options = 
    dateFormat: 'Y-m-d H:i'
    enableTime: true
    minDate: 'today'
    plugins: [new confirmDatePlugin(showAlways: true)]

  $startsAt.flatpickr $.extend({}, options, {
    onClose: (selectedDates, dateStr, instance) ->
      unless $endsAt.val()
        $endsAt.flatpickr $.extend({}, options, {
          defaultDate: selectedDates[0],
          minDate: selectedDates[0]
        })
  })

  $endsAt.flatpickr(options)
