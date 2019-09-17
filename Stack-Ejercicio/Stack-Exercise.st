!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'a 9/16/2019 20:45:59'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	self halt
	stack push: pushedObject.	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #Actual category: #'Stack-Exercise'!
Object subclass: #Actual
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Actual methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:50:02'!
pop 
^self subclassResponsibility ! !

!Actual methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:50:31'!
popFrom: aStack
^self subclassResponsibility ! !


!classDefinition: #ActualNoVacio category: #'Stack-Exercise'!
Actual subclass: #ActualNoVacio
	instanceVariableNames: 'objetoAsociado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ActualNoVacio methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:55:49'!
asociar: anObject
objetoAsociado := anObject! !

!ActualNoVacio methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:44:14'!
pop
stack actualizaActual.
^stack popear.
! !

!ActualNoVacio methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:51:52'!
popFrom: aStack
aStack actualizaActual.
^aStack popear.
! !


!classDefinition: #ActualVacio category: #'Stack-Exercise'!
Actual subclass: #ActualVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ActualVacio methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 19:59:05'!
pop
^stack error: OOStack stackEmptyErrorDescription! !

!ActualVacio methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:50:44'!
popFrom: aStack
^stack error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack actual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'a 9/16/2019 20:58:15'!
initialize
|actualVacio|
stack:= OrderedCollection new.
stack add: ActualVacio new.
actual asociar: stack first! !


!OOStack methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:56:58'!
actualizaActual

actual asociar:(stack at:2)! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:35:50'!
isEmpty

^stack size = 1 .! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:51:33'!
pop
actual popFrom: self
"""stack isEmpty ifTrue: [^self error: OOStack stackEmptyErrorDescription].

^stack removeFirst.
"""! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:28:39'!
popear 
^stack removeFirst! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:56:01'!
push: anObjectToBePushed

stack addFirst: anObjectToBePushed.
actual asociar: anObjectToBePushed! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 20:16:29'!
size

^stack size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'a 9/16/2019 19:26:06'!
top
stack isEmpty ifTrue: [^self error: OOStack stackEmptyErrorDescription].

^stack first.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
