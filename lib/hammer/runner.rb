# encoding: UTF-8

module Hammer::Runner

  include Hammer::Config

  class << self

    def run!
      load_app_files
      Hammer::Core::Base.run!
      setup_application
      Hammer.logger.info "== Settings\n" + config.pretty_inspect
      Hammer.logger.level = config[:logger][:level]
      Hammer::Core::Application.run!
    end

    private

    def load_app_files
      require "./loader.rb"
    end

    def setup_application
      Hammer::Core::Application.set \
          :root => Dir.pwd,
          :host => config[:web][:host],
          :port => config[:web][:port],
          :environment => config[:web][:environment]
    end
  end
end
