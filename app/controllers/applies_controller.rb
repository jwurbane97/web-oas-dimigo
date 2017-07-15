class AppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_apply, only: [:show, :edit, :update, :destroy, :accept, :reject, :print]
  
  def index
    if current_user.permission then
      redirect_to requests_path
    else
      @applies = Apply.where(user_id: current_user.id)
    end
  end

  def new
    if User.find(1).applies.where("DATE(created_at) = DATE(?)", Time.now).count > 0 then
      flash['경고'] = "이미 오늘의 외출신청 내역이 존재합니다."
      redirect_to applies_path
    end
    @apply = Apply.new
  end

  def show
  end

  def edit
  end
  
  def create
     @apply = Apply.new(sch_start: params[:apply][:sch_start], sch_end: params[:apply][:sch_end], reason: params[:apply][:reason], user_id: current_user.id)

    respond_to do |format|
      if @apply.save
        flash['성공'] = '신청이 완료되었습니다.'
        format.html { redirect_to @apply }
        format.json { render :show, status: :created, location: @apply }
      else
        format.html { render :new }
        format.json { render json: @apply.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @apply.update(sch_start: params[:apply][:sch_start], sch_end: params[:apply][:sch_end], reason: params[:apply][:reason], user_id: current_user.id)
        flash['성공'] = '성공적으로 변경되었습니다.' 
        format.html { redirect_to @apply }
        format.json { render :show, status: :ok, location: @apply }
      else
        format.html { render :edit }
        format.json { render json: @apply.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @apply.destroy
    respond_to do |format|
      format.html { redirect_to applies_url, notice: '성공적으로 삭제되었습니다.' }
      format.json { head :no_content }
    end
  end
  
  def print
    respond_to do |format|
      format.pdf do
        render pdf: "apply",
          encoding: 'UTF8',
         page_size: "A6",
           formats: 'html',
      show_as_html: params[:debug].present?
      end
    end
  end
  
  def accept
    if @apply.update_attributes(accepted: true) then
      flash['성공'] = '승인되었습니다.'
      redirect_to requests_path
    end
  end
  
  def reject
    if @apply.update_attributes(accepted: false) then
      flash['성공'] = '거절처리되었습니다.'
      redirect_to requests_path
    end
  end
  
  private
  
  def set_apply
    if request.path.include? 'accept' or request.path.include? 'reject' or request.path.include? 'print'
      @apply = Apply.find(params[:apply_id])
    else
      @apply = Apply.find(params[:id])
    end
  end
  
end
