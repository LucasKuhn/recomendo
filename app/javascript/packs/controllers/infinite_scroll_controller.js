import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["entries", "pagination"]
  static loading_more = false;

  scroll() {
    let next_page = this.paginationTarget.querySelector("a[rel='next']")
    if(next_page == null) { return }
    // console.log(window.pageYOffset)
    let url = next_page.href
    var body = document.body
    var html = document.documentElement
    var height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)
    // console.log(height)
    if (window.pageYOffset >= height - window.innerHeight - 300) {
      if ( !this.loading_more ) {
        this.loading_more = true
        console.log("loading_more")
        this.loadMore(url)
      }
    }

  }

  printf() {
    console.log("Reached the end!")
  }

  loadMore(url) {
    Rails.ajax({
      type: 'GET',
      url: url,
      dataType: 'json',
      success: (data) => {
        console.log(data)
        this.entriesTarget.insertAdjacentHTML('beforeend', data.entries)
        this.paginationTarget.innerHTML = data.pagination
        this.loading_more = false
      }
    })
  }
}
