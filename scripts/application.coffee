AppPrototype = ->
	state: [
	]

	turn: 0

	init: ->
		@state = [
			[0,0,0],
			[0,0,0],
			[0,0,0],
		]
		@turn = @_rand(2)
		@_play() if @turn == 1

	render: ->
		console.log @turn
		$(".board .row .cell").removeClass("x o")

		@state.forEach (row, y) =>
			row.forEach (cell, x) =>
				switch cell
					when 1
						cssClass = "x"
					when 2
						cssClass = "o"
					else
						cssClass = ""

				@_cellFor(x, y).addClass(cssClass)

	registerClicks: ->
		@state.forEach (row, y) =>
			row.forEach (cell, x) =>
				@_cellFor(x, y).click (e) =>
					if @turn == 0 and @state[y][x] == 0
						@state[y][x] = 1
						@turn = 1
						@render()
						@_checkWin()
						@_play()

		$(".start-again").click =>
			@init()
			@render()
		$(".start-again").attr('disabled', true)

	_cellFor: (x, y) ->
		$(".board .row:nth-child(#{y+1}) .cell:nth-child(#{x+1})")

	# do an AI turn
	# just select anywhere
	_play: ->
		while not @_gameOver()
			x = @_rand(3)
			y = @_rand(3)
			if @state[y][x] == 0
				@state[y][x] = 2
				@turn = 0
				@render()
				@_checkWin()
				break

	_rand: (n) ->
		Math.floor(Math.random() * n)

	_checkWin: ->
		player = @_hasWin()
		if player > 0
			$(".start-again").attr('disabled', false)
			if player == 1
				alert "You won!"
			else if player == 2
				alert "The computer won"

	_hasWin: ->
		# are there any rows/columns matched?
		for player in [1..2]
			for y in [0...3]
				row = true
				for x in [0...3]
					row = row and @state[y][x] == player
				return player if row

			for x in [0...3]
				col = true
				for y in [0...3]
					col = col and @state[y][x] == player
				return player if col

			# diagonal
			diag = true
			for x in [0...3]
				diag = diag and @state[x][x] == player
			return player if diag

			# reverse diag
			rev = true
			for x in [0...3]
				rev = rev and @state[@state.length-x-1][x] == player
			return player if rev
			
		return -1

	_gameOver: ->
		# has the game won?
		return true if @_hasWin() >= 0

		# is the board filled up?
		for row in @state
			for cell in row
				return false if cell == 0

		return true

	ready: ->
		@init()
		@registerClicks()
		@render()

window.App = new AppPrototype()

$(document).ready ->
	App.ready()
