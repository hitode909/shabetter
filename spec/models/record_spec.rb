# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../models_helper'

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

  it 'has recorder' do
    @east_1.recorder.should == @east
  end

#   it 'has name' do
#     @east.name.should == 'east'
#   end

#   it 'has description' do
#     @east.description.should == 'east server'
#   end

#   it 'has path' do
#     @east.path.should == '/recorder/east'
#   end

#   it 'has path with method' do
#     @east.path('hello').should == '/recorder/east.hello'
#   end


end
