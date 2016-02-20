require 'spec_helper'

describe Hulaki::ContactParser do 

  context "If valid csv format is imported" do
    let(:file_path) { '/home/neha/contact.csv' }

    it "should successfully parse the file" do
      response = Hulaki::ContactParser.new(file_path).process
      expect(response).to be_a_kind_of(Array)
    end
    
    it "should eradicate empty rows" do
      response = Hulaki::ContactParser.new(file_path).parse_file

    end

    it "should store the imported file in hash"
  end

  context "If valid csv format is not improted" do
    it "should raise exception"
  end
  
end