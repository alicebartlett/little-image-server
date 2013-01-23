require 'sinatra'
require 'json'
require 'date'

get '/edition/' do
  require './imagefetcher.rb'
  @image = ImageFetcher.get_image_for_date
  etag = Digest::MD5.hexdigest(@image)
  erb :edition
end


get '/sample/' do
  require './imagefetcher.rb'
  @image = ImageFetcher.get_image_for_date
  etag = Digest::MD5.hexdigest(@image)
  erb :edition
end
