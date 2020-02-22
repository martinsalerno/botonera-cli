require 'spec_helper'

describe Botonera do
  subject(:botonera) { Botonera.new }

  before do
    allow(botonera.display).to receive_message_chain(:clear_screen!, :print_botonera!, :read_char!)
      .and_return(action)
  end

  describe '#start!' do
    context 'when quitting the botonera' do
      let(:action) { Constants::QUIT }

      before do
        allow(botonera).to receive(:quit!).and_call_original

        botonera.start!
      end

      it 'calls quit!' do
        expect(botonera).to have_received(:quit!)
      end
    end
  end
end
