$ ->
  fields = ['repositories', 'title', 'labels', 'assignee', 'milestone', 'body']
  config = {}

  chrome.storage.local.get fields, (items) ->
    fields.forEach (field) ->
      val = decodeURIComponent items[field]
      $('#'+field).val(val)

  $('#form').submit (e) ->
    e.preventDefault()

    fields.forEach (field) ->
      inputValue = $('#'+field).val()
      inputValue = encodeURIComponent inputValue if field != 'repositories'
      config[field] = $.trim(inputValue)

    chrome.storage.local.set config, ->
        alert('Configurations are saved successfully.')
