# == Schema Information
#
# Table name: status_updates
#
#  id         :integer          not null, primary key
#  status     :string(10)       not null
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :status_update do
    
  end
end
