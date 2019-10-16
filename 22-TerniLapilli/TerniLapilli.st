!classDefinition: #Test category: #TerniLapilli!
TestCase subclass: #Test
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 20:41:52'!
test01WhenGameStartsPlayerXIsPlaying

	| juego |
	
	juego := Juego initialize.

	self assert: (juego isPlayingX) = true.! !

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 23:23:38'!
test02WhenGameTheGameIsNotOverAndGameIsNotTied

	| juego |
	
	juego := Juego initialize.
	
	self assert: (juego isOver) = false.
	self assert: (juego isTied) = false.! !

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 20:41:57'!
test03WhenGameIsCreatedPlayerOIsNotPlaying
	| juego |
	
	juego := Juego initialize.
	
	self assert: (juego isPlayingO) = false. ! !

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 20:42:00'!
test04WhenGameIsCreatedTheBoardIsEmpty
	| juego |
	
	juego := Juego initialize.
	
	self assert: juego boardIsEmpty = true.! !

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 20:42:03'!
test05WhenGameIsCreatedNeitherPlayerHasWon

	| juego |
	
	juego := Juego initialize.
	
	self assert: juego hasPlayerXWon  = false.
	self assert: juego hasPlayerOWon  = false.! !

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 20:42:05'!
test06EachPlayerCanMoveOnePiecePerMove
  | juego |

	juego := Juego initialize.
	
	juego putXAt: #(1 1).
	
	self assert: juego isPlayingO.
	
	self should: [juego putXAt: #(1 2)]
		 raise: Error.
	
	
	self assert: juego isPlayingO .! !

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 21:14:57'!
test07TheFirstThreeMovesImpliesPutPiecesOnTheBoard
	| juego |
	
	juego := Juego new.
	
	juego putXAt: #(1 1).
	self assert: juego isPlayingO.
	
	juego putOAt: #(3 3).
	self assert: juego isPlayingX.
	
	juego putXAt: #(1 2).
	self assert: juego isPlayingO.
	
	juego putOAt: #(3 2).
	self assert: juego isPlayingX.
	
	juego putXAt: #(2 1).
	self assert: juego isPlayingO.
	
	juego putOAt: #(2 3).
	self assert: juego isPlayingX.
! !

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 20:52:29'!
test08FromFourthMovePlayerCantPutPiecesInsteadHasToMoveThem
	| juego |

	juego := Juego new.
	
	juego putXAt: #(1 1).
	self assert: juego isPlayingO.
	
	juego putOAt: #(3 3).
	self assert: juego isPlayingX.
	
	juego putXAt: #(1 2).
	self assert: juego isPlayingO.
	juego putOAt: #(3 2).
	self assert: juego isPlayingX.
	juego putXAt: #(2 1).
	self assert: juego isPlayingO.
	juego putOAt: #(2 3).
	self assert: juego isPlayingX.
		
	self should: [juego putXAt: #(1 1)]
		raise: Error.
	
	self should: [juego putOAt: #(1 1)]
		raise: Error.
		
		
	! !

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 22:55:36'!
test09CheckPositionsOfPiecesIsCorrect

	| positionsLeft juego |
	juego := Juego new.
	
	juego putXAt: #(1 1).
	self assert: (juego isOccuped: #(1 1)).
	juego putOAt: #(2 3).
	self assert: (juego isOccuped: #(2 3)).
	
	positionsLeft := #((1 2) #(1 3) #(2 2) #(2 1) #(3 1) #(3 2) #(3 3)).
	
	self assert: (positionsLeft allSatisfy: [:position | (juego isOccuped: position) = false]).! !

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 22:59:59'!
test10CheckIfThreeInSameRowFinishesTheGame

	| juego |
	
	juego := Juego new.
	
	juego putXAt: #(1 1).
	juego putOAt: #(2 1).
	juego putXAt: #(1 2).
	juego putOAt: #(2 3 ).
	juego putXAt: #(1 3).
	
	self assert: (juego isOver).
	! !

!Test methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 23:30:06'!
test11CheckMoveOfPositionIsCorrect
	| juego |
	juego := Juego new.
	
	juego putXAt: #(1 1).
	self assert: juego isPlayingO.
	
	juego putOAt: #(3 3).
	self assert: juego isPlayingX.
	
	juego putXAt: #(1 2).
	self assert: juego isPlayingO.
	juego putOAt: #(3 2).
	self assert: juego isPlayingX.
	juego putXAt: #(2 1).
	self assert: juego isPlayingO.
	juego putOAt: #(2 3).
	self assert: juego isPlayingX.
	
	juego moveFrom: #(1 2) To: #(1 3).
	self assert: (juego isOccuped: #(1 3)).
	self assert: ((juego isOccuped: #(1 2)) = false).
	self assert: juego isPlayingO.
		
		
		
		
	! !


!classDefinition: #Board category: #TerniLapilli!
Object subclass: #Board
	instanceVariableNames: 'size board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Board methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 22:47:30'!
initialize
	|a b c|
	size := 3.
	a := Array with:0 with:0 with:0.
	b := Array with:0 with:0 with:0.
	c := Array with:0 with:0 with:0.
	board := Array new:4.
	board 
		at: 1 put: a;
		at: 2 put: b;
		at: 3 put: c;
		yourself.
	^self.
! !

!Board methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 21:34:49'!
isEmpty
	^(((board at:1) = #(0 0 0)) & ((board at:2) = #(0 0 0)) & ((board at:3) = #(0 0 0)))! !

!Board methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 23:33:46'!
moveFrom: aPosition To:anotherPosition
	|anteriorId filaVieja filaNueva |
	anteriorId := (board at: (aPosition at: 1)) at: (aPosition at:2).
	filaVieja := board at: (aPosition at: 1).
	filaVieja at: (aPosition at: 2) put: 0.
	filaNueva := board at: (anotherPosition at: 1).
	filaNueva at: (anotherPosition at:2 ) put: anteriorId.! !

!Board methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 21:12:24'!
positionIsFree: aPosition

	^((board at:(aPosition at: 1) ) at: (aPosition at:2)) = 0! !

!Board methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 22:53:13'!
positionIsOccuped: aPosition
	^(self positionIsFree: aPosition) = false.! !

!Board methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 18:52:23'!
positionIsValid: aPosition
							
	 ^ aPosition allSatisfy: [:pos | (pos >= 1) & (pos <= 3)].
	! !

!Board methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 22:41:40'!
put: aIdentifier to: aPosition
|temp pos2|
	temp := board at: (aPosition at:1).
	pos2 := aPosition at: 2.
	temp at: pos2 put: aIdentifier.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Board class' category: #TerniLapilli!
Board class
	instanceVariableNames: ''!

!Board class methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 19:02:28'!
initialize

^self new initialize.! !


!classDefinition: #Juego category: #TerniLapilli!
Object subclass: #Juego
	instanceVariableNames: 'isOver isTied playerPlaying board playerXPieces playerOPieces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Juego methodsFor: 'state of board' stamp: 'db 10/15/2019 19:13:23'!
boardIsEmpty
	^board isEmpty.! !

!Juego methodsFor: 'state of board' stamp: 'db 10/15/2019 22:51:48'!
isOccuped: aPosition

	^board positionIsOccuped: aPosition.! !


!Juego methodsFor: 'state of game' stamp: 'db 10/15/2019 23:08:39'!
finishTheGame
	isOver := true.! !

!Juego methodsFor: 'state of game' stamp: 'db 10/15/2019 19:34:55'!
hasWonPlayer: aPlayer 
	^self hasThreeInLinePlayer: aPlayer! !

!Juego methodsFor: 'state of game' stamp: 'db 10/15/2019 18:04:10'!
isOver
	^isOver ! !

!Juego methodsFor: 'state of game' stamp: 'db 10/15/2019 18:04:14'!
isTied
	^isTied ! !



!Juego methodsFor: 'initialization' stamp: 'db 10/15/2019 23:23:49'!
initialize
	isOver := false.
	isTied := false.
	playerPlaying := #X.
	playerXPieces := Array with:0 with:0 with:0.  """ #(0 0 0)"""
	playerOPieces := Array with:0 with:0 with:0.
	board := Board new.
	^self.! !


!Juego methodsFor: 'players' stamp: 'db 10/15/2019 19:38:52'!
hasPlayerOWon
	^self hasThreeInLinePlayer: #O.! !

!Juego methodsFor: 'players' stamp: 'db 10/15/2019 19:33:30'!
hasPlayerXThreeInLine
	|a b c|					
	playerXPieces detect: [:piece | piece = 0 ifTrue: [^false.].].
	a := playerXPieces at:1.
	b := playerXPieces at:2.
	c := playerXPieces at:3.
	
	(board positionIsValid: a) ifTrue: [
							(board positionIsValid: b) ifTrue: [
													(board positionIsValid: c) ifTrue: [
																					"""misma fila """			 
																					((a at: 1) = (b at: 1)) ifTrue: [((a at:1) = (c at:1)) ifTrue: [^true]].
																					""" misma columna"""
																					((a at: 2) = (b at: 2)) ifTrue: [((a at:2) = (c at:2)) ifTrue: [^true]].
																					""" en diagonal """
																					((a at: 1) ~= (b at: 1) ifTrue: [((a at:1) ~= (c at:1)) ifTrue: [((b at:1) ~= (c at: 1))]]) ifTrue: [
																																					((a at: 2) ~= (b at: 1) ifTrue: [((a at: 2) ~= (c at:1)) ifTrue: [((b at: 2) ~= (c at: 2))]]) 
																																											
																																											].
																					].
															].
									].
	^false.! !

!Juego methodsFor: 'players' stamp: 'db 10/15/2019 22:57:40'!
hasPlayerXWon
	^self hasThreeInLinePlayer: #X.! !

!Juego methodsFor: 'players' stamp: 'db 10/15/2019 23:23:04'!
hasThreeInLinePlayer: aPlayer
	|a b c playerPieces|					
	aPlayer = #X ifTrue: [playerPieces := playerXPieces] ifFalse: [aPlayer = #O ifTrue: [playerPieces := playerOPieces] ifFalse:[^false]].	
	(playerPieces includes: 0) ifTrue: [^false].
	a := playerXPieces at:1.
	b := playerXPieces at:2.
	c := playerXPieces at:3.
	
	(board positionIsValid: a) ifTrue: [
							(board positionIsValid: b) ifTrue: [
													(board positionIsValid: c) ifTrue: [
																					"""misma fila """			 
																					((a at: 1) = (b at: 1)) ifTrue: [((a at:1) = (c at:1)) ifTrue: [^true]].
																					""" misma columna"""
																					((a at: 2) = (b at: 2)) ifTrue: [((a at:2) = (c at:2)) ifTrue: [^true]].
																					""" en diagonal """
																					((a at: 1) ~= (b at: 1)) & ((a at: 1) ~= (c at: 1)) & ((b at: 1) ~= (c at: 1)) & ((a at: 2) ~= (b at: 1)) & ((a at: 2) ~=(c at: 1)) & ((b at: 2) ~= (c at:2)) ifTrue:[^true.].
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


!Juego methodsFor: 'movements' stamp: 'db 10/15/2019 23:06:22'!
checkIfPlayerWon
	^self hasThreeInLinePlayer: playerPlaying.! !

!Juego methodsFor: 'movements' stamp: 'db 10/15/2019 23:31:18'!
moveFrom: aPositionOfAPiece To: aPositionInTheBoard
	| currentPlayerPieces |
	playerPlaying =  #X ifTrue: [currentPlayerPieces := playerXPieces ] ifFalse:[currentPlayerPieces := playerOPieces ].
	(board positionIsValid: aPositionOfAPiece) & 
	(board positionIsValid: aPositionInTheBoard) &
      (board positionIsOccuped: aPositionOfAPiece ) & 
      (board positionIsFree: aPositionInTheBoard ) &
	(currentPlayerPieces includes: (aPositionOfAPiece )) ifTrue: [
															board moveFrom: aPositionOfAPiece To:  aPositionInTheBoard.
															(playerPlaying  = #X) ifTrue: [playerPlaying := #O] ifFalse:[ playerPlaying := #O ].
															].
													
	^Error
		! !

!Juego methodsFor: 'movements' stamp: 'db 10/15/2019 23:10:13'!
putOAt: aPosition

	playerPlaying = #O ifFalse: [^self ErrorPlayerIsNotMoving ].

	(playerOPieces allSatisfy:[:piece | piece ~= 0]) ifTrue:[
													^ self ErrorPlayerHasNoMorePiecesToPut 
												].

	(board positionIsValid: aPosition) & (board positionIsFree: aPosition) ifTrue: [
																				playerOPieces at: (playerOPieces findFirst: [:p | p = 0]) put: aPosition.
																				board put: #O to: aPosition.
																			] ifFalse:[^Juego ErrorPositionInvalid ].
										
	self checkIfPlayerWon ifTrue: [self finishTheGame] ifFalse: [
		
																playerPlaying := #X.
		
															].! !

!Juego methodsFor: 'movements' stamp: 'db 10/15/2019 23:10:23'!
putXAt: aPosition

	playerPlaying = #X ifFalse: [^self ErrorPlayerIsNotMoving ].
	
	(playerXPieces allSatisfy:[:piece | piece ~= 0]) ifTrue:[
													^ self ErrorPlayerHasNoMorePiecesToPut 
												].
											
	(board positionIsValid: aPosition) & (board positionIsFree: aPosition) ifTrue: [
																				playerXPieces at: (playerXPieces findFirst: [:p | p = 0]) put: aPosition.
																				board put: #X to: aPosition.
																			] ifFalse:[^Juego ErrorPositionInvalid ].																		
										
	self checkIfPlayerWon ifTrue: [self finishTheGame] ifFalse: [
		
																playerPlaying := #O.
		
															].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Juego class' category: #TerniLapilli!
Juego class
	instanceVariableNames: ''!

!Juego class methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 20:04:19'!
ErrorPlayerHasNoMorePiecesToPut
^self Error! !

!Juego class methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 19:57:12'!
ErrorPlayerIsNotMoving
	^self error! !

!Juego class methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 20:13:14'!
ErrorPositionInvalid
^self error.! !

!Juego class methodsFor: 'as yet unclassified' stamp: 'db 10/15/2019 20:40:49'!
initialize
^self new initialize.! !


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