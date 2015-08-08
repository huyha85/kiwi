$ ->
  $('#users').on 'change', ->
    userId = $(this).val()
    if userId == ''
      window.location.href = '/checkins/index'
    else
      window.location.href = "/checkins/index?user_id=#{userId}"

window.drawChart = (labels, datasets) ->
  data = {
    labels : labels,
    datasets : [
      {
        fillColor : "rgba(220,4,4,0.5)",
        strokeColor : "rgba(220,4,4,1)",
        pointColor : "rgba(220,4,4,1)",
        pointStrokeColor : "#fff",
        data : datasets
      }
    ]
  }

  $('#canvas').remove()
  $('#graph-container').append('<canvas id="canvas"></canvas>')
  myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Bar(data)