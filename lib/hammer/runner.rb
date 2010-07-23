# encoding: UTF-8

module Hammer
  module Runner

    include Hammer::Config

    class << self

      def run!
        #          encoding
        load_app_files
        Core::Base.run!
        setup_application
        Hammer.logger.info "== Settings\n" + config.pretty_inspect
        Hammer.logger.level = config[:logger][:level]
        Core::Application.run!
      end

      private

      def load_app_files
        require "./loader.rb"
      end

      def setup_application
        Core::Application.set \
            :root => Dir.pwd,
            :host => config[:web][:host],
            :port => config[:web][:port],
            :environment => config[:web][:environment]
      end

      def encoding
        puts "External encoding: #{Encoding.default_external.inspect}"
        puts "Internal encoding: #{Encoding.default_internal.inspect}"
      end

    end

  end
end