require 'rails_helper'
RSpec.describe Payment, type: :model do
  @user = User.create(name: 'Amos')
  subject { Payment.new(name: 'onions', amount: 1, author_id: @user) }
  before { subject.save }
  it 'name should be present have some inclusion' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'amount  should be a integer' do
    subject.amount = 'not an integer'
    expect(subject).to_not be_valid
  end

  it 'amount  should be greater than 0' do
    subject.amount = 0
    expect(subject).to_not be_valid
  end
end
