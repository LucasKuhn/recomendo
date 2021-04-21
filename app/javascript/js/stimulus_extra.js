window.addEventListener('load', function(){
  dispatchScroll()
});

document.addEventListener('turbo:load', function(){
  setTimeout(dispatchScroll, 100);
});

function dispatchScroll() {
  window.dispatchEvent(new Event('scroll'));
}
