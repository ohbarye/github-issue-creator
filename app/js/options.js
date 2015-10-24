(function() {
  $(function() {
    var config, fields;
    fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body'];
    config = {};
    chrome.storage.local.get(fields, function(items) {
      return fields.forEach(function(field) {
        var val;
        val = decodeURIComponent(items[field]);
        return $('#' + field).val(val);
      });
    });
    return $('#form').submit(function(e) {
      e.preventDefault();
      fields.forEach(function(field) {
        var inputValue;
        inputValue = $('#' + field).val();
        if (field !== 'repositories') {
          inputValue = encodeURIComponent(inputValue);
        }
        return config[field] = $.trim(inputValue);
      });
      return chrome.storage.local.set(config, function() {
        return alert('Configurations are saved successfully.');
      });
    });
  });

}).call(this);