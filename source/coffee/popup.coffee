$ ->
  fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body']

  chrome.storage.local.get fields, (config) ->
    repositories = config.repositories.split('\n')
    $.each repositories, (i, repo) ->
      href = "https://github.com/#{repo}/issues/new"
      href += "?title=#{config.title}&labels=#{config.labels}&assignee=#{config.assignee}&milestone=#{config.milestone}&body=#{config.body}"
      $('#repositories').append "<a href='#{href}' class='list-group-item'>#{repo}</a>"

    $('a').click (e) ->
      e.preventDefault()
      location = $(e.currentTarget).attr('href')
      chrome.tabs.create({url: location})

