'From Cuis 5.0 [latest update: #4689] on 4 August 2021 at 4:01:59 pm'!
'Description '!
!provides: 'QuickNote' 1 6!
!requires: 'Cuis-Base' 50 4689 nil!
!requires: 'StyledText' 1 52 nil!
SystemOrganization addCategory: 'QuickNote'!


!classDefinition: #QuickNote category: 'QuickNote'!
Object subclass: #QuickNote
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuickNote'!
!classDefinition: 'QuickNote class' category: 'QuickNote'!
QuickNote class
	instanceVariableNames: ''!


!QuickNote class methodsFor: 'as yet unclassified' stamp: 'NM 8/4/2021 14:28:33'!
open
	"Open a new QuickNote"
	StyledTextEditor openQuickNote .
! !

!StyledTextModel class methodsFor: '*QuickNote' stamp: 'NM 8/4/2021 11:19:11'!
newQuickNote
	^self styleSet: StyleSet quickNote! !

!StyleSet methodsFor: '*QuickNote' stamp: 'NM 8/4/2021 11:11:23'!
createQuickNoteCharacterStyleSet
	"Build one of the many possible sets of Styles. Maybe other methods like this will be added."
	| greenItalic greenBig redBold nullStyle completedText basePointSize familyName |

	familyName _ FontFamily defaultFamilyName.
	basePointSize _ FontFamily defaultPointSize.

	greenItalic _ self characterStyleNamedOrNew: 'Green Italic'.
	greenItalic privateFamilyName: familyName pointSize: basePointSize emphasis: AbstractFont italicCode color: Color green.

	greenBig _ self characterStyleNamedOrNew: 'Green Big'.
	greenBig privateFamilyName: familyName pointSize: basePointSize * 14//10 emphasis: 0 color: Color green.

	redBold _ self characterStyleNamedOrNew: 'Red Bold'.
	redBold privateFamilyName: familyName pointSize: basePointSize emphasis: AbstractFont boldCode color: Color red.

	completedText _ self characterStyleNamedOrNew: 'Completed Text'.
	completedText privateFamilyName: familyName pointSize: basePointSize*12//10 emphasis: 0 color: Color green.

	nullStyle _ CharacterStyle nullStyle.

	characterStyles _ {
		{$u.	greenItalic}.
		{$i. 	greenBig}.
		{$o.	redBold}.
		{$p.	completedText}.
		{$n.	nullStyle}
	}.
	
	self triggerEvent: #stylesChanged! !

!StyleSet methodsFor: '*QuickNote' stamp: 'NM 8/4/2021 15:57:09'!
createQuickNoteParagraphStyleSet
	"Build one of the many possible sets of Styles. Maybe other methods like this will be added."
	| smalltalkCode typeWriter  s familyName  
	  s2 monoFamilyName  |

	familyName _ FontFamily defaultFamilyName.
	s _ FontFamily defaultPointSize.


	smalltalkCode _ self paragraphStyleNamedOrNew: 'Smalltalk code'.
	smalltalkCode privateFamilyName: familyName pointSize: s emphasis: 0 color: nil
		alignment: CharacterScanner leftFlushCode firstIndent: s restIndent: s rightIndent: s
		spaceBefore: 0 spaceAfter: 0;
			doShout.

	monoFamilyName  _ FontFamily defaultFamilyName: 'DejaVu Sans Mono'.
	s2 _ FontFamily defaultPointSize .
        typeWriter _ self paragraphStyleNamedOrNew: 'Typewriter'.
	typeWriter privateFamilyName: monoFamilyName pointSize: s2 emphasis: 0 color: nil
		alignment: CharacterScanner leftFlushCode firstIndent: s restIndent: s rightIndent: s
		spaceBefore: 0 spaceAfter: 0.


	paragraphStyles _ {
		{$0.	typeWriter}.
		{$7.	smalltalkCode}.
	}.
	
	self triggerEvent: #stylesChanged! !

!StyleSet methodsFor: '*QuickNote' stamp: 'NM 8/4/2021 15:45:05'!
defaultQuickNoteStyle
	"Usually we include a 'Normal' style. If not, answer some style anyway.
	We might refine this!!"
	"^(self paragraphStyleNamed: 'Normal') ifNil: [ self paragraphStyleAt: 1 ] "
	^(self paragraphStyleNamed: 'Typewriter') ifNil: [ self paragraphStyleAt: 1 ]
	! !

!StyleSet class methodsFor: '*QuickNote' stamp: 'NM 8/4/2021 11:12:55'!
quickNote
	^self new
		createQuickNoteParagraphStyleSet;
		createQuickNoteCharacterStyleSet! !

!StyledTextEditor class methodsFor: '*QuickNote' stamp: 'NM 8/4/2021 14:30:46'!
openQuickNote
	"Open a new instance on an empty file"
"
	StyledTextEditor open.
"
	| model |
	"we need font 'DejaVu Sans Mono', if not present load ALL fonts.
	This is an overkill and should be more specific. TOFIX. TODO.
	"
	(FontFamily familyNames includes: 'DejaVu Sans Mono') ifFalse: [ 
		FontFamily readAdditionalTrueTypeFonts . 
		"necessary hack"
		self runningWorld doOneCycle.
		].
	model _ StyledTextModel newQuickNote.
	^SystemWindow editFancierStyledText: model label: 'QuickNote'! !
