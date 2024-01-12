class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category

  def index
    @transactions = @category.payment_categories.includes(:payment).order(created_at: :desc)
    @total_amount = @transactions.sum { |payment_category| payment_category.payment.amount }
  end

  def new
    @payment = Payment.new
    respond_to do |format|
      format.html { render :new, locals: { payment: @payment } }
    end
  end

  def create
    @payment = current_user.payments.build(transaction_params)

    if @payment.save
      @payment_category = PaymentCategory.create(payment: @payment, category: @category)
      if @payment_category.save
        redirect_to category_payments_path(@category), notipatce: 'Transaction created successfully.'
      end
    else
      render :new, locals: { payment: @payment }
    end
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def transaction_params
    params.require(:payment).permit(:name, :amount)
  end
end
