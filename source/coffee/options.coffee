_gaq = _gaq || []; _gaq.push(['_setAccount', 'UA-58056432-3']); _gaq.push(['_trackPageview'])
ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true
ga.src = 'https://ssl.google-analytics.com/ga.js'
s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s)

$ ->
  fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body']
  config = {}

  chrome.storage.local.get fields, (items) ->
    fields.forEach (field) ->
      val = items[field]
      $('.'+field).val decodeURIComponent(val) if val

    preview()

  $('#form').submit (e) ->
    e.preventDefault()

    fields.forEach (field) ->
      inputValue = $('.'+field).val()
      inputValue = encodeURIComponent inputValue if field != 'repositories'
      config[field] = $.trim(inputValue)

    chrome.storage.local.set config, ->
      $('#saved').removeClass('hide')

  $('#hide-message').click (e) ->
    e.preventDefault()
    $('#saved').addClass('hide')

  $('a').click (e) ->
    e.preventDefault()
    location = $(e.currentTarget).attr('href')
    chrome.tabs.create({url: location})

  $('.body').keyup ->
    preview()

  preview = ->
    marked.setOptions
      langPrefix: ''

    md = sanitize $('.body').val()
    $('.preview').html marked(md)
    $('.preview pre code').each (i, elm) ->
      $(elm).text unsanitize(elm.textContent)
      hljs.highlightBlock elm, elm.className
      hljs.initHighlightingOnLoad()

  sanitize = (html) ->
    $('<div />').text(html).html().replace(/&gt;/g, ">")

  unsanitize = (html) ->
    $('<div />').html(html).text()
