!classDefinition: #MarsRoverTest category: #'21-MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 14:08:27'!
assertHeadingIsValid: aHeading
	|headings headingUpperCase|
	headings := Set with: $N with:$O with:$S with:$E.
	self assert: aHeading isLetter.
	headingUpperCase := aHeading asUppercase.
	self assert: headings includes: headingUpperCase.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 13:57:02'!
assertValueIsANumber: aValue
	self assert: aValue class = SmallInteger! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 14:11:15'!
test01newMarsRoverMustHaveValidCoordinates
	|marsRover x y|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $N.
	x := (marsRover xCoordinates).
	self assertValueIsANumber: x.
	y := (marsRover yCoordinates).
	self assertValueIsANumber: y.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 17:17:24'!
test02newMarsRoverMustHaveValidHeading
	|marsRover heading|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $N.
	heading := marsRover heading.
	self assertHeadingIsValid: heading! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 14:24:56'!
test03newMarsRoverCantHaveInvalidCoordinates
	|marsRover|
	self should: [marsRover := MarsRover initializeWithX: 5 andY: $d andHeading: $N.]
		raise: Error. 

	self should: [marsRover := MarsRover initializeWithX: $a andY: 5 andHeading: $N.]
		raise: Error. 
			
	self should: [marsRover := MarsRover initializeWithX: $a andY: $d andHeading: $N.]
		raise: Error. 
			! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 14:28:52'!
test04newMarsRoverCantHaveInvalidHeading
	self should: [MarsRover initializeWithX: 5 andY: 1 andHeading: $f]
		raise: Error.
		
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 15:45:41'!
test05newMarsRoverHeadingIsNotCaseSensitive
	|marsRover|
	marsRover :=  MarsRover initializeWithX: 5 andY: 10 andHeading: $n.
	self assert: true.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 17:31:35'!
test06marsRoverWithHeadingNorthWithForwardCommandMustHaveSameXCordinateAndOneUnitMoreInYCoordinate
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $N.
	comandos := 'f'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = (1 + oldYCoordinate ).
	self assert: (marsRover xCoordinates) = (oldXCoordinate ). ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 17:33:09'!
test07marsRoverWithHeadingNorthWithBackCommandMustHaveSameXCoordinateAndOneUnitMinusInYCoordinate
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $N.
	comandos := 'b'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = (oldYCoordinate - 1 ).
	self assert: (marsRover xCoordinates) = (oldXCoordinate ). ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 17:39:49'!
test08marsRoverWithNorthHeadingWithRCommandNewHeadingIsEast
	|marsRover comandos|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $N.
	comandos := 'r'.
	marsRover executeCommands: comandos.
	self assert: (marsRover heading) = ($E).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 17:40:53'!
test09marsRoverWithSouthHeadingWithICommandNewHeadingIsEast
	|marsRover comandos|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $S.
	comandos := 'I'.
	marsRover executeCommands: comandos.
	self assert: (marsRover heading) = ($E).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 17:42:19'!
test10marsRoverWithHeadingWestWithFCommandMustHaveSameYCoordinateAndOneUnitMinusInXCoordinate
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $O.
	comandos := 'f'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = (oldYCoordinate  ).
	self assert: (marsRover xCoordinates) = (oldXCoordinate - 1). ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 17:46:39'!
test11marsRoverHasToExecuteUntilACommandIsInvalid
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $N.
	comandos := 'ffrfgf'. """ posicion final x:1 y: 2""" 
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = (oldYCoordinate + 2).
	self assert: (marsRover xCoordinates) = (oldXCoordinate +1 ). ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 17:51:13'!
test12marsRoverStopExecutingCommandsWhenFindsInvalid
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $N.
	comandos := 'affffriririfrfgf'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = oldYCoordinate.
	self assert: (marsRover xCoordinates) = oldXCoordinate! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 17:55:59'!
test13marsRoverTurnsNotChangePosition
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $N.
	comandos := 'rrrriiiirrriiii'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = oldYCoordinate.
	self assert: (marsRover xCoordinates) = oldXCoordinate! !

!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/6/2019 17:55:15'!
test14marsRover360TurnsNotChangeHeading
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $N.
	comandos := 'rrrr'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = oldYCoordinate.
	self assert: (marsRover xCoordinates) = oldXCoordinate.
	self assert: (marsRover heading) = $N.
	
	""" ahora left turns"""
	marsRover := MarsRover initializeWithX: 0 andY: 0 andHeading: $N.
	comandos := 'iiii'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = oldYCoordinate.
	self assert: (marsRover xCoordinates) = oldXCoordinate.
	self assert: (marsRover heading) = $N.! !


!classDefinition: #Coordinate category: #'21-MarsRover'!
Object subclass: #Coordinate
	instanceVariableNames: 'x y'
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!Coordinate methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:25:05'!
+ aCoordinate
|newCoord|
	newCoord := Coordinate newWithX: (aCoordinate x + self x) andY: (aCoordinate y + self y).
	^newCoord 

! !

!Coordinate methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:36:40'!
- aCoordinate
|newCoord|
	newCoord := Coordinate newWithX: (self x - aCoordinate x) andY: (self y - aCoordinate y).
	^newCoord 

! !

!Coordinate methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:19:09'!
checkAValue: aValue and: anotherValue
	(aValue class = SmallInteger) ifTrue: [(anotherValue class) = SmallInteger ifTrue: [^true.]]! !

!Coordinate methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:30:17'!
newWithX: aValue andY: anotherValue
	(self checkAValue: aValue and: anotherValue ) ifFalse: [self InvalidCoordinates ].
	x := aValue.
	y := anotherValue .! !

