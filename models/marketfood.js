var mongoose = require('mongoose'),
	Schema = mongoose.Schema

var marketFoodSchema = new Schema({ 
	marketName: String,
	name: String,
	price: Number,
	promotion: Number,
	barcode: String
})

module.exports = mongoose.model('MarketFood', marketFoodSchema)
