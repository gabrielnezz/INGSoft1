!classDefinition: #CajeroTest category: #TusLibros stamp: 'd b 11/3/2019 21:56:22'!
TestCase subclass: #CajeroTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CajeroTest methodsFor: 'tests' stamp: 'd b 11/2/2019 23:17:25'!
test01CajeroNeedsANonEmptyPriceList

	| cajero priceList |
	
	priceList := Dictionary new..
	self 
		should: [cajero := Cajero new initializeWithPriceList: priceList.]
			raise: Error
				withMessageText: Cajero ErrorPriceListNeeded.
				! !

!CajeroTest methodsFor: 'tests' stamp: 'd b 11/2/2019 23:26:55'!
test03NewCajeroNotHaveBooksToSell

	| cajero priceList |
	
	priceList := self createPriceList.
	cajero := Cajero new initializeWithPriceList: priceList.
	self assert: cajero isEmpty.
				! !

!CajeroTest methodsFor: 'tests' stamp: 'd b 11/2/2019 23:28:25'!
test04CajeroRecognizeTheBooksAndQuantityOfTheGivenList

	| cajero priceList |
	
	priceList := self createPriceList.
	cajero := Cajero new initializeWithPriceList: priceList.
	cajero addItems: self createListOfBooks.
	self deny: cajero isEmpty.
	self assert: cajero itemCount = ((self createListOfBooks)size).
	
				! !

!CajeroTest methodsFor: 'tests' stamp: 'd b 11/3/2019 21:55:03'!
test05CajeroNoPuedeCheckoutearTarjetaVencida

	| cajero priceList |
	
	priceList := self createPriceList.
	cajero := Cajero new initializeWithPriceList: priceList.
	self should: [cajero checkOutWithCardNumber: '121' owner: 'jose' expirationDate: (December of: 2014)]
		raise:  Error - MessageNotUnderstood
			withMessageText: Card ErrorExpirationDate .
	"q error usar ahi?"! !


!CajeroTest methodsFor: 'aux' stamp: 'd b 11/2/2019 23:11:48'!
createListOfBooks
	
	^#('A3322', 'A111', 'A4222', 'A3123')! !

!CajeroTest methodsFor: 'aux' stamp: 'd b 11/2/2019 23:15:42'!
createPriceList
	|priceList |
	priceList := Dictionary new.
	priceList add: 'A3322'->1010; add: 'A111'->300; add: 'A4222'->720; add: 'A3123'->900; yourself.
	^priceList .! !


!classDefinition: #CardTest category: #TusLibros stamp: 'd b 11/3/2019 21:56:22'!
TestCase subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:14:55'!
test01NumeroDeTarjetaNoPuedeTenerLetras

	self 
		should: [Card initializeWithNumber: '12342A' owner: 'gonzalo' expiration: (October  of: 2020)] 
			raise: Error - MessageNotUnderstood 
				withMessageText: Card ErrorNumber.! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:24:45'!
test02NumeroDeTarjetaNoPuedeSerVacio
	self 
		should: [Card initializeWithNumber: '' owner: 'gonzalo' expiration: (October  of: 2020)] 
			raise: Error - MessageNotUnderstood 
				withMessageText: Card ErrorNumber.! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:26:17'!
test03DueñoDeTarjetaNoPuedeSerVacio
	self 
		should: [Card initializeWithNumber: '213' owner: '' expiration: (October  of: 2020)] 
			raise: Error - MessageNotUnderstood 
				withMessageText: Card ErrorOwner.! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:28:40'!
test04DueñoDeTarjetaNoPuedeTenerMasDe30Caracteres
	self 
		should: [Card initializeWithNumber: '213' owner: 'gonzalogonzalogonzalogonzalogonzalo' expiration: (October  of: 2020)] 
			raise: Error - MessageNotUnderstood 
				withMessageText: Card ErrorOwner.! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:35:19'!
test05LaFechaDeExpiracionNoPuedeEstarVencida
	self 
		should: [Card initializeWithNumber: '213' owner: 'Lucas' expiration: (October of: 2019)] 
			raise: Error - MessageNotUnderstood 
				withMessageText: Card ErrorExpirationDate.! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:41:26'!
test06NumeroDeTarjetaDebeSerPositivo
	self 
		should: [Card initializeWithNumber: '-213' owner: 'Lucas' expiration: (October of: 2020)] 
			raise: Error - MessageNotUnderstood 
				withMessageText: Card ErrorNumber .! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:41:56'!
test07NumeroDeTarjetaDebeSerEntero
	self 
		should: [Card initializeWithNumber: '1/3' owner: 'Lucas' expiration: (October of: 2020)] 
			raise: Error - MessageNotUnderstood 
				withMessageText: Card ErrorNumber .! !


