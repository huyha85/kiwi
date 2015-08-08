$ ->
  $('#users').on 'change', ->
    userId = $(this).val()
    if userId == ''
      window.location.href = '/checkins/index'
    else
      window.location.href = "/checkins/index?user_id=#{userId}"