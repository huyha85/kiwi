$ ->
  $('#users').on 'change', ->
    userId = $(this).val()
    if userId == ''
      window.location.href = '/checkins'
    else
      window.location.href = "/checkins?user_id=#{userId}"

window.timeFormat = (time_str) ->
  time = parseFloat(time_str)
  if time == 0
    'Not checked in'
  else
    hour = Math.floor(time)
    minute = Math.floor((time - hour) * 60)
    "Checked in at #{padZero(hour)}:#{padZero(minute)}"

window.padZero = (figure) ->
  (if figure < 10 then '0' else '') + figure

window.drawChart = (labels, datasets) ->
  data = {
    labels : labels,
    datasets : [
      {
        fillColor : "transparent",
        strokeColor : "rgba(220,4,4,1)",
        pointColor : "rgba(220,4,4,1)",
        pointStrokeColor : "#fff",
        data : datasets
      }
    ]
  }

  chartOptions = {
    scaleGridLineColor : "#555",
    tooltipTemplate: "<%= label %>: <%= timeFormat(value) %>",
    scaleBeginAtZero: true
  }

  $('#canvas').remove()
  $('#graph-container').prepend('<canvas id="canvas"></canvas>')
  myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Line(data, chartOptions)