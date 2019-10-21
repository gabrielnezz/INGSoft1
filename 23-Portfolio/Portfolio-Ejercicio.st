!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'g j 10/20/2019 22:35:45'!
test01EmptyPortfolioDoesNotHaveTransactions

	| portfolio account |
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	self assert: 0 equals: portfolio transactions size.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'g j 10/20/2019 20:48:14'!
test01PortfolioCanAddAnAccountAndAccessItsBalance

	| portfolio account |
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'g j 10/20/2019 21:37:32'!
test02PortfolioCanAddMoreThan1Account

	| portfolio account1 account2 |
	account1 := ReceptiveAccount withId: 1.
	account2 := ReceptiveAccount withId: 2.
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
		
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'g j 10/20/2019 21:49:24'!
test03PortfolioCanNotAddTheSameAccountTwice

	| portfolio account1 |
	account1 := ReceptiveAccount withId: 1.
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	
	self should: [portfolio addAccount: account1 ]
		raise: Error
		withMessageText: 'No se puede agregar la misma cuenta mas de una vez'.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'g j 10/20/2019 21:57:04'!
test04PortfolioBalanceIsTheSumOfAssociatedAccountsBalance

	| portfolio account1 account2 account3 |
	
	account1 := ReceptiveAccount withId: 1.
	account2 := ReceptiveAccount withId: 2.
	account3 := ReceptiveAccount withId: 3.
	
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 200 on: account2. 
	Deposit register: 75 on: account3.
	
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	portfolio addAccount: account3.
		
	self assert: 325 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'g j 10/20/2019 22:48:32'!
test05PortfolioCanAddAPortfolioAndCalculateBalanceProperly

	| supPortfolio subPortfolio account1 account2 |
	
	account1 := ReceptiveAccount withId: 1.
	account2 := ReceptiveAccount withId: 2.
	
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 200 on: account2.
	
	
	supPortfolio := Portfolio new.
	subPortfolio := Portfolio new.
	supPortfolio addAccount: account1.
	subPortfolio addAccount: account2.
	
	supPortfolio addPortfolio: subPortfolio.
		
	self assert: 250 equals: supPortfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'g j 10/20/2019 22:53:16'!
test06PortfolioCanNotAddAnAccountThatIsManagedByASuperiorPortfolio

	| supPortfolio subPortfolio account1 account2 |
	
	account1 := ReceptiveAccount withId: 1.
	account2 := ReceptiveAccount withId: 2.
	
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 200 on: account2.
	
	
	supPortfolio := Portfolio new.
	subPortfolio := Portfolio new.
	supPortfolio addAccount: account1.
	supPortfolio addPortfolio: subPortfolio.
	
	self should: [subPortfolio addAccount: account1.]
		raise: Error
		withMessageText: 'Esta cuenta ya pertenece a este arbol de portfolios'.
	
! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'g j 10/20/2019 20:59:40'!
netValue 
^value! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'g j 10/20/2019 21:00:04'!
netValue

	^ value * -1! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfoliosThatOwnMe'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'g j 10/20/2019 23:05:49'!
addAccount: aReceptiveAccount
	portfoliosThatOwnMe do: [:portfolio | portfolio accounts detect: 
		[:anAccount | anAccount id = aReceptiveAccount id] ifNone: [accounts add: aReceptiveAccount.
		^aReceptiveAccount .].
		self class AccountAlreadyInCurrentTree.
		].
	accounts detect: [:anAccount | anAccount id = aReceptiveAccount id] ifNone: [accounts add: aReceptiveAccount.
		^aReceptiveAccount ].	
	self class RepeatedAccountsNotAllowed ! !

!Portfolio methodsFor: 'initialization' stamp: 'g j 10/20/2019 22:55:48'!
initialize
	accounts:= OrderedCollection new.
	portfoliosThatOwnMe := OrderedCollection new.! !


!Portfolio methodsFor: 'accessing' stamp: 'g j 10/20/2019 23:01:33'!
accounts
^accounts select: [:anAccountOrPortfolio | anAccountOrPortfolio class = ReceptiveAccount.].! !

!Portfolio methodsFor: 'accessing' stamp: 'g j 10/20/2019 20:47:42'!
balance
	^accounts sum: [:anAccount | anAccount balance].! !

!Portfolio methodsFor: 'accessing' stamp: 'g j 10/20/2019 22:39:25'!
transactions
	| allTransactions |
	allTransactions := OrderedCollection new.
	accounts do: [: anAccount | allTransactions addAll: anAccount transactions.].
	
	^allTransactions.! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'g j 10/20/2019 22:56:45'!
addPortfolio: aPortfolio 
	accounts add: aPortfolio.
	aPortfolio addPortfolioOwner: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'g j 10/20/2019 22:56:31'!
addPortfolioOwner: aPortfolio 
	portfoliosThatOwnMe add: aPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!


!Portfolio class methodsFor: 'error messages' stamp: 'g j 10/20/2019 22:53:50'!
AccountAlreadyInCurrentTree.
self error: 'Esta cuenta ya pertenece a este arbol de portfolios'! !

!Portfolio class methodsFor: 'error messages' stamp: 'g j 10/20/2019 21:43:23'!
RepeatedAccountsNotAllowed
self error: 'No se puede agregar la misma cuenta mas de una vez'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'g j 10/20/2019 20:36:23'!
initializeWithId: anId

	transactions := OrderedCollection new.
	id := anId! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'g j 10/20/2019 21:00:55'!
balance
	^transactions sum: [ :aTransaction | aTransaction netValue ] ifEmpty: [ 0 ].! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'g j 10/20/2019 21:08:09'!
id
^id! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'g j 10/20/2019 20:48:59'!
withId: anId
	^self new initializeWithId: anId.! !
