Smalltalk current createPackage: 'Maglev-Vendor' properties: #{}!
Object subclass: #MaglevAjax
	instanceVariableNames: ''
	package: 'Maglev-Vendor'!

!MaglevAjax class methodsFor: 'not yet classified'!

ajax: aString data: data
	< var result = $.parseJSON($.ajax({url: aString, data: $.parseJSON(data._asJSONString()), async: false}).responseText);
	if (result.success === false) {
		self.error('Server call failed: ' + result.exception);
	}
	else {
		return result.result;
	} >
!

ajax: aString data: data withCallback: aBlock
	< $.ajax({url: aString, data: $.parseJSON(data._asJSONString()), async: true, complete: function(response) {
		var result = $.parseJSON(response.responseText);
		if (result.success === false) {
			self.error('Server call failed: ' + result.exception);
		} else {
			aBlock._value_(result.result);
		}
	}}); >
! !

Object subclass: #MaglevJsPlumb
	instanceVariableNames: ''
	package: 'Maglev-Vendor'!

MaglevJsPlumb class instanceVariableNames: 'sourceTarget defaults referenceConnection instanceOfConnection virtualClassConnection superclassConnection connection'!

!MaglevJsPlumb class methodsFor: 'accessing'!

connection
	^ connection
!

defaults
	^ defaults
!

instanceOfConnection
	^ instanceOfConnection
!

referenceConnection
	^ referenceConnection
!

sourceTarget
	^ sourceTarget
!

virtualClassConnection
	^ virtualClassConnection
! !

!MaglevJsPlumb class methodsFor: 'constants'!

constConnection
	^ Dictionary new
		at: #iv put: referenceConnection;
		at: #hashKey put: referenceConnection;
		at: #hashValue put: referenceConnection;
		at: #arrayElement put: referenceConnection;
		at: #class put: instanceOfConnection;
		at: #virtualClass put: virtualClassConnection;
		at: #superclass put: superclassConnection;
		yourself
! !

!MaglevJsPlumb class methodsFor: 'initializing'!

initialize
	self initializeConstants.
	self initializeJsPlumb.
!

initializeChromeFix
	< document.onselectstart = function() {
		return false;
	}; >
!

initializeConstants
	sourceTarget := self constSourceTarget.
	defaults := self constDefaults.
	referenceConnection := self constReferenceConnection.
	instanceOfConnection := self constInstanceOfConnection.
	virtualClassConnection := self constVirtualClassConnection.
	superclassConnection := self constSuperclassConnection.
	connection := self constConnection.
!

initializeJsPlumb
	window jsPlumb
		bind: 'ready'
		to: [
			self initializeChromeFix.
			window jsPlumb setRenderMode: jsPlumb SVG.
			window jsPlumb importDefaults: defaults].
! !

!MaglevJsPlumb class methodsFor: 'interactions'!

connectWindow: sourceWindow to: targetWindow as: cType with: caption
	|params type defParams sourceEl targetEl text|
	sourceWindow = targetWindow ifTrue: [^ self].
	type := self connection at: cType.
	sourceEl := sourceWindow container asJQuery.
	targetEl := targetWindow container asJQuery.
	caption
		ifNil: [text := '']
		ifNotNil: [text := caption asString].
	text = ''
		ifFalse: [text := '<span class="component object-ivname-box" style="white-space: nowrap;">', text, '</span>'].
	< params = $.extend(true, {}, type); 
	params.source = sourceEl;
	params.target = targetEl; 
	params.overlays[1][1].label = text; >.

	jsPlumb connect: params.
!

connectWindow: sourceWindow to: targetWindow with: parameters
	|params type defParams|
	sourceWindow = targetWindow ifTrue: [^ self].
	type := self connection at: (parameters at: #type).
	< params = $.extend(true, {}, defParams); >.
	params
		basicAt: 'source' put: sourceWindow container;
		basicAt: 'target' put: targetWindow container.

	jsPlumb connect: params.
!

deleteEndpointsFor: anObject
	|endpoints|
	endpoints := jsPlumb getEndpoints: anObject.
	endpoints ifNotNil: [endpoints do: [:endpoint | jsPlumb deleteEndpoint: endpoint]].
!

prepareObject: anObject
	jsPlumb draggable: anObject.
	jsPlumb makeSource: anObject a: sourceTarget.
	jsPlumb makeTarget: anObject a: sourceTarget.
! !

