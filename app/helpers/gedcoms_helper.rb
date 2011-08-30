module GedcomsHelper
  
  class GedcomFile

    def initialize gedcom
      raise ArgumentError unless gedcom.exists?
      @ged = gedcom.to_file
      @token = ''
      @birthplaces = { }
    end

    def head(lines = 10)
      l = [ ]
      (1..lines).each { |i| l[i-1] = @ged.gets.chomp }
      return l
    end

    def parse_gedcom
      until @token == 'INDI' do
        tokenize
      end
      while @token == 'INDI' do
        parse_individual
      end
    end

    def report_birthplaces
      @birthplaces.sort.each do |key, value|
        print key; print " = "; puts value
      end
    end

    private

      def tokenize
        tokens = [ ]
        tokens = @ged.gets.split
        @token = tokens.last
        tokens
      end
    
      def parse_individual
        tokens = [ ]
        tokens = tokenize
        while tokens.first > '0' do
          if tokens[1] == 'BIRT' then 
            parse_birth
          end
          tokens = tokenize
        end
      end

      def parse_birth
        tokens = [ ]
        tokens = @ged.gets.split(' ',3)
        @token = tokens.last
        while tokens.first > '1' do
          if tokens[1] == 'PLAC' then
            place = tokens.last.chomp.split(',').reverse
            p = place.map { |s| s.strip }
            if @birthplaces.has_key?(p) then
              @birthplaces[p] += 1
            else
              @birthplaces[p] = 1
            end
          end
          tokens = @ged.gets.split(' ',3)
          @token = tokens.last
        end
      end

  end
  
end

#parser = GedcomsHelper::GedcomFile.new( *ARGV )
#parser.parse_gedcom
#parser.report_birthplaces
