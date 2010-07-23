files = [
  "widget.rb",
  "widget/abstract.rb",
  "widget/wrapping.rb",
  "widget/component.rb",
  "widget/callback.rb",
  "widget/base.rb",
  "widget/collection.rb",
  "widget/optionable_collection.rb",
  "widget/layout.rb",

  "component.rb",
  "component/abstract.rb",
  "component/rendering.rb",
  "component/answer.rb",
  "component/passing.rb",
  "component/inspection.rb",
  "component/base.rb",
  "component/form_part.rb",
  "component/developer/gc.rb",
  "component/developer/tools.rb",
  "component/developer/log.rb",

  "core.rb",
  "core/observable.rb",
  "logger.rb",
  "runner.rb",

  "core/base.rb",
  "core/action.rb",
  "core/web_socket/connection.rb",
  "core/container.rb",
  "core/context.rb",
  "core/common_logger.rb",
  "core/application.rb",

  "widget/form_part.rb",
  "widget/form_part/abstract.rb",
  "widget/form_part/textarea.rb",
  "widget/form_part/select.rb",
  "widget/form_part/input.rb",

  "component/developer/inspection.rb",
  "component/developer/inspection/abstract.rb",
  "component/developer/inspection/simple.rb",
  "component/developer/inspection/object.rb",
  "component/developer/inspection/module.rb",
  "component/developer/inspection/class.rb",
  "component/developer/inspection/hash.rb",
  "component/developer/inspection/array.rb"
]

files.each do |file|
  require "hammer/#{file}"
end