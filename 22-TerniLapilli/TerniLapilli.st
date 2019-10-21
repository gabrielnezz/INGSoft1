!classDefinition: #Test category: #TerniLapilli!
TestCase subclass: #Test
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 19:45:52'!
test01WhenGameStartsPlayerXIsPlaying

	| juego |
	
	juego := Juego initialize.

	self assert: (juego isPlayingX).! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 19:58:33'!
test02WhenGameIsCreatedTheGameIsNotOverAndGameIsNotTied

	| juego |
	
	juego := Juego initialize.
	
	self assert: (juego isOver) = false.! !

!Test methodsFor: 'tests' stamp: 'db 10/15/2019 20:41:57'!
test03WhenGameIsCreatedPlayerOIsNotPlaying
	| juego |
	
	juego := Juego initialize.
	
	self assert: (juego isPlayingO) = false. ! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 19:45:10'!
test04WhenGameIsCreatedTheBoardIsEmpty
	| juego |
	
	juego := Juego initialize.
	
	self assert: juego boardIsEmpty.! !

!Test methodsFor: 'tests' stamp: 'db 10/15/2019 20:42:03'!
test05WhenGameIsCreatedNeitherPlayerHasWon

	| juego |
	
	juego := Juego initialize.
	
	self assert: juego hasPlayerXWon  = false.
	self assert: juego hasPlayerOWon  = false.! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 20:01:22'!
test06EachPlayerCanMoveOnePiecePerMove
  | juego |

	juego := Juego initialize.
	
	juego putXAt: 1@1.
	
	self assert: juego isPlayingO.
	
	self should: [juego putXAt: 1@2]
		raise: Error
		withMessageText: 'Player is not moving'.
	
	
	self assert: juego isPlayingO .! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 22:36:05'!
test06MoveOfMoreThanOneCellOfDistanceIsNotAllowed
	| juego |
	
	juego := Juego new.
	
	juego putXAt: 1@1.
	juego putOAt: 3@3.
	
	juego putXAt: 1@2.
	juego putOAt:3@2.
	
	juego putXAt: 2@1.
	juego putOAt: 2@3.
	
	self should:[juego moveFrom: 1@1 To: 1@3]
		raise: Error
			withMessageText: 'Move is too far'.
	! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 20:04:45'!
test07TheFirstThreeMovesImpliesPutPiecesOnTheBoard
	| juego |
	
	juego := Juego new.
	
	juego putXAt: 1@1.
	self assert: juego isPlayingO.
	
	juego putOAt: 3@3.
	self assert: juego isPlayingX.
	
	juego putXAt: 1@2.
	self assert: juego isPlayingO.
	
	juego putOAt: 3@2.
	self assert: juego isPlayingX.
	
	juego putXAt: 2@1.
	self assert: juego isPlayingO.
	
	juego putOAt: 2@3.
	self assert: juego isPlayingX.
! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 20:13:02'!
test08FromFourthMovePlayerCantPutPiecesInsteadHasToMoveThem
	| juego |

	juego := Juego new.
	
	juego putXAt: 1@1.
	self assert: juego isPlayingO.
	
	juego putOAt: 3@3.
	self assert: juego isPlayingX.
	
	juego putXAt: 1@2.
	self assert: juego isPlayingO.
	juego putOAt: 3@2.
	self assert: juego isPlayingX.
	juego putXAt: 2@1.
	self assert: juego isPlayingO.
	juego putOAt: 2@3.
	self assert: juego isPlayingX.
		
	self should: [juego putXAt: 1@1]
		raise: Error.
	
	self should: [juego putOAt: 1@1]
		raise: Error.
		
		
	! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 20:16:53'!
test09CheckPositionsOfPiecesIsCorrect

	| positionsLeft juego |
	juego := Juego new.
	
	juego putXAt: 1@1.
	self assert: (juego isPlaceOccuped: 1@1).
	juego putOAt: 2@3.
	self assert: (juego isPlaceOccuped: 2@3).
	"""
	positionsLeft := #((1@2) (1@3) (2@2) (2@1) (3@1) (3@2) (3@3)).
	
	self assert: (positionsLeft allSatisfy: [:position | (juego isPlaceOccuped: position) = false]).
	"""! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 20:17:22'!
