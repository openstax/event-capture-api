class DatumSwaggerFinder
  attr_reader :datum_files
  attr_reader :datum_classes

  def initialize
    @path = Rails.application.secrets.kafka[:schemas_path]
  end

  def datum_files
    @datum_files ||= begin
      datum_mask = File.join(@path, "**", "*_swagger.rb")
      Dir.glob(datum_mask).each_with_object([]) do |filename,collection|
        collection << filename
      end
    end
  end

  def datum_classes
    @datum_classes ||= begin
      datum_files.map do |filename|
        # Remove the standard prefix and use what's left to generate file name.
        # This is necessary for swagger to load the model for processing.
        #
        # What's left is the rails standard namespaced file name in the
        # swagger file, after removing the eager load path.
        filename.slice! 'datum/schema/org/openstax'
        filename.camelize.split('/').join('::').gsub('.rb','').constantize
      end
    end
  end
end
