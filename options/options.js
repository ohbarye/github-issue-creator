
$(function() {
  var fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body'];
  var config = {};

  // load config from chrome local storage
  chrome.storage.local.get(fields, function(items) {
    fields.forEach(function(field) {
      $('#'+field).val(items[field]);
    });
  });

  // save
  $('#form').submit(function(e) {
    e.preventDefault();

    fields.forEach(function(field) {
      config[field] = $('#'+field).val();
    });

    // Update list of repos into local storage when submitting form
    chrome.storage.local.set(config, function() {
        alert('Configurations are saved successfully.');
    });
  });
});
