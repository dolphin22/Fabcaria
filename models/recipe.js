var mongoose = require('mongoose'),
	Schema = mongoose.Schema

var recipeSchema = new Schema({ 
	name: String,
	image: String,
	ingredients: String
})

recipeSchema.index({ name: "text", ingredients: "text" })

module.exports = mongoose.model('Recipe', recipeSchema)
