!classDefinition: #I category: #'Numeros de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros de Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 20:38:35'!
* unNumeroDePeano
	^unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 19:55:54'!
+ unNumeroDePeano
	^unNumeroDePeano  next
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 19:30:15'!
- unNumeroDePeano
	^self ErrorAlRestarleAlUno

! !

!I class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 21:05:01'!
/ unNumeroDePeano
^I! !

!I class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 19:51:42'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 19:31:04'!
previous
	^self ErrorAlPedirPreviousDeUno! !

!I class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 20:46:51'!
restaAlReves: unNumeroDePeano
	^unNumeroDePeano previous! !


!I class methodsFor: 'nil' stamp: 'db 8/28/2019 19:30:49'!
ErrorAlPedirPreviousDeUno
^'Error: El I no tiene antecesor'! !

!I class methodsFor: 'nil' stamp: 'db 8/28/2019 19:30:07'!
ErrorAlRestarleAlUno
^'Error: No se le puede restarle al I'! !


!classDefinition: #II category: #'Numeros de Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros de Peano'!
II class
	instanceVariableNames: 'next'!

!II class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 20:38:21'!
* unNumeroDePeano 
^ (unNumeroDePeano + unNumeroDePeano)! !

!II class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 20:04:22'!
+ unNumeroDePeano
	^I + (I + unNumeroDePeano)! !

!II class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 20:34:07'!
- unNumeroDePeano
^unNumeroDePeano restaAlReves: self ! !

!II class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 21:07:03'!
/ unNumeroDePeano
^I! !

!II class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 22:50:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.! !

!II class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 20:56:44'!
next
	next ifNil:[
		next := self cloneNamed: (self name , 'I').
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 19:57:53'!
previous
^I! !

!II class methodsFor: 'as yet unclassified' stamp: 'db 8/27/2019 20:01:13'!
removeAllNext
	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 19:28:36'!
restaAlReves: unNumeroDePeano
^unNumeroDePeano previous - self previous! !


!classDefinition: #III category: #'Numeros de Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros de Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 22:38:22'!
* unNumeroDePeano 
^ (unNumeroDePeano + unNumeroDePeano)! !

!III class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 22:38:22'!
+ unNumeroDePeano
	^I + (I + unNumeroDePeano)! !

!III class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 22:38:22'!
- unNumeroDePeano
^unNumeroDePeano restaAlReves: self ! !

!III class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 22:38:22'!
/ unNumeroDePeano
^I! !

!III class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 22:50:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := nil.! !

!III class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 22:38:22'!
next
	next ifNil:[
		next := self cloneNamed: (self name , 'I').
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 22:50:20'!
previous
previous ifNil:[^II].
^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 22:38:22'!
removeAllNext
	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'db 8/28/2019 22:38:22'!
restaAlReves: unNumeroDePeano
^unNumeroDePeano previous - self previous! !

II initializeAfterFileIn!
III initializeAfterFileIn!