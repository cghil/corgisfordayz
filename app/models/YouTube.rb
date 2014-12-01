require 'json'
module YouTube
  class Client
    include HTTParty

    base_uri 'https://www.googleapis.com/youtube/v3'

    def initialize
    end

    def get_search_results(params) #search terms
      params = params.gsub(/ /, "+")
      p params
      get_string = "/search?part=snippet&q=#{params}&type=video&videoCaption=closedCaption&key=#{API_KEY}"
      p get_string
      response = self.class.get(get_string)
      hash = response.parsed_response
    end
  end
end


class Filter
  def self.find_snippet(hash)
    items = hash["items"]
    snippets = []
    items.each do |item|
      snippets << item["snippet"]
    end
    snippets
  end
  def self.video_id(hash)
    items = hash["items"]
    video_ids =[]
    items.each do |item|
      video_ids << item["id"]["videoId"]
    end
    # video_id= hash["id"]["videoid"]
    video_ids
  end
  def self.find_title(snippet)
    title = snippet["title"]
  end
  def self.find_description(snippet)
    description = snippet["description"]
  end
  def self.find_thumbnail(snippet)
    thumbnail = snippet["thumbnails"]["medium"]["url"]
  end
end

class FilterSnippet
  def self.find_all_titles(snippets)
    titles = []
    snippets.each do |snippet|
      titles << Filter.find_title(snippet)
    end
    titles
  end
  def self.find_all_descriptions(snippets)
    descriptions = []
    snippets.each do |snippet|
      descriptions << Filter.find_description(snippet)
    end
    descriptions
  end
  def self.find_all_thumbnails(snippets)
    thumbnails = []
    snippets.each do |snippet|
      thumbnails << Filter.find_thumbnail(snippet)
    end
    thumbnails
  end
end
