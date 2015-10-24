$ ->
  fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body']
  config = {}

  chrome.storage.local.get fields, (items) ->
    fields.forEach (field) ->
      $('#'+field).val items[field]

  $('#form').submit (e) ->
    e.preventDefault()

    fields.forEach (field) ->
      config[field] = $.trim($('#'+field).val())

    chrome.storage.local.set config, ->
        alert('Configurations are saved successfully.')
