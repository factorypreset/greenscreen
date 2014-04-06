require 'test_helper'
require 'rake'

describe "EPA greenvehicles rake tasks" do

  before :each do
    load File.expand_path("../../../lib/tasks/epa.rake", __FILE__)
    Rake::Task.define_task(:environment)

    # use a single dummy import file
    TEST_IMPORT_FILES = {
      2013 => "dummy.txt"
    }
  end

  it "can attempt to load vehicle makes from a csv" do
    # pending
  end
end