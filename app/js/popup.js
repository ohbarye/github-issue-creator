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
    var fields;
    fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body', 'projects'];
    return chrome.storage.local.get(fields, function(config) {
      var ref, repositories;
      repositories = (ref = config.repositories) != null ? ref.split('\n') : void 0;
      if (repositories) {
        $.each(repositories, function(i, repo) {
          var href;
          href = "https://github.com/" + repo + "/issues/new";
          href += "?title=" + config.title + "&labels=" + config.labels + "&assignee=" + config.assignee + "&milestone=" + config.milestone + "&body=" + config.body + "&projects=" + config.projects;
          return $('#repositories').append("<a href='" + href + "' class='list-group-item'>" + repo + "</a>");
        });
      }
      return $('a').click(function(e) {
        var location;
        e.preventDefault();
        location = $(e.currentTarget).attr('href');
        return chrome.tabs.create({
          url: location
        });
      });
    });
  });

}).call(this);