require 'aws-sdk'
require 'sinatra/contrib'
class ImageFetcher
  
  # At the moment this just supports AWS, but you could, if you were so inclined, change it to return the top image from a tumblr or whatever.
  def self.get_image_for_date(filename)
    
    AWS.config(
      :access_key_id => self.aws_key,
      :secret_access_key => self.aws_secret)
    s3 = AWS::S3.new
    bucket = s3.buckets[self.aws_bucket_name]
    
    # Make this image public
    begin
      bucket.objects[filename].write(bucket.objects[filename].read, {:acl => :public_read})
    rescue AWS::S3::Errors::SignatureDoesNotMatch => e
      puts e.class
      raise Exception 'AWS credentials are not correct, check your secret.'
      return
    rescue AWS::S3::Errors::InvalidAccessKeyId
      raise Exception 'AWS credentials are not correct, check your key.'
      return
    rescue AWS::S3::Errors::NoSuchBucket
      raise Exception "We couldn't find a bucket called #{self.aws_bucket_name}."
      return
    rescue AWS::S3::Errors::NoSuchKey
      # No image for today's date, no problems
      return
    end
    
    return bucket.objects[filename].public_url.to_s
  
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
  
  def self.aws_bucket_name
    if ENV['BUCKET_NAME'] != nil
      return ENV['BUCKET_NAME']
    else
      config_file './config.yml'
      return settings.bucket_name
    end
  end
end