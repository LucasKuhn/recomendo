const input = document.getElementById('post_url');
var   input_timeout = null

input.addEventListener('input', function (e) {
  console.log("input listener")
  hidePreview()
  clearTimeout(input_timeout)
  input_timeout = setTimeout(function () {
    if (isValidUrl(input.value)) {
      getMetadataFromUrl(input.value)
    }
  }, 400);
});

function getMetadataFromUrl(url) {
  fetch(`/cors/get_metadata?url=${url}`)
  .then(response => response.json())
  .then(json => responseHandler(json))
}

function responseHandler(json) {
  if (json) {
    document.querySelector('#link-title').innerText = json.title
    document.querySelector('#link-description').innerText = json.description
    document.querySelector('#link-preview').classList.remove('d-none')
  }
}

function hidePreview() {
  document.querySelector('#link-preview').classList.add('d-none')
}

function isValidUrl(string) {
  let url;
  try {
    url = new URL(string);
  } catch (_) {
    return false;
  }
  return url.protocol === "http:" || url.protocol === "https:";
}
