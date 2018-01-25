(function (controllers) {
		
  var homeController = require("./homeController");

  controllers.init = function (app) {
    homeController.init(app);
  };

})(module.exports);

// var express = require('express');
// var router = express.Router();

// /* GET home page. */
// router.get('/', function(req, res, next) {
//   res.render('index', { title: 'Express' });
// });

// module.exports = router;
