!classDefinition: #MarsRoverTest category: #'21-MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'db 10/6/2019 14:08:27'!
assertHeadingIsValid: aHeading
	|headings headingUpperCase|
	headings := Set with: $N with:$O with:$S with:$E.
	self assert: aHeading isLetter.
	headingUpperCase := aHeading asUppercase.
	self assert: headings includes: headingUpperCase.
	! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'db 10/6/2019 13:57:02'!
assertValueIsANumber: aValue
	self assert: aValue class = SmallInteger! !


!MarsRoverTest methodsFor: 'tests' stamp: 'db 10/9/2019 18:47:01'!
test01newMarsRoverMustHaveValidCoordinates
	|marsRover x y|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $N.
	x := (marsRover xCoordinates).
	self assertValueIsANumber: x.
	y := (marsRover yCoordinates).
	self assertValueIsANumber: y.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:35:37'!
test02newMarsRoverMustHaveValidHeading
	|marsRover heading|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $N.
	heading := marsRover heading.
	self assertHeadingIsValid: heading! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:36:04'!
test03newMarsRoverCantHaveInvalidCoordinates
	|marsRover|
	self should: [marsRover := MarsRover withX: 5 andY: $d andHeading: $N.]
		raise: Error. 

	self should: [marsRover := MarsRover withX: $a andY: 5 andHeading: $N.]
		raise: Error. 
			
	self should: [marsRover := MarsRover withX: $a andY: $d andHeading: $N.]
		raise: Error. 
			! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:37:23'!
test04newMarsRoverCantHaveInvalidHeading
	self should: [MarsRover withX: 5 andY: 1 andHeading: $f]
		raise: Error.
		
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:37:30'!
test05newMarsRoverHeadingIsNotCaseSensitive
	|marsRover|
	marsRover :=  MarsRover withX: 5 andY: 10 andHeading: $n.
	self assert: true.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:37:56'!
test06marsRoverWithHeadingNorthWithForwardCommandMustHaveSameXCordinateAndOneUnitMoreInYCoordinate
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $N.
	comandos := 'f'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = (1 + oldYCoordinate ).
	self assert: (marsRover xCoordinates) = (oldXCoordinate ). ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:38:03'!
test07marsRoverWithHeadingNorthWithBackCommandMustHaveSameXCoordinateAndOneUnitMinusInYCoordinate
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $N.
	comandos := 'b'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = (oldYCoordinate - 1 ).
	self assert: (marsRover xCoordinates) = (oldXCoordinate ). ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:38:11'!
test08marsRoverWithNorthHeadingWithRCommandNewHeadingIsEast
	|marsRover comandos|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $N.
	comandos := 'r'.
	marsRover executeCommands: comandos.
	self assert: (marsRover heading) = ($E).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:38:20'!
test09marsRoverWithSouthHeadingWithICommandNewHeadingIsEast
	|marsRover comandos|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $S.
	comandos := 'I'.
	marsRover executeCommands: comandos.
	self assert: (marsRover heading) = ($E).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:38:26'!
test10marsRoverWithHeadingWestWithFCommandMustHaveSameYCoordinateAndOneUnitMinusInXCoordinate
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $O.
	comandos := 'f'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = (oldYCoordinate  ).
	self assert: (marsRover xCoordinates) = (oldXCoordinate - 1). ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:38:35'!
test11marsRoverHasToExecuteUntilACommandIsInvalid
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $N.
	comandos := 'ffrfgf'. """ posicion final x:1 y: 2""" 
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = (oldYCoordinate + 2).
	self assert: (marsRover xCoordinates) = (oldXCoordinate +1 ). ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:39:49'!
test12marsRoverStopExecutingCommandsWhenFindsInvalid
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $N.
	comandos := 'affffriririfrfgf'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = oldYCoordinate.
	self assert: (marsRover xCoordinates) = oldXCoordinate! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:39:56'!
