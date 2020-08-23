class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_admin!, only:[:index]
  skip_before_action :verify_authenticity_token

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        # format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        # format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /transactions/mpesa
  def mpesa_transcation_callback
    # receive payment params
    paybill = params[:PayBillNumber]
    phone = params[:PhoneNumber]
    mpesa_transaction_code = params[:MpesaReceiptNumber]
    amount = params[:Amount]
    amount = amount.to_i
    account_no = params[:AccountReference]
    transaction_description = params[:TransactionDesc]
    name = params[:FullNames]
    date = params[:TransTime]
    order = Order.where(:order_number => params[:AccountReference]).last

    # Create a new transaction for the received data
    # order id for connection with orders
    callback_params = {
      'transaction_id' => params[:PayBillNumber], 
      'account_from' => params[:PhoneNumber],
      'transaction_code' => params[:MpesaReceiptNumber],
      'amount' => params[:Amount], 
      'order_id' => order.id,
      'message' => params[:TransactionDesc],
      'callback_returned' => params[:FullNames],
      'date' => params[:TransTime],
      'payment_mode' => "MPESA"
    }
    @transaction = Transaction.new(callback_params)
    # Update the concern Order

    order.payment_date = Date.today()
    order.transaction_id = @transaction.id
    if order.payment_status == "Unpaid"
      balance = order.order_subtotal - amount
      # set the balance here in future.
      order.reducing_balance = balance
      if balance <= 0
        order.payment_status = "Paid"
        order.paid = true
      elsif balance > 0
        order.payment_status = 'part'
      end
    elsif order.payment_status == "part"
      balance = order.reducing_balance - amount
      order.reducing_balance = balance
      if balance <= 0
        order.payment_status = "Paid"
        order.paid = true
      elsif balance > 0
        order.payment_status = 'part'
      end
    elsif order.payment_status == "Paid"
      balance = order.reducing_balance - amount
      order.reducing_balance = balance
    end
    
    respond_to do |format|
      if @transaction.save && order.save
        # format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        # format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.permit(:transaction_id, :order_id, :callback_returned, :amount, :account_from, :transaction_code, :message, :date, :payment_mode)
    end
end