!Coordinate methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 13:54:16'!
x
	^x
	! !

!Coordinate methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 13:54:21'!
y
	^y! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Coordinate class' category: #'21-MarsRover'!
Coordinate class
	instanceVariableNames: ''!

!Coordinate class methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:19:20'!
InvalidCoordinates
	^self error: 'Invalid coordinates'! !

!Coordinate class methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 13:16:03'!
newWithX: aValue andY: anotherValue
	^self new newWithX: aValue andY: anotherValue! !


!classDefinition: #HandlerMovement category: #'21-MarsRover'!
Object subclass: #HandlerMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!HandlerMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:16:04'!
checkValidHeading: aHeading
	^('NSEO' includes: aHeading)! !

!HandlerMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 16:52:24'!
do
	^self subclassResponsibility ! !

!HandlerMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:11:32'!
heading
	^self subclassResponsibility .! !

!HandlerMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:21:19'!
initializeWithHeading: aHeading
	|aHeadingUppercase|
	aHeadingUppercase := aHeading asUppercase.
	(self checkValidHeading: aHeadingUppercase) ifFalse: [^ self InvalidHeading ].
	(aHeadingUppercase = $O) ifTrue: [^LeftMovement new].
	(aHeadingUppercase = $N) ifTrue: [^UpMovement new].
	(aHeadingUppercase = $S) ifTrue: [^DownMovement new].
	(aHeadingUppercase = $E) ifTrue: [^RightMovement new].! !

!HandlerMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:07:05'!
rotateLeft
	^self subclassResponsibility ! !

!HandlerMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:01:27'!
rotateRight
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HandlerMovement class' category: #'21-MarsRover'!
HandlerMovement class
	instanceVariableNames: ''!

!HandlerMovement class methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:16:21'!
InvalidHeading
	^self error: 'Invalid heading'! !

!HandlerMovement class methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:10:36'!
initializeWithHeading: aHeading
	^self new initializeWithHeading: aHeading.! !


!classDefinition: #DownMovement category: #'21-MarsRover'!
HandlerMovement subclass: #DownMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!DownMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:06:30'!
do
	|newCoord|
	newCoord := Coordinate newWithX: 0 andY: -1.
	^newCoord .! !

!DownMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:11:42'!
heading
	^$S! !

!DownMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:07:21'!
rotateLeft
	^RightMovement new.! !

!DownMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:53:25'!
rotateRight
	^LeftMovement new.! !


!classDefinition: #LeftMovement category: #'21-MarsRover'!
HandlerMovement subclass: #LeftMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!LeftMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 16:52:14'!
do
	|newCoord|.
	newCoord  := Coordinate newWithX: -1 andY: 0.
	^newCoord ! !

!LeftMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:11:48'!
heading
	^$O! !

!LeftMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:07:55'!
rotateLeft
	^DownMovement new.! !

!LeftMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:04:33'!
rotateRight
	^UpMovement new.
	! !


!classDefinition: #RightMovement category: #'21-MarsRover'!
HandlerMovement subclass: #RightMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!RightMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:06:53'!
do
	|newCoord|.
	newCoord  := Coordinate newWithX: 1 andY: 0.
	^newCoord ! !

!RightMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:12:03'!
heading
	^$E! !

!RightMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:07:33'!
rotateLeft
	^UpMovement new.! !

!RightMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:05:40'!
rotateRight
	^DownMovement new.! !


!classDefinition: #UpMovement category: #'21-MarsRover'!
HandlerMovement subclass: #UpMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!UpMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:06:44'!
do
	|newCoord|.
	newCoord  := Coordinate newWithX: 0 andY: 1.
	^newCoord ! !

!UpMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:11:57'!
heading
	^$N! !

!UpMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:07:41'!
rotateLeft
	^LeftMovement new.! !

!UpMovement methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:38:52'!
rotateRight
	^RightMovement new.
	! !


!classDefinition: #MarsRover category: #'21-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinates handlerMovement'
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:45:47'!
checkValidCommand: aCommand
	('FBIR' includes: (aCommand asUppercase)) ifFalse:[('FBIR' includes: aCommand) ifFalse:[^false.].].
	^true.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:48:01'!
executeCommands: aStringOfCommands
|aCommand	|
	aStringOfCommands do: [:command | aCommand := command asUppercase. 
									(self checkValidCommand: aCommand) ifTrue:[
									(aCommand = $F) ifTrue: [coordinates := coordinates + handlerMovement do ].
									(aCommand = $R) ifTrue: [handlerMovement := handlerMovement rotateRight]. 
									(aCommand = $I) ifTrue: [handlerMovement := handlerMovement rotateLeft].
									(aCommand = $B) ifTrue: [coordinates := coordinates - handlerMovement do]
									] ifFalse:[^self]
									
								].
						! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:12:08'!
heading
	^handlerMovement heading.
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:02:27'!
initializeWithX: xValue andY: yValue andHeading: aHeading
	handlerMovement := HandlerMovement initializeWithHeading: aHeading.
	coordinates  := Coordinate newWithX: xValue andY: yValue.
	^self! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 16:59:48'!
xCoordinates
	^coordinates x! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 17:10:10'!
yCoordinates
	^coordinates y. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'21-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 16:45:22'!
InvalidCommand
	^self error: 'Invalid Command'! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'db 10/6/2019 14:09:32'!
initializeWithX: xValue andY: yValue andHeading: aHeading
	^(self new) initializeWithX: xValue andY: yValue andHeading: aHeading.! !
