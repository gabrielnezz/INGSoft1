!classDefinition: #CajeroTest category: #TusLibros stamp: 'g j 11/4/2019 21:09:02'!
TestCase subclass: #CajeroTest
	instanceVariableNames: 'carty sellBooky cart sellBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CajeroTest methodsFor: 'tests' stamp: 'g j 11/4/2019 19:15:43'!
defaultCatalog

	| catalog |
	catalog := Dictionary new.
	catalog add: 'Juans Book' -> 200.
	catalog add: 'Coso' -> 123.
	^catalog
	! !

!CajeroTest methodsFor: 'tests' stamp: 'g j 11/4/2019 20:19:41'!
setUp
	
	cart := Cart acceptingItemsOf: self defaultCatalog.
		
	sellBook := OrderedCollection new.
	! !

!CajeroTest methodsFor: 'tests' stamp: 'g j 11/4/2019 20:25:42'!
test02CajeroCanNotCheckoutWithEmptyCart

	| cajero creditCard |
	
	creditCard := Card initializeWithNumber: '123123' owner: 'ggg' expiration: (December of: 2040).
	
	cajero := Cajero with: cart andCreditCard: creditCard andHistoryBook: sellBook.
	self should: [cajero checkoutOnADate: (FixedGregorianDate monthOfYear: (October of: 2020) dayNumber: 22)]
		raise: Error - MessageNotUnderstood 
		withMessageText: Cajero CarritoVacio.
	
				! !

!CajeroTest methodsFor: 'tests' stamp: 'g j 11/4/2019 20:29:22'!
test03CajeroNoPuedeCheckoutearTarjetaVencida

	| cajero creditCard |

	creditCard := Card initializeWithNumber:  '123654' owner: 'DBuzeta' expiration: (October of: 2015). 	
	
	cart add: 'Juans Book'.
	
	
	cajero := Cajero with: cart andCreditCard: creditCard andHistoryBook: sellBook. 
	
	self should: [ cajero checkoutOnADate: (FixedGregorianDate monthOfYear: (October of: 2020) dayNumber: 22)]
		raise: Error - MessageNotUnderstood 
		withMessageText: Cajero TarjetaVencida.! !

!CajeroTest methodsFor: 'tests' stamp: 'g j 11/4/2019 20:46:38'!
test04CajeroVendeLibroYElMontoCobradoEsElPrecioDelLibro

	| cajero creditCard valorVenta |
	
	cart add: 'Juans Book'.
	
	creditCard := Card initializeWithNumber: '123123' owner: 'ggg' expiration: (December of: 2040).
	
	cajero := Cajero with: cart andCreditCard: creditCard andHistoryBook: sellBook.
	valorVenta := cajero checkoutOnADate: (FixedGregorianDate monthOfYear: (October of: 2020) dayNumber: 22).
	
	self assert: 200 equals: valorVenta. 
	
				! !

!CajeroTest methodsFor: 'tests' stamp: 'g j 11/4/2019 20:38:55'!
test05CajeroAñadeNuevoRegistroALibroDeVentas

	| cajero creditCard |
	
	cart add: 'Juans Book'.
	
	creditCard := Card initializeWithNumber: '123123' owner: 'ggg' expiration: (December of: 2040).
	
	self assert: sellBook isEmpty.
	
	cajero := Cajero with: cart andCreditCard: creditCard andHistoryBook: sellBook.
	cajero checkoutOnADate: (FixedGregorianDate monthOfYear: (October of: 2020) dayNumber: 22).
	
	self assert: 1 equals: sellBook size.
	
				! !



!classDefinition: #CardTest category: #TusLibros stamp: 'g j 11/4/2019 21:09:02'!
TestCase subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'as yet unclassified' stamp: 'g j 11/4/2019 18:44:01'!
test01NumeroDeTarjetaSoloPuedeTenerNumeros

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


!classDefinition: #CartTest category: #TusLibros stamp: 'g j 11/4/2019 21:09:02'!
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

!CartTest methodsFor: 'tests' stamp: 'g j 11/4/2019 18:51:49'!
test09NewCartHasZeroTotalAmount

	| cart |
	
	cart := self createCart.
	
	self assert: 0 equals: cart montoTotal.! !

!CartTest methodsFor: 'tests' stamp: 'g j 11/4/2019 19:05:08'!
test10CartWithABookHasATotalAmountOfTheBooksPrice

	| cart |
	
	cart := self createCart.
	
	cart add: 'Juans Book'.
	
	
	self assert: 200 equals: cart montoTotal.! !

!CartTest methodsFor: 'tests' stamp: 'g j 11/4/2019 19:08:02'!
test11CartWith2SameBooksHasATotalAmountOfTheBooksPriceTwice

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: 'Juans Book'.
	
	
	self assert: 400 equals: cart montoTotal.! !

!CartTest methodsFor: 'tests' stamp: 'g j 11/4/2019 19:07:13'!
test12CartWithBooksHasATotalAmountOfTheBooksPrices

	| cart |
	
	cart := self createCart.
	
	cart add: 1 of: 'Juans Book'.
	
	cart add: 1 of: 'Coso'.
	
	
	self assert: 323 equals: cart montoTotal.! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'g j 11/4/2019 18:58:42'!
defaultCatalog
	| catalog |
	catalog := Dictionary new.
	catalog add: 'Juans Book' -> 200.
	catalog add: 'Coso' -> 123.
	^catalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'g j 11/4/2019 19:00:18'!
