!classDefinition: #CartTest category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #XXXTest category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
TestCase subclass: #XXXTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 18:44:06'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard 
	! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 18:43:04'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 17:44:10'!
test01CreandoUnNuevoCarritoYEsDevueltoPorListCarts

	| newCartId xxx |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	newCartId := xxx createCartForId: 2 withPassword: 'keloke'.
	
	self assert: (xxx listCartWithId: newCartId) isEmpty.! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 17:44:13'!
test02SeAgregaUnLibroAlCarritoYAlListarloAparece

	| newCartId xxx libros |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	newCartId := xxx createCartForId: 2 withPassword: 'keloke'.
	
	xxx addToCartWithId: newCartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	libros := (xxx listCartWithId: newCartId).
	
	
	self assert: 1 equals: libros size.
	self assert: 1 equals: (libros at: testObjectsFactory itemSellByTheStore).! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 17:44:16'!
test03NoSePuedeCrearUnCarritoConUnUsuarioInvalido

	| xxx |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	
	self should: [xxx createCartForId: 4 withPassword: 'keloke'.]
		raise: Error - MessageNotUnderstood
		withMessageText: XXX usuarioInvalido.
! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 17:44:19'!
test04SeCreanDosCarritosYAmbosSonDevueltosPorListCart

	| xxx cart1Id cart2Id libros1 libros2 |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	
	cart1Id := xxx createCartForId: 2 withPassword: 'keloke'.
	cart2Id := xxx createCartForId: 2 withPassword: 'keloke'.
	
	xxx addToCartWithId: cart1Id withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	libros1 := (xxx listCartWithId: cart1Id).
	
	libros2 := (xxx listCartWithId: cart2Id).
	
	self assert: 1 equals: libros1 size.
	self assert: 1 equals: (libros1 at: testObjectsFactory itemSellByTheStore).
	
	self assert: libros2 isEmpty.! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 17:44:24'!
test05SeCreanDosCarritosDeDiferentesUsuariosYSonDistintos

	| xxx cart1Id cart2Id libros1 libros2 |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	
	cart1Id := xxx createCartForId: 2 withPassword: 'keloke'.
	cart2Id := xxx createCartForId: 3 withPassword: 'jajaja'.
	
	xxx addToCartWithId: cart1Id withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	xxx addToCartWithId: cart1Id withISBN: testObjectsFactory anotherItemSellByTheStore withQuantity: 1.
	
	xxx addToCartWithId: cart2Id withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	libros1 := (xxx listCartWithId: cart1Id).
	
	libros2 := (xxx listCartWithId: cart2Id).
	
	self assert: 2 equals: libros1 size.
	self assert: 1 equals: (libros1 at: testObjectsFactory itemSellByTheStore).
	self assert: 1 equals: (libros1 at: testObjectsFactory anotherItemSellByTheStore ).
	
	self assert: 1 equals: libros2 size.
	self assert: 1 equals: (libros2 at: testObjectsFactory itemSellByTheStore).! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 17:44:29'!
test06NoSePuedeCheckoutearUnCarritoInexistente

	| xxx |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	self should: [xxx checkoutWithCartId: #id
		on: testObjectsFactory today
		 aCreditCardNumber: '113584'
		 anExpirationDate: testObjectsFactory notExpiredDate
		 andOwnerName: 'Dario'.]
	raise: Error - MessageNotUnderstood
	withMessageText: XXX CarritoInexistente.! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 20:54:58'!
test07NoSePuedeCheckoutearUnCarritoVacio

	| xxx cartId |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	cartId := xxx createCartForId: 2 withPassword: 'keloke'.
	
	
	self should: [xxx checkoutWithCartId: cartId
		 on: testObjectsFactory today
		 aCreditCardNumber: '123456' 
		 anExpirationDate: testObjectsFactory notExpiredDate
		 andOwnerName: 'Carlitos'.]
	raise: Error - MessageNotUnderstood
	withMessageText: Cashier cartCanNotBeEmptyErrorMessage.
	
	! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 19:31:49'!
test08DespuesDeCheckoutearElUsuarioTieneUnaCompra

	| xxx cartId listaCompras |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	cartId := xxx createCartForId: 2 withPassword: 'keloke'.
	
	xxx addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	xxx checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.
	
	listaCompras := xxx listPurchasesForUserId: 2 withPassword: 'keloke'.
	
	self assert: (listaCompras allSatisfy: [:aSale | ((aSale soldOf: testObjectsFactory itemSellByTheStore) = 1) & (aSale total = 10)]).
	
	! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 19:54:41'!
