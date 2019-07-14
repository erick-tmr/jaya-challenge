class IssueEventParser
  include Instrumentation::BaseService

  def initialize(opts = {})
    @payload = opts.fetch(:payload, '')
  end

  def call
    parse_payload
  end

  private

  def parse_payload
    {
      issue_id: json_hash[:issue][:id],
      action: json_hash[:action],
      payload: json_hash
    }
  end

  def json_hash
    JSON.parse(@payload).with_indifferent_access
  end
end
