class CorsController < ApplicationController
  def get_title
    require 'open-uri'
    title = Nokogiri::HTML(open(params[:url], "User-Agent" => "Ruby/#{RUBY_VERSION}")).css('title').text
    render json: { title: title }
  end

  require 'open-uri'

  def get_metadata
    url = params[:url]
    # https://github.com/jhy/jsoup/issues/976
    # https://medium.com/@tusharseth93/scraping-the-web-a-fast-and-simple-way-to-scrape-amazon-b3d6d74d649f
    user_agent = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
    uri = URI.parse(URI.encode(url))
    html = URI.open(url, "User-Agent" => user_agent)
    document = Nokogiri::HTML(html)

    open_graph = document.css('meta[property^="og"]')

    if open_graph.any?
      result = open_graph.map { |elm| [elm['property'].delete_prefix("og:"), elm['content']] }.to_h
    else
      result = {
        title: document.at_css('meta[name="title"]').try(:[],'content') || document.at_css('title').text,
        description: document.at_css('meta[name="description"]').try(:[],'content'),
        image: "https://www.google.com/s2/favicons?domain=#{url}&sz=128"
      }
    end
    # image: "https://icons.duckduckgo.com/ip3/#{url}.ico"
    # https://stackoverflow.com/questions/38599939/how-to-get-larger-favicon-from-googles-api/46044485

    # document.at_xpath('//head/link[@rel="shortcut icon"]') link rel="shortcut icon"
    render json: result
  end

  def get_metadata2
    url = "https://www.amazon.com.br/Pílulas-azuis-Frederik-Peeters/dp/8582861591/"
    uri = URI.parse(URI.encode(url))
    html = Net::HTTP.get(uri)
    document = Nokogiri::HTML(html)
    open_graph = document.css('meta[property^="og"]')

    req = Net::HTTP::Get.new(uri)
    req["User-Agent"] = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

    html = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }

    uri = URI.parse(URI.encode(url))

    uri = URI('http://example.com/some_path?query=string')

    user_agent = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new(uri)
      request.delete 'User-Agent'
      request.add_field 'User-Agent', user_agent
      request.add_field 'User-Agent', user_agent
      "text/html"
      response = http.request request # Net::HTTPResponse object
    end

    http = Net::HTTP.start(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'User-Agent' => user_agent})
    response = http.request(req)

    puts response.body


    URI.open("http://www.ruby-lang.org/en") {|f|
      byebug
      f.each_line {|line| p line}
      p f.base_uri         # <URI::HTTP:0x40e6ef2 URL:http://www.ruby-lang.org/en/>
      p f.content_type     # "text/html"
      p f.charset          # "iso-8859-1"
      p f.content_encoding # []
      p f.last_modified    # Thu Dec 05 02:45:02 UTC 2002
    }
  end



  def facebook_metadata
    
  end
end
