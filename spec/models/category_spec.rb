require 'rails_helper'
RSpec.describe Category, type: :model do
  @user = User.create(name: 'Amos')
  subject { Category.new(name: 'gym equipment', icon: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxVzKiW3wBEPzWsq2XdhipyJqH-O-iluoXWw&usqp=CAU', user_id: @user) }
  before { subject.save }
  it 'name should be present have some inclusion' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'icon should be present have some inclusion' do
    subject.icon = nil
    expect(subject).to_not be_valid
  end
end
