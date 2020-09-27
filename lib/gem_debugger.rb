# It is difficult in a Docker environment to debug within a gem, because there's no easy
# way to edit the gem in the running container to add a debugger line.  This small
# class looks up gem paths and inserts breakpoints.

class GemDebugger
  def self.break_at_line(gem_name:, file_in_gem:, line:)
    require 'byebug/core'
    gem_path = `bundle info --path #{gem_name}`.strip

    Byebug::Breakpoint.add("#{gem_path}/#{file_in_gem}", line)
    Byebug.start unless Byebug.started?
  end
end
