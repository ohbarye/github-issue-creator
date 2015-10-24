$ ->
  fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body']
  config = {}

  chrome.storage.local.get fields, (items) ->
    fields.forEach (field) ->
      val = decodeURIComponent items[field]
      $('#'+field).val(val)

    preview()

  $('#form').submit (e) ->
    e.preventDefault()

    fields.forEach (field) ->
      inputValue = $('#'+field).val()
      inputValue = encodeURIComponent inputValue if field != 'repositories'
      config[field] = $.trim(inputValue)

    chrome.storage.local.set config, ->
        alert('Configurations are saved successfully.')

  $('#body').keyup ->
    preview()

  preview = ->
    marked.setOptions
      langPrefix: ''

    md = sanitize $('#body').val()
    $('#preview').html marked(md)
    $('#preview pre code').each (i, elm) ->
      $(elm).text unsanitize(elm.textContent)
      hljs.highlightBlock elm, elm.className
      hljs.initHighlightingOnLoad()

  sanitize = (html) ->
    $('<div />').text(html).html().replace(/&gt;/g, ">")

  unsanitize = (html) ->
    $('<div />').html(html).text()
