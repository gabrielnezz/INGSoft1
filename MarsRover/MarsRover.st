!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'g j 10/6/2019 21:54:32'!
test01MarsRoverShouldCreateCorrectly

	| marsRover |
	marsRover := MarsRover withPosition: 1@2 andDirection: 'N'.
	
	self assert: marsRover position x equals: 1.
	self assert: marsRover position y equals: 2.
	self assert: marsRover direction equals: 'N'.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'g j 10/6/2019 22:04:59'!
test02MarsRoverReceivesAForwardCommandAndMoves

	| marsRover |
	marsRover := MarsRover withPosition: 1@2 andDirection: 'N'.
	
	self assert: marsRover position x equals: 1.
	self assert: marsRover position y equals: 2.
	self assert: marsRover direction equals: 'N'.
	
	marsRover receiveSequence: 'f'.
	
	self assert: marsRover position x equals: 1.
	self assert: marsRover position y equals: 3.
	self assert: marsRover direction equals: 'N'.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'g j 10/6/2019 22:05:54'!
test03MarsRoverReceivesABackwardCommandAndMovesBack

	| marsRover |
	marsRover := MarsRover withPosition: 1@2 andDirection: 'N'.
	
	self assert: marsRover position x equals: 1.
	self assert: marsRover position y equals: 2.
	self assert: marsRover direction equals: 'N'.
	
	marsRover receiveSequence: 'b'.
	
	self assert: marsRover position x equals: 1.
	self assert: marsRover position y equals: 1.
	self assert: marsRover direction equals: 'N'.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'g j 10/6/2019 22:10:51'!
test04MarsRoverReceivesABackwardCommandAndMovesToLeft

	| marsRover |
	marsRover := MarsRover withPosition: 1@2 andDirection: 'E'.
	
	self assert: 1 equals: marsRover position x.
	self assert: 2 equals: marsRover position y.
	self assert: 'E' equals: marsRover direction.
	
	marsRover receiveSequence: 'b'.
	
	self assert: 0 equals: marsRover position x.
	self assert: 2 equals: marsRover position y.
	self assert: 'E' equals: marsRover direction.
	
	! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'g j 10/6/2019 21:51:08'!
direction
^direction! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'g j 10/6/2019 21:49:59'!
initializeWithPosition: aPosition andDirection: aDirection

position:= aPosition.
direction := aDirection.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'g j 10/6/2019 21:50:54'!
position
^position ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'g j 10/6/2019 22:24:18'!
receiveSequence: aSequenceOfCommands

(aSequenceOfCommands = 'f' and: (direction = 'N')) ifTrue: [ position := position x @ (position y + 1)].

(aSequenceOfCommands = 'b' and: (direction = 'E')) ifTrue: [ position := (position x -1) @ position y ].

(aSequenceOfCommands = 'b' and: (direction = 'N')) ifTrue: [position := position x @ (position y - 1)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'g j 10/6/2019 21:49:14'!
withPosition: aPosition andDirection: aDirection
	^self new initializeWithPosition: aPosition andDirection: aDirection.! !
