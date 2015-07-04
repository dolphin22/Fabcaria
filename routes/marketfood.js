var express = require('express'),
	router = express.Router(),
	MarketFood = require('../models/marketfood')

router.route('/')
        .post(function(req, res) {
                var marketfood = new MarketFood()
                marketfood.marketName = req.body.marketName
                marketfood.name = req.body.name
                marketfood.price = req.body.price
		marketfood.promotion = req.body.promotion
		marketfood.barcode = req.body.barcode

                marketfood.save(function(err) {
                        if(err) res.send(err)
                        res.json({ message: 'MarketFood created' })
                })
        })
        .get(function(req, res) {
                MarketFood.find(function(err, marketfoods) {
                        if(err) res.send(err)
                        res.json(marketfoods)
                })
        })

router.route('/:marketfood_id')
        .get(function(req, res) {
                MarketFood.findById(req.params.marketfood_id, function(err, marketfood) {
                        if(err) res.send(err)
                        res.json(marketfood)
                })
        })
        .put(function(req, res) {
                MarketFood.findById(req.params.marketfood_id, function(err, marketfood) {
                        if(err) res.send(err)
                        marketfood.marketName = req.body.marketName
                        marketfood.name = req.body.name
                        marketfood.price = req.body.price
			marketfood.promotion = req.body.promotion
			marketfood.barcode = req.body.barcode

                        marketfood.save(function(err){
                                if(err) res.send(err)
                                res.send({ message: 'MarketFood updated' })
                        })
                })
        })
        .delete(function(req, res) {
                MarketFood.remove({
                        _id: req.params.marketfood_id
                }, function(err, marketfood){
                        if(err) res.send(err)
                        res.json({ message: 'MarketFood deleted' })
                })
        })

module.exports = router
