require 'sinatra'
require 'json'
require 'date'

get '/edition/' do
  require './imagefetcher.rb'
  
  if params[:local_delivery_time].nil?
    today = Date.today
  else
    today = Date.parse(params[:local_delivery_time])
  end

  filename = today.strftime('%d-%b-%Y')
  etag = Digest::MD5.hexdigest(filename)

  @image = ImageFetcher.get_image_for_date(filename)

  if @image.nil?
    # no image found today, so we won't send one to BERG Cloud. To make one, add a file to your AWS bucket called #{filename}
    return 204
  end

  erb :edition
end


get '/sample/' do
  require './imagefetcher.rb'
  @image = ImageFetcher.get_image_for_date('sample')
  etag = Digest::MD5.hexdigest(@image)
  erb :edition
end
