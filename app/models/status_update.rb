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

class StatusUpdate < ActiveRecord::Base
  ALLOWED_STATES = ['UP', 'DOWN']

  validates :system_status, presence:    true, 
                            allow_blank: false,
                            inclusion:   { in: ALLOWED_STATES,
                                           message: "Status must be one of #{ALLOWED_STATES.to_sentence(last_word_connector: ' or ', two_words_connector: ' or ')}." }

  default_scope  { order(created_at: :desc) }

  before_validation :set_missing_status_to_latest

  def system_status=(st)
    if st.nil?
      super st
    else
      super st.upcase
    end
  end

  def as_json(options={})
    {
      system_status: system_status,
      message: message,
    }
  end

  protected

  def set_missing_status_to_latest
    return if !self.system_status.nil? || StatusUpdate.count == 0

    self.system_status = StatusUpdate.first.system_status
  end
end
