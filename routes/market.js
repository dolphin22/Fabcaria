var express = require('express'),
	router = express.Router(),
	Market = require('../models/market')

router.route('/')
        .post(function(req, res) {
                var market = new Market()
                market.name = req.body.name
                market.address = req.body.address
                market.phoneNumber = req.body.phoneNumber
		market.website = req.body.website

                market.save(function(err) {
                        if(err) res.send(err)
                        res.json({ message: 'Market created' })
                })
        })
        .get(function(req, res) {
                Market.find(function(err, markets) {
                        if(err) res.send(err)
                        res.json(markets)
                })
        })

router.route('/:market_id')
        .get(function(req, res) {
                Market.findById(req.params.market_id, function(err, market) {
                        if(err) res.send(err)
                        res.json(market)
                })
        })
        .put(function(req, res) {
                Market.findById(req.params.market_id, function(err, market) {
                        if(err) res.send(err)
                        market.name = req.body.name
                        market.address = req.body.address
                        market.phoneNumber = req.body.phoneNumber
			market.website = req.body.website

                        market.save(function(err){
                                if(err) res.send(err)
                                res.send({ message: 'Market updated' })
                        })
                })
        })
        .delete(function(req, res) {
                Market.remove({
                        _id: req.params.market_id
                }, function(err, market){
                        if(err) res.send(err)
                        res.json({ message: 'Market deleted' })
                })
        })

module.exports = router
