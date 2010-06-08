# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../models_helper'
require 'base64'

describe Model::Record do
  include Model
  before do
    @east = load("model/recorder__east")
    @east_1 = load("model/record__east_1")
  end

  it 'has record class' do
    @east_1.should be_an_instance_of Model::Record
  end

  it 'has data' do
    @east_1.data.should_not be_nil
  end

  it 'may has text' do
    @east_1.text.should == 'こんにちは'
  end

#   it 'has recorder' do
#     @east_1.recorder.should == @east
#   end

  it 'has get_binary_from_base64 method (internal)' do
    message = 'こんにちは'
    Model::Record.get_binary_from_base64('data:audio/wav;base64,' + Base64.encode64(message)).should == message
  end

  it 'will die when input is not base64 encoded' do
    lambda{
      @east_1.get_binary_from_base64('cool')
    }.should raise_error
  end

  it 'has new_record method' do
    message = 'おはようございます'
    text = 'おはよう!!!!'
    place = '滋賀'
    record = Model::Record.new_record(
      :data => 'data:audio/wav;base64,' + Base64.encode64(message),
      :text => text,
      :place => place
      )

    record.data.should == message
    record.text.should == text
    record.place.should == place
  end

end
