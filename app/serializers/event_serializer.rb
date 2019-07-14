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

class EventSerializer
  include FastJsonapi::ObjectSerializer

  set_type :event
  set_id :id

  belongs_to :issue

  attributes :action, :payload
end
