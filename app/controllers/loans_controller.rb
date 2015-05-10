class LoansController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource


  def index

    @loans = Loan.all
    @loans_active = Loan.where('status' => 'Active')
    @loans_delivered = Loan.where('status' => 'Delivered')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @loans }
    end
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    @loan = Loan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @loan }
    end
  end

  # GET /loans/new
  # GET /loans/new.json
  def new
    @loan = Loan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @loan }
    end
  end

  # GET /loans/1/edit
  def edit
    @loan = Loan.find(params[:id])
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(params[:loan])
    book = Book.find(params[:loan]['book_id'])
    if book.format == 'Physical'
      helper_book_true book
      @loan.return_date = Date.today + 7
    else 
      @loan.return_date = '9999-09-09'.to_date
    end
    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render json: @loan, status: :created, location: @loan }
      else
        format.html { render action: "new" }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def helper_book_false book
    book.borrowed = false
    book.save
  end

  def helper_book_true book
    book.borrowed = true
    book.save
  end

  # PUT /loans/1
  # PUT /loans/1.json
  def update
    @loan = Loan.find(params[:id])
    book = Book.find(@loan.book_id)
    new_book = Book.find(params[:loan]['book_id'])
 
    if @loan.book_id != new_book.id
      if new_book.format == 'Physical'
        @loan.return_date = Date.today + 7
        helper_book_true new_book
      else
        @loan.return_date = '9999-09-09'.to_date
        helper_book_false book
      end
      helper_book_false book
    end
    respond_to do |format|
      if @loan.update_attributes(params[:loan])
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan = Loan.find(params[:id])
    helper_book_false Book.find(@loan.book_id)
    @loan.destroy

    respond_to do |format|
      format.html { redirect_to loans_url }
      format.json { head :no_content }
    end
  end
end
