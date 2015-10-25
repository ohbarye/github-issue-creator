(function() {
  var _gaq, ga, s;

  _gaq = _gaq || [];

  _gaq.push(['_setAccount', 'UA-58056432-3']);

  _gaq.push(['_trackPageview']);

  ga = document.createElement('script');

  ga.type = 'text/javascript';

  ga.async = true;

  ga.src = 'https://ssl.google-analytics.com/ga.js';

  s = document.getElementsByTagName('script')[0];

  s.parentNode.insertBefore(ga, s);

  $(function() {
    var config, fields, preview, sanitize, unsanitize;
    fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body'];
    config = {};
    chrome.storage.local.get(fields, function(items) {
      fields.forEach(function(field) {
        var val;
        val = decodeURIComponent(items[field]);
        return $('#' + field).val(val);
      });
      return preview();
    });
    $('#form').submit(function(e) {
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
        return $('#saved').removeClass('hide');
      });
    });
    $('#hide-message').click(function(e) {
      e.preventDefault();
      return $('#saved').addClass('hide');
    });
    $('#markdown-link').click(function(e) {
      var location;
      e.preventDefault();
      location = $(e.currentTarget).attr('href');
      return chrome.tabs.create({
        url: location
      });
    });
    $('#body').keyup(function() {
      return preview();
    });
    preview = function() {
      var md;
      marked.setOptions({
        langPrefix: ''
      });
      md = sanitize($('#body').val());
      $('#preview').html(marked(md));
      return $('#preview pre code').each(function(i, elm) {
        $(elm).text(unsanitize(elm.textContent));
        hljs.highlightBlock(elm, elm.className);
        return hljs.initHighlightingOnLoad();
      });
    };
    sanitize = function(html) {
      return $('<div />').text(html).html().replace(/&gt;/g, ">");
    };
    return unsanitize = function(html) {
      return $('<div />').html(html).text();
    };
  });

}).call(this);
