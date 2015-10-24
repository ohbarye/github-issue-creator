$(function() {
  var fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body'];

  chrome.storage.local.get(fields, function(config) {
    repositories = config.repositories.split('\n');
    $.each(repositories, function(i, repo) {
      href = 'https://github.com/' + repo + '/issues/new' + '?title=';
      $('#repositories').append(
        '<a href="' + href + '" class="list-group-item">' + repo + '</a>'
      );
    });

    $('#repositories a').click(function(e) {
      e.preventDefault();
      var repoLocation = $(e.currentTarget).attr('href');
      // Attempt to fetch the instance of the currently-open tab
      chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
        // Redirect the current tab if one is found, otherwise create a new one
        if (tabs.length) {
          chrome.tabs.update(tabs[0].id, {url: repoLocation});
        } else {
          chrome.tabs.create({url: repoLocation});
        }
      });
    });
  });
});