test09DespuesDeDosComprasElClienteTieneDosSales

	| xxx cartId listaCompras |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	cartId := xxx createCartForId: 2 withPassword: 'keloke'.
	
	xxx addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.	
	xxx checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.
	
	cartId := xxx createCartForId: 2 withPassword: 'keloke'.
	xxx addToCartWithId: cartId withISBN: testObjectsFactory anotherItemSellByTheStore withQuantity: 1.	
	xxx checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.
	
	listaCompras := xxx listPurchasesForUserId: 2 withPassword: 'keloke'.
	self assert: listaCompras size = 2.
	! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 19:39:28'!
test10SiFallaElCheckoutEntoncesElClienteNoTieneNuevasCompras

	| xxx cartId listaComprasAntes |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	cartId := xxx createCartForId: 2 withPassword: 'keloke'.
	
	xxx addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	listaComprasAntes := xxx listPurchasesForUserId: 2 withPassword: 'keloke'.
	
	self should:[
	xxx checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory expiredDate 
	andOwnerName: 'Carlitos'.]
		raise: Error - MessageNotUnderstood
			withMessageText: Cashier canNotChargeAnExpiredCreditCardErrorMessage.
	
	self assert: listaComprasAntes size = (xxx listPurchasesForUserId: 2 withPassword: 'keloke') size.
	
	! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 19:57:58'!
test11NoSePuedeCheckoutearUnCarritoCheckouteado

	| xxx cartId listaCompras |
	xxx := XXX withCatalog: testObjectsFactory defaultCatalog throught: self.
	
	cartId := xxx createCartForId: 2 withPassword: 'keloke'.
	
	xxx addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	xxx checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.
	
	self should: [xxx checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.]
		raise: Error - MessageNotUnderstood
			withMessageText: XXX CartAlreadyCheckoutead.
	
	
	! !


!classDefinition: #Cart category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'g j 11/11/2019 17:36:00'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'g j 11/7/2019 20:08:32'!
initializeAcceptingItemsOf: aCatalog withId: anId 

	catalog := aCatalog.
	items := OrderedCollection new.
	id := anId.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 18:11:06'!
listBooks
	| listedBooks |
	listedBooks := Dictionary new.
	items do: [:anItem | 
		(listedBooks allSatisfy: [
									:aBook | (listedBooks keyAtValue: aBook) ~=anItem]) ifTrue: [
			 																		listedBooks add:(anItem -> (items occurrencesOf: anItem))]].
																			
	^listedBooks.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'g j 11/11/2019 17:35:42'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog! !

!Cart class methodsFor: 'instance creation' stamp: 'g j 11/7/2019 20:08:23'!
acceptingItemsOf: aCatalog withId: anId 

	^self new initializeAcceptingItemsOf: aCatalog withId: 1 ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'g j 11/14/2019 17:36:39'!
createSale
	| list |
	list := cart listBooks.
	^Sale of: total withItemList: list.
	
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'g j 11/14/2019 18:30:07'!
registerSale
	
	| newSale |
	
	newSale  := self createSale.
	salesBook add: newSale.
	^newSale.
	! !


!Cashier methodsFor: 'checkout' stamp: 'g j 11/14/2019 18:30:24'!
checkOut

	self calculateTotal.
	self debitTotal.

	^self registerSale.! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
Object subclass: #Clock
	instanceVariableNames: 'currentTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 20:37:07'!
avanzarMin: aMin! !

!Clock methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 20:37:23'!
currentTime
	^currentTime ! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
Object subclass: #Sale
	instanceVariableNames: 'total saleItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'g j 11/14/2019 19:11:19'!
itemsSold
	
	^ saleItems.! !

!Sale methodsFor: 'total' stamp: 'g j 11/14/2019 19:17:42'!
soldOf: aIsbn

	^saleItems at: aIsbn ifAbsent:[0].! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'g j 11/14/2019 17:40:11'!
initializeOf: anAmount withItemList: aBookList 
	total := anAmount.
	saleItems := aBookList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
Sale class
	instanceVariableNames: ''!


!Sale class methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 17:38:07'!
of: anAmount withItemList: aBookList
	^self new initializeOf: anAmount withItemList: aBookList.
	
	! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'g j 11/11/2019 18:01:16'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'g j 11/11/2019 18:01:33'!
anotherItemSellByTheStorePrice
	
	^33! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'g j 11/11/2019 17:36:21'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'g j 11/11/2019 18:02:27'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'g j 11/14/2019 19:36:53'!
expiredDate