test10CheckIfThreeInSameRowFinishesTheGame

	| juego |
	
	juego := Juego new.
	
	juego putXAt: 1@1.
	juego putOAt: 2@1.
	juego putXAt: 1@2.
	juego putOAt: 2@3.
	juego putXAt: 1@3.
	
	self assert: (juego isOver).
	! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 20:18:12'!
test11CheckMoveOfPositionIsCorrect
	| juego |
	juego := Juego new.
	
	juego putXAt: 1@1.
	self assert: juego isPlayingO.
	
	juego putOAt: 3@3.
	self assert: juego isPlayingX.
	
	juego putXAt: 1@2.
	self assert: juego isPlayingO.
	juego putOAt: 3@2.
	self assert: juego isPlayingX.
	juego putXAt: 2@1.
	self assert: juego isPlayingO.
	juego putOAt: 2@3.
	self assert: juego isPlayingX.
	
	juego moveFrom: 1@2 To: 1@3.
	self assert: (juego isPlaceOccuped: 1@3).
	self assert: ((juego isPlaceOccuped: 1@2) = false).
	self assert: juego isPlayingO.
		
		
		
		
	! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 22:57:06'!
test12WhenGameIsOverNeitherPlayerCanMove
	| juego |
	juego := Juego new.
	
	self assert: (juego isOver) = false.
	
	juego putXAt: 1@1.
	juego putOAt: 2@1.
	juego putXAt: 1@2.
	juego putOAt: 2@3.
	juego putXAt: 1@3.
	
	self assert: juego isOver.
	self should: [juego moveFrom: #(1 1) To: #(2 2) ] 
		raise: Error
		withMessageText: 'Game is over'.
! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 20:18:34'!
test13AssertPlayerXWon
	| juego |
	juego := Juego new.
	
	self assert: (juego isOver) = false.
	
	juego putXAt: 1@1.
	juego putOAt: 2@1.
	juego putXAt: 1@2.
	juego putOAt: 2@3.
	juego putXAt: 1@3.
	
	
	self assert: juego isOver.
	
	self assert: (juego hasPlayerXWon).
	self assert: (juego hasPlayerOWon) = false.
	! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 20:37:08'!
test14CantMoveAPieceToAPositionOccuped

	| juego |
	
	juego := Juego new.
	
	juego putXAt: 1@1.
	
	self should: [juego putOAt: 1@1]
		raise: Error
		withMessageText: 'Position occuped'.! !

!Test methodsFor: 'tests' stamp: 'db 10/16/2019 20:36:16'!
test15CantMoveToPositionOutsideTheBoard

| juego |
	juego := Juego new.
	
	juego putXAt: 1@1.
	
	self should: [juego putOAt: 5@5]
		raise: Error
		withMessageText: 'Position invalid'.! !


!classDefinition: #Board category: #TerniLapilli!
Object subclass: #Board
	instanceVariableNames: 'size board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Board methodsFor: 'state of board' stamp: 'db 10/15/2019 21:34:49'!
isEmpty
	^(((board at:1) = #(0 0 0)) & ((board at:2) = #(0 0 0)) & ((board at:3) = #(0 0 0)))! !

!Board methodsFor: 'state of board' stamp: 'db 10/16/2019 20:03:50'!
positionIsFree: aPosition

	^((board at:(aPosition x) ) at: (aPosition y)) = 0! !

!Board methodsFor: 'state of board' stamp: 'db 10/15/2019 22:53:13'!
positionIsOccuped: aPosition
	^(self positionIsFree: aPosition) = false.! !

!Board methodsFor: 'state of board' stamp: 'db 10/16/2019 20:03:31'!
positionIsValid: aPosition
							
	 (aPosition x >= 1) & (aPosition x <= 3) ifTrue: [ 
												(aPosition y >= 1) & (aPosition y <= 3) ifTrue: [
																							^true
																						]
												].
	^false.! !

!Board methodsFor: 'state of board' stamp: 'db 10/16/2019 22:07:58'!
size
^size ! !


!Board methodsFor: 'state of places' stamp: 'db 10/16/2019 20:00:50'!
moveFrom: aPosition To:anotherPosition
	|anteriorId filaVieja filaNueva |
	anteriorId := (board at: (aPosition x)) at: (aPosition y).
	filaVieja := board at: (aPosition x).
	filaVieja at: (aPosition y) put: 0.
	filaNueva := board at: (anotherPosition x).
	filaNueva at: (anotherPosition y) put: anteriorId.! !

!Board methodsFor: 'state of places' stamp: 'db 10/16/2019 20:00:24'!
put: aIdentifier to: aPosition
|temp pos2|
	temp := board at: (aPosition x).
	pos2 := aPosition y.
	temp at: pos2 put: aIdentifier.! !


!Board methodsFor: 'initialization' stamp: 'db 10/16/2019 19:53:57'!
initialize
	|a b c|
	size := 3.
	a := Array with:0 with:0 with:0.
	b := Array with:0 with:0 with:0.
	c := Array with:0 with:0 with:0.
	board := Array new:3.
	board 
		at: 1 put: a;
		at: 2 put: b;
		at: 3 put: c;
		yourself.
	^self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Board class' category: #TerniLapilli!
Board class
	instanceVariableNames: ''!

!Board class methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 19:02:28'!
initialize

^self new initialize.! !


!classDefinition: #Juego category: #TerniLapilli!
Object subclass: #Juego
	instanceVariableNames: 'isOver playerPlaying board playerXPieces playerOPieces juegoEstadoActual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Juego methodsFor: 'state of board' stamp: 'db 10/15/2019 19:13:23'!
boardIsEmpty
	^board isEmpty.! !

!Juego methodsFor: 'state of board' stamp: 'db 10/16/2019 17:56:50'!
isPlaceOccuped: aPosition

	^board positionIsOccuped: aPosition.! !


!Juego methodsFor: 'state of game' stamp: 'db 10/15/2019 23:08:39'!
finishTheGame
	isOver := true.! !

!Juego methodsFor: 'state of game' stamp: 'db 10/15/2019 18:04:10'!
isOver
	^isOver ! !


!Juego methodsFor: 'initialization' stamp: 'db 10/16/2019 22:56:40'!
initialize
	isOver := false.
	playerPlaying := #X.
	playerXPieces := Array with:0 with:0 with:0.  """ #(0 0 0)"""
	playerOPieces := Array with:0 with:0 with:0.
	board := Board new.
	^self.! !


!Juego methodsFor: 'players' stamp: 'db 10/15/2019 19:38:52'!
hasPlayerOWon
	^self hasThreeInLinePlayer: #O.! !

!Juego methodsFor: 'players' stamp: 'db 10/15/2019 22:57:40'!
hasPlayerXWon
	^self hasThreeInLinePlayer: #X.! !

!Juego methodsFor: 'players' stamp: 'db 10/16/2019 20:11:19'!
hasThreeInLinePlayer: aPlayer
	|pieza1 pieza2 pieza3 playerPieces|					
	aPlayer = #X ifTrue: [playerPieces := playerXPieces] ifFalse: [aPlayer = #O ifTrue: [playerPieces := playerOPieces] ifFalse:[^false]].	
	(playerPieces includes: 0) ifTrue: [^false].
	pieza1 := playerXPieces at: 1.
	pieza2 := playerXPieces at: 2.
	pieza3 := playerXPieces at: 3.
	(board positionIsValid: pieza1) ifTrue: [
							(board positionIsValid: pieza2) ifTrue: [
													(board positionIsValid: pieza3) ifTrue: [
																					"""misma fila """			 
																					((pieza1 x) = (pieza2 x)) ifTrue: [((pieza1 x) = (pieza3 x)) ifTrue: [^true]].
																					""" misma columna"""
																					((pieza1 y) = (pieza2 y)) ifTrue: [((pieza1 y) = (pieza3 y)) ifTrue: [^true]].
																					""" en diagonal """
																					((pieza1 x) ~= (pieza2 x)) & ((pieza1 x) ~= (pieza3 x)) & ((pieza2 x) ~= (pieza3 x)) & ((pieza2 y) ~= (pieza2 x)) & ((pieza1 y) ~=(pieza3 x)) & ((pieza2 y) ~= (pieza3 y)) ifTrue:[^true.].
																					].
															].
									].
	^false.! !

!Juego methodsFor: 'players' stamp: 'db 10/15/2019 18:04:42'!
isPlayingO
	^(playerPlaying = #O)! !

!Juego methodsFor: 'players' stamp: 'db 10/15/2019 22:57:40'!
isPlayingX

	^(playerPlaying = #X)! !


!Juego methodsFor: 'movements' stamp: 'db 10/16/2019 22:27:18'!
checkDistanceIsLessThanOneCellOf:  aPosition To: anotherPosition

	"""  no puede ser simetrico"""
	 (aPosition x = anotherPosition y) & (aPosition y = anotherPosition x) ifTrue:[^false].
	"""is in same row and then column is one bigger/less  or simmetric """
	(aPosition x = anotherPosition x) ifTrue: [
										( ( aPosition y - anotherPosition y)abs <= 1) ifTrue: [
																					^true.
																				].
		
										]  ifFalse: [
											(aPosition y = anotherPosition y) ifTrue: [
																					((aPosition x - anotherPosition  x)abs <= 1) ifTrue: [
																																^true.
																															].
																				].
											].
										
	""" positions are row and column exact 1 bigger/less """								
	(aPosition x ~= anotherPosition x ) & ((aPosition x - anotherPosition x)abs <= 1) ifTrue:[
											(aPosition y ~= anotherPosition y) & ( (aPosition y - anotherPosition y)abs <= 1) ifTrue:[
																					""" check movement is not """
																					^true.
																				]
											].
	^false.! !

!Juego methodsFor: 'movements' stamp: 'db 10/15/2019 23:06:22'!
checkIfPlayerWon
	^self hasThreeInLinePlayer: playerPlaying.! !

!Juego methodsFor: 'movements' stamp: 'db 10/16/2019 22:39:57'!
moveFrom: aPositionOfAPiece To: aPositionInTheBoard
	| currentPlayerPieces |
	isOver ifTrue:[^Juego ErrorGameIsOver].
	playerPlaying =  #X ifTrue: [currentPlayerPieces := playerXPieces ] ifFalse:[currentPlayerPieces := playerOPieces ].
	(board positionIsValid: aPositionOfAPiece) ifFalse:[^Juego ErrorPositionInvalid ].
	
	 
	(board positionIsValid: aPositionInTheBoard) ifFalse:[^Juego ErrorPositionInvalid ].
	
      (board positionIsOccuped: aPositionOfAPiece ) ifFalse:[^Juego ErrorPositionIsEmpty ].

      (board positionIsFree: aPositionInTheBoard ) ifFalse:[^Juego ErrorPositionOccuped].

	(currentPlayerPieces includes: (aPositionOfAPiece )) ifFalse: [^Juego ErrorPieceIsNotFromPlayerPlaying].
	
	(self checkDistanceIsLessThanOneCellOf: aPositionOfAPiece To: aPositionInTheBoard ) ifFalse:[^Juego ErrorMoveIsTooFar ] ifTrue: [
															board moveFrom: aPositionOfAPiece To:  aPositionInTheBoard.
															(playerPlaying  = #X) ifTrue: [
																							playerPlaying := #O
																						] ifFalse:[
																						 	playerPlaying := #O 
																						].
															].

	self checkIfPlayerWon ifTrue: [^JuegoEstadoOver new].
		! !

!Juego methodsFor: 'movements' stamp: 'db 10/16/2019 22:56:47'!
putOAt: aPosition
    self putInPosition: aPosition fromPlayer: #O withOpponent: #X.

! !

!Juego methodsFor: 'movements' stamp: 'db 10/16/2019 20:27:39'!
putXAt: aPosition
	self putInPosition: aPosition fromPlayer: #X withOpponent: #O.
! !


!Juego methodsFor: 'movements - private' stamp: 'db 10/16/2019 21:41:44'!
putInPosition: aPosition fromPlayer: actualPlayer withOpponent: opponentPlayer
    | currentPlayerPieces |
    isOver ifTrue:[^Juego ErrorGameIsOver].
    playerPlaying = actualPlayer ifFalse: [^Juego ErrorPlayerIsNotMoving ].
    playerPlaying =  #X ifTrue: [currentPlayerPieces := playerXPieces ] ifFalse:[currentPlayerPieces := playerOPieces ].

    (currentPlayerPieces allSatisfy:[:piece | piece ~= 0]) ifTrue:[
   												 ^ Juego ErrorPlayerHasNoMorePiecesToPut
   											 ].


	(board positionIsValid: aPosition) ifTrue: [(board positionIsFree: aPosition) ifTrue: [
																					currentPlayerPieces at: (currentPlayerPieces findFirst: [:p | p = 0]) put: aPosition.
																					board put: actualPlayer to: aPosition.
																				] ifFalse:  [^Juego ErrorPositionOccuped ].
										] ifFalse:[^Juego ErrorPositionInvalid ].
   									 
    self checkIfPlayerWon ifTrue: [self finishTheGame] ifFalse: [
   															 playerPlaying := opponentPlayer.
   														 ].

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Juego class' category: #TerniLapilli!
Juego class
	instanceVariableNames: ''!

!Juego class methodsFor: 'Errors' stamp: 'db 10/16/2019 19:33:51'!
ErrorGameIsOver
^self error: 'Game is over'! !

!Juego class methodsFor: 'Errors' stamp: 'db 10/16/2019 22:32:00'!
ErrorMoveIsTooFar
^self error:'Move is too far'! !

!Juego class methodsFor: 'Errors' stamp: 'db 10/16/2019 22:31:01'!
ErrorPieceIsNotFromPlayerPlaying
^self error: 'Piece is not from player playing'.! !

!Juego class methodsFor: 'Errors' stamp: 'db 10/16/2019 19:49:53'!
ErrorPlayerHasNoMorePiecesToPut
	^self error: 'Player has no more pieces to put'! !

!Juego class methodsFor: 'Errors' stamp: 'db 10/16/2019 19:34:10'!
ErrorPlayerIsNotMoving
	^self error: 'Player is not moving'! !

!Juego class methodsFor: 'Errors' stamp: 'db 10/16/2019 19:34:32'!
ErrorPositionInvalid
	^self error: 'Position invalid'.! !

!Juego class methodsFor: 'Errors' stamp: 'db 10/16/2019 19:37:55'!
ErrorPositionInvalidOrOccuped
	^self error: 'Position invalid or occuped'.! !

!Juego class methodsFor: 'Errors' stamp: 'db 10/16/2019 22:29:40'!
ErrorPositionIsEmpty
^self error:'Position is empty'! !

!Juego class methodsFor: 'Errors' stamp: 'db 10/16/2019 20:35:48'!
ErrorPositionOccuped
	^self error: 'Position occuped'! !


!Juego class methodsFor: 'initialize' stamp: 'db 10/15/2019 20:40:49'!
initialize
^self new initialize.! !


!Juego class methodsFor: 'as yet unclassified' stamp: 'db 10/16/2019 21:39:41'!
Error
^self error:'El movimiento no es valido'! !


!classDefinition: #JuegoEstadoMoverPiezas category: #TerniLapilli!
Juego subclass: #JuegoEstadoMoverPiezas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!JuegoEstadoMoverPiezas methodsFor: 'as yet unclassified' stamp: 'db 10/16/2019 22:47:06'!
putInPosition: aPosition fromPlayer: actualPlayer withOpponent: opponentPlayer
    | currentPlayerPieces |
    isOver ifTrue:[^Juego ErrorGameIsOver].
    playerPlaying = actualPlayer ifFalse: [^Juego ErrorPlayerIsNotMoving ].
    playerPlaying =  #X ifTrue: [currentPlayerPieces := playerXPieces ] ifFalse:[currentPlayerPieces := playerOPieces ].

    (currentPlayerPieces allSatisfy:[:piece | piece ~= 0]) ifTrue:[
   												 ^ Juego ErrorPlayerHasNoMorePiecesToPut
   											 ].


	(board positionIsValid: aPosition) ifTrue: [(board positionIsFree: aPosition) ifTrue: [
																					currentPlayerPieces at: (currentPlayerPieces findFirst: [:p | p = 0]) put: aPosition.
																					board put: actualPlayer to: aPosition.
																				] ifFalse:  [^Juego ErrorPositionOccuped ].
										] ifFalse:[^Juego ErrorPositionInvalid ].
   									 
    self checkIfPlayerWon ifTrue: [self finishTheGame] ifFalse: [
   															 playerPlaying := opponentPlayer.
   														 ].

! !


!classDefinition: #JuegoEstadoOver category: #TerniLapilli!
Juego subclass: #JuegoEstadoOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!JuegoEstadoOver methodsFor: 'as yet unclassified' stamp: 'db 10/16/2019 22:41:14'!
doesNotUnderstand: aMessage
	^self error: 'El juego finalizo'! !

!JuegoEstadoOver methodsFor: 'as yet unclassified' stamp: 'db 10/16/2019 22:36:43'!
isOver
	^true! !


!classDefinition: #JuegoEstadoPonerPiezas category: #TerniLapilli!
Juego subclass: #JuegoEstadoPonerPiezas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!


!classDefinition: #O category: #TerniLapilli!
Object subclass: #O
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!


!classDefinition: #X category: #TerniLapilli!
Object subclass: #X
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

Board initialize!
Juego initialize!