test13marsRoverTurnsNotChangePosition
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $N.
	comandos := 'rrrriiiirrriiii'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = oldYCoordinate.
	self assert: (marsRover xCoordinates) = oldXCoordinate! !

!MarsRoverTest methodsFor: 'tests' stamp: 'g j 10/7/2019 09:40:12'!
test14marsRover360TurnsNotChangeHeading
	|marsRover comandos oldXCoordinate oldYCoordinate|
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $N.
	comandos := 'rrrr'.
	oldXCoordinate := marsRover xCoordinates.
	oldYCoordinate  := marsRover yCoordinates.
	marsRover executeCommands: comandos.
	self assert: (marsRover yCoordinates) = oldYCoordinate.
	self assert: (marsRover xCoordinates) = oldXCoordinate.
	self assert: (marsRover heading) = $N.
	
	""" ahora left turns"""
	marsRover := MarsRover withX: 0 andY: 0 andHeading: $N.
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

!Coordinate methodsFor: 'operations' stamp: 'g j 10/10/2019 10:28:41'!
+ aCoordinate
|newCoord|
	newCoord := Coordinate withX: (aCoordinate x + self x) andY: (aCoordinate y + self y).
	^newCoord 

! !

!Coordinate methodsFor: 'operations' stamp: 'g j 10/10/2019 10:28:41'!
- aCoordinate
|newCoord|
	newCoord := Coordinate withX: (self x - aCoordinate x) andY: (self y - aCoordinate y).
	^newCoord 

! !


!Coordinate methodsFor: 'accessing' stamp: 'db 10/6/2019 13:54:16'!
x
	^x
	! !

!Coordinate methodsFor: 'accessing' stamp: 'db 10/6/2019 13:54:21'!
y
	^y! !


!Coordinate methodsFor: 'initialization' stamp: 'g j 10/10/2019 10:53:19'!
initializeWithX: xValue andY: yValue
	(self checkXValue: xValue and: yValue ) ifFalse: [self InvalidCoordinates ].
	x := xValue.
	y := yValue.! !


!Coordinate methodsFor: 'testing' stamp: 'g j 10/10/2019 10:53:06'!
checkXValue: xValue and: yValue
	^xValue class = SmallInteger and: yValue class = SmallInteger.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Coordinate class' category: #'21-MarsRover'!
Coordinate class
	instanceVariableNames: ''!

!Coordinate class methodsFor: 'instance creation' stamp: 'g j 10/10/2019 10:29:01'!
withX: aValue andY: anotherValue
	^self new initializeWithX: aValue andY: anotherValue! !


!Coordinate class methodsFor: 'error messages' stamp: 'db 10/6/2019 17:19:20'!
InvalidCoordinates
	^self error: 'Invalid coordinates'! !


!classDefinition: #HandlerMovement category: #'21-MarsRover'!
Object subclass: #HandlerMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!HandlerMovement methodsFor: 'actions' stamp: 'db 10/6/2019 16:52:24'!
do
	^self subclassResponsibility ! !

!HandlerMovement methodsFor: 'actions' stamp: 'db 10/6/2019 17:07:05'!
rotateLeft
	^self subclassResponsibility ! !

!HandlerMovement methodsFor: 'actions' stamp: 'db 10/6/2019 17:01:27'!
rotateRight
	^self subclassResponsibility ! !


!HandlerMovement methodsFor: 'accessing' stamp: 'db 10/6/2019 17:11:32'!
heading
	^self subclassResponsibility .! !


!HandlerMovement methodsFor: 'testing' stamp: 'db 10/9/2019 18:39:16'!
checkValidHeading: aHeading
	^('NSEO' includes: aHeading)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HandlerMovement class' category: #'21-MarsRover'!
HandlerMovement class
	instanceVariableNames: 'uniqueInstance'!

!HandlerMovement class methodsFor: 'testing' stamp: 'db 10/9/2019 18:39:53'!
checkValidHeading: aHeading
	^('NSEO' includes: aHeading)! !