^(Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'g j 11/11/2019 20:54:29'!
notExpiredDate

^(Month month: self today monthIndex year: self today yearNumber + 1).! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #XXX category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
Object subclass: #XXX
	instanceVariableNames: 'catalog carts users merchantProcessor salesBook checkoutedCarts clientSales cartsPerClient currentCartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!XXX methodsFor: 'as yet unclassified' stamp: 'g j 11/7/2019 19:46:33'!
addToCartWithId: aCartId withISBN: anISBN withQuantity: aQuantity 
	
	| cartToAdd |
	cartToAdd := carts at: aCartId ifAbsent: [].
	
	cartToAdd add: aQuantity of: anISBN.! !

!XXX methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 19:11:51'!
assertCarritoExiste: aCartId 
	(carts includesKey: aCartId) ifFalse: [self error: self class CarritoInexistente.]! !

!XXX methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 20:05:37'!
assertCarritoNoEstaCheckouteado: aCartId 
	^(checkoutedCarts includesKey: aCartId) ifTrue: [self error: XXX CartAlreadyCheckoutead ].! !

!XXX methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 17:50:33'!
assertValidUser: anId with: aPassword
	(users at: anId ifAbsent: [self error: self class usuarioInvalido]) = aPassword.! !

!XXX methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 19:58:39'!
checkoutWithCartId: aCartId on: aDate aCreditCardNumber: aNumber anExpirationDate: monthOfYear andOwnerName: aName

	| aCashier aCreditCard cartToCheckout saleGenerated actualUserId actualUserSales |
	self assertCarritoNoEstaCheckouteado: aCartId.
	self assertCarritoExiste: aCartId.
	cartToCheckout := carts at: aCartId.
	aCreditCard := CreditCard expiringOn: monthOfYear.
	aCashier := Cashier toCheckout: cartToCheckout charging: aCreditCard throught: merchantProcessor on: aDate registeringOn: salesBook.
	
	[ saleGenerated := aCashier checkOut.] on: Cashier cartCanNotBeEmptyErrorMessage
	do: [:err | self error: self class CarritoVacio.].
	
	actualUserId := self retrieveUserOf: aCartId.
	actualUserSales := clientSales at: actualUserId ifAbsent:[clientSales add: actualUserId -> OrderedCollection new.
		actualUserSales := clientSales at: actualUserId.].
	actualUserSales add: saleGenerated.
	clientSales add: actualUserId-> actualUserSales.
	
	checkoutedCarts add: aCartId->cartToCheckout.
	carts removeKey: aCartId ifAbsent: [].! !

!XXX methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 20:09:05'!
createCartForId: anUserId withPassword: aString 
	
	| newCart nextCartId cartsForActualUser |
	
	self assertValidUser: anUserId with: aString .
	newCart := Cart acceptingItemsOf: catalog.
	
	nextCartId := self nextCartId.
	
	cartsForActualUser := cartsPerClient at: anUserId ifAbsent: [cartsPerClient add: anUserId -> OrderedCollection new.
		cartsForActualUser := cartsPerClient at: anUserId].
	cartsForActualUser add: nextCartId.
	carts add: nextCartId->newCart.
	
	^nextCartId.! !

!XXX methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 17:51:44'!
listCartWithId: aCartId
	| libros actualCart |
	actualCart := carts at: aCartId ifAbsent:[].

	libros := actualCart listBooks.
	
	^libros.! !

!XXX methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 19:39:58'!
listPurchasesForUserId: anUserId withPassword: aString
	| sum |
	sum := 0. 
	"(clientSales at: anUserId) do: [:a | sum _ sum + a total]."
	^clientSales at: anUserId ifAbsent:[OrderedCollection new].
	! !

!XXX methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 20:11:23'!
nextCartId
	| idToReturn |
	idToReturn := currentCartId.
	currentCartId := currentCartId + 1.
	^idToReturn.! !

!XXX methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 18:54:22'!
retrieveUserOf: aCartId 
	| userID |
	
	 userID := cartsPerClient keyAtValue: (cartsPerClient detect: [:aCartList | aCartList includes: aCartId] ifNone: []).
	^userID. ! !


!XXX methodsFor: 'initialization' stamp: 'g j 11/14/2019 20:08:29'!
initializeWithCatalog: aCatalog throught: aMerchantProcessor 
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	carts := Dictionary new.
	users := Dictionary new.
	users add: 2->'keloke'.
	users add: 3->'jajaja'.
	salesBook := OrderedCollection new.
	checkoutedCarts := Dictionary new.
	clientSales := Dictionary new.
	cartsPerClient := Dictionary new.
	currentCartId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXX class' category: #TusLibros stamp: 'g j 11/14/2019 20:59:20'!
XXX class
	instanceVariableNames: ''!

!XXX class methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 18:24:15'!
CarritoInexistente
	^'El carrito no existe.'! !

!XXX class methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 18:28:36'!
CarritoVacio
	^'El carrito esta vacio.'! !

!XXX class methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 19:57:35'!
CartAlreadyCheckoutead
	^'Carrito ya checkouteado'! !

!XXX class methodsFor: 'as yet unclassified' stamp: 'g j 11/7/2019 20:44:51'!
usuarioInvalido
	^'Usuario invalido'! !

!XXX class methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 18:41:05'!
withCatalog: aDictionary throught: aMerchantProcessor
	^self new initializeWithCatalog: aDictionary throught: aMerchantProcessor ! !
