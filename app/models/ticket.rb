class Ticket < ApplicationRecord
  # STATUS = ['New', 'Blocked', 'In Progress', 'Fixed']
  STATUS = %w(new blocked in_progress fixed)

  belongs_to :project
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id', optional: true

  has_many :ticket_tags, dependent: :destroy
  has_many :tags, through: :ticket_tags
  has_many :comments

  validates :name, presence: true

  def list_tags
    self.tags.map(&:name).join(', ')
  end
end