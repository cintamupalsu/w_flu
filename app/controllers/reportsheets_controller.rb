class ReportsheetsController < ApplicationController
  before_action :set_reportsheet, only: [:show, :edit, :update, :destroy]

  # GET /reportsheets
  # GET /reportsheets.json
  def index
    @reportsheets = Reportsheet.all
  end

  # GET /reportsheets/1
  # GET /reportsheets/1.json
  def show
  end

  # GET /reportsheets/new
  def new
    @reportsheet = Reportsheet.new
  end

  # GET /reportsheets/1/edit
  def edit
  end

  # POST /reportsheets
  # POST /reportsheets.json
  def create
    @reportsheet = Reportsheet.new(reportsheet_params)

    respond_to do |format|
      if @reportsheet.save
        format.html { redirect_to @reportsheet, notice: 'Reportsheet was successfully created.' }
        format.json { render :show, status: :created, location: @reportsheet }
      else
        format.html { render :new }
        format.json { render json: @reportsheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reportsheets/1
  # PATCH/PUT /reportsheets/1.json
  def update
    respond_to do |format|
      if @reportsheet.update(reportsheet_params)
        format.html { redirect_to @reportsheet, notice: 'Reportsheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @reportsheet }
      else
        format.html { render :edit }
        format.json { render json: @reportsheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportsheets/1
  # DELETE /reportsheets/1.json
  def destroy
    @reportsheet.destroy
    respond_to do |format|
      format.html { redirect_to reportsheets_url, notice: 'Reportsheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reportsheet
      @reportsheet = Reportsheet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reportsheet_params
      params.require(:reportsheet).permit(:user_id, :comment)
    end
end
