class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :reviews, -> {extending WithUserAssociationExtension}, dependent: :destroy

  validates :name, length:{ minimum: 3 }, uniqueness: true

  def build_review(attributes = {}, user)
    review = reviews.build(attributes)
    review.user = user
    review
  end

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
