# Add your own tasks in files placed in services/tasks ending in .rake,
# for example services/tasks/capistrano.rake, and they will automatically be available to Rake.

file 'config/secrets.yml' => 'config/secrets.yml.example' do |task|
  cp task.prerequisites.first, task.name
end

Rake::Task['config/secrets.yml'].invoke

require_relative 'config/application'

Rails.application.load_tasks
