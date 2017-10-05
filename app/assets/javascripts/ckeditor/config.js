CKEDITOR.editorConfig = function (config) {
 
  config.toolbar_mini = [
    ["Bold",  "Italic",  "Underline",  "Strike", "Font","FontSize", "-", "Line Height","Indent","Outdent","Subscript",  "Superscript", "Smiley", "JustifyRight", "JustifyCenter", "JustifyLeft", "JustifyBlock" ],
  ];
  config.toolbar = "mini";
  removePlugins ='elementspath';
  config.removePlugins = 'elementspath';
  config.disableNativeSpellChecker = false;
  config.enterMode = CKEDITOR.ENTER_BR;
  config.toolbarCanCollapse = true;
  config.resize_enabled = true
  
}