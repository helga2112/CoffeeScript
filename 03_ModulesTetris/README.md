ADDITIONAL INSTALL:

npm install browserify-shim -- save
npm install browserify -g
npm install coffeeify
npm install --save-dev coffeeify coffeescript



COMPILE:
browserify -t coffeeify main.coffee > bundle.js



INFO
http://browserify.org/
https://github.com/browserify/browserify-handbook
