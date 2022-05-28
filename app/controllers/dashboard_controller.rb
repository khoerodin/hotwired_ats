class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    report_data = Charts::ApplicantsChart.new(current_user.account_id).generate

    @categories = report_data.keys.to_json
    @series = report_data.values.to_json
  end
end
