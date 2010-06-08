# -*- coding: utf-8 -*-
module ::Model
  module ModelHelper
    def path(method = nil)
      namespace = self.class.to_s.split('::').last.downcase
      key = self.respond_to?(:name) ? self.name : self.id
      if method
        "/#{namespace}/#{key}.#{method}"
      else
        "/#{namespace}/#{key}"
      end
    end
  end

  class Recorder < Sequel::Model
    include ModelHelper
    plugin :timestamps, :update_on_create => true
    set_schema do
      primary_key :id
      String :name, :null => false, :unique => true
      String :description
      datetime :created_at
      datetime :updated_at
    end

    def validate
      errors.add(:name, "can't be empty") if name.empty?
      errors.add(:description, "can't be empty") if description.empty?
    end

    create_table unless table_exists?
    one_to_many :records, :order => :created_at
  end

  class Record < Sequel::Model
    include ModelHelper
    plugin :timestamps, :update_on_create => true
    set_schema do
      primary_key :id
      blob :data
      String :text
      foreign_key :recorder_id
      datetime :created_at
      datetime :updated_at
    end

    create_table unless table_exists?
    many_to_one :recorder
  end

end
