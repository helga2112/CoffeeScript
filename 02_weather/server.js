var http = require('http');
var static = require('node-static');
var file = new static.Server('.', {
  cache: 0
});


function accept(req, res) {
    file.serve(req, res);

}

// ------ запустить сервер -------

if (!module.parent) {
  http.createServer(accept).listen(80);
  console.log('Server is running on port 80')
} else {
  exports.accept = accept;
}