!HandlerMovement class methodsFor: 'testing' stamp: 'g j 10/10/2019 09:58:01'!
headingDirection: aDirection
	^self subclassResponsibility.! !


!HandlerMovement class methodsFor: 'error messages' stamp: 'db 10/6/2019 17:16:21'!
InvalidHeading
	^self error: 'Invalid heading'! !


!HandlerMovement class methodsFor: 'instance creation' stamp: 'db 10/9/2019 18:31:51'!
new
	^self subclassResponsibility ! !

!HandlerMovement class methodsFor: 'instance creation' stamp: 'g j 10/10/2019 10:21:04'!
withHeading: aHeading
	|movementClass|
	
	(self checkValidHeading: aHeading asUppercase) ifFalse: [^ self InvalidHeading ].
	
	movementClass _ self subclasses detect: [ :aMovementClass | aMovementClass headingDirection: aHeading asUppercase ].
	
	^movementClass new.! !


!classDefinition: #DownMovement category: #'21-MarsRover'!
HandlerMovement subclass: #DownMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!DownMovement methodsFor: 'accessing' stamp: 'db 10/6/2019 17:11:42'!
heading
	^$S! !


!DownMovement methodsFor: 'actions' stamp: 'g j 10/7/2019 10:27:33'!
do
	^Coordinate newWithX: 0 andY: -1.! !

!DownMovement methodsFor: 'actions' stamp: 'db 10/6/2019 17:07:21'!
rotateLeft
	^RightMovement new.! !

!DownMovement methodsFor: 'actions' stamp: 'db 10/6/2019 17:53:25'!
rotateRight
	^LeftMovement new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DownMovement class' category: #'21-MarsRover'!
DownMovement class
	instanceVariableNames: ''!

!DownMovement class methodsFor: 'testing' stamp: 'g j 10/10/2019 09:58:59'!
headingDirection: aDirection
^aDirection = $S.! !


!DownMovement class methodsFor: 'instance creation' stamp: 'db 10/9/2019 18:46:14'!
new
	uniqueInstance ifNil: [uniqueInstance := self basicNew initialize].
       ^uniqueInstance ! !


!classDefinition: #LeftMovement category: #'21-MarsRover'!
HandlerMovement subclass: #LeftMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!LeftMovement methodsFor: 'accessing' stamp: 'db 10/6/2019 17:11:48'!
heading
	^$O! !


!LeftMovement methodsFor: 'actions' stamp: 'g j 10/10/2019 10:33:13'!
do
	^Coordinate withX: -1 andY: 0.! !

!LeftMovement methodsFor: 'actions' stamp: 'db 10/6/2019 17:07:55'!
rotateLeft
	^DownMovement new.! !

!LeftMovement methodsFor: 'actions' stamp: 'db 10/6/2019 17:04:33'!
rotateRight
	^UpMovement new.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LeftMovement class' category: #'21-MarsRover'!
LeftMovement class
	instanceVariableNames: ''!

!LeftMovement class methodsFor: 'testing' stamp: 'g j 10/10/2019 09:59:22'!
headingDirection: aDirection
^aDirection = $O.! !


!LeftMovement class methodsFor: 'instance creation' stamp: 'db 10/9/2019 18:54:19'!
new
	uniqueInstance ifNil: [uniqueInstance := self basicNew initialize].
       ^uniqueInstance ! !


!classDefinition: #RightMovement category: #'21-MarsRover'!
HandlerMovement subclass: #RightMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!RightMovement methodsFor: 'actions' stamp: 'g j 10/10/2019 10:33:31'!
do
	^Coordinate withX: 1 andY: 0.! !

!RightMovement methodsFor: 'actions' stamp: 'db 10/6/2019 17:07:33'!
rotateLeft
	^UpMovement new.! !

!RightMovement methodsFor: 'actions' stamp: 'db 10/6/2019 17:05:40'!
rotateRight
	^DownMovement new.! !


