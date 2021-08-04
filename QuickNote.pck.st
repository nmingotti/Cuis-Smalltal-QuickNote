'From Cuis 5.0 [latest update: #4689] on 4 August 2021 at 2:35:18 pm'!
'Description '!
!provides: 'QuickNote' 1 5!
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

!StyleSet methodsFor: '*QuickNote' stamp: 'NM 8/4/2021 11:10:52'!
createQuickNoteParagraphStyleSet
	"Build one of the many possible sets of Styles. Maybe other methods like this will be added."
	| heading1 heading2 heading3 emphasized normal numbered alphabetic bulleted smalltalkCode typeWriter  s familyName  
	  s2 monoFamilyName  |

	familyName _ FontFamily defaultFamilyName.
	s _ FontFamily defaultPointSize.

	normal _ self paragraphStyleNamedOrNew: 'Normal'.
	normal privateFamilyName: familyName pointSize: s emphasis: 0 color: nil
		alignment: CharacterScanner justifiedCode firstIndent: s*3 restIndent: s rightIndent: s
		spaceBefore: s*8//10 spaceAfter: s*2//10.

	emphasized _ self paragraphStyleNamedOrNew: 'Emphasized'.
	emphasized privateFamilyName: familyName pointSize: s emphasis: AbstractFont boldCode color: nil
		alignment: CharacterScanner justifiedCode firstIndent: s*6 restIndent: s*6 rightIndent: s*6
		spaceBefore: s spaceAfter: s*2//10.

	heading1 _ self paragraphStyleNamedOrNew: 'Heading 1'.
	heading1 privateFamilyName: familyName pointSize: s*3 emphasis: 0 color: nil
		alignment: CharacterScanner centeredCode firstIndent: 0 restIndent: 0 rightIndent: 0
		spaceBefore: s*3 spaceAfter: s*2.

	heading2 _ self paragraphStyleNamedOrNew: 'Heading 2'.
	heading2 privateFamilyName: familyName pointSize: s*2 emphasis: AbstractFont boldCode color: nil
		alignment: CharacterScanner centeredCode firstIndent: 0 restIndent: 0 rightIndent: 0
		spaceBefore: s*2 spaceAfter: 2.

	heading3 _ self paragraphStyleNamedOrNew: 'Heading 3'.
	heading3 privateFamilyName: familyName pointSize: s*15//10 emphasis: AbstractFont italicCode color: nil
		alignment: CharacterScanner centeredCode firstIndent: 0 restIndent: 0 rightIndent: 0
		spaceBefore: s*15//10 spaceAfter: s//2.

	numbered _ self paragraphStyleNamedOrNew: 'Numbered List'.
	numbered privateFamilyName: familyName pointSize: s emphasis: 0 color: nil
		alignment: CharacterScanner justifiedCode firstIndent: s restIndent: s*5 rightIndent: s
		spaceBefore: s*8//10 spaceAfter: s*2//10;
			privateListBulletPattern: '%%%. '.

	alphabetic _ self paragraphStyleNamedOrNew: 'Alphabetic List'.
	alphabetic privateFamilyName: familyName pointSize: s emphasis: 0 color: nil
		alignment: CharacterScanner justifiedCode firstIndent: s restIndent: s*3 rightIndent: s
		spaceBefore: s*8//10 spaceAfter: s*2//10;
			privateListBulletPattern: 'z) '.

	bulleted _ self paragraphStyleNamedOrNew: 'Bulleted List'.
	bulleted privateFamilyName: familyName pointSize: s emphasis: 0 color: nil
		alignment: CharacterScanner justifiedCode firstIndent: s restIndent: s*3 rightIndent: s
		spaceBefore: s*8//10 spaceAfter: s*2//10;
			privateListBulletPattern: '° '.

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
		{$0.	normal}.
		{$e.	emphasized}.
		{$1.	heading1}.
		{$2.	heading2}.
		{$3.	heading3}.
		{$4.	numbered}.
		{$5.	alphabetic}.
		{$6.	bulleted}.
		{$7.	smalltalkCode}.
		{$8.	typeWriter}
	}.
	
	self triggerEvent: #stylesChanged! !

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
