class Project < ApplicationRecord
  has_many :tickets, dependent: :destroy

  validates :name, presence: true

  def open_tickets
    self.tickets.reject {|ticket| ticket == 'fixed'}.size
  end

  def total_tickets
    self.tickets.size
  end
end