!classDefinition: #TerniLapilliTest category: #'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:22:02'!
test01GamesStartsWithEmptyBoardAndXStartPlaying
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	self assert: true equals: terniLapilli emptyBoard.
	self assert: true equals: terniLapilli isPlayingX.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:23:43'!
test02GameStartsAndOCanNotPlay

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	
	self deny: terniLapilli isPlayingO.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:31:21'!
test03XMarksAndThenIsOTurn

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	
	self assert: true equals: terniLapilli isPlayingX.
	
	terniLapilli putXAtPosition: 1@1.
	self assert: false equals: terniLapilli isPlayingX. 
	self assert: true equals: terniLapilli isPlayingO.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:33:33'!
test04OMarksAndThenIsXTurn

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAtPosition: 1@1.
	
	self assert: true equals: terniLapilli isPlayingO.
	terniLapilli putOAtPosition: 2@2.
	
	self assert: true equals: terniLapilli isPlayingX. 
	self assert: false equals: terniLapilli isPlayingO.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 20:31:29'!
test05OCanNotPutAFichaInTheSameSpotAsX

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAtPosition: 1@1.
	
	self should:  [terniLapilli putOAtPosition: 1@1]
	raise: Error
	withMessageText: 'No se pueden poner dos fichas en el mismo lugar.'! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 20:34:29'!
test06XCanNotPutAFichaInTheSameSpotAsO

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAtPosition: 1@1.
	terniLapilli putOAtPosition: 1@2.
	
	self should:  [terniLapilli putXAtPosition: 1@2]
	raise: Error
	withMessageText: 'No se pueden poner dos fichas en el mismo lugar.'! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 20:36:44'!
test07XCanNotMarkAnInvalidSpot

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	
	self should:  [terniLapilli putXAtPosition: 4@1.]
	raise: Error
	withMessageText: 'La posición solicitada excede el tablero.'! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 20:52:58'!
test08XCanNotMarkASpotTwoTimes

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli putXAtPosition: 1@1.
	terniLapilli putOAtPosition: 1@2.
	
	self should:  [terniLapilli putXAtPosition: 1@1.]
	raise: Error
	withMessageText: 'No se pueden poner dos fichas en el mismo lugar.'! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 21:00:36'!
test09XCanNotPlayWhileOisPlaying

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli putXAtPosition: 1@1.
	self assert: true equals: terniLapilli isPlayingO.
	
	self should:  [terniLapilli putXAtPosition: 1@2.]
	raise: Error
	withMessageText: 'Todavía es turno del otro jugador.'! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 21:53:19'!
test10XMarksThreeTimesLinearAndWins

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli putXAtPosition: 1@1.
	terniLapilli putOAtPosition: 1@2.
	terniLapilli putXAtPosition: 2@1.
	terniLapilli putOAtPosition: 1@3.
	terniLapilli putXAtPosition: 3@1.
	terniLapilli putOAtPosition: 3@2.
	
	self assert: true equals: terniLapilli isOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 21:54:22'!
test11OMarksThreeTimesDiagonalAndWins

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli putXAtPosition: 1@2.
	terniLapilli putOAtPosition: 1@1.
	terniLapilli putXAtPosition: 2@1.
	terniLapilli putOAtPosition: 2@2.
	terniLapilli putXAtPosition: 3@1.
	terniLapilli putOAtPosition: 3@3.
	
	self assert: true equals: terniLapilli isOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 22:04:03'!
test12BothMarksThreeTimesButTheGameStillPlaying

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli putXAtPosition: 1@2.
	terniLapilli putOAtPosition: 1@1.
	terniLapilli putXAtPosition: 2@1.
	terniLapilli putOAtPosition: 3@2.
	terniLapilli putXAtPosition: 3@1.
	terniLapilli putOAtPosition: 3@3.
	
	self assert: false equals: terniLapilli isOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 22:12:33'!
test12XPlayerCanNotWinByPutting4Fichas

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	terniLapilli putXAtPosition: 1@1.
	terniLapilli putOAtPosition: 1@2.
	terniLapilli putXAtPosition: 2@2.
	terniLapilli putOAtPosition: 2@3.
	terniLapilli putXAtPosition: 3@1.
	terniLapilli putOAtPosition: 3@2.
	terniLapilli putXAtPosition: 2@1.
	
	self assert: false equals: terniLapilli isOver.! !


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'fichasX fichasO isXTurn isOver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 22:19:39'!
checkIfValidPosition: aPoint
	((aPoint x < 1) or: (aPoint y < 1)) ifTrue: [^self class InvalidPositionSignal ].
	((aPoint x > 3) or: (aPoint y > 3)) ifTrue: [^self class InvalidPositionSignal ].! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:20:06'!
emptyBoard
^fichasX isEmpty and: fichasO isEmpty.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 21:07:36'!
initialize

	fichasX := OrderedCollection new.
	fichasO := OrderedCollection new.
	isXTurn := true.
	isOver:= false.
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 21:07:47'!
isOver
	^isOver! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:29:56'!
isPlayingO
^isXTurn not! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:29:45'!
isPlayingX
^isXTurn! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 22:21:37'!
isSpotFree: aPoint

((fichasX includes: aPoint) or: (fichasO includes: aPoint)) ifTrue: [^self class InvalidPutSignal ]. ! !


!TerniLapilli methodsFor: 'actions' stamp: 'g j 10/14/2019 22:22:13'!
putOAtPosition: aPoint
	self isPlayingX ifTrue: [^self class OtherPlayerPlaying ].
	self checkIfValidPosition: aPoint.
	self isSpotFree: aPoint.
	fichasO add: aPoint.
	
	fichasO size = 3 ifTrue: [
		(fichasO select: [:aCoordinate | aCoordinate y = aCoordinate x]) size = 3 ifTrue: [isOver := true.]
		].
	isXTurn := true.! !

!TerniLapilli methodsFor: 'actions' stamp: 'g j 10/14/2019 22:22:22'!
putXAtPosition: aPoint
	self isPlayingO ifTrue: [^self class OtherPlayerPlaying ].
	self checkIfValidPosition: aPoint.
	self isSpotFree: aPoint.
	fichasX add: aPoint.
	fichasX size = 3 ifTrue: [
		(fichasX select: [:aCoordinate | aCoordinate y = 1]) size = 3 ifTrue: [isOver := true.]
		].
	isXTurn := false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 20:39:31'!
InvalidPositionSignal
self error: 'La posición solicitada excede el tablero.'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 20:31:42'!
InvalidPutSignal
self error: 'No se pueden poner dos fichas en el mismo lugar.'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'g j 10/14/2019 21:00:28'!
OtherPlayerPlaying
self error: 'Todavía es turno del otro jugador.'! !
