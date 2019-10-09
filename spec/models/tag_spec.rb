require 'rails_helper'

RSpec.describe Tag, type: :model do

  subject { described_class.new(title: "Today") }

  it "is valid with a title" do
    expect(subject).to be_valid
  end
  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it "is not valid if title too short" do
    subject.title = "a"
    expect(subject).to_not be_valid
  end
  it "should validate uniqueness of title" do
    tag1 = Tag.create(title: "Today")
    tag1.save
    tag2 = Tag.create(title: "Today")
    expect { tag2.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end
  it "is not valid if title too long" do
    subject.title = SecureRandom.alphanumeric(101)
    expect(subject).to_not be_valid
  end

  it { should have_many(:tasks) }

  it "has many tasks" do
    expect(Tag).to have_many(:tasks)
  end

end
