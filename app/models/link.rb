class Link < ActiveRecord::Base

  belongs_to :user

  validates :url, url: true
  validates :url, :title, presence: true

end
