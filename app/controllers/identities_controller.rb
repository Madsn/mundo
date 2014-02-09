class IdentitiesController < ApplicationController
  before_action :set_identity, only: [:show, :edit, :destroy]

  def index
    @identities = Identity.all
  end

  def show
  end

  def new
    @identity = env['omniauth.identity']
  end

  def edit
  end

  def destroy
    @identity.destroy
    respond_to do |format|
      format.html { redirect_to identities_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_identity
    @identity = Identity.find(params[:id])
  end
end