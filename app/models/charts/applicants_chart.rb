module Charts
  class ApplicantsChart
    def initialize(account_id)
      @account_id = account_id
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
        .where("applicants.created_at > ?", 90.days.ago)
        .group("date(applicants.created_at)")
        .count
    end

    def zero_fill_dates(applicants)
      (90.days.ago.to_date..Date.today.to_date).index_with do |date|
        applicants.fetch(date, 0)
      end
    end
  end
end
