// Reset modal on cancel
$('#cancel-modal').on('click', function () {
  $(this).closest('form').trigger('reset');
})

// Change the modal according to the category chosen
$('#new-post-modal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var category_id = button.data('category-id') // Extract info from data-* attributes
  var category_name = button.data('category-name') // Extract info from data-* attributes
  switch(category_name.toLowerCase().replace(/[^a-z]/g, '')) {
    case 'filme':
    tags = 'suspense, drama'
    break;
    case 'livro':
    tags = 'romance, poesia'
    break;
    case 'seriado':
    tags = 'netflix, AppleTV'
    break;
    case 'podcast':
    tags = 'spotify, entrevista'
    break;
    case 'video':
    tags = 'youtube, ted'
    break;
    default:
    tags = ''
  }
  $('.bootstrap-tagsinput input').attr('placeholder', tags);
  $('.bootstrap-tagsinput input').focus(function(){
    $(this).removeAttr('placeholder');
  });
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this)
  modal.find('select').val(category_id)
  modal.find('.modal-title').text(category_name)
})


// Auto Grow text area
// https://gomakethings.com/automatically-expand-a-textarea-as-the-user-types-using-vanilla-javascript/
var autoExpand = function (field) {

  // Reset field height
  field.style.height = 'inherit';

  // Get the computed styles for the element
  var computed = window.getComputedStyle(field);

  // Calculate the height
  var height = parseInt(computed.getPropertyValue('border-top-width'), 10)
  + parseInt(computed.getPropertyValue('padding-top'), 10)
  + field.scrollHeight
  + parseInt(computed.getPropertyValue('padding-bottom'), 10)
  + parseInt(computed.getPropertyValue('border-bottom-width'), 10);

  field.style.height = height + 'px';

};

document.addEventListener('input', function (event) {
  if (event.target.tagName.toLowerCase() !== 'textarea') return;
  autoExpand(event.target);
}, false);


// Fix multiple modal Bootstrap bug
// https://stackoverflow.com/questions/28077066/bootstrap-modal-issue-scrolling-gets-disabled
$('body').on('hidden.bs.modal', function () {
  if($('.modal.show').length > 0)
  {
    $('body').addClass('modal-open');
  }
});
