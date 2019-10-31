!classDefinition: #ApiCarritoTests category: #'25-TusLibros' stamp: 'd b 10/31/2019 00:28:04'!
TestCase subclass: #ApiCarritoTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!ApiCarritoTests methodsFor: 'tests' stamp: 'd b 10/30/2019 20:53:30'!
test01AfterCreateCartResponseCodeIs0
	| request clientId clientPassw api |
	
	api := TusLibrosApi initialize.
	clientId := '123'.
	clientPassw := 'passfacil'.
	
	request := api createCartForClient: clientId andPassword: clientPassw.
	
	self assert: (request at: 1) = $0.
	
	! !

!ApiCarritoTests methodsFor: 'tests' stamp: 'd b 10/30/2019 21:05:58'!
test02AfterCreateCartIsEmpty
	| request clientId clientPassw api cartId|
	
	api := TusLibrosApi new.
	clientId := '123'.
	clientPassw := 'passfacil'.
	request := api createCartForClient: clientId andPassword: clientPassw.
	cartId := '999'.
	
	request := api listCart: cartId.
	
	self assert: (request at: 1) = $0.
	self assert: (request size) = 2. "supongo que respondera '0|' sin nada despues de pipe"
	! !

!ApiCarritoTests methodsFor: 'tests' stamp: 'd b 10/31/2019 00:25:47'!
test03AddingBookToCartNeedsQuantityGreaterThanZero
	| cartId bookIsbn bookQuantity api clientId response clientPassw|
	
	api := TusLibrosApi new.
	
	bookIsbn := 'A3322'.
	bookQuantity := 1.
	clientId := '123'.
	clientPassw := 'passfacil'.
	response := api createCartForClient: clientId andPassword: clientPassw.
	
	cartId := response copyFrom: 3 to: (response size). "esto es para sacar el id del carrito"
	
	response := api addToCart: cartId bookId: bookIsbn andQuantity: bookQuantity.
	
	self assert: response = '0|OK'.! !

!ApiCarritoTests methodsFor: 'tests' stamp: 'd b 10/30/2019 22:58:34'!
test04AddingBookWithZeroQuantityReturnsError

	| cartId bookIsbn bookQuantity api response clientId clientPassw | 
	
	api := TusLibrosApi new.
	cartId := '999'.
	bookIsbn := 'A333'.
	bookQuantity := 0.
	clientId := '123'.
	clientPassw := 'passfacil'.
	response := api createCartForClient: clientId andPassword: clientPassw.
	cartId := response copyFrom: 3 to: (response size). "esto es para sacar el id del carrito"
	
	response := api addToCart: cartId bookId: bookIsbn andQuantity: bookQuantity.
	
	self assert: response = ('1|', TusLibrosApi ErrorInvalidBookQuantity).
! !

!ApiCarritoTests methodsFor: 'tests' stamp: 'd b 10/30/2019 23:00:36'!
test05ListingCartItemsWithWrongCartIdReturnsError
	| response api  |
	
	api := TusLibrosApi new.
	
	response := api listCart: '2232'.
	
	
	self assert: response = ('1|', TusLibrosApi ErrorCartInvalid ).
		
	! !

!ApiCarritoTests methodsFor: 'tests' stamp: 'd b 10/30/2019 23:07:51'!
test06CreatingCartWithInvalidClientReturnsError
	| response api  |
	
	api := TusLibrosApi new.
	
	response := api createCartForClient: 'asdasd' andPassword: 'asdad'.
	
	self assert: response = ('1|', TusLibrosApi ErrorClientNotExists ).
		
	! !

!ApiCarritoTests methodsFor: 'tests' stamp: 'd b 10/30/2019 23:53:02'!
test07AfterAddingBookToCartIsNotEmpty
	| cartId response api bookIsbn |
	
	api := TusLibrosApi new.
	
	response := api createCartForClient: '123' andPassword: 'passfacil'.
	
	cartId := response copyFrom: 3 to: (response size).
	
	bookIsbn := 'A3322'.
	
	response := api addToCart: cartId bookId: bookIsbn andQuantity: 1.
	
	self assert: response = '0|OK'.
	
	response := api listCart: cartId.
	
	self assert: response = '0|A3322|1'.! !

!ApiCarritoTests methodsFor: 'tests' stamp: 'd b 10/31/2019 00:26:28'!
test08AddingToCartABookFailsWhenIsNotFromEditorial
	| cartId response api bookIsbn |
	
	api := TusLibrosApi new.
	
	response := api createCartForClient: '123' andPassword: 'passfacil'.
	
	cartId := response copyFrom: 3 to: (response size).
	
	bookIsbn := 'A33222'.
	
	response := api addToCart: cartId bookId: bookIsbn andQuantity: 1.
	
	self assert: response =( '1|' , TusLibrosApi ErrorBookInvalid).! !

!ApiCarritoTests methodsFor: 'tests' stamp: 'd b 10/31/2019 00:26:34'!
test09AddingInvalidBookToCartNotAffectTheStateOfTheCart
	| cartId response api bookIsbn |
	
	api := TusLibrosApi new.
	
	response := api createCartForClient: '123' andPassword: 'passfacil'.
	
	cartId := response copyFrom: 3 to: (response size).
	
	bookIsbn := 'A33222'.
	
	response := api addToCart: cartId bookId: bookIsbn andQuantity: 1.
	
	response := api listCart: cartId.
	
	self assert: response = '0|'.! !


!classDefinition: #Cart category: #'25-TusLibros' stamp: 'd b 10/31/2019 00:28:04'!
Object subclass: #Cart
	instanceVariableNames: 'books last_transaction clientOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'd b 10/31/2019 00:11:56'!
initializeForClient: aClient
	clientOwner := aClient.
	books := Dictionary new.
	last_transaction := GregorianDateTime now.	
	^self.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'd b 10/30/2019 22:44:59'!
addBook: aBookIsbn quantity: aQuantity

	(books includesKey: aBookIsbn) ifTrue: [
				books at: aBookIsbn put: (aQuantity + (books at: aBookIsbn)).
		] ifFalse:[
			books at: aBookIsbn put: aQuantity.
		].
	^self.! !


!Cart methodsFor: 'accessing' stamp: 'd b 10/30/2019 22:50:31'!
id
	^'999'! !

!Cart methodsFor: 'accessing' stamp: 'd b 10/31/2019 00:04:55'!
listOfBooksAndQuantity
	|desc|
	desc := ''.
	books keysDo: [:aBook | desc := aBook , '|' , ((books at: aBook) asString)].
	^desc.! !


!classDefinition: #StorageManager category: #'25-TusLibros' stamp: 'd b 10/31/2019 00:28:04'!
Object subclass: #StorageManager
	instanceVariableNames: 'books clients carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!StorageManager methodsFor: 'initialization' stamp: 'd b 10/31/2019 00:13:10'!
initialize
	clients := Dictionary new.
	carts := OrderedCollection new.
	books := OrderedCollection new.
	books add: 'A3322'.
	"""TODO: temporal para probar"""
	clients at: '123' put:'passfacil'.
	^self! !


!StorageManager methodsFor: 'validations' stamp: 'd b 10/30/2019 22:52:59'!
checkCartExists: aCartId.
	^carts detect: [:aCart | aCart id = aCartId ifTrue: [^true]] ifNone: [^false.].! !

!StorageManager methodsFor: 'validations' stamp: 'd b 10/30/2019 23:05:37'!
checkClient: aClientId passwordIsValid: aPassw
	^(clients at: aClientId) = aPassw .! !

!StorageManager methodsFor: 'validations' stamp: 'd b 10/30/2019 20:45:07'!
checkClientExists: aClientId
	^clients includesKey: aClientId.! !


!StorageManager methodsFor: 'accessing' stamp: 'd b 10/30/2019 23:51:24'!
addBook: bookIsbn ToCart: cartId quantity: quantity 
	|cart|
	cart := carts detect: [:aCart | aCart id = cartId] ifNone: ["verificar aca o en api?"].
	cart addBook: bookIsbn quantity: quantity.
	
	! !

!StorageManager methodsFor: 'accessing' stamp: 'd b 10/30/2019 22:50:16'!
addCartForClient: aClientId andPassword: aPass
	|newCart|
	newCart  := Cart new initializeForClient: aClientId.
	
	carts add: newCart.
	^newCart id.! !

!StorageManager methodsFor: 'accessing' stamp: 'd b 10/31/2019 00:03:26'!
listOfCart: aCartId
	|cart|
	cart := carts detect: [:c | c id = aCartId].
	
	^(cart listOfBooksAndQuantity)
	
	! !


!StorageManager methodsFor: 'as yet unclassified' stamp: 'd b 10/31/2019 00:23:37'!
checkBookExists: aBookIsbn
	^books includes: aBookIsbn.! !


!classDefinition: #TusLibrosApi category: #'25-TusLibros' stamp: 'd b 10/31/2019 00:28:04'!
Object subclass: #TusLibrosApi
	instanceVariableNames: 'tusLibrosStorageManager'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!TusLibrosApi methodsFor: 'methods |' stamp: 'd b 10/31/2019 00:07:43'!
request: aStringOfResource withParams: params 
	|cartId listDescriptionOfCart|
	aStringOfResource = 'createCart' ifTrue: [
												cartId := tusLibrosStorageManager addCartForClient: (params at: 'clientId') andPassword: (params at: 'clientPass').
												^'0|', cartId. 
											].	
	aStringOfResource = 'listCart' ifTrue:  [
												listDescriptionOfCart := tusLibrosStorageManager listOfCart: (params at: 'cartId').
												^'0|', listDescriptionOfCart.
											].
										
	aStringOfResource = 'addToCart' ifTrue: [
												tusLibrosStorageManager addBook: (params at: 'bookIsbn') ToCart: (params at: 'cartId') quantity: (params  at:'quantity').
												^'0|OK'.
											].														
										
																				
										
	^self error: TusLibrosApi ErrorResourceNotFound.
										
										! !


!TusLibrosApi methodsFor: 'assertions ' stamp: 'd b 10/30/2019 22:17:11'!
checkCartIdIsValid: aCartId
	^tusLibrosStorageManager checkCartExists: aCartId.! !

!TusLibrosApi methodsFor: 'assertions ' stamp: 'd b 10/30/2019 22:07:59'!
checkClient: aClientId passwordIsValid: aPassword
	^tusLibrosStorageManager checkClient: aClientId passwordIsValid: aPassword.! !

!TusLibrosApi methodsFor: 'assertions ' stamp: 'd b 10/30/2019 22:07:49'!
checkClientIdIsFromRegisteredClient: aClientId
	^tusLibrosStorageManager checkClientExists: aClientId.
! !

!TusLibrosApi methodsFor: 'assertions ' stamp: 'd b 10/30/2019 22:07:41'!
checkQuantityIsValid: aQuantity 
	^aQuantity > 0 ifTrue: [^true] ifFalse: [^false].! !


!TusLibrosApi methodsFor: 'resources' stamp: 'd b 10/31/2019 00:22:05'!
addToCart: aCartId bookId: aBookIsbn andQuantity: aQuantity 
	| params response |
	
	params := Dictionary new.
	
	(self checkCartIdIsValid: aCartId) ifTrue: [
		
										(self checkQuantityIsValid: aQuantity) ifFalse: [
																						response := '1|', TusLibrosApi ErrorInvalidBookQuantity.
																						^response.
																					].
										
										(self checkBookIsFromEditorial: aBookIsbn) ifFalse: [
																									response := '1|', TusLibrosApi ErrorBookInvalid. 			
																									]	
														 ifTrue:[
															
																	params at: 'bookIsbn' put: aBookIsbn.
																	params at: 'quantity' put: aQuantity.
																	params at: 'cartId' put: aCartId.
																	response := self request: 'addToCart' withParams: params.
																].
												] ifFalse: [
															response := '1|', TusLibrosApi ErrorCartInvalid.
												].
											
	^response.
	! !

!TusLibrosApi methodsFor: 'resources' stamp: 'd b 10/30/2019 23:07:29'!
createCartForClient: aClientId andPassword: aPassword
	| params response|
	params := Dictionary new.
	(self checkClientIdIsFromRegisteredClient: aClientId) ifTrue:[
		(self checkClient: aClientId passwordIsValid: aPassword) ifTrue:[
				params add: 'clientId'->aClientId.
				params add: 'clientPass'->aPassword.
	
				response := self request: 'createCart' withParams: params.
																		] ifFalse:[
																			response := '1|', TusLibrosApi ErrorClientCredentials .
																		].
																] ifFalse: [
			response := '1|', TusLibrosApi ErrorClientNotExists .
		].
	

	^response.
	! !

!TusLibrosApi methodsFor: 'resources' stamp: 'd b 10/30/2019 23:01:53'!
listCart: aCartId
	| params response |
	params := Dictionary new.
	params at: 'cartId' put: aCartId.
	
	(self checkCartIdIsValid: aCartId) ifTrue: [
			response := self request: 'listCart' withParams: params.	
		] ifFalse: [response := '1|', TusLibrosApi ErrorCartInvalid ].
	
	
	^response.
	
	! !


!TusLibrosApi methodsFor: 'initialization' stamp: 'd b 10/30/2019 20:42:25'!
initialize
	tusLibrosStorageManager := StorageManager new.
	^self! !


!TusLibrosApi methodsFor: 'associating' stamp: 'd b 10/31/2019 00:23:01'!
checkBookIsFromEditorial: aBookIsbn 
	 ^tusLibrosStorageManager checkBookExists: aBookIsbn.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosApi class' category: #'25-TusLibros' stamp: 'd b 10/31/2019 00:28:04'!
TusLibrosApi class
	instanceVariableNames: ''!

!TusLibrosApi class methodsFor: 'errors descriptions' stamp: 'd b 10/30/2019 22:21:38'!
ErrorCartInvalid
	^'El cart es invalido'! !

!TusLibrosApi class methodsFor: 'errors descriptions' stamp: 'd b 10/30/2019 23:05:55'!
ErrorClientCredentials
	^'El cliente ingresado es invalido'! !

!TusLibrosApi class methodsFor: 'errors descriptions' stamp: 'd b 10/30/2019 23:06:04'!
ErrorClientNotExists
	^'El cliente ingresado no existe'! !

!TusLibrosApi class methodsFor: 'errors descriptions' stamp: 'd b 10/30/2019 21:56:35'!
ErrorInvalidBookQuantity
	^'La cantidad seleccionada es invalida'! !

!TusLibrosApi class methodsFor: 'errors descriptions' stamp: 'd b 10/30/2019 21:05:39'!
ErrorResourceNotFound
	^'El recurso pedido no fue encontrado'! !

!TusLibrosApi class methodsFor: 'errors descriptions' stamp: 'd b 10/30/2019 20:42:10'!
initialize

	^self new initialize! !


!TusLibrosApi class methodsFor: 'auto complete' stamp: 'd b 10/31/2019 00:15:31'!
ErrorBookInvalid
	^'El libro no pertenece a la editorial'.! !

TusLibrosApi initialize!