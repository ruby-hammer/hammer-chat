# encoding: UTF-8

module Examples
  module Form
    class Base < Hammer::Component::Base
      include Hammer::Component::Form

      attr_reader :counter
      after_initialize { @counter = 0 }

      define_widget do
        def wrapper_classes
          super << 'form'
        end

        def content
          label 'Name:', :for => @label_id = Hammer::Core.generate_id, :class => 'span-3 inline'
          div :class => %w{span-21 last}, :style => 'height: 36px;' do
            input :name => :name, :value => value(:name), :type => :text, :id => @label_id
          end

          input :name => :hidden, :value => value(:hidden), :type => :hidden

          label 'Password:', :for => @label_id = Hammer::Core.generate_id, :class => 'span-3 inline'
          div :class => %w{span-21 last}, :style => 'height: 36px;' do
            input :name => :password, :value => value(:password), :type => :password, :id => @label_id
          end

          label 'Sex:', :for => @label_id = Hammer::Core.generate_id, :class => 'span-3 inline'
          div :class => %w{span-21 last}, :style => 'height: 36px;' do
            select :name => :sex, :id => @label_id do
              [nil, 'male', 'female'].each do |opt|
                value, text = opt
                text ||= value
                option text, :value => value, :selected => value(:sex) == value ? :selected : false
              end
            end
          end

          label 'Description:', :for => @label_id = Hammer::Core.generate_id, :class => 'span-3 inline'
          div :class => %w{span-21 last}, :style => 'height: 90px;' do
            textarea value(:description), :name => :description, :id => @label_id, :style => 'height: 66px'
          end

          div :class => %w{span-21 prepend-3 last}, :style => 'height: 36px;' do
            submit("Send for the #{counter}th time", :class => %w{clear}).update { @counter += 1 }
          end
          strong 'Values:'
          ul do
            record.members.each do |key|
              li "#{key}: #{value(key).inspect}"
            end
          end

          render sub if sub

        end
      end

    end
  end
end
