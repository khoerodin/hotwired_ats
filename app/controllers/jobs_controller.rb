class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: %i[show edit update destroy]

  # GET /jobs
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  def show; end

  # GET /jobs/new
  def new
    html = render_to_string(partial: "form", locals: { job: Job.new })
    render operations: cable_car
      .inner_html("#slideover-content", html:)
      .text_content("#slideover-header", text: "Post a new job")
  end

  # GET /jobs/1/edit
  def edit; end

  # POST /jobs
  def create
    @job = Job.new(job_params)
    @job.account = current_user.account

    if @job.save
      html = render_to_string(partial: "job", locals: { job: @job })
      render operations: cable_car
        .prepend("#jobs", html:)
        .dispatch_event(name: "submit:success")
    else
      html = render_to_string(partial: "form", locals: { job: @job })
      render operations: cable_car
        .inner_html("#job-form", html:), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to job_url(@job), notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.require(:job).permit(:title, :status, :job_type, :location, :account_id, :description)
  end
end
