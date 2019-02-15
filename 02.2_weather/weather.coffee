@doGetWeather = ()->
    console.log 'get'
    url = 'http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=296825658cf6173062078c07ff1ab3ce'
    fetch url
        .then processResponce 

processResponce = (responce)->
    if responce.status is not 200
        console.log 'Some error ', responce.status
    
    responce.json().then parseData

parseData = (data) ->
    console.log '2 >>> ', data
    addData(data)


class Weather
    constructor: (obj) ->
        @temperature = obj.main.temp
        @pressure = obj.main.pressure
        @temp_min = obj.main.temp_min
        @temp_max = obj.main.temp_max
    

addData = (data) ->
    weather = new Weather data
    div = document.createElement('div');
    div.innerHTML = '<p> temperature ' + weather.temperature + '</p>
                    <p> pressure ' + weather.pressure + '</p>
                    <p> temperature min: ' + weather.temp_min + '</p>
                    <p> temperature max: ' + weather.temp_max + '</p>'
    document.body.appendChild div