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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:40:20'!
test05OCanNotPutAFichaInTheSameSpotAsX

	| terniLapilli |
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAtPosition: 1@1.
	
	terniLapilli putOAtPosition: 1@1.
	
	self assert: true equals: terniLapilli isPlayingX. 
	
	self should:  [terniLapilli isPlayingO] description: 'No se pueden poner dos fichas en el mismo lugar'.  ! !


!classDefinition: #Jugador category: #'Terni Lapilli'!
Object subclass: #Jugador
	instanceVariableNames: 'game turn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!Jugador methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 17:49:04'!
initializeWithGame: aGame
	
	game := aGame.
	turn = false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: #'Terni Lapilli'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 17:48:04'!
withGame: game

^self new initializeWithGame: game.! !


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'fichasX fichasO isXTurn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:20:06'!
emptyBoard
^fichasX isEmpty and: fichasO isEmpty.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:30:42'!
initialize

	fichasX := OrderedCollection new.
	fichasO := OrderedCollection new.
	isXTurn := true.
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:29:56'!
isPlayingO
^isXTurn not! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:29:45'!
isPlayingX
^isXTurn! !


!TerniLapilli methodsFor: 'actions' stamp: 'a 10/10/2019 18:43:26'!
putOAtPosition: aPoint
	((fichasX includes: aPoint) or: (fichasO includes: aPoint)) ifTrue: [^self class InvalidPutSignal ]. 
	fichasX add: aPoint.
	isXTurn := true.! !

!TerniLapilli methodsFor: 'actions' stamp: 'a 10/10/2019 18:30:31'!
putXAtPosition: aPoint 
	fichasX add: aPoint.
	isXTurn := false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'a 10/10/2019 18:41:53'!
InvalidPutSignal
self error: 'No se pueden poner dos fichas en el mismo lugar'.! !
