_gaq = _gaq || []; _gaq.push(['_setAccount', 'UA-58056432-3']); _gaq.push(['_trackPageview'])
ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true
ga.src = 'https://ssl.google-analytics.com/ga.js'
s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s)

$ ->
  fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body']

  chrome.storage.local.get fields, (config) ->
    repositories = config.repositories?.split('\n')
    if repositories
      $.each repositories, (i, repo) ->
        href = "https://github.com/#{repo}/issues/new"
        href += "?title=#{config.title}&labels=#{config.labels}&assignee=#{config.assignee}&milestone=#{config.milestone}&body=#{config.body}"
        $('#repositories').append "<a href='#{href}' class='list-group-item'>#{repo}</a>"

    $('a').click (e) ->
      e.preventDefault()
      location = $(e.currentTarget).attr('href')
      chrome.tabs.create({url: location})