itemSellByTheStore
	
	^ 'Juans Book'! !


!classDefinition: #Cajero category: #TusLibros stamp: 'g j 11/4/2019 21:09:02'!
Object subclass: #Cajero
	instanceVariableNames: 'priceList items cart card sellBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cajero methodsFor: 'as yet unclassified' stamp: 'd b 11/2/2019 23:29:31'!
addItems: aListOfBooks
	items := aListOfBooks.
	! !

!Cajero methodsFor: 'as yet unclassified' stamp: 'g j 11/4/2019 20:28:36'!
assertCarritoNoVacio
	cart isEmpty ifTrue: [self error: Cajero CarritoVacio.]! !

!Cajero methodsFor: 'as yet unclassified' stamp: 'g j 11/4/2019 19:27:46'!
checkOutWithCardNumber: aStringOfCardNumber owner: aName expirationDate: aGregorianMonthOfYear
	
	
	| cardd |
	cardd := Card initializeWithNumber: aStringOfCardNumber owner: aName  expiration: aGregorianMonthOfYear .
	
	^self.! !

!Cajero methodsFor: 'as yet unclassified' stamp: 'd b 11/2/2019 23:32:54'!
initializeWithPriceList: aPriceList
	aPriceList isEmpty ifTrue: [^self error: Cajero ErrorPriceListNeeded ].
	priceList := aPriceList.
	items := OrderedCollection new.
	^self.! !

!Cajero methodsFor: 'as yet unclassified' stamp: 'd b 11/2/2019 23:30:18'!
isEmpty
	^items size = 0.! !

!Cajero methodsFor: 'as yet unclassified' stamp: 'd b 11/2/2019 23:34:35'!
itemCount
	^items size! !


!Cajero methodsFor: '*Aconcagua-Extensions' stamp: 'g j 11/4/2019 19:27:58'!
initializeWith: aCart andCreditCard: aCard 
	self shouldBeImplemented.
	cart := aCart.
	card := aCard.! !


!Cajero methodsFor: 'initialization' stamp: 'g j 11/4/2019 19:31:47'!
initializeWith: aCart andCreditCard: aCard andHistoryBook: aSellBook 
	cart := aCart.
	card := aCard.
	sellBook := aSellBook.! !


!Cajero methodsFor: 'casing' stamp: 'g j 11/4/2019 20:35:55'!
checkoutOnADate: aDate
	self assertCarritoNoVacio.
	self assertTarjetaNoVencida: aDate.
	^cart montoTotal.
	! !


!Cajero methodsFor: 'binding' stamp: 'g j 11/4/2019 19:45:02'!
assertTarjetaNoVencida
	(card expiredOn: GregorianMonthOfYear current) ifTrue:[^self error: Cajero TarjetaVencida].! !

!Cajero methodsFor: 'binding' stamp: 'g j 11/4/2019 19:57:54'!
assertTarjetaNoVencida: aDate
	(card expiredOn: aDate) ifTrue: [^self error: Cajero TarjetaVencida].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cajero class' category: #TusLibros stamp: 'g j 11/4/2019 21:09:02'!
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


!Cajero class methodsFor: 'instance creation' stamp: 'g j 11/4/2019 19:20:37'!
with: aCart andCreditCard: aCard 
	^self new initializeWith: aCart andCreditCard: aCard ! !

!Cajero class methodsFor: 'instance creation' stamp: 'g j 11/4/2019 19:31:32'!
with: aCart andCreditCard: aCard andHistoryBook: aSellBook 
	^self new initializeWith: aCart andCreditCard: aCard andHistoryBook: aSellBook! !


!Cajero class methodsFor: 'error messages' stamp: 'g j 11/4/2019 19:32:49'!
TarjetaVencida
	^'Error la tarjeta esta vencida.'! !


!Cajero class methodsFor: 'as yet unclassified' stamp: 'g j 11/4/2019 20:26:34'!
CarritoVacio
	^'El carrito esta vacio.'! !


!classDefinition: #Card category: #TusLibros stamp: 'g j 11/4/2019 21:09:02'!
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

!Card methodsFor: 'as yet unclassified' stamp: 'g j 11/4/2019 20:13:30'!
expiredOn: aDateToCompare 
	^ expiration < aDateToCompare monthOfYear.! !

!Card methodsFor: 'as yet unclassified' stamp: 'g j 11/4/2019 19:20:05'!
initializeWithNumber: aNumber owner: aName expiration: aGregorianMonthOfYear 
	self assertNumberIsValid: aNumber.
	self assertOwnerIsValid: aName.
	owner := aNumber .
	expiration := aGregorianMonthOfYear .
	creditNumber  := aNumber .
	^self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros stamp: 'g j 11/4/2019 21:09:02'!
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


!classDefinition: #Cart category: #TusLibros stamp: 'g j 11/4/2019 21:09:02'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items montoTotal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'g j 11/4/2019 19:02:10'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'g j 11/4/2019 18:50:16'!
initializeAcceptingItemsOf: aCatalog

	montoTotal:= 0.
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

!Cart methodsFor: 'testing' stamp: 'g j 11/4/2019 18:52:16'!
montoTotal
	
	^montoTotal.! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'g j 11/4/2019 18:52:59'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	montoTotal := montoTotal + (aQuantity *  (catalog at: anItem)).
	
	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'g j 11/4/2019 21:09:02'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !
