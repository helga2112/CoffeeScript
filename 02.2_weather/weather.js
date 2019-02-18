(function() {
  var Weather, addData, parseData, processResponce;

  this.doGetWeather = function() {
    var url;
    console.log('get');
    url = 'http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=296825658cf6173062078c07ff1ab3ce';
    return fetch(url).then(processResponce);
  };

  processResponce = function(responce) {
    if (responce.status === !200) {
      console.log('Some error ', responce.status);
    }
    return responce.json().then(parseData);
  };

  parseData = function(data) {
    console.log('2 >>> ', data);
    return addData(data);
  };

  Weather = class Weather {
    constructor(obj) {
      this.temperature = obj.main.temp;
      this.pressure = obj.main.pressure;
      this.temp_min = obj.main.temp_min;
      this.temp_max = obj.main.temp_max;
    }

  };

  addData = function(data) {
    var div, weather;
    weather = new Weather(data);
    div = document.createElement('div');
    div.innerHTML = '<p> temperature ' + weather.temperature + '</p> <p> pressure ' + weather.pressure + '</p> <p> temperature min: ' + weather.temp_min + '</p> <p> temperature max: ' + weather.temp_max + '</p>';
    return document.body.appendChild(div);
  };

}).call(this);


//# sourceMappingURL=weather.js.map
//# sourceURL=coffeescript