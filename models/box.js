var mongoose = require('mongoose'),
	Schema = mongoose.Schema

var boxSchema = new Schema({ 
	rfidTag: String,
	foodName: String,
	weight: Number,
	createDate: { type: Date, default: Date.now } 
})

boxSchema.index({ foodName: "text" })

module.exports = mongoose.model('Box', boxSchema)
