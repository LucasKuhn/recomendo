url = "https://nordweg-cors.herokuapp.com/?http://youtube.com/get_video_info?video_id=HPJKxAhLw5I"
video_id = "HPJKxAhLw5I"

thumbnail = "https://img.youtube.com/vi/#{video_id}/hqdefault.jpg"

video_info = open("http://youtube.com/get_video_info?video_id=#{video_id}").read
parsed_info = Rack::Utils.parse_nested_query(video_info)
json_info = JSON.parse(parsed_info["player_response"])
title = json_info.dig("videoDetails","title")



// JS
video_id = "HPJKxAhLw5I"

title = null
url = `https://nordweg-cors.herokuapp.com/?http://youtube.com/get_video_info?video_id=${video_id}`
thumbnail = `https://img.youtube.com/vi/${video_id}/hqdefault.jpg`
$.get( url, function( data ) {
  parsed_info = JSON.parse('{"' + data.replace(/&/g, '","').replace(/=/g,'":"') + '"}', function(key, value) { return key===""?value:decodeURIComponent(value) })
  json_info = JSON.parse(parsed_info.player_response)
  title = json_info.videoDetails.title.replace(/\+/g, ' ');
}).done(function() {
  $('#videoPreview').append(`<img src=${thumbnail} width="100" height="100"/>`);
  $('#videoPreview').append(`</br><h1>${title}</h1>`);
});


require 'benchmark'

input = ("a".."z").map { |letter| [letter, letter] }.to_h
n = 10_000

Benchmark.bm do |benchmark|
  benchmark.report("likes") do
    n.times do
      user = User.last
      user.likes.include?(like)
    end
  end

  benchmark.report("like_ids") do
    n.times do
      user = User.last
      user.like_ids.include?(like.id)
    end
  end
end




require 'open-uri'

def get_metadata

  url = params[:url]

  user_agent = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
  html = URI.open(url, "User-Agent" => user_agent)
  document = Oga.parse(html)

  open_graph = document.css('meta[property^="og"]')

  if open_graph.any?
    result = open_graph.map { |elm| [elm['property'].delete_prefix("og:"), elm['content']] }.to_h
  else
    title_tag = document.at_css('meta[name="title"]')
    description_tag = document.at_css('meta[name="description"]')
    result = {
      title: title_tag ? title_tag['content'] : document.at_css('title').text,
      description: description_tag ? description_tag['content'] : "",
      image: "https://www.google.com/s2/favicons?domain=#{url}&sz=128"
    }
  end

  render json: result
end
