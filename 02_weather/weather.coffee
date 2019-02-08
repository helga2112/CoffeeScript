https = require 'https'

url = 'api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=296825658cf6173062078c07ff1ab3ce'

console.log url

req = https.get url, (res) ->
  status = res.statusCode
  value = if status == 200 then 1 else 0
  if status == 200
    # ...
    console.log "yey!"
    res.on 'data', (chunk) ->
      console.log('body: ' + chunk)
  else
    # ...
    console.log "i'm not worthy"

req.on 'error', ->
  msg = "not available"
  console.log msg
console.log "done!"