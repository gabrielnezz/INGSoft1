!classDefinition: #CartTest category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'd b 11/17/2019 15:51:55'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn: salesBook forUserId: 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'd b 11/17/2019 15:52:20'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new
		forUserId: 2.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'd b 11/17/2019 15:52:37'!
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
				registeringOn: salesBook 
				forUserId: 2]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'd b 11/17/2019 15:52:46'!
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
		registeringOn: salesBook
		forUserId: 2.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'd b 11/17/2019 15:52:52'!
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
		registeringOn: salesBook
		forUserId: 2.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'd b 11/17/2019 15:52:58'!
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
		registeringOn: salesBook
		forUserId: 2.
		
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


!classDefinition: #TusLibrosInterfaceInternaTest category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
TestCase subclass: #TusLibrosInterfaceInternaTest
	instanceVariableNames: 'testObjectsFactory debitBehavior salesBook interface clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:49:11'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard 
	! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:55:44'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	salesBook := OrderedCollection new.
	clock := ClockSimulator withDate: DateAndTime now.
	interface := TusLibrosInterface withCatalog: testObjectsFactory defaultCatalog throught: self registeringOn: OrderedCollection new withClock: clock.! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:12:39'!
test01CreandoUnNuevoCarritoYEsDevueltoPorListCarts

	| newCartId |
	newCartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	self assert: (interface listCartWithId: newCartId) isEmpty.! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:12:52'!
test02SeAgregaUnLibroAlCarritoYAlListarloAparece

	| newCartId libros |

	newCartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: newCartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	libros := (interface listCartWithId: newCartId).
	
	self assert: 1 equals: libros size.
	self assert: 1 equals: (libros at: testObjectsFactory itemSellByTheStore).! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:47:16'!
test03NoSePuedeCrearUnCarritoConUnUsuarioInvalido


	self should: [interface createCartForId: 4 withPassword: 'keloke'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface usuarioInvalido.
! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:13:15'!
test04SeCreanDosCarritosYAmbosSonDevueltosPorListCart

	| cart1Id cart2Id libros1 libros2 |
	cart1Id := interface createCartForId: 2 withPassword: 'keloke'.
	cart2Id := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cart1Id withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	libros1 := (interface listCartWithId: cart1Id).
	
	libros2 := (interface listCartWithId: cart2Id).
	
	self assert: 1 equals: libros1 size.
	self assert: 1 equals: (libros1 at: testObjectsFactory itemSellByTheStore).
	
	self assert: libros2 isEmpty.! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:14:12'!
test05SeCreanDosCarritosDeDiferentesUsuariosYSonDistintos

	| cart1Id cart2Id libros1 libros2 |
	cart1Id := interface createCartForId: 2 withPassword: 'keloke'.
	cart2Id := interface createCartForId: 3 withPassword: 'jajaja'.
	
	interface addToCartWithId: cart1Id withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	interface addToCartWithId: cart1Id withISBN: testObjectsFactory anotherItemSellByTheStore withQuantity: 1.
	
	interface addToCartWithId: cart2Id withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	libros1 := (interface listCartWithId: cart1Id).
	
	libros2 := (interface listCartWithId: cart2Id).
	
	self assert: 2 equals: libros1 size.
	self assert: 1 equals: (libros1 at: testObjectsFactory itemSellByTheStore).
	self assert: 1 equals: (libros1 at: testObjectsFactory anotherItemSellByTheStore ).
	
	self assert: 1 equals: libros2 size.
	self assert: 1 equals: (libros2 at: testObjectsFactory itemSellByTheStore).! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:47:22'!
test06NoSePuedeCheckoutearUnCarritoInexistente


	self should: [interface checkoutWithCartId: #id
		on: testObjectsFactory today
		 aCreditCardNumber: '113584'
		 anExpirationDate: testObjectsFactory notExpiredDate
		 andOwnerName: 'Dario'.]
	raise: Error - MessageNotUnderstood
	withMessageText: TusLibrosInterface CarritoInexistente.! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:14:36'!
test07NoSePuedeCheckoutearUnCarritoVacio

	| cartId |
		
	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	self should: [interface checkoutWithCartId: cartId
		 on: testObjectsFactory today
		 aCreditCardNumber: '123456' 
		 anExpirationDate: testObjectsFactory notExpiredDate
		 andOwnerName: 'Carlitos'.]
	raise: Error - MessageNotUnderstood
	withMessageText: Cashier cartCanNotBeEmptyErrorMessage.
	
	! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:14:49'!
test08DespuesDeCheckoutearElUsuarioTieneUnaCompra

	| cartId listaCompras |

	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	interface checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.
	
	listaCompras := interface listPurchasesForUserId: 2 withPassword: 'keloke'.
	
	self assert: (listaCompras allSatisfy: [:aSale | ((aSale soldOf: testObjectsFactory itemSellByTheStore) = 1) & (aSale total = 10)]).
	
	! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:15:06'!
test09DespuesDeDosComprasElClienteTieneDosSales

	|cartId listaCompras |

	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.	
	interface checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.
	
	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	interface addToCartWithId: cartId withISBN: testObjectsFactory anotherItemSellByTheStore withQuantity: 1.	
	interface checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.
	
	listaCompras := interface listPurchasesForUserId: 2 withPassword: 'keloke'.
	self assert: listaCompras size = 2.
	! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:15:24'!
test10SiFallaElCheckoutEntoncesElClienteNoTieneNuevasCompras

	| cartId listaComprasAntes |

	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	listaComprasAntes := interface listPurchasesForUserId: 2 withPassword: 'keloke'.
	
	self should:[
	interface checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory expiredDate 
	andOwnerName: 'Carlitos'.]
		raise: Error - MessageNotUnderstood
			withMessageText: Cashier canNotChargeAnExpiredCreditCardErrorMessage.
	
	self assert: listaComprasAntes size = (interface listPurchasesForUserId: 2 withPassword: 'keloke') size.
	
	! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:47:30'!
test11NoSePuedeCheckoutearUnCarritoCheckouteado

	| cartId |
	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cartId withISBN: (testObjectsFactory itemSellByTheStore) withQuantity: 1.
	interface checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.
	
	self should: [interface checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.]
		raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface CartAlreadyCheckoutead.
	
	
	! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 16:47:34'!
test12NoSePuedePedirVentasDeUnUsuarioInvalido

	self should: [interface listPurchasesForUserId: testObjectsFactory invalidUser withPassword: testObjectsFactory invalidUserPassword .]
		raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface usuarioInvalido .

	
	
	! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 21:06:55'!
test13NoSePuedeCheckoutearSobreElCarritoLuegoDe30MinutosSinUsarlo

	| cartId |

	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	clock adelantarTiempo: 31 minutes.
	
	self should: [interface checkoutWithCartId: cartId
	on: testObjectsFactory today 
	aCreditCardNumber: '123456'
	anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.]
	raise: Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface ErrorCarritoExpirado 
	! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 21:03:57'!
test14NoSePuedeAgregarCosasAlCarritoLuegoDe30MinutosSinUsarlo

	| cartId |

	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	clock adelantarTiempo: 31 minutes.
	
	self should: [interface addToCartWithId: cartId withISBN: testObjectsFactory anotherItemSellByTheStore withQuantity: 5.]
		raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface ErrorCarritoExpirado .
	
	
	! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 21:18:17'!
test15SePuedeAgregarCosasAlCarritoHasta30MinutosSinUsarlo

	| cartId librosEnCarrito |

	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	clock adelantarTiempo: 30 minutes.
	interface addToCartWithId: cartId withISBN: testObjectsFactory anotherItemSellByTheStore withQuantity: 5.

		
	librosEnCarrito := (interface listCartWithId: cartId).
	
	self assert: 2 equals: librosEnCarrito size.
	self assert: 1 equals: (librosEnCarrito at: testObjectsFactory itemSellByTheStore).
	self assert: 5 equals: (librosEnCarrito at: testObjectsFactory anotherItemSellByTheStore).! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 21:31:44'!
test16AgregarAlgoAlCarritoActualizaElUltimoUsoDelCarrito

	| cartId librosEnCarrito |

	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	clock adelantarTiempo: 15 minutes.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory anotherItemSellByTheStore withQuantity: 1.

	clock adelantarTiempo: 20 minutes.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory anotherItemSellByTheStore withQuantity: 1.
			
	librosEnCarrito := (interface listCartWithId: cartId).
	
	self assert: 2 equals: librosEnCarrito size.
	self assert: 1 equals: (librosEnCarrito at: testObjectsFactory itemSellByTheStore).
	self assert: 2 equals: (librosEnCarrito at: testObjectsFactory anotherItemSellByTheStore).! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 23:26:56'!
test17CrearUnCarritoNoCuentaComoTransaccionParaLaExpiracion

	| cartId librosEnCarrito |

	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	clock adelantarTiempo: 31 minutes.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
			
	librosEnCarrito := (interface listCartWithId: cartId).
	
	self assert: 1 equals: librosEnCarrito size.
	self assert: 1 equals: (librosEnCarrito at: testObjectsFactory itemSellByTheStore).! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 23:31:22'!
test18ListarElCaritoActualizaElUltimoUsoDelCarrito

	| cartId librosEnCarrito |

	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
		
	clock adelantarTiempo: 25 minutes.
	
	self assert: 1 equals: (interface listCartWithId: cartId) size.
	
	clock adelantarTiempo: 6 minutes.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
			
	librosEnCarrito := (interface listCartWithId: cartId).
	
	self assert: 1 equals: librosEnCarrito size.
	self assert: 2 equals: (librosEnCarrito at: testObjectsFactory itemSellByTheStore).! !

!TusLibrosInterfaceInternaTest methodsFor: 'tests' stamp: 'd b 11/17/2019 23:35:19'!
test19NoPuedoListarCarritoDespuesDeCheckoutear

	| cartId |

	cartId := interface createCartForId: 2 withPassword: 'keloke'.
	
	interface addToCartWithId: cartId withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	interface checkoutWithCartId: cartId on: testObjectsFactory today aCreditCardNumber: '123456' anExpirationDate: testObjectsFactory notExpiredDate 
	andOwnerName: 'Carlitos'.
	
	self should: [(interface listCartWithId: cartId).]
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosInterface CartAlreadyCheckoutead.! !


!classDefinition: #AuditableItem category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
Object subclass: #AuditableItem
	instanceVariableNames: 'itemId item lastUsed estado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuditableItem methodsFor: 'accessing' stamp: 'd b 11/17/2019 23:39:34'!
checkouted
	^estado checkouted! !

!AuditableItem methodsFor: 'accessing' stamp: 'd b 11/17/2019 17:17:14'!
estado
	^estado! !

!AuditableItem methodsFor: 'accessing' stamp: 'd b 11/17/2019 17:09:33'!
item
	^item! !

!AuditableItem methodsFor: 'accessing' stamp: 'd b 11/17/2019 17:09:24'!
itemId
	^itemId! !

!AuditableItem methodsFor: 'accessing' stamp: 'd b 11/17/2019 22:52:51'!
lastUsed
	^lastUsed ! !


!AuditableItem methodsFor: 'updating' stamp: 'd b 11/17/2019 23:07:32'!
fromAudit: anAuditableItem
	itemId := anAuditableItem itemId.
	item  := anAuditableItem item.
	lastUsed := anAuditableItem lastUsed.! !

!AuditableItem methodsFor: 'updating' stamp: 'd b 11/17/2019 22:56:54'!
nuevoEstado: unNuevoEstado 
	estado := unNuevoEstado .
	^self.! !

!AuditableItem methodsFor: 'updating' stamp: 'd b 11/17/2019 22:54:47'!
updateLastTransactionTo: aDateTime
	lastUsed := aDateTime .! !


!AuditableItem methodsFor: 'initialization' stamp: 'd b 11/17/2019 22:01:30'!
withItemId: aCartId withItem: aCart on: currentTime.
	itemId := aCartId.
	item := aCart.
	lastUsed := currentTime.
	"estado := #OK."
	estado := ItemJustCreated new.! !


!AuditableItem methodsFor: 'visitor' stamp: 'd b 11/17/2019 22:05:39'!
accept: aVisitor
	estado accept:aVisitor .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuditableItem class' category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
AuditableItem class
	instanceVariableNames: ''!

!AuditableItem class methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 17:06:10'!
withItemId: aCartId withItem: aCart on: currentTime
	^self new withItemId: aCartId withItem: aCart on: currentTime.! !


!classDefinition: #ItemCheckouted category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
AuditableItem subclass: #ItemCheckouted
	instanceVariableNames: 'auditItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ItemCheckouted methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 21:54:34'!
accept: aVisitor
	^aVisitor visitItemCheckouted 
	! !

!ItemCheckouted methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:39:53'!
checkouted
	^true! !

!ItemCheckouted methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:22:38'!
from: anAuditItem
	auditItem := anAuditItem ! !

!ItemCheckouted methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:20:42'!
item
	^auditItem item ! !

!ItemCheckouted methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:20:44'!
itemId
	^auditItem itemId ! !

!ItemCheckouted methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:20:38'!
lastUsed
	^auditItem lasUsed ! !


!classDefinition: #ItemExpired category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
AuditableItem subclass: #ItemExpired
	instanceVariableNames: 'auditItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ItemExpired methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 21:54:44'!
accept: aVisitor
	^aVisitor visitItemExpired ! !

!ItemExpired methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:40:22'!
checkouted 
	^false! !

!ItemExpired methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:22:41'!
from: anAuditItem
	auditItem := anAuditItem ! !

!ItemExpired methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:19:38'!
item
	^auditItem item! !

!ItemExpired methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:19:35'!
itemId
	^auditItem itemId ! !

!ItemExpired methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:19:44'!
lastUsed
	^auditItem lastUsed ! !


!classDefinition: #ItemInUse category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
AuditableItem subclass: #ItemInUse
	instanceVariableNames: 'auditItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ItemInUse methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 22:43:14'!
accept: aVisitor
	^aVisitor visitItemInUseWithItem: self. ! !

!ItemInUse methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:40:15'!
checkouted
	^false! !

!ItemInUse methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:22:30'!
from: anAuditItem
	auditItem := anAuditItem ! !

!ItemInUse methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:19:56'!
item
	^auditItem item ! !

!ItemInUse methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:20:00'!
itemId
	^auditItem itemId ! !

!ItemInUse methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:21:47'!
lastUsed
	^auditItem lastUsed ! !


!classDefinition: #ItemJustCreated category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
AuditableItem subclass: #ItemJustCreated
	instanceVariableNames: 'auditItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ItemJustCreated methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 21:54:53'!
accept: aVisitor
	^aVisitor visitItemJustCreated ! !

!ItemJustCreated methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:40:09'!
checkouted
	^false! !

!ItemJustCreated methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:22:33'!
from: anAuditItem
	auditItem := anAuditItem ! !

!ItemJustCreated methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:20:14'!
item
	^auditItem item! !

!ItemJustCreated methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:20:20'!
itemId
	^auditItem itemId! !

!ItemJustCreated methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 23:20:28'!
lastUsed
	^auditItem lasUsed ! !


!classDefinition: #Cart category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
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

!classDefinition: 'Cart class' category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'g j 11/11/2019 17:35:42'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog! !

!Cart class methodsFor: 'instance creation' stamp: 'g j 11/7/2019 20:08:23'!
acceptingItemsOf: aCatalog withId: anId 

	^self new initializeAcceptingItemsOf: aCatalog withId: 1 ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total userId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'd b 11/17/2019 15:43:31'!
createSale
	| list |
	list := cart listBooks.
	^Sale of: total withItemList: list ofUser: userId .
	
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


!Cashier methodsFor: 'checkout' stamp: 'd b 11/17/2019 15:05:24'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.
	^total.! !


!Cashier methodsFor: 'initialization' stamp: 'd b 11/17/2019 15:48:50'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook forUserId: aUserId
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	userId := aUserId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'd b 11/17/2019 15:49:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook forUserId: aUserId
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook forUserId: aUserId.! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #ClockSimulator category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
Object subclass: #ClockSimulator
	instanceVariableNames: 'currentTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockSimulator methodsFor: 'accessing' stamp: 'd b 11/17/2019 16:34:21'!
adelantarTiempo: aTime
	currentTime := currentTime + aTime .! !

!ClockSimulator methodsFor: 'accessing' stamp: 'd b 11/17/2019 16:34:43'!
currentTime
	^currentTime! !

!ClockSimulator methodsFor: 'accessing' stamp: 'd b 11/17/2019 23:51:12'!
valueWithCurrentTime: aBlock
	^aBlock value:currentTime 
	"isExpiredOn: aDate
	^aDate < (currentTime - 30 minutes)
	"! !


!ClockSimulator methodsFor: 'initialization' stamp: 'd b 11/17/2019 16:33:36'!
withDate: aDateTime
	currentTime := aDateTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClockSimulator class' category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
ClockSimulator class
	instanceVariableNames: 'date'!

!ClockSimulator class methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 16:32:49'!
withDate: aDateTime
	^self new withDate: aDateTime.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
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

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
Object subclass: #Sale
	instanceVariableNames: 'total saleItems userId'
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

!Sale methodsFor: 'total' stamp: 'd b 11/17/2019 15:28:13'!
userOwnerId
	
	^ userId .! !


!Sale methodsFor: 'initialization' stamp: 'd b 11/17/2019 15:43:47'!
initializeOf: anAmount withItemList: aBookList ofUser:aUserId.
	total := anAmount.
	saleItems := aBookList.
	userId := aUserId .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 15:50:49'!
of: anAmount withItemList: aBookList ofUser: aUserId.
	^self new initializeOf: anAmount withItemList: aBookList ofUser: aUserId.
	
	! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'd b 11/17/2019 15:58:44'!
invalidUser
	
	^'george'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'd b 11/17/2019 15:58:39'!
invalidUserPassword
	
	^'george passwordfacil'! !

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

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'g j 11/17/2019 13:09:34'!
todayPlus31
	
	^ today + (Duration minutes: 31)! !


!classDefinition: #TusLibrosInterface category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'catalog carts users merchantProcessor salesBook cartsPerClient currentCartId clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'accessing' stamp: 'd b 11/17/2019 23:23:00'!
addToCartWithId: aCartId withISBN: anISBN withQuantity: aQuantity 
	
	| cartToAdd auditItem|
	self assertCarritoExiste: aCartId.
	self assertCarritoNoEstaCheckouteado: aCartId.
	self assertCarritoIsNotExpired: aCartId.
	
	auditItem := (carts detect:[:anAuditItem | anAuditItem itemId  = aCartId]).
	cartToAdd := auditItem item.
	
	cartToAdd add: aQuantity of: anISBN.
	
	auditItem nuevoEstado: ((ItemInUse new) from: auditItem). "todo:usar singleton aca"	
	
	self updateLastTransactionTo: auditItem.! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'd b 11/17/2019 22:04:45'!
checkoutWithCartId: aCartId on: aDate aCreditCardNumber: aNumber anExpirationDate: monthOfYear andOwnerName: aName

	| aCashier aCreditCard cartToCheckout auditItemOfCart |
	self assertCarritoNoEstaCheckouteado: aCartId.
	self assertCarritoExiste: aCartId.
	self assertCarritoIsNotExpired: aCartId.
	auditItemOfCart := carts detect: [:anAuditItem | anAuditItem itemId = aCartId].
	cartToCheckout := auditItemOfCart item.
	aCreditCard := CreditCard expiringOn: monthOfYear.
	aCashier := Cashier toCheckout: cartToCheckout charging: aCreditCard throught: merchantProcessor on: aDate registeringOn: salesBook forUserId: (self retrieveUserOf: aCartId).
	
	[aCashier checkOut.] on: Cashier cartCanNotBeEmptyErrorMessage
	do: [:err | self error: self class CarritoVacio.].
	
	auditItemOfCart nuevoEstado: ItemCheckouted new.! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'd b 11/17/2019 17:05:19'!
createCartForId: anUserId withPassword: aString 
	
	| newCart nextCartId cartsForActualUser |
	
	self assertValidUser: anUserId with: aString .
	newCart := Cart acceptingItemsOf: catalog.
	
	nextCartId := self nextCartId.
	
	cartsForActualUser := cartsPerClient at: anUserId ifAbsent: [cartsPerClient add: anUserId -> OrderedCollection new.
		cartsForActualUser := cartsPerClient at: anUserId].
	cartsForActualUser add: nextCartId.
	
	carts add: (AuditableItem withItemId: nextCartId withItem: newCart on: clock currentTime).
	"carts add: nextCartId->newCart."
	
	^nextCartId.! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'd b 11/17/2019 23:36:30'!
listCartWithId: aCartId
	| libros auditItem |
	self assertCarritoExiste: aCartId .
	self assertCarritoNoEstaCheckouteado: aCartId .
	auditItem := carts detect: [:anAuditItem | anAuditItem itemId = aCartId].

	libros := auditItem item listBooks.
	
	self updateLastTransactionTo: auditItem.
	
	^libros.! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'd b 11/17/2019 15:28:01'!
listPurchasesForUserId: anUserId withPassword: aPassword
	self assertValidUser: anUserId with: aPassword.
	^salesBook select: [:aSale | aSale userOwnerId = anUserId]
	
	! !


!TusLibrosInterface methodsFor: 'assertions' stamp: 'd b 11/17/2019 22:34:28'!
assertCarritoExiste: aCartId 
	"(carts includesKey: aCartId) ifFalse: [self error: self class CarritoInexistente.]"
	(carts anySatisfy: [:anAuditableItem | anAuditableItem itemId = aCartId]) ifFalse: [self error: self class CarritoInexistente.].	! !

!TusLibrosInterface methodsFor: 'assertions' stamp: 'd b 11/17/2019 23:13:00'!
assertCarritoIsNotExpired: aCartId
	| auditItem |
	auditItem := carts detect: [:anAuditItem | anAuditItem itemId = aCartId].
	auditItem accept: self.
	"(clock isExpiredOn: auditItem lastUsed) ifTrue: [self error: self class ErrorCarritoExpirado ]."
	
	! !

!TusLibrosInterface methodsFor: 'assertions' stamp: 'd b 11/17/2019 23:40:56'!
assertCarritoNoEstaCheckouteado: aCartId 
	
	(carts anySatisfy: [:anAuditableItem | anAuditableItem itemId = aCartId & (anAuditableItem checkouted)]) ifTrue: [self error: self class CartAlreadyCheckoutead .].! !

!TusLibrosInterface methodsFor: 'assertions' stamp: 'd b 11/17/2019 20:54:03'!
assertValidUser: anId with: aPassword
	(users at: anId ifAbsent: [self error: self class usuarioInvalido]) = aPassword.! !


!TusLibrosInterface methodsFor: 'queries' stamp: 'g j 11/14/2019 20:11:23'!
nextCartId
	| idToReturn |
	idToReturn := currentCartId.
	currentCartId := currentCartId + 1.
	^idToReturn.! !

!TusLibrosInterface methodsFor: 'queries' stamp: 'g j 11/14/2019 18:54:22'!
retrieveUserOf: aCartId 
	| userID |
	
	 userID := cartsPerClient keyAtValue: (cartsPerClient detect: [:aCartList | aCartList includes: aCartId] ifNone: []).
	^userID. ! !

!TusLibrosInterface methodsFor: 'queries' stamp: 'd b 11/17/2019 22:40:18'!
updateLastTransactionTo: anAuditItem
	anAuditItem updateLastTransactionTo: clock currentTime.! !


!TusLibrosInterface methodsFor: 'visitors' stamp: 'd b 11/17/2019 21:58:37'!
visitItemCheckouted
	self error: TusLibrosInterface CartAlreadyCheckoutead ! !

!TusLibrosInterface methodsFor: 'visitors' stamp: 'd b 11/17/2019 21:58:09'!
visitItemExpired
	self error: self class ErrorCarritoExpirado.! !

!TusLibrosInterface methodsFor: 'visitors' stamp: 'd b 11/17/2019 23:55:56'!
visitItemInUseWithItem: auditItem
	(clock valueWithCurrentTime: [:currentTime | (auditItem lastUsed) < (currentTime - (30 minutes))]) ifTrue: [auditItem nuevoEstado: ItemExpired new. self error: self class ErrorCarritoExpirado ].! !

!TusLibrosInterface methodsFor: 'visitors' stamp: 'd b 11/17/2019 21:55:27'!
visitItemJustCreated
	^true! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'd b 11/17/2019 21:23:14'!
withCatalog: aCatalog throught: aMerchantProcessor registeringOn: aSalesBook withClock: aClock.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	carts := OrderedCollection new.
	users := Dictionary new.
	users add: 2->'keloke'.
	users add: 3->'jajaja'.
	salesBook := OrderedCollection new.
	cartsPerClient := Dictionary new.
	currentCartId := 0.
	salesBook:= aSalesBook.
	clock := aClock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #TusLibros stamp: 'd b 11/17/2019 23:56:27'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 18:24:15'!
CarritoInexistente
	^'El carrito no existe.'! !

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'g j 11/11/2019 18:28:36'!
CarritoVacio
	^'El carrito esta vacio.'! !

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'g j 11/14/2019 19:57:35'!
CartAlreadyCheckoutead
	^'Carrito ya checkouteado'! !

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 16:47:54'!
ErrorCarritoExpirado
	^'Carrito expirado'! !

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'g j 11/17/2019 14:25:21'!
InactiveCart
	'El carrito se encuentra invalido'! !

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'g j 11/7/2019 20:44:51'!
usuarioInvalido
	^'Usuario invalido'! !

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'd b 11/17/2019 16:54:44'!
withCatalog: aCatalog throught: aMerchantProcessor registeringOn: salesBook withClock: aClock.
	^self new withCatalog: aCatalog throught: aMerchantProcessor registeringOn: salesBook withClock: aClock.! !
