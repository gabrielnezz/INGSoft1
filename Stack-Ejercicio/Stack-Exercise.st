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

!OOStackTest methodsFor: 'test' stamp: 'db 9/17/2019 18:23:35'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd b 9/18/2019 22:16:08'!
test01ElPrefijoNoPuedeSerVacio
|unBuscadorDePrefijo stack|
stack := OOStack new.
unBuscadorDePrefijo  := SentenceFinderByPrefix new.
	self should: [ unBuscadorDePrefijo find: '' enElStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix PrefixError ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd b 9/18/2019 22:16:12'!
test02ElPrefijoNoPuedeContenerEspacios
|unBuscadorDePrefijo stack|
stack := OOStack new.
unBuscadorDePrefijo  := SentenceFinderByPrefix new.
	self should: [ unBuscadorDePrefijo find: '' enElStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix PrefixError ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd b 9/18/2019 22:54:59'!
test03ElPrefijoEsCaseSensitive
|unBuscadorDePrefijo stack stackResultado|
stackResultado  := OOStack  new.
stack := OOStack new.
stack push: 'wint'.
stack push: 'WiNt'.
unBuscadorDePrefijo  := SentenceFinderByPrefix new.
self assert:  [(unBuscadorDePrefijo find: 'Wint' enElStack: stack) size = stackResultado size].
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd b 9/18/2019 23:05:06'!
test04ElPrefijoMatchea
|stack stackResultado unBuscadorDePrefijo|
stack := OOStack new.
stackResultado  := OOStack  new.
unBuscadorDePrefijo  := SentenceFinderByPrefix new.
stack push: 'wint af'.
stack push: 'wint'.
stackResultado push: 'wint af'.
stackResultado push: 'wint'.
self assert:  [(unBuscadorDePrefijo find: 'wint' enElStack: stack) size = stackResultado size].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd b 9/18/2019 22:58:20'!
test05UnStackVacioEsInvalido
|stack unBuscadorDePrefijo|
stack  := OOStack  new.
unBuscadorDePrefijo  := SentenceFinderByPrefix new.
	self should: [ unBuscadorDePrefijo find: 'asa' enElStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix ErrorDeStackVacio ]! !


!classDefinition: #ElementoEncapsulador category: #'Stack-Exercise'!
Object subclass: #ElementoEncapsulador
	instanceVariableNames: 'indice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementoEncapsulador methodsFor: 'utils' stamp: 'db 9/17/2019 19:19:44'!
dameElElementoEncapsuladorAnterior
^ self subclassResponsibility.! !

!ElementoEncapsulador methodsFor: 'utils' stamp: 'db 9/17/2019 19:03:24'!
dameIndice
^indice! !

!ElementoEncapsulador methodsFor: 'utils' stamp: 'db 9/17/2019 19:37:37'!
dameObjetoAsociado
^self subclassResponsibility ! !


!classDefinition: #ElementoEncapsuladorNoVacio category: #'Stack-Exercise'!
ElementoEncapsulador subclass: #ElementoEncapsuladorNoVacio
	instanceVariableNames: 'objetoAsociado elementoEncapsuladorAnterior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementoEncapsuladorNoVacio methodsFor: 'utils' stamp: 'db 9/17/2019 19:15:18'!
crearConObjectoAsociado: unObjecto yElementoEncapsuladorAnterior: unElementoEncapsulador
objetoAsociado  := unObjecto .
elementoEncapsuladorAnterior  := unElementoEncapsulador.
indice := (unElementoEncapsulador dameIndice) + 1 ! !

!ElementoEncapsuladorNoVacio methodsFor: 'utils' stamp: 'db 9/17/2019 19:17:46'!
dameElElementoEncapsuladorAnterior
^elementoEncapsuladorAnterior ! !

!ElementoEncapsuladorNoVacio methodsFor: 'utils' stamp: 'db 9/17/2019 19:20:23'!
dameObjetoAsociado
^objetoAsociado ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementoEncapsuladorNoVacio class' category: #'Stack-Exercise'!
ElementoEncapsuladorNoVacio class
	instanceVariableNames: ''!

!ElementoEncapsuladorNoVacio class methodsFor: 'as yet unclassified' stamp: 'db 9/17/2019 19:32:52'!
crearConObjectoAsociado: unObjectoAAsociar yElementoEncapsuladorAnterior: unElementoEncapsulador
|nuevoElementoEncapsulador|
nuevoElementoEncapsulador  := ElementoEncapsuladorNoVacio new crearConObjectoAsociado: unObjectoAAsociar  yElementoEncapsuladorAnterior: unElementoEncapsulador.
^nuevoElementoEncapsulador.! !


!classDefinition: #ElementoEncapsuladorVacio category: #'Stack-Exercise'!
ElementoEncapsulador subclass: #ElementoEncapsuladorVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementoEncapsuladorVacio methodsFor: 'utils' stamp: 'db 9/17/2019 19:19:30'!
dameElElementoEncapsuladorAnterior
^self error: OOStack stackEmptyErrorDescription.! !

!ElementoEncapsuladorVacio methodsFor: 'utils' stamp: 'db 9/17/2019 19:37:59'!
dameObjetoAsociado
^self error: OOStack stackEmptyErrorDescription ! !


!ElementoEncapsuladorVacio methodsFor: 'initialization' stamp: 'db 9/17/2019 19:15:49'!
initialize
indice := 0! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elementoEncapsuladorActual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'db 9/17/2019 19:06:52'!
initialize
elementoEncapsuladorActual := ElementoEncapsuladorVacio new.

"""
stack:= OrderedCollection new.
stack add: ActualVacio new.
elementoActual := ActualNoVacio new.
elementoActual reasociarCon: stack first"""! !


!OOStack methodsFor: 'as yet unclassified' stamp: 'db 9/17/2019 19:16:25'!
isEmpty

^elementoEncapsuladorActual dameIndice  = 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'db 9/17/2019 19:35:51'!
pop
	|elementoAEliminar|
	elementoAEliminar := elementoEncapsuladorActual.
	elementoEncapsuladorActual := elementoEncapsuladorActual dameElElementoEncapsuladorAnterior.
	^elementoAEliminar dameObjetoAsociado.
	"""stack isEmpty ifTrue: [^self error: OOStack stackEmptyErrorDescription].

	^stack removeFirst.
	"""! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'db 9/17/2019 19:36:00'!
push: anObjectToBePushed
	|nuevoElemento|
	nuevoElemento := ElementoEncapsuladorNoVacio crearConObjectoAsociado: anObjectToBePushed yElementoEncapsuladorAnterior: elementoEncapsuladorActual.
	elementoEncapsuladorActual :=nuevoElemento 
	
	
	"""elementoActual reasociarCon: anObjectToBePushed"""! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'db 9/17/2019 19:36:05'!
size

	^elementoEncapsuladorActual  dameIndice! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'db 9/17/2019 19:36:42'!
top
^elementoEncapsuladorActual dameObjetoAsociado! !

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

!SentenceFinderByPrefix methodsFor: 'utils' stamp: 'd b 9/18/2019 22:47:39'!
conCadaElementoDelStack: stack yElPrefijo: unPrefijo realizarComprobacion: aBlock
[stack isEmpty] whileFalse:[aBlock value: stack pop]! !

!SentenceFinderByPrefix methodsFor: 'utils' stamp: 'd b 9/18/2019 23:01:14'!
find: unPrefijo enElStack: unStack
|stackDeCopia stackConElementosConPrefijoEncontrado|
self verificarPrefijoValido: unPrefijo.
self verificarQueElStackNoSeaVacio: unStack.

stackDeCopia  := OOStack new.
stackConElementosConPrefijoEncontrado := OOStack new.

self conCadaElementoDelStack: unStack yElPrefijo: unPrefijo realizarComprobacion:
										 [:topeActual | stackDeCopia push: topeActual .
											 (topeActual beginsWith: unPrefijo) ifTrue:
																	[stackConElementosConPrefijoEncontrado push: topeActual].].
^stackConElementosConPrefijoEncontrado ! !


!SentenceFinderByPrefix methodsFor: 'chequeo de input' stamp: 'd b 9/18/2019 22:23:34'!
verificarPrefijoValido: unPrefijo

(unPrefijo size = 0) ifTrue:[self error: SentenceFinderByPrefix PrefixError ].

(unPrefijo allSatisfy: [:a | a ~= $ ]) ifFalse:[self error: SentenceFinderByPrefix PrefixError ].
! !

!SentenceFinderByPrefix methodsFor: 'chequeo de input' stamp: 'd b 9/18/2019 23:00:52'!
verificarQueElStackNoSeaVacio: unStack
^unStack isEmpty  ifTrue:[self error: SentenceFinderByPrefix ErrorDeStackVacio ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'd b 9/18/2019 22:58:36'!
ErrorDeStackVacio
^'El stack no puede ser vacio'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'd b 9/18/2019 21:04:42'!
PrefixError
^'El prefijo no puede ser vacio o contener espacios'! !
