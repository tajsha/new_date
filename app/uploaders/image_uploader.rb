# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
   # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper


  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  #process :scale => [200, 300]
  process :auto_orient
  
  #
  # def scale(width, height)
  #   # do something
  # end
  
  
  
  def resize_to_limit(width, height)
        manipulate! do |img|
          img.resize "#{width}x#{height}>"
          img = yield(img) if block_given?
          img
        end
      end
      
      def auto_orient
         manipulate! do |image|
           image.auto_orient
           image
         end
       end


  # Create different versions of your uploaded files:
   version :thumb do
     process :auto_orient
     process :resize_to_fill => [162, 170]
   end

   version :avatar do
     process :auto_orient
     process :resize_to_fill => [77, 77]
   end
   
   version :profile do
     process :auto_orient
     process :resize_to_fill => [194, 207]
   end
   
   version :popup do
     process :auto_orient
     process :resize_to_fit => [500, 500]
   end

   version :box do
     process :auto_orient
     process :resize_to_fill => [194, 285]
   end
   
   version :similar do
     process :auto_orient
     process :resize_to_fill => [194, 139]
   end
   
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end