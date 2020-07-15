class Ticket < ApplicationRecord
  STATUS = %w(new blocked in_progress fixed)

  belongs_to :project
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id', optional: true

  has_many :ticket_tags
  has_many :tags, through: :ticket_tags, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true

  def list_tags
    self.tags.map(&:name).join(', ')
  end
end