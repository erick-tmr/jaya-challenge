# == Schema Information
#
# Table name: issues
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  github_id  :bigint           not null
#
# Indexes
#
#  index_issues_on_github_id  (github_id) UNIQUE
#

class IssueSerializer
  include FastJsonapi::ObjectSerializer

  set_type :issue
  set_id :id

  attributes :github_id
end
