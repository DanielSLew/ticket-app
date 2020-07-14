class User < ApplicationRecord
  # has_many :projects
  # has_many :tickets
  
  has_secure_password

  validates :username, length: {minimum: 2}, uniqueness: true
  validates :email, uniqueness: true, 
             format: { with: /\A.+@.+\..+/, message: 'address is invalid.' }
  validates :password, length: {minimum: 6}, confirmation: true
end