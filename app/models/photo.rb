class Photo < ApplicationRecord
  belongs_to :room

  require 'mini_magick'
  mount_uploader :image, ImageUploader
  serialize :image, JSON
end
