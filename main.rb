# -*- coding: utf-8 -*-
require 'sinatra/base'
require 'haml'
require 'models/init'
require 'logger'

class ShabetterApp < Sinatra::Base
  helpers do
    alias_method :h, :escape_html

    def logger
      @logger ||= Logger.new($stdout)
    end

    def entity_link(obj)
      return unless obj.respond_to? :path and obj.respond_to? :name
      haml '%a{:href => obj.path}= obj.name',
      :locals => {:obj => obj},
      :layout => false
    end

  end

  set :haml, :escape_html => true
  set :static, true
  set :public, File.dirname(__FILE__) + '/public'

  before do
    @errors = []
    @messages = []
  end

  get '/' do
    @records = Model::Record.order(:created_at.desc).all
    haml :index
  end

  post '/record' do
    # 本当はここで例外処理するべき
    record = Model::Record.new_record(
      :data  => params[:data],
      :text  => params[:text],
      :place => params[:place]
      )

    response['Content-Type'] = 'text/plain'
    record.path
  end

  get %r{/record/(\d+)} do
    id = params[:captures][0]
    record = Model::Record.find(:id => id)
    halt 404 unless record

    response['Content-Type'] = 'audio/wav'
    record.data.to_s
  end

end
