class CorsController < ApplicationController
  def get_title
    require 'open-uri'
    title = Nokogiri::HTML(open(params[:url], "User-Agent" => "Ruby/#{RUBY_VERSION}")).css('title').text
    render json: { title: title }
  end

  def get_metadata
    require 'open-uri'
    url = params[:url]
    # https://github.com/jhy/jsoup/issues/976
    # https://medium.com/@tusharseth93/scraping-the-web-a-fast-and-simple-way-to-scrape-amazon-b3d6d74d649f
    document = Nokogiri::HTML(open(url, "User-Agent" => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"))

    open_graph = document.css('meta[property^="og"]')
    
    if open_graph.present?
      result = open_graph.map { |elm| [elm['property'].delete_prefix("og:"), elm['content']] }.to_h
    else
      result = {
        title: document.at_css('meta[name="title"]').try(:[],'content') || document.at_css('title').text
        description: document.at_css('meta[name="description"]').try(:[],'content')
        image: "https://www.google.com/s2/favicons?domain=#{url}&sz=128"
      }
    end
    # image: "https://icons.duckduckgo.com/ip3/#{url}.ico"
    # https://stackoverflow.com/questions/38599939/how-to-get-larger-favicon-from-googles-api/46044485

    document.at_xpath('//head/link[@rel="shortcut icon"]') link rel="shortcut icon"
    render json: result
  end
end
