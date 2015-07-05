var mongoose = require('mongoose'),
	Schema = mongoose.Schema

var foodSchema = new Schema({ 
	type: String,
	name: String,
	expire_in: Number,
	image: String
})

module.exports = mongoose.model('Food', foodSchema)
