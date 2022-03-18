class Micropost < ApplicationRecord
  ATTR_CHANGE = %i(content image).freeze

  belongs_to :user
  has_one_attached :image

  scope :newest, ->{order created_at: :desc}

  validates :content, presence: true,
             length: {maximum: Settings.valid.length_140}
  validates :image, content_type: {in: Settings.image.accept_format,
                                   message: I18n.t("microposts.valid.image")},
             size: {less_than: Settings.image.size_mb_5.megabytes,
                    message: I18n.t("microposts.valid.size_image")}

  def display_image
    image.variant(resize_to_limit: Settings.range_500)
  end
end
