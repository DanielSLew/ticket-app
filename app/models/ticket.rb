class Ticket < ApplicationRecord
  belongs_to :project

  has_many :ticket_tags
  has_many :tags, through: :ticket_tags

  validates :name, presence: true

  def list_tags
    self.tags.map(&:name).join(', ')
  end
end