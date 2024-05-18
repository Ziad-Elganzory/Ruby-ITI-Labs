class Article < ApplicationRecord
  include Visible
  has_many :comments, dependent: :destroy
  has_one_attached :image
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 10}

  before_update do
    puts "check for report count"
    if self.report_count >= 3
      self.status = "archived"
    end
  end
end
