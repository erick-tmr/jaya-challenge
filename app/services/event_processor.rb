class EventProcessor
  include Instrumentation::BaseService

  def initialize(opts = {})
    @params = opts.fetch(:params, {})
  end

  def call
    get_or_create_issue
    create_event
  end

  private

  def get_or_create_issue
    @issue = Issue.find_by(github_id: @params[:issue_id])

    return @issue if @issue.present?

    @issue = Issue.create(
      github_id: @params[:issue_id]
    )
  end

  def create_event
    new_event = Event.new(
      action: @params[:action],
      payload: @params[:payload],
      issue: @issue
    )

    new_event.save
  end
end
