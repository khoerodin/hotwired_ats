class ApplicantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_applicant, only: %i[show edit change_stage]
  include Filterable

  # GET /applicants
  def index
    @grouped_applicants = filter!(Applicant)
                          .for_account(current_user.account_id)
                          .group_by(&:stage)
  end

  # GET /applicants/1
  def show; end

  # GET /applicants/new
  def new
    html = render_to_string(partial: "form", locals: { applicant: Applicant.new })
    render operations: cable_car
      .inner_html("#slideover-content", html:)
      .text_content("#slideover-header", text: "Add an applicant")
  end

  # GET /applicants/1/edit
  def edit; end

  # POST /applicants
  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.save
      render operations: cable_car.dispatch_event(name: "submit:success")
    else
      html = render_to_string(partial: "form", locals: { applicant: @applicant })
      render operations: cable_car
        .inner_html("#applicant-form", html:), status: :unprocessable_entity
    end
  end

  def change_stage
    @applicant.update(applicant_params)
    head :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :phone, :stage, :status, :job_id, :resume)
  end
end
