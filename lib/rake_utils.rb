module RakeUtils

  def self.running_task?(task_name)
    File.basename($PROGRAM_NAME) == "rake" &&
    Rake.application.top_level_tasks.any?{|top_level_task| top_level_task.match(task_name)}
  end

end
