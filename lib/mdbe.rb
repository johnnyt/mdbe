lib_path = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

module Mdbe
#    initializer "mdbe" do |app|
#      app.config.threadsafe!
#
#      app.config.after_initialize do
#        MaglevDatabaseExplorer.ensure_debug_server_running!
#        MaglevDatabaseExplorer.install_rails_debugger
#      end
#    end

  def full_gem_path
    gem = Gem.loaded_specs["mdbe"]
    gem.full_gem_path
  end

  def eval_object
    @eval_object ||= Object.new
  end

  def debug_storage
    @debug_storage ||= {}
  end

  def store_debug_object(obj)
    debug_storage[obj.object_id] = obj
  end

  module_function :full_gem_path, :eval_object,
    :debug_storage, :store_debug_object
end

require "mdbe/database_views"
require "mdbe/ruby_workspace"
require "mdbe/code_evaluation"
#require "mdbe/debug_server"
require "mdbe/halt"
