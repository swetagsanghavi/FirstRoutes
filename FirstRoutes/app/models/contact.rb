# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  email      :string           not null
#  user_id    :integer          not null
#  timestamps :datetime
#

class Contact < ActiveRecord::Base
  validates :name, presence: true, uniqueness: {:scope => :email}

  belongs_to :owner,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User,
  dependent: :destroy

  has_many :contact_shares,
  primary_key: :id,
  foreign_key: :contact_id,
  class_name: :ContactShare

  has_many :shared_users,
    through: :contact_shares,
    source: :receiver

end
