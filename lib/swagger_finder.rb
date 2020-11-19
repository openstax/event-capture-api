class SwaggerFinder
  def files
    @files ||= begin
      file_mask = File.join("schemas", "**", "swagger.rb")
      Dir.glob(file_mask).each_with_object([]) do |filename,collection|
        collection << filename
      end
    end
  end

  def classes
    @classes ||= begin
      files.flat_map do |filename|
        # Remove the standard prefix and use what's left to generate file name.
        # This is necessary for swagger to load the model for processing.
        #
        # What's left is the rails standard namespaced file name in the
        # swagger file, after removing the eager load path.
        filename.slice! 'schemas/org/openstax/'
        filename.slice! '.rb'
        filename_parts = filename.split('/').map(&:camelize)
        filename_parts.join("::").constantize
      end
    end
  end
end
