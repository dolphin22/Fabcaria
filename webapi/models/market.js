var mongoose = require('mongoose'),
	Schema = mongoose.Schema

var marketSchema = new Schema({ 
	name: String,
	address: String,
	phoneNumber: String,
	website: String	
})

module.exports = mongoose.model('Market', marketSchema)
