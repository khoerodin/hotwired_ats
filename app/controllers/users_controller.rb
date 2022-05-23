class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = current_user.account.users
  end

  def new
    @user = User.new
    html = render_to_string(partial: "form", locals: { user: @user })
    render operations: cable_car
      .inner_html("#slideover-content", html:)
      .text_content("#slideover-header", text: "Add a new user")
  end

  def create
    @user = User.new(user_params)
    @user.account = current_user.account
    @user.password = SecureRandom.alphanumeric(24)

    if @user.save
      html = render_to_string(partial: "user", locals: { user: @user })
      render operations: cable_car
        .prepend("#users", html:)
        .dispatch_event(name: "submit:success")
    else
      html = render_to_string(partial: "form", locals: { user: @user })
      render operations: cable_car
        .inner_html("#user-form", html:), status: :unprocessable_entity
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
