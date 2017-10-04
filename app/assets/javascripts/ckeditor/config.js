CKEDITOR.editorConfig = function (config) {
 
  config.toolbar_mini = [
    ["Bold",  "Italic",  "Underline",  "Strike", "Font","FontSize", "-", "Line Height", "Subscript",  "Superscript", "Smiley", "JustifyRight", "JustifyCenter", "JustifyLeft", "JustifyBlock" ],
  ];
  config.toolbar = "mini";
  removePlugins ='elementspath';
  config.removePlugins = 'elementspath';
  config.toolbarCanCollapse = true;
  config.resize_enabled = true
  
}