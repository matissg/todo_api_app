require 'rails_helper'

RSpec.describe Task, type: :model do

  subject { described_class.new(title: "First Task", tags: []) }

  it "is valid with correct attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it "is valid with tags as array" do
    subject.tags = ["Today", "Now"]
    expect(subject).to be_valid
  end

  it "is not valid if tags not array" do
    expect { Task.new(title: "Test", tags: "Test") }.to raise_error { |error|
      expect(error).to be_a(ActiveRecord::RecordInvalid)
    }
  end

  it "is not valid if too many tags" do
    expect {
      Task.new(title: "Test", tags: 31.times.map{ SecureRandom.alphanumeric(8) })
    }.to raise_error { |error|
      expect(error).to be_a(ActiveRecord::RecordInvalid)
    }
  end

  it { should have_many(:task_tags) }

  it "has many tags" do
    expect(Task).to have_many(:task_tags)
  end

  it "is not valid with wrong task title" do
    task = Task.create(title: "Correct Title")
    expect(
      task.update(title: "ab", tags: ["Today", "Home"])
    ).to eq(false)
  end

end
