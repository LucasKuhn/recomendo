class GetUrlData
  API_ENDPOINT = "https://graph.facebook.com/v8.0/"
  ACCESS_TOKEN = Rails.application.credentials.dig(:facebook, :access_token)

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def run
    return unless valid_url?

    data = get_data

    if data["og_object"].blank?
      scrape_url and return
    end

    image_object = data["og_object"]["image"].try(:first)

    title = data["og_object"]["title"]
    description = data["og_object"]["description"]
    image = image_object.try(:[],'url')
    image_ratio = get_ratio(image_object)
    site_name = data["og_object"]["site_name"]

    {
      title: title,
      description: description,
      image: image,
      image_ratio: image_ratio,
      site_name: site_name
    }
  end

  private

  def get_ratio(image_object)
    if !image_object || !image_object['width'] || !image_object['height']
      return 'square'
    elsif image_object['width'] < 200 || image_object['height'] < 200
      return 'square'
    elsif ( image_object['width'] / image_object['height'] ) == 1
      return 'square'
    else
      'landscape'
    end
  end

  def valid_url?
    uri = URI.parse(URI.encode(url))
    uri.is_a?(URI::HTTP||URI::HTTPS)
  end

  def get_data
    p "get_data"
    query = {
      id: url,
      access_token: ACCESS_TOKEN,
      fields: "og_object{type, id, title, description, updated_time, image, video, site_name}",
      scrape: true
    }
    uri = URI.parse(API_ENDPOINT)
    uri.query = URI.encode_www_form(query.to_a)

    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def scrape_url
    p "scrape_url"
    uri = URI.parse(API_ENDPOINT)
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    body = {
      "id": url,
      "access_token": ACCESS_TOKEN,
      scrape: true
    }
    request.body = body.to_json

    # TODO Maybe using typhoeus is better than a thread for the http request
    Thread.new do
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.request(request)
    end
  end

end
