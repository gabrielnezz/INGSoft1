!classDefinition: #AccountNamedTest category: #'Portfolio-Solucion'!
TestCase subclass: #AccountNamedTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountNamedTest methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 21:24:25'!
test01ReceptiveAccountWithNameIsCorrect
	| ac1 |
	ac1 := ReceptiveAccount named:'jose'.
	
	self assert: ac1 name = 'jose'! !

!AccountNamedTest methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 21:25:59'!
test02PortfolioWithNameIsCorrect
	| portfolio |
	portfolio := Portfolio named: 'portfolio de carlos'.
	
	self assert: portfolio name = 'portfolio de carlos'! !


!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 20:53:07'!
test01PortfolioHasZeroBalanceWhenCreatedEmpty

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0. 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 21:14:12'!
test02EmptyPortfolioDoesNotKnowTransactionsNotContainedInItself

	| portfolio deposit withdraw |
	
	portfolio := Portfolio new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (portfolio hasRegistered: deposit).
	self deny: (portfolio hasRegistered:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 20:53:18'!
test03EmptyPortfolioDoesNotHaveTransactions

	| portfolio |
	
	portfolio := Portfolio new.
		
	self assert: portfolio transactions isEmpty .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'atr 5/26/2019 18:32:08'!
test04APortfolioBalanceEqualsTheSumOfItsElements

	| portfolio anotherPortfolio anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	portfolio add:  anAccount.
	anotherPortfolio add: anotherAccount .
	portfolio add: anotherPortfolio.
	
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	
	Deposit register: 75 on:  anotherAccount .
	self assert: portfolio balance equals: (anAccount balance + anotherAccount balance ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 21:25:12'!
test05APortfolioKnowsTheTransactionsOfTheAccountsItHasRegistered

	| portfolio anAccount aDeposit |
	
	anAccount := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add:  anAccount.

	aDeposit := Deposit for: 100.

	anAccount register: aDeposit .
	
	self assert: (portfolio hasRegistered: aDeposit) .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 21:26:45'!
test06APortfolioHasTheTransactionsOfTheAccountsItHasRegistered

	| portfolio anAccount aDeposit |
	
	anAccount := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add:  anAccount.

	aDeposit := Deposit for: 100.

	anAccount register: aDeposit .
	
	self assert: portfolio transactions equals: anAccount transactions .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'db 10/20/2019 11:50:57'!
assertPortfolio: portfolio3 hasTransactionsOf: arrayOfPortfolios
	|totalTransactions|
	totalTransactions := 0.
	self assert: (arrayOfPortfolios allSatisfy: [:portfolio | (portfolio3 transactions) includes: (portfolio transactions)]).
	totalTransactions := arrayOfPortfolios do:[:portfolio | totalTransactions := totalTransactions + portfolio size].
	self assert: totalTransactions = (portfolio3 transactions size).! !

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'db 10/20/2019 01:09:10'!
test08NewPorfolioHasNotAccounts
	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: 0 = (portfolio countOfAccounts).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'db 10/20/2019 10:45:18'!
test09PortfolioWithOneAccountsHasSameBalanceAndTransactions

	| account portfolio a c |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio addAccount: account.
	Deposit register: 150 on: account.
	self assert: portfolio balance = account balance.
	a := portfolio transactions.
	c := account transactions.
	self assert: a = c.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'db 10/20/2019 11:07:30'!
test10PortfolioWithAccount1WithPositiveBalanceAndAccount2WithBiggerNegativeBalanceHasNegativeBalance

	| portfolio account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	Deposit register: 200 on: account1. 
	
	account2 := ReceptiveAccount new.
	Withdraw register: 250 on: account2.
	
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	self assert: (portfolio balance) < 0.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'db 10/20/2019 11:11:12'!
test11PortfolioWithAccount1WithPositiveBalanceAndAccount2WithLowerNegativeBalanceHasPositiveBalance

	| portfolio account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	Deposit register: 200 on: account1. 
	
	account2 := ReceptiveAccount new.
	Withdraw register: 150 on: account2.
	
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	self assert: (portfolio balance) > 0.! !


!classDefinition: #ReportTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'tests' stamp: 'db 10/27/2019 15:20:52'!
test01ReportAccountSummaryForAReceptiveAccountWithNoTransactionsShowsJustTheBalanceWhichIsZero
	| account reportDescription|
	
	account := ReceptiveAccount new.
	reportDescription := account accountSummary.
	self assert: reportDescription size = 1.
	self assertLastLineOfReport: reportDescription DescribesBalanceOfAccount: account.! !

!ReportTest methodsFor: 'tests' stamp: 'db 10/27/2019 15:31:12'!
test02ReportAccountSummaryForAReceptiveAccountWithOneDepositShowsThatDeposit
	| account reportDescription |
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	reportDescription := account accountSummary.
	self assert: (reportDescription size = 2).
	self assertLastLineOfReport: reportDescription DescribesBalanceOfAccount: account.
	self assert: (reportDescription at: 1) = ('Depósito por 100.').! !

!ReportTest methodsFor: 'tests' stamp: 'db 10/27/2019 16:59:56'!
test03ReportOfPortfolioWithOneAccountIsEqualAsTheReportOfThatAccount
	| account1 portfolio reportDescriptionOfAccount reportDescriptionOfPortfolio |
	
	account1 := ReceptiveAccount new.
	
	portfolio := (Portfolio new)add: account1.
	
	Deposit register: 100 on: account1.
	Withdraw register: 200 on: account1.
	
	reportDescriptionOfAccount := account1 accountSummary.
	reportDescriptionOfPortfolio := portfolio accountSummary.
	
	self assertPortfolioReport: reportDescriptionOfPortfolio  isEqualToListOfReports: (Array with: reportDescriptionOfAccount) .! !

!ReportTest methodsFor: 'tests' stamp: 'db 10/27/2019 15:46:05'!
test04ReportOfPortfolioWithOneAccountIsEqualAsReportOfThatAccount
	| account1 portfolio reportDescriptionAccount reportDescriptionPortfolio |
	
	account1 := ReceptiveAccount new.

	portfolio := (Portfolio new) add: account1.		
	
	Deposit register: 100 on: account1.
	Withdraw register: 200 on: account1.
	
	reportDescriptionAccount := account1 accountSummary.
	reportDescriptionPortfolio := portfolio accountSummary.
	self assert: reportDescriptionPortfolio size = 1.
	self assertReport: (reportDescriptionPortfolio at: 1) isEqualTo: reportDescriptionAccount .! !

!ReportTest methodsFor: 'tests' stamp: 'db 10/27/2019 15:42:41'!
test05ReportOfAccountSummaryOfAccountWithOneDepositAndOneWithdrawAndNoTransactionsShowsTheDepositAndWithdrawAndBalance
	| account1 reportDescription |
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Withdraw register: 200 on: account1.
	
	reportDescription := account1 accountSummary.
	
	self assert: (reportDescription size = 3).
	
	self assertLastLineOfReport: reportDescription DescribesBalanceOfAccount: account1.
	
	self assert: (reportDescription at: 1) = ('Depósito por 100.').
	self assert: (reportDescription at: 2) = ('Extracción por 200.').! !

!ReportTest methodsFor: 'tests' stamp: 'db 10/27/2019 16:03:14'!
test06ReportOfAccountWithTransferInShowsTheTransferAndBalanceButNoOtherTransactions
	| account1 account2 transfer reportDescriptionAC1 reportDescriptionAC2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account2.
	transfer := Transfer of: 50 from: account2 to: account1.
	
	reportDescriptionAC1 := account1 accountSummary.

	reportDescriptionAC2 := account2 accountSummary.
		
	self assert: (reportDescriptionAC1 size = 2).
	
	self assertLastLineOfReport: reportDescriptionAC1 DescribesBalanceOfAccount: account1.
	
	self assert: (reportDescriptionAC1 at: 1) = ('Entrada por transferencia de 50.').
	
	
	self assert: (reportDescriptionAC2 size = 3).
	
	self assertLastLineOfReport: reportDescriptionAC2 DescribesBalanceOfAccount: account2.
	
	self assert: reportDescriptionAC2 includes: 'Salida por transferencia de 50.'.! !

!ReportTest methodsFor: 'tests' stamp: 'db 10/27/2019 16:14:50'!
test08ReportOfPortfolioWithTwoAccountsIsEqualToReportOfBothAccounts
	| account1 account2 portfolio reportDescriptionAC1 reportDescriptionAC2 reportDescriptionPortfolio |
	
	account1 := ReceptiveAccount new.

	account2 := ReceptiveAccount new.		
	
	Deposit register: 100 on: account1.
	Withdraw register: 200 on: account1.
	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.
	
	reportDescriptionAC1 := account1 accountSummary.
	reportDescriptionAC2 := account2 accountSummary.
	reportDescriptionPortfolio := portfolio accountSummary.
	
	self assertPortfolioReport: reportDescriptionPortfolio isEqualToListOfReports: (Array with: reportDescriptionAC1 with: reportDescriptionAC2 ).
	! !


!ReportTest methodsFor: 'assertions' stamp: 'db 10/27/2019 15:23:35'!
assertLastLineOfReport: aReportDescription DescribesBalanceOfAccount: anAccount
	| tam |
	tam := aReportDescription size.
	
	self assert: (aReportDescription at: tam) = ('Balance = ', ((anAccount balance) asString) , '.').! !

!ReportTest methodsFor: 'assertions' stamp: 'db 10/27/2019 17:01:22'!
assertPortfolioReport: portfolioReport isEqualToListOfReports: listOfReports
	| position |
	self assert: (listOfReports size) = portfolioReport size.
	
	listOfReports allSatisfy: [:report  | position := (portfolioReport indexOf: report ifAbsent:[^false]). self assertReport: report isEqualTo: (portfolioReport at: position)].
	^true.! !

!ReportTest methodsFor: 'assertions' stamp: 'db 10/27/2019 17:01:32'!
assertReport: aReport isEqualTo: anotherReport.

	self assert: (aReport size) = (anotherReport size).
	
	
	(aReport allSatisfy: [:desc | anotherReport includes: desc]) ifFalse:[^false.].
	^true! !

!ReportTest methodsFor: 'assertions' stamp: 'db 10/27/2019 16:10:31'!
assertReport: aReport isEqualToListOfReports: listOfReports
	| acum |
	acum := 0.
	listOfReports allSatisfy: [:report  | acum := acum + report size. (report allSatisfy: [:reportLineDescrip | aReport includes: reportLineDescrip ]).].
	self assert: (aReport size) = acum.! !


!classDefinition: #SpecialAccountSummaryTest category: #'Portfolio-Solucion'!
TestCase subclass: #SpecialAccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialAccountSummaryTest methodsFor: 'tests' stamp: 'db 10/27/2019 22:26:15'!
test01SpecialAccountSummaryOfEmptyPortfolioHasOnlyOneElement

	|aSpecialSummay aPortfolio|
	
	aPortfolio := Portfolio named: 'Portfolio 1'.
	
	aSpecialSummay := SpecialAccountSummary new initializeWith: aPortfolio.
	
	self assert: aSpecialSummay first equals: 'Portfolio 1'.! !

!SpecialAccountSummaryTest methodsFor: 'tests' stamp: 'db 10/27/2019 22:45:58'!
test02PortfolioWithOnlyPortfolios

	|aSpecialSummary aPortfolioRoot portfolio2 portfolio3 |
	
	portfolio3 := Portfolio named: 'Portfolio 3'.	
	portfolio2 := Portfolio named: 'Portfolio 2' with: portfolio3.
	aPortfolioRoot := Portfolio named: 'Portfolio raiz' with:portfolio2.
	
	aSpecialSummary := SpecialAccountSummary new initializeWith: aPortfolioRoot .
	
	self assert: aSpecialSummary size equals:3.
	self assert: aSpecialSummary first equals: 'Portfolio raiz'.
	self assert: aSpecialSummary  second equals: '    ', 'Portfolio 2'.
	self assert: aSpecialSummary third equals: '    ' , '    ' , 'Portfolio 3'.
	
	
	
	! !

!SpecialAccountSummaryTest methodsFor: 'tests' stamp: 'db 10/27/2019 23:00:50'!
test03ExampleOfExerciseBonusTrackRunsAsExpected

	|johnsAccount angiesAccount childrenPortfolio myAccount familyPortfolio aSpecialAccountSummary descriptions| 
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	
	aSpecialAccountSummary := SpecialAccountSummary new initializeWith: familyPortfolio .
	descriptions := OrderedCollection new.
	descriptions add: 'Portfolio de la familia'.
	descriptions add:'    ', 'Cuenta Mia'. 
	descriptions add: '    ' , '    ' , 'Balance = 0.'.
	descriptions add: '    ' , 'Portfolio de hijos'.
	descriptions add:  '    ', '    ' , 'Cuenta de Juan'.
	descriptions add:'    ', '    ', '    ', 'Balance = 0.'.
	descriptions add: '    ' , '    ' , 'Cuenta de Angeles'.
	descriptions add: '    ' , '    ', '    ' ,'Balance = 0.'.
	
	self assert: (descriptions allSatisfy: [:aDescription | aSpecialAccountSummary includes: aDescription ]).
! !


!classDefinition: #TransferNetTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 17:34:05'!
test01TransferNetOfAccountWithoutTransactionIsZero
	|account transfernetValue|
	account := ReceptiveAccount new.
	transfernetValue := TransferNet initializeWithAccount: account .
	self assert: transfernetValue = 0.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 17:34:55'!
test02TransferNetOfAccountWithDepositAndWithdrawButNoTransactionIsZero
	|account transfernetValue|
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 120 on: account.
	transfernetValue := TransferNet initializeWithAccount: account .
	self assert: transfernetValue = 0.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 17:48:15'!
test03TransferNetOfAccountIsTheSumOfTheTransfers

	|account1 account2 transfernetValue|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 200 on:account1.
	Deposit register: 300 on: account2.
	Transfer of: 50 from: account1 to: account2.
	Transfer of: 150 from: account2 to: account1.
	Transfer of: 50 from: account1 to: account2.
	transfernetValue := 0.
	transfernetValue := TransferNet initializeWithAccount: account1 .
	
	self assert: transfernetValue = 50.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 20:47:56'!
test04TransferNetOfPortfolioWithTwoAccountIsTheSumOfTheTransfersOfThem

	|account1 account2  transfernetValueAC1 transfernetValueAC2 transfernetValuePortfolio portfolio|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on:account1.
	Deposit register: 300 on: account2.
	portfolio := Portfolio new.
	
	portfolio add: account1.
	portfolio add: account2.
	
	Transfer of: 50 from: account1 to: account2.
	Transfer of: 150 from: account2 to: account1.
	Transfer of: 50 from: account1 to: account2.
	
	transfernetValueAC1 := TransferNet initializeWithAccount: account1 .
	
	transfernetValueAC2 := TransferNet initializeWithAccount: account2.
	
	transfernetValuePortfolio := TransferNet initializeWithAccount: portfolio.	
	
	self assert: (transfernetValueAC1 + transfernetValueAC2) = transfernetValuePortfolio .! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 20:54:54'!
test05TransferNetOfPortfolioWithTwoAccountWithNoTransfersIsZero

	|account1 account2  transfernetValueAC1 transfernetValueAC2 transfernetValuePortfolio portfolio|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	portfolio add: account1.
	portfolio add: account2.
	
	transfernetValueAC1 := TransferNet initializeWithAccount: account1 .
	
	transfernetValueAC2 := TransferNet initializeWithAccount: account2.
	
	transfernetValuePortfolio := TransferNet initializeWithAccount: portfolio.	
	
	self assert: (transfernetValueAC1 + transfernetValueAC2) = transfernetValuePortfolio .! !


!classDefinition: #TransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'test' stamp: 'g j 10/21/2019 20:48:38'!
test01TransferFromAnAccountToAnotherModifiesBothBalances

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Deposit register: 300 on: account2. 

	Transfer of: 75 from: account1 to: account2.
	
	self assert: 125 equals: account1 balance.
	self assert: 375 equals: account2 balance.	! !

!TransferTest methodsFor: 'test' stamp: 'g j 10/21/2019 20:55:38'!
test02TransferFromAnAccountToAnotherRegisterInBothAccounts

	| account1 account2 transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Deposit register: 300 on: account2. 

	transfer := Transfer of: 75 from: account1 to: account2.
	
	account1 hasRegistered: transfer out.
	account2 hasRegistered: transfer in.
		! !

!TransferTest methodsFor: 'test' stamp: 'g j 10/21/2019 20:57:17'!
test03TransferFromAnAccountToAnotherInTheSamePortfolioDoesNotAffectTheBalance

	| account1 account2 transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Deposit register: 300 on: account2. 

	transfer := Transfer of: 75 from: account1 to: account2.
	
	account1 hasRegistered: transfer out.
	account2 hasRegistered: transfer in.
		! !

!TransferTest methodsFor: 'test' stamp: 'db 10/26/2019 22:17:00'!
test04TransferFromPortfolioIsInvalid


	| account1 account2 portfolio transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Withdraw register: 300 on: account2. 
	portfolio := Portfolio with: account1.
	
	self should: [ transfer := Transfer of: 75 from: portfolio to: account2.]
		raise: Error
			withMessageText: Transfer ErrorPortfolioDoesNotSupportTransfer .
	
	! !

!TransferTest methodsFor: 'test' stamp: 'db 10/27/2019 12:40:36'!
test05TransferToPortfolioIsInvalid


	| account1 account2 portfolio transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Withdraw register: 300 on: account2. 
	portfolio := Portfolio with: account1.
	
	self should: [ transfer := Transfer of: 75 from: account2 to: portfolio.]
		raise: Error
			withMessageText: Transfer ErrorPortfolioDoesNotSupportTransfer .
	
	! !

!TransferTest methodsFor: 'test' stamp: 'db 10/27/2019 12:45:55'!
test06TransferValueCantBeZero


	| account1 account2 transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self should: [ transfer := Transfer of: 0 from: account1 to: account2.]
		raise: Error
			withMessageText: Transfer ErrorTransferValueMustBeGreaterThanZero .
	
	! !

!TransferTest methodsFor: 'test' stamp: 'db 10/27/2019 12:47:47'!
test07TransferValueMustBeGreaterThanZero


	| account1 account2 transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self should: [ transfer := Transfer of: -1 from: account1 to: account2.]
		raise: Error
			withMessageText: Transfer ErrorTransferValueMustBeGreaterThanZero .
	
	! !

!TransferTest methodsFor: 'test' stamp: 'db 10/27/2019 15:59:37'!
test08TransferValueMustBeGreaterThanBalanceOfTheAccountWichIsGonnaTransfer


	| account1 account2 portfolio transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Withdraw register: 300 on: account2. 
	
	self should: [ transfer := Transfer of: 301 from: account2 to: account1.]
		raise: Error
			withMessageText: Transfer ErrorAccountCantAffordThatTransfer .
	
	! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'Reports' stamp: 'db 10/27/2019 13:01:21'!
accountSummary

	^self subclassResponsibility .! !

!Account methodsFor: 'Reports' stamp: 'db 10/27/2019 22:27:27'!
apply: aCollaborator
	^self subclassResponsibility ! !

!Account methodsFor: 'Reports' stamp: 'db 10/27/2019 20:26:39'!
generateTransferNetWith: aReport
	^self subclassResponsibility .! !


!Account methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 21:24:34'!
name
	^name! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'db 10/20/2019 01:10:21'!
countOfAccounts
	^ accounts size.! !


!Portfolio methodsFor: 'accessing' stamp: 'db 10/27/2019 22:18:39'!
accounts 
^accounts ! !

!Portfolio methodsFor: 'accessing' stamp: 'db 10/20/2019 10:45:18'!
addAccount: anAccountToAdd 
	accounts add: anAccountToAdd! !

!Portfolio methodsFor: 'accessing' stamp: 'db 10/27/2019 17:10:29'!
addPortfolio: aPortfolio 
	
	accounts add: aPortfolio! !

!Portfolio methodsFor: 'accessing' stamp: 'db 10/20/2019 11:45:44'!
portfolios
	^portfolios .! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'db 10/27/2019 21:18:30'!
named: aName
	name := aName.
	^self initialize.! !


!Portfolio methodsFor: 'operations' stamp: 'TF 5/27/2019 15:24:40'!
addPortfolioThatManages: aPortfolio
	portfoliosThatManageMe add: aPortfolio .! !


!Portfolio methodsFor: 'operations - private' stamp: 'TF 5/27/2019 15:26:01'!
accountsOrPortfoliosManagedByAnyoneThatManagesMe
	| allAccountsOrPortfoliosManagedByAnyoneThatManagesMe |
	
	allAccountsOrPortfoliosManagedByAnyoneThatManagesMe := Set new .
	
	self portfoliosThatManageMe do: 
		[:aPortfolio | allAccountsOrPortfoliosManagedByAnyoneThatManagesMe addAll: aPortfolio managedAccountsOrPortfolios.].
	
	^allAccountsOrPortfoliosManagedByAnyoneThatManagesMe .
	
	! !

!Portfolio methodsFor: 'operations - private' stamp: 'TF 5/27/2019 15:19:05'!
managedAccountsOrPortfolios
	| allManagedAccountsOrPortfolios |
	
	allManagedAccountsOrPortfolios := Set with: self.
	
	managedPortfoliosAndAccounts do: 
		[:aPortfolioOrAccount | allManagedAccountsOrPortfolios addAll: aPortfolioOrAccount managedAccountsOrPortfolios.].
	
	^allManagedAccountsOrPortfolios .
	
	! !

!Portfolio methodsFor: 'operations - private' stamp: 'TF 5/27/2019 15:25:33'!
portfoliosThatManageMe
	| allPortfoliosThatManageMe |
	
	allPortfoliosThatManageMe := Set with: self .
	
	portfoliosThatManageMe do: 
		[:aPortfolio | allPortfoliosThatManageMe addAll: aPortfolio portfoliosThatManageMe.].
	
	^allPortfoliosThatManageMe .
	
	! !


!Portfolio methodsFor: 'assertions' stamp: 'TF 5/27/2019 15:23:55'!
assertNoDuplicateInformationByAdding: anAccountOrPortfolio

	^(self accountsOrPortfoliosManagedByAnyoneThatManagesMe 
		intersection: 
			(anAccountOrPortfolio managedAccountsOrPortfolios )) 
				ifNotEmpty: [^self error: self class CannotHaveElementRepeated .].
	
	! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'db 10/27/2019 15:46:37'!
accountSummary
	| reports |
	reports := OrderedCollection new.
	accounts do: [:account | reports add: (AccountSummary initializeWithAccount: account)].
	^reports! !

!Portfolio methodsFor: 'report' stamp: 'db 10/27/2019 22:28:04'!
apply: aCollaborator
	^aCollaborator generateForPortfolio: self.! !

!Portfolio methodsFor: 'report' stamp: 'db 10/27/2019 20:54:11'!
generateTransferNetWith: aReport
	| transactionsOfAllAccount |
	transactionsOfAllAccount := OrderedCollection new.
	accounts do:[:account | (account transactions) do: [:transaction | transactionsOfAllAccount add: transaction].].
	^aReport generateWith: transactionsOfAllAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TF 5/23/2019 21:37:32'!
CannotHaveElementRepeated
	^'The element is already in the portfolio.'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 21:26:50'!
named: aName
	^self new named: aName.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 22:44:58'!
named: aName with: anAccount
	|aPortfolio|
	aPortfolio := self new named: aName.
	aPortfolio add: anAccount .
	
	^aPortfolio.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 22:45:17'!
named: aName with: anAccount with: anotherAccount
	|aPortfolio|
	aPortfolio := self new named: aName.
	aPortfolio add: anAccount .
	aPortfolio add: anotherAccount .
	^aPortfolio.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'db 10/27/2019 21:17:25'!
named: aName
	name :=aName.
	^self initialize.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'portfolio operations - private' stamp: 'TF 5/27/2019 15:08:52'!
managedAccountsOrPortfolios
	^Set with: self.! !


!ReceptiveAccount methodsFor: 'portfolio operations' stamp: 'TF 5/27/2019 15:24:52'!
addPortfolioThatManages: aPortfolio! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'db 10/27/2019 13:27:03'!
accountSummary
	
	^AccountSummary initializeWithAccount: self.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'db 10/27/2019 22:28:15'!
apply: aCollaborator
	^aCollaborator generateForReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'db 10/27/2019 20:28:01'!
generateTransferNetWith: aReport
	^aReport generateWith: transactions.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'db 10/27/2019 15:16:54'!
getDescriptionOfTransactionsAsStringsToReport: aReport
	|descriptions|
	descriptions := ''.
	transactions do: [:transaction | aReport addDescriptionOfTransaction: transaction getDescription].
	aReport addDescriptionOfTransaction: 'Balance = ', (self balance) asString , '.'.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 21:16:25'!
named: aName
	^self new named: aName! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'TF 5/23/2019 20:32:21'!
netValue 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'db 10/20/2019 10:50:16'!
= aTransactionToCompareWith

^self subclassResponsibility .! !

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 17:25:24'!
apply: aTransferNetReport

	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 15:17:14'!
getDescription
	^self subclassResponsibility .! !

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 13:10:39'!
getTransaction
	 ^self subclassResponsibility .! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'db 10/27/2019 16:56:19'!
netValue
	^value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'comparing' stamp: 'db 10/20/2019 10:50:40'!
= aTransactionToCompareWith

^(self value) = aTransactionToCompareWith value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'db 10/27/2019 17:28:31'!
apply: aTransferNetReport
	^aTransferNetReport deposit: self.! !

!Deposit methodsFor: 'report' stamp: 'db 10/27/2019 15:26:30'!
getDescription 
	^'Depósito por ', value asString , '.'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferIn category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferIn
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferIn methodsFor: 'accessing' stamp: 'g j 10/21/2019 20:43:57'!
affectBalance: aBalance
^aBalance + transfer value.! !

!TransferIn methodsFor: 'accessing' stamp: 'g j 10/21/2019 20:42:15'!
initializeAssociatedWith: aTransfer 
	transfer := aTransfer.! !


!TransferIn methodsFor: 'value' stamp: 'db 10/26/2019 22:01:07'!
transfer
^transfer! !

!TransferIn methodsFor: 'value' stamp: 'db 10/26/2019 21:57:00'!
value
	^transfer value! !


!TransferIn methodsFor: 'comparing' stamp: 'db 10/26/2019 22:00:44'!
= aTransactionToCompareWith

^((transfer = aTransactionToCompareWith transfer) & (self class = aTransactionToCompareWith class))! !


!TransferIn methodsFor: 'report' stamp: 'db 10/27/2019 17:28:42'!
apply: aTransferNetReport
	^aTransferNetReport transferIn: self.! !

!TransferIn methodsFor: 'report' stamp: 'db 10/27/2019 15:27:30'!
getDescription 
	^'Entrada por transferencia de ', (transfer value) asString , '.'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferIn class' category: #'Portfolio-Solucion'!
TransferIn class
	instanceVariableNames: ''!

!TransferIn class methodsFor: 'instance creation' stamp: 'g j 10/21/2019 20:45:09'!
associatedWith: aTransfer 
	^self new initializeAssociatedWith: aTransfer! !


!classDefinition: #TransferOut category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferOut
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferOut methodsFor: 'accessing' stamp: 'g j 10/21/2019 20:44:18'!
affectBalance: aBalance
^aBalance - transfer value.! !

!TransferOut methodsFor: 'accessing' stamp: 'g j 10/21/2019 20:43:10'!
initializeAssociatedWith: aTransfer 
	transfer := aTransfer.! !


!TransferOut methodsFor: 'value' stamp: 'db 10/26/2019 22:01:01'!
transfer 
^transfer! !

!TransferOut methodsFor: 'value' stamp: 'db 10/26/2019 21:57:09'!
value
	^transfer value! !


!TransferOut methodsFor: 'comparing' stamp: 'db 10/26/2019 22:01:21'!
= aTransactionToCompareWith

^((transfer = aTransactionToCompareWith transfer) & (self class = aTransactionToCompareWith class))! !


!TransferOut methodsFor: 'report' stamp: 'db 10/27/2019 17:28:53'!
apply: aTransferNetReport
	^aTransferNetReport transferOut: self.! !

!TransferOut methodsFor: 'report' stamp: 'db 10/27/2019 15:27:20'!
getDescription 
	^'Salida por transferencia de ', (transfer value) asString , '.'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferOut class' category: #'Portfolio-Solucion'!
TransferOut class
	instanceVariableNames: ''!

!TransferOut class methodsFor: 'accessing' stamp: 'g j 10/21/2019 20:42:53'!
associatedWith: aTransfer 
	^self new initializeAssociatedWith: aTransfer! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'db 10/27/2019 16:56:26'!
netValue
	^value negated.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'comparing' stamp: 'db 10/20/2019 10:50:50'!
= aTransactionToCompareWith
^(self value) = aTransactionToCompareWith value.
! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'db 10/27/2019 17:29:02'!
apply: aTransferNetReport
	^aTransferNetReport withdraw: self.! !

!Withdraw methodsFor: 'report' stamp: 'db 10/27/2019 15:26:24'!
getDescription 
	^'Extracción por ', value asString , '.'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'descriptions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 15:12:44'!
addDescriptionOfTransaction: aTransactionDescription
	descriptions add: aTransactionDescription .! !


!classDefinition: #AccountSummary category: #'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'db 10/27/2019 21:05:42'!
initializeWithAccount: anAccount
	descriptions := OrderedCollection new.
	anAccount getDescriptionOfTransactionsAsStringsToReport: self.
	^descriptions ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 13:24:35'!
initializeWithAccount: aReceptiveAccount
	^self new initializeWithAccount: aReceptiveAccount ! !


!classDefinition: #SpecialAccountSummary category: #'Portfolio-Solucion'!
Report subclass: #SpecialAccountSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialAccountSummary methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 22:18:20'!
generateForPortfolio: aPortfolio
	|portfolioReport|
	
	portfolioReport  := OrderedCollection new.
	
	aPortfolio accounts do: [:anAccount | portfolioReport  addAll: (anAccount  apply: self)].
	
	portfolioReport  := portfolioReport  collect: [:lineReport | '    ', lineReport ].
	
	portfolioReport  addFirst: aPortfolio name.
	
	^portfolioReport.! !

!SpecialAccountSummary methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 22:33:36'!
generateForReceptiveAccount: aReceptiveAccount

	|accountSummaryReport newAccountSummaryReport |
	
	accountSummaryReport := aReceptiveAccount accountSummary.
	
	newAccountSummaryReport  := accountSummaryReport collect: [:lineReport | '    ', lineReport].
	
	newAccountSummaryReport  addFirst: aReceptiveAccount  name.
	
	^newAccountSummaryReport ! !

!SpecialAccountSummary methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 22:24:34'!
initializeWith: anAccount
	account := anAccount.
	^account apply: self.! !


!classDefinition: #TransferNet category: #'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'db 10/27/2019 20:28:59'!
initializeWithAccount: anAccount
	^anAccount generateTransferNetWith: self.
	
	! !


!TransferNet methodsFor: 'values' stamp: 'db 10/27/2019 17:36:02'!
deposit: aDeposit
	^0.! !

!TransferNet methodsFor: 'values' stamp: 'db 10/27/2019 17:30:08'!
transferIn: aTransferIn
	^aTransferIn transfer value.! !

!TransferNet methodsFor: 'values' stamp: 'db 10/27/2019 17:49:25'!
transferOut: aTransferOut
	^aTransferOut transfer value negated.! !

!TransferNet methodsFor: 'values' stamp: 'db 10/27/2019 17:35:54'!
withdraw: aWithdraw
	^0.! !


!TransferNet methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 20:29:21'!
generateWith: transactions
	^transactions sum: [:aTransaction | aTransaction apply: self] ifEmpty:[0].	

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 16:48:09'!
initializeWithAccount: anAccount
	^self new initializeWithAccount: anAccount! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value transferIn transferOut'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'db 10/27/2019 15:57:39'!
initializeOf: aValue from: senderAccount to: receiverAccount 
	self assertSenderAccountIsAnAccount: senderAccount andReceiverAccountIsAnAccount: receiverAccount.
	self assertValueIsGreaterThanZero: aValue.
	self assertSenderAccount: senderAccount CanDealWithValue: aValue.
	value:= aValue.
	transferIn:= TransferIn associatedWith: self.
	transferOut:= TransferOut associatedWith: self.
	senderAccount register: transferOut.
	receiverAccount register: transferIn.! !


!Transfer methodsFor: 'value' stamp: 'g j 10/21/2019 20:44:29'!
value
^value.! !


!Transfer methodsFor: 'assertions' stamp: 'db 10/27/2019 15:59:14'!
assertSenderAccount: senderAccount CanDealWithValue: aValue.

	(senderAccount balance >= aValue) ifFalse:[^self error: Transfer ErrorAccountCantAffordThatTransfer ] ! !

!Transfer methodsFor: 'assertions' stamp: 'db 10/27/2019 12:44:19'!
assertSenderAccountIsAnAccount: senderAccount andReceiverAccountIsAnAccount: receiverAccount.
	((senderAccount class = ReceptiveAccount ) & (receiverAccount  class = ReceptiveAccount )) ifFalse: [^self error: Transfer ErrorPortfolioDoesNotSupportTransfer ].! !

!Transfer methodsFor: 'assertions' stamp: 'db 10/27/2019 12:48:30'!
assertValueIsGreaterThanZero: aValue

	aValue > 0 ifFalse: [^self error: Transfer ErrorTransferValueMustBeGreaterThanZero ].! !


!Transfer methodsFor: 'accessing' stamp: 'g j 10/21/2019 20:56:10'!
in
	^transferIn.! !

!Transfer methodsFor: 'accessing' stamp: 'g j 10/21/2019 20:55:55'!
out
	^transferOut ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'accessing' stamp: 'g j 10/21/2019 20:38:40'!
of: aValue from: senderAccount to: receiverAccount 
	
	^self new initializeOf: aValue from: senderAccount to: receiverAccount 
! !


!Transfer class methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 15:55:56'!
ErrorAccountCantAffordThatTransfer
^'La cuenta no tiene fondos suficientes'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'db 10/26/2019 22:16:47'!
ErrorPortfolioDoesNotSupportTransfer
^'Portfolio does not support transfers'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'db 10/27/2019 12:46:14'!
ErrorTransferValueMustBeGreaterThanZero
^'Transfer value must be grather than zero!!'.! !
