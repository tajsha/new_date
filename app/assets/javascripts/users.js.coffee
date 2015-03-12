# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('.best_in_place').best_in_place()
  $('.converation').click (e) ->
    href = $(this).data('href')
    if(!$('.conversation_avatar').is(e.target))
      window.location = href
  $('.adv_search').click (e) ->
    e.preventDefault
    $('.advanced_search_div').removeClass('hide')
  $('.simple_search').click (e) ->
    e.preventDefault
    $('.advanced_search_div').addClass('hide')
  $(document).on 'click', '.common_box.box1', (e) ->
    console.log('target', e.target)
    if(!$('.message_btn').is(e.target) && $('.message_btn').has(e.target).length == 0 && !$('.save_btn').is(e.target) && $('.save_btn').has(e.target).length == 0 && !$('.report_btn').is(e.target) && $('.report_btn').has(e.target).length == 0)
      href = '/users/'+ $(this).data('user-id')
      window.location = href