# frozen_string_literal: true

require_relative '../spec_helper-backend_tpl'
describe Asciidoctor::BackendTemplate::Converter do
  well_done_message = "Well done: You plugged in a converter backend named 'backend_tpl'"
  context 'When initializing' do
    it "should self register as tpl for 'backend_tpl'" do
      registered = Asciidoctor::Converter.for 'backend_tpl'
      expect(registered).to be described_class
    end
  end

  context 'When calling #convert on any object' do
    it "should return our 'Well done!' message" do
      result = described_class.new('backend_tpl', {}).convert 'DUMMY TEST STRING'
      expect(result).to eq well_done_message
    end
  end

  context 'When calling #Asciidoctor.convert on a String object' do
    context "Given backend 'backend_tpl'" do
      it 'should output our "Well done!" message' do
        result = Asciidoctor.convert 'DUMMY TEST STRING', backend: 'backend_tpl'
        expect(result).to eq well_done_message
      end
    end
  end
end
