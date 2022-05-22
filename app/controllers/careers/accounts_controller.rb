module Careers
  class AccountsController < ApplicationController
    def show
      @account = Account.find(params[:id])
    end
  end
end
