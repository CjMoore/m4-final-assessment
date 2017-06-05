class Link < ActiveRecord::Base

  belongs_to :user

  validates :url, url: true
  validates :url, :title, presence: true

  def self.get_recent_read
    where('read = ? AND updated_at >= ?', true, 1.day.ago)
  end
end
