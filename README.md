Little Image Server
===================

This is a minimum viable publication for Little Printer. It connects to an Amazon Web Bucket and serves an image that is named with today's date in the format %d-%b-%Y e.g. '23-Jan-12'. 
These instructions are intended for people who want to deploy to Heroku and then just leave it alone. There is no programming required to use this publication, but you will need to be OK with the basics of the command line and git (and if you aren't, hopefully these instructions will be enough.)

Use
===

You'll need git. You there are a bunch of options available to you here: https://help.github.com/articles/set-up-git
You'll need a github profile.

Now, assuming git is working on your computer and you have a github profile, fork  and clone this repository. More here: (https://help.github.com/articles/fork-a-repo)

Now, you should have this code on your computer. Hurrah! You'll need to do a very small amount of set up and then you'll be ready to go!

1. Open the file in the public file called 'meta.json'. You'll need to name your publication, write a short description of what it does, and how often it is delivered.
2. Pick an icon for your publication. It should be called icon.png and be in the public folder.
3. (optional) At the moment your publication will return an image, but if you want your publication to have some more html in it, you can modify the file called edition.erb in the folder called views.
4. Commit these changes to git using `git commit -a -m 'your commit message here'`

Image storage
=============

This publication uses the AWS file storage for storing images. For the amount that you'll be using it, it should be free. To use it you will need to set up an account here: http://aws.amazon.com/. Once you've done that you should be able to go to this url: https://console.aws.amazon.com/s3/home?region=us-east-1 and start uploading images for your publication.
Select 'create bucket' and name your bucket something sensible. Write this name down, you'll need it later. Then you can start adding images to your bucket. In order for this to work, you'll need to add images with the date that you want them to be published in the following format: 30-Jan-13 (the day, a three letter month code, and the year separated with hyphens)

You will also need to upload an image called "sample" which will be the image users get when they press the "print sample" button on BERG Cloud.
Deployment
==========

Let's use Heroku, it's free and easy. The getting started with git and Heroku guide is here: https://devcenter.heroku.com/articles/quickstart.

One Last Thing
==============

You're going to need to give heroku some environment varibles so it can access your AWS Bucket. First, figure out your key and secret over here: https://portal.aws.amazon.com/gp/aws/securityCredentials

In your app directory type the following:

$ heroku config:add AWS_KEY=Access_Key_ID(should be a 20 character string)
$ heroku config:add AWS_SECRET=Secret_Access_Key(should be a mix of numbers and lower case letters)


and, You know those that bucket name that you wrote down earlier? Well, here's where you need it.

$ heroku config:add BUCKET_NAME=the_name_you_gave_that_bucket

You're good to go.

Test it works
=============

When you deployed to Heroku, it should have given you your website address, now, if you go to http://that_address.herokuapp.com/edition/ you should see todays image (if there is an image in AWS with today's date as the filename, or a blank page if there isn't one)