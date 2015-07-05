var express = require('express'),
	app = express(),
	logger = require('morgan'),
	bodyParser = require('body-parser'),
	mongoose = require('mongoose')

app.use(logger('dev'))
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use(express.static('public'))

var port = process.env.PORT || 2204;

mongoose.connect('mongodb://localhost/fabcaria', function(error) {
	if(error) console.log('database connection failed.')
	else console.log('database connection established.')
})
var Food = require('./models/food'),
    Box = require('./models/box'),
    Market = require('./models/market'),
    MarketFood = require('./models/marketfood'),
    Recipe = require('./models/recipe')

var router = express.Router(),
	foods = require('./routes/food'),
	boxes = require('./routes/box'),
	markets = require('./routes/market'),
	marketfoods = require('./routes/marketfood'),	
	recipes = require('./routes/recipe')
	findrecipe = require('./routes/findrecipe'),
	pickedrecipe = require('./routes/pickedrecipe')

router.get('/', function(req, res) {
	res.json({ message: 'Welcome to Fabcaria\'s API' })
})

app.use('/api', router)
app.use('/api/foods', foods)
app.use('/api/boxes', boxes)
app.use('/api/markets', markets)
app.use('/api/marketfoods', marketfoods)
app.use('/api/recipes', recipes)
app.use('/api/findrecipe', findrecipe)
app.use('/api/pickedrecipe', pickedrecipe)

app.listen(port)
console.log('Server started at port ' + port)
