$ ->
  fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body']

  chrome.storage.local.get fields, (config) ->
    repositories = config.repositories.split('\n')
    $.each repositories, (i, repo) ->
      href = "https://github.com/#{repo}/issues/new"
      href += "?title=#{config.title}&labels=#{config.labels}&assignee=#{config.assignee}&milestone=#{config.milestone}&body=#{encodeURIComponent config.body}"
      $('#repositories').append "<a href='#{href}' class='list-group-item'>#{repo}</a>"

    $('#repositories a').click (e) ->
      e.preventDefault()
      repoLocation = $(e.currentTarget).attr('href')
      chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
        if tabs.length
          chrome.tabs.update tabs[0].id, {url: repoLocation}
        else
          chrome.tabs.create({url: repoLocation})

