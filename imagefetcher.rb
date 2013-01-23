require 'aws-sdk'
require 'sinatra/contrib'
class ImageFetcher
  
  # At the moment this just supports AWS, but you could, if you were so inclined, change it to return the top image from a tumblr or whatever.
  def self.get_image_for_date
    
    AWS.config(
      :access_key_id => self.aws_key,
      :secret_access_key => self.aws_secret)
    s3 = AWS::S3.new
    bucket = s3.buckets['little-server-images']
    
    # Make this image public
    bucket.objects['25-jan-2012'].write(bucket.objects['25-jan-2012'].read, {:acl => :public_read})
    return bucket.objects['25-jan-2012'].public_url.to_s
  
  end
  
  def self.aws_key
    if ENV['AWS_KEY'] != nil
      return ENV['AWS_KEY']
    else
      config_file './config.yml'
      return settings.access_key_id
    end
  end
  
  def self.aws_secret
    if ENV['AWS_SECRET'] != nil
      return ENV['AWS_SECRET']
    else
      config_file './config.yml'
      return settings.secret_access_key
    end
  end
end