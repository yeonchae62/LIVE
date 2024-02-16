# require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  it "should be valid" do
    expect(@user).to be_valid
  end

  it "name should be present" do
    @user.name = ""
    expect(@user).not_to be_valid
  end

  # Add email test case
  it "email should be present" do
    @user.email = "     "
    expect(@user).not_to be_valid
  end
end

