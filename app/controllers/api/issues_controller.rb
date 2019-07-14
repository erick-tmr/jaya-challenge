module Api
  class IssuesController < ApplicationController
    def index
      render_json_response(
        resources: issues,
        serializer: IssueSerializer
      )
    end

    private

    def issues
      Issue.all
    end
  end
end
