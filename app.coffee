express = require "express"
http = require "http"
crypto = require "crypto"
path = require "path"


app = express()

app.configure(()->
    crypto.randomBytes(48, (ex, buf) ->
        token = buf.toString('hex');
        app.set('port', process.env.PORT || 3080);
        app.set('views', __dirname + '/views');
        app.set('view engine', 'jade');
        app.use(express.favicon());
        app.use(express.cookieParser());
        app.use(express.session(secret: token));
        app.use(express.logger('dev'));
        app.use(express.bodyParser());
        app.use(express.methodOverride());
        app.use(app.router);
        app.use(express.static(path.join(__dirname, 'public')));
        require("./routes")(app);
        #Create webserver
        http.createServer(app).listen(app.get('port'), ()->
          console.log("Express server listening on port " + app.get('port'));
        )
    );

);