!classDefinition: #CartTest category: #TusLibros stamp: 'd b 11/3/2019 21:56:22'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #Cajero category: #TusLibros stamp: 'd b 11/3/2019 21:56:22'!
Object subclass: #Cajero
	instanceVariableNames: 'priceList items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cajero methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:52:51'!
checkOutWithCardNumber: aStringOfCardNumber owner: aName expirationDate: aGregorianMonthOfYear
	| card |
	
	card := Card initializeWithNumber: aStringOfCardNumber owner: aName  expiration: aGregorianMonthOfYear .
	
	^self.! !

!Cajero methodsFor: 'as yet unclassified' stamp: 'd b 11/2/2019 23:32:38'!
checkout
	items isEmpty ifTrue: [^self error: Cajero ErrorCheckoutNeedsABook ].
	
	^self! !

!Cajero methodsFor: 'as yet unclassified' stamp: 'd b 11/2/2019 23:32:54'!
initializeWithPriceList: aPriceList
	aPriceList isEmpty ifTrue: [^self error: Cajero ErrorPriceListNeeded ].
	priceList := aPriceList.
	items := OrderedCollection new.
	^self.! !

!Cajero methodsFor: 'as yet unclassified' stamp: 'd b 11/2/2019 23:34:35'!
itemCount
	^items size! !


!Cajero methodsFor: 'binding' stamp: 'd b 11/2/2019 23:30:18'!
isEmpty
	^items size = 0.! !


!Cajero methodsFor: '*Chalten-Time Extensions' stamp: 'd b 11/2/2019 23:29:31'!
addItems: aListOfBooks
	items := aListOfBooks.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cajero class' category: #TusLibros stamp: 'd b 11/3/2019 21:56:22'!
Cajero class
	instanceVariableNames: ''!

!Cajero class methodsFor: 'errors' stamp: 'd b 11/3/2019 21:51:14'!
ErrorCardExpired
	^'La tarjeta esta vencida'.! !

!Cajero class methodsFor: 'errors' stamp: 'd b 11/2/2019 23:21:54'!
ErrorCheckoutNeedsABook
	^'No se puede checkoutear un cajero si no hay libros para pagar'! !

!Cajero class methodsFor: 'errors' stamp: 'd b 11/2/2019 23:31:51'!
ErrorNoBooks
	^'No hay libros que checkoutear'! !

!Cajero class methodsFor: 'errors' stamp: 'd b 11/2/2019 23:06:02'!
ErrorPriceListNeeded
	^'Es necesario una lista de precios no vacia'! !


!classDefinition: #Card category: #TusLibros stamp: 'd b 11/3/2019 21:56:22'!
Object subclass: #Card
	instanceVariableNames: 'creditNumber expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:40:39'!
assertFechaEstaVigente: aGregorianMonthOfYear
		
	(aGregorianMonthOfYear > (GregorianMonthOfYear current)) ifFalse: [^self error: Card ErrorExpirationDate ].
! !

!Card methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:25:44'!
assertNumberIsValid: aString
	
	(aString allSatisfy: [:char | char isDigit]) & (aString isEmpty= false) ifFalse: [^self error: Card ErrorNumber ].
	! !

!Card methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:32:06'!
assertOwnerIsValid: aString
	
	(aString allSatisfy: [:char | char isLetter]) & (aString isEmpty= false) & (aString size <= 30) ifFalse: [^self error: Card ErrorOwner ].
	! !

!Card methodsFor: 'as yet unclassified' stamp: 'd b 11/3/2019 21:34:47'!
initializeWithNumber: aNumber owner: aName expiration: aGregorianMonthOfYear 
	self assertNumberIsValid: aNumber.
	self assertOwnerIsValid: aName.
	self assertFechaEstaVigente: aGregorianMonthOfYear.
	owner := aNumber .
	expiration := aGregorianMonthOfYear .
	creditNumber  := aNumber .
	^self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros stamp: 'd b 11/3/2019 21:56:22'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'accessing' stamp: 'd b 11/3/2019 21:15:23'!
ErrorNumber
	^'El numero de tarjeta es invalido'! !

!Card class methodsFor: 'accessing' stamp: 'd b 11/3/2019 21:26:34'!
ErrorOwner
	^'El nombre del owner es invalido'! !


!Card class methodsFor: 'instance creation' stamp: 'd b 11/3/2019 21:33:45'!
ErrorExpirationDate
	^'La fecha de expiracion es invalida'.! !

!Card class methodsFor: 'instance creation' stamp: 'd b 11/3/2019 21:31:18'!
initializeWithNumber: aNumber owner: aName expiration: aGregorianMonthOfYear 
	^self new initializeWithNumber: aNumber owner: aName expiration: aGregorianMonthOfYear.! !


!classDefinition: #Cart category: #TusLibros stamp: 'd b 11/3/2019 21:56:22'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'd b 11/3/2019 21:56:22'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !
