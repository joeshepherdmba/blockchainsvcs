(function(homeController){
    homeController.init = function(app){
        app.get('/', function(req, res){
            res.render('index', {title: "The Board"});
        });

        app.post("/", function(req, res){
            console.log(req.headers);
            console.log(req.body);

        });
    };
})(module.exports);