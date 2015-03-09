/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here.
	// For complete reference see:
	// http://docs.ckeditor.com/#!/api/CKEDITOR.config

	// The toolbar groups arrangement, optimized for a single toolbar row.
	config.toolbarGroups = [
		{ name: 'document',	   groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'undo',   groups: [ 'undo' ] },
		{ name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
		{ name: 'forms' },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
		{ name: 'links' },
		{ name: 'insert' },
		{ name: 'styles' },
		{ name: 'colors' },
		{ name: 'tools' },
		{ name: 'others' },
		//{ name: 'about' }
	];


    //config.toolbar = [
    //    //{ name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'Source'] },
    //    //{ name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] }
    //    // { name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ], items: [ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
    //    // { name: 'forms', items: [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] },
    //    //{ name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
    //    //{ name: 'insert', items: [ 'Image', 'Flash', 'Table', 'HorizontalRule', 'SpecialChar' ] },
    //    //{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
    //    //'/',
    //    //{ name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
    //    //{ name: 'colors', items: [ 'TextColor', 'BGColor' ] },
    //    //{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] }
    //];
    //
    //config.toolbar_mini = [
    //    //{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
    //    //{ name: 'styles', items: [ 'Font', 'FontSize' ] },
    //    //{ name: 'colors', items: [ 'TextColor', 'BGColor' ] },
    //    //{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
    //    //{ name: 'insert', items: [ 'Image', 'Table', 'HorizontalRule', 'SpecialChar' ] }
    //];



	// The default plugins included in the basic setup define some buttons that
	// are not needed in a basic editor. They are removed here.
	//config.removeButtons = 'Cut,Copy,Paste,Undo,Redo,Anchor,Underline,Strike,Subscript,Superscript';

	// Dialog windows are also simplified.
	config.removeDialogTabs = 'link:advanced;link:target';
    config.startupFocus = false;
};
//CKEDITOR.env.mobile = true;

CKEDITOR.on('dialogDefinition', function(ev) {
    // Take the dialog name and its definition from the event
    // data.
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;

    // Check if the definition is from the dialog we're
    // interested on (the "Link" dialog).
    if (dialogName == 'link') {
        // Get a reference to the "Link Info" tab.
        var infoTab = dialogDefinition.getContents('info');

        // Get a reference to the link type
        var linkOptions = infoTab.get('linkType');

        // set the array to your preference
        linkOptions['items'] = [['URL', 'url'], ['Anchor', 'anchor']];
    }
});

CKEDITOR.on('instanceReady', function(ev) {
    ev.editor.on('paste', function(evt) {
        evt.data.dataValue = evt.data.dataValue.replace(/&nbsp;/g,'');
        evt.data.dataValue = evt.data.dataValue.replace(/<p><\/p>/g,'');
    }, null, null, 9);
});