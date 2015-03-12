# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  # if $('.hiddenpage').length
    # $('#append_and_paginate').prepend('<a id="append_more_results" href="javascript:void(0);">Show more questions</a>');
  $('#append_and_paginate').click (e) ->
    console.log('clicked')
    e.preventDefault()
    url = $('.hiddenpage .next_page').attr('href')
    uri = url.split('?')
    ajax_url = uri[0]+'.js?'+uri[1]
    current_page = url[url.length-1]
    if ajax_url
      # $('.hiddenpage').text('Fetching more questions...')
      $.get(ajax_url,  ->
      ).always (data) ->
        console.log(data)
        console.log('current_page'+current_page)
        total_pages = $('.total_pages').val()
        console.log('total pages'+ total_pages)
        $('#questions_div').append(data.responseText)
        console.log(total_pages == parseInt(current_page))
        if (total_pages == current_page)
          $('#append_and_paginate').hide()
        else
          $('.hiddenpage .next_page').attr('href',uri[0]+'?page='+(parseInt(current_page)+1))
        return