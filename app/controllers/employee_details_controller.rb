class EmployeeDetailsController < ApplicationController
  # GET /employee_details
  # GET /employee_details.json
  require 'will_paginate/array'

  def index
    @classification_headings = ClassificationHeading.order('display_order')
    @paramempid = params[:param1]
    if @paramempid
      @employee_details = EmployeeDetail.where(:employee_id=>@paramempid).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    else
      @employee_details = EmployeeDetail.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    end

    respond_to do |format|
      format.html # salary_sheet.html.haml
      format.json { render json: @employee_details }
    end
  end

  # GET /employee_details/1
  # GET /employee_deta  ils/1.json
  def show
    @paramempid = params[:param2]
    @employee_detail = EmployeeDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @employee_detail }
    end
  end

  # GET /employee_details/new
  # GET /employee_details/new.json
  def new
    @classification_headings = ClassificationHeading.order('display_order')
    @paramempid = params[:param1]
    @employee_detail = EmployeeDetail.new()
    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @employee_detail }
    end
  end

  # GET /employee_details/1/edit
  def edit
    @paramempid = params[:param1]
    @employee_detail = EmployeeDetail.find(params[:id])

    @classification_headings = ClassificationHeading.order('display_order')
  end

  # POST /employee_details
  # POST /employee_details.json
  def create
    params[:employee_detail][:pan] = params[:panoption] if params[:panoption] != "ADD PAN"
    @employee_detail = EmployeeDetail.new(params[:employee_detail])

    respond_to do |format|
      if @employee_detail.employee_id != nil
        effective_date = @employee_detail.effective_date
        employee_id = @employee_detail.employee_id
        EmployeeDetail.set_current_employee_id employee_id
        last_record_id = EmployeeDetail.find_last_record_id employee_id  if employee_id != nil

        result1 = EmployeeDetail.effective_date_after_doj? effective_date
        effective_date_after_doj = result1[0]
        @employee_detail.errors.add(:effective_date,result1[1]) if result1[1] != ''


        result2 = EmployeeDetail.effective_date_before_dol? effective_date
        effective_date_before_dol = result2[0]
        @employee_detail.errors.add(:effective_date,result2[1]) if result2[1] != ''


        result3 = EmployeeDetail.effective_date_validation_with_saved_dates? effective_date
        var_effective_date_validation_with_saved_dates = result3[0]
        @employee_detail.errors.add(:effective_date,result3[1]) if result3[1] != ''

        if ( effective_date_after_doj && effective_date_before_dol && var_effective_date_validation_with_saved_dates ) && @employee_detail.save then
          sal_gr_id = @employee_detail.salary_group_id

          SalaryGroupDetail.salary_group_details(sal_gr_id).each do |sgd|
            SalaryAllotment.create!(:employee_id => employee_id, :employee_detail_id => @employee_detail.id, :effective_date => @employee_detail.effective_date, :salary_head_id => sgd.salary_head_id, :salary_group_detail_id => sgd.id, :salary_allotment =>0)
          end

          EmployeeDetail.update_last_record last_record_id,effective_date.yesterday if last_record_id != 0
          format.html { redirect_to employee_details_path(:param1 => employee_id), notice: 'Employee detail was successfully created.' }
          format.json { render json: @employee_detail, status: :created, location: @employee_detail }
        else
          @paramempid = employee_id
          @classification_headings = ClassificationHeading.order('display_order')
          format.html { render "new" }
          format.json { render json: @employee_detail.errors, status: :unprocessable_entity }
        end
      else
        @paramempid = employee_id
        @classification_headings = ClassificationHeading.order('display_order')
        format.html { render "new" }
        format.json { render json: @employee_detail.errors, status: :unprocessable_entity }

      end
    end
  end

  # PUT /employee_details/1
  # PUT /employee_details/1.json
  def update
    params[:employee_detail][:pan] = params[:panoption] if ( params[:panoption] != "ADD PAN"  and params[:panoption] != " " )
    @employee_detail = EmployeeDetail.find(params[:id])
    @paramempid = params[:employee_detail]['employee_id']
    @classification_headings = ClassificationHeading.order('display_order')
    respond_to do |format|
      if @employee_detail.update_attributes(params[:employee_detail])
        format.html { redirect_to employee_details_path(:param1 => params[:employee_detail]['employee_id']), notice: 'Employee detail was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render 'edit' }
        format.json { render json: @employee_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_details/1
  # DELETE /employee_details/1.json
  def destroy
    @employee_detail = EmployeeDetail.find(params[:id])
    @paramempid = @employee_detail.employee_id
    @employee_detail.destroy
    last_record_id = EmployeeDetail.find_last_record_id @paramempid
    EmployeeDetail.update_last_record last_record_id,nil if last_record_id != 0
    respond_to do |format|
      format.html { redirect_to employee_details_url(:param1 => @paramempid), notice: 'Employee detail was successfully Destroyed.' }
      format.json { head :ok }
    end
  end
end