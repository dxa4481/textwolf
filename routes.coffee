module.exports = (app) ->
	app.get('/', (req, res) ->
		console.log 'LLALALAL'
		res.render 'playercount'
	)
	app.post('/', (req, res) ->
		return res.send 404 unless req.body.playerCount and not isNaN req.body.playerCount
		res.redirect '/count/' + req.body.playerCount
	)
	app.get('/count/:playerCount', (req, res) ->
		res.render 'phoneNumbers'
	)