!RightMovement methodsFor: 'accessing' stamp: 'db 10/6/2019 17:12:03'!
heading
	^$E! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RightMovement class' category: #'21-MarsRover'!
RightMovement class
	instanceVariableNames: ''!

!RightMovement class methodsFor: 'testing' stamp: 'g j 10/10/2019 09:59:33'!
headingDirection: aDirection
^aDirection = $E.! !


!RightMovement class methodsFor: 'instance creation' stamp: 'db 10/9/2019 18:32:28'!
new
	uniqueInstance ifNil: [uniqueInstance := self basicNew initialize].
       ^uniqueInstance ! !


!classDefinition: #UpMovement category: #'21-MarsRover'!
HandlerMovement subclass: #UpMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!UpMovement methodsFor: 'actions' stamp: 'g j 10/10/2019 10:32:55'!
do
	^Coordinate withX: 0 andY: 1.! !

!UpMovement methodsFor: 'actions' stamp: 'db 10/6/2019 17:07:41'!
rotateLeft
	^LeftMovement new.! !

!UpMovement methodsFor: 'actions' stamp: 'db 10/6/2019 17:38:52'!
rotateRight
	^RightMovement new.
	! !


!UpMovement methodsFor: 'accessing' stamp: 'db 10/6/2019 17:11:57'!
heading
	^$N! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UpMovement class' category: #'21-MarsRover'!
UpMovement class
	instanceVariableNames: ''!

!UpMovement class methodsFor: 'testing' stamp: 'g j 10/10/2019 09:59:42'!
headingDirection: aDirection
^aDirection = $N.! !


!UpMovement class methodsFor: 'instance creation' stamp: 'db 10/9/2019 18:48:26'!
new
	uniqueInstance ifNil: [uniqueInstance := self basicNew initialize].
       ^uniqueInstance ! !


!classDefinition: #MarsRover category: #'21-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinates handlerMovement'
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!MarsRover methodsFor: 'testing' stamp: 'g j 10/10/2019 11:22:27'!
checkValidCommand: aCommand
	^'FBIR' includes: aCommand asUppercase.! !


!MarsRover methodsFor: 'initialization' stamp: 'g j 10/10/2019 10:29:51'!
initializeWithX: xValue andY: yValue andHeading: aHeading
	handlerMovement := HandlerMovement withHeading: aHeading.
	coordinates  := Coordinate withX: xValue andY: yValue.
	^self! !


!MarsRover methodsFor: 'actions' stamp: 'g j 10/7/2019 10:21:31'!
executeCommands: aSequenceOfCommands
|aCommand	|
	aSequenceOfCommands do: [:command | aCommand := command asUppercase. 
									(self checkValidCommand: aCommand) ifTrue:[
									(aCommand = $F) ifTrue: [coordinates := coordinates + handlerMovement do ].
									(aCommand = $R) ifTrue: [handlerMovement := handlerMovement rotateRight]. 
									(aCommand = $I) ifTrue: [handlerMovement := handlerMovement rotateLeft].
									(aCommand = $B) ifTrue: [coordinates := coordinates - handlerMovement do]
									] ifFalse:[^self]
									
								].
						! !


!MarsRover methodsFor: 'accessing' stamp: 'db 10/6/2019 17:12:08'!
heading
	^handlerMovement heading.
! !

!MarsRover methodsFor: 'accessing' stamp: 'g j 10/7/2019 10:20:44'!
xCoordinates
	^coordinates x.! !

!MarsRover methodsFor: 'accessing' stamp: 'db 10/6/2019 17:10:10'!
yCoordinates
	^coordinates y. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'21-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error messages' stamp: 'db 10/6/2019 16:45:22'!
InvalidCommand
	^self error: 'Invalid Command'! !


!MarsRover class methodsFor: 'instance creation' stamp: 'g j 10/7/2019 09:40:59'!
withX: xValue andY: yValue andHeading: aHeading
	^(self new) initializeWithX: xValue andY: yValue andHeading: aHeading.! !
