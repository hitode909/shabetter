# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../models_helper'

describe Model::Recorder do
  include Model
  before do
    @east = load("model/recorder__east")
    @east_1 = load("model/record__east_1")
  end

  it 'has user class' do
    @east.should be_an_instance_of Model::Recorder
  end

  it 'has name' do
    @east.name.should == 'east'
  end

  it 'has description' do
    @east.description.should == 'east server'
  end

  it 'has path' do
    @east.path.should == '/recorder/east'
  end

  it 'has path with method' do
    @east.path('hello').should == '/recorder/east.hello'
  end

  it 'has records' do
    @east.records.should include @east_1
  end

end
