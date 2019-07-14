# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  action     :string
#  payload    :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  issue_id   :bigint           not null
#
# Indexes
#
#  index_events_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#

class Event < ApplicationRecord
  belongs_to :issue
end
