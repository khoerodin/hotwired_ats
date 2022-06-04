module Charts
  class ApplicantsChart
    def initialize(account_id, params = {})
      @account_id = account_id
      @start_date = params[:start_date].presence || default_start_date
      @end_date = params[:end_date].presence || Date.today.end_of_day
    end

    def generate
      applicants = query_data
      zero_fill_dates(applicants)
    end

    private

    def query_data
      Applicant
        .includes(:job)
        .for_account(@account_id)
        .where(applicants: { created_at: @start_date..@end_date })
        .group("date(applicants.created_at)")
        .count
    end

    def zero_fill_dates(applicants)
      (90.days.ago.to_date..Date.today.to_date).index_with do |date|
        applicants.fetch(date, 0)
      end
    end

    def default_start_date
      90.days.ago
    end
  end
end
