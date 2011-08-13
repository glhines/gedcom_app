module Paperclip
  # Parses GEDCOM files that are uploaded.
  class GedcomParser < Processor

    attr_accessor :format, :whiny, :convert_options,
                  :source_file_options

    # Performs the conversion of the +file+ . Returns the Tempfile
    # that contains the parsed file.
    def make
      src = @file
      #dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
      #dst.binmode
      #dst = @tempfile
    end
  end
end
