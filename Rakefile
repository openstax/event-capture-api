# Add your own tasks in files placed in services/tasks ending in .rake,
# for example services/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# Debugging in gems while using Docker is tricky -- the below commands help.  Remember
# to recomment before pushing.
#
# require 'gem_debugger'
# GemDebugger.break_at_line(gem_name: 'avro-builder',
#                           file_in_gem: 'lib/avro/builder/rake/avro_generate_task.rb',
#                           line: 37)
#
# require 'gem_debugger'
# GemDebugger.break_at_line(gem_name: 'openstax_swagger',
#                           file_in_gem: 'lib/tasks/generate_model_bindings.rake',
#                           line: 15)
