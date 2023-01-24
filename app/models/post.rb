class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  validate :max_images

  private

  def max_images
    if images.length > 10
      images_to_purge = images.drop(10)
      images_to_purge.each { |img| img.purge }
      errors.add(:images, "can't be more than 10")
    end
  end
end
