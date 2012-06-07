require 'iconv'
module GedcomsHelper
  
  class GedcomFile

    def initialize gedcom
      raise ArgumentError unless gedcom.exists?
      @ged = gedcom.to_file
      @token = ''
      @id = ''
      @birthplaces = { }
      @birthplaces_rollup = { }
      @persons = { }
      @families = { }
      @names = { }
      @births = { }
      @parents = { }
    end

    def head(lines = 10)
      l = [ ]
      (1..lines).each { |i| l[i-1] = @ged.gets.chomp }
      return l
    end

    def parse_gedcom
      @tokens = []
      until @tokens[1] == 'CHAR' do
        @tokens = @ged.gets.split
      end
      parse_encoding
      until @token == 'INDI' do
        tokenize
      end
      while @token == 'INDI' do
        parse_individual(@id)
      end
    end

    def report_birthplaces
      return @birthplaces.sort
    end

    def report_birthplaces_rollup
      return @birthplaces_rollup.sort
    end

    def report_names
    end

    def transcoder
      return @transcoder
    end

    private

      def parse_encoding
        encoding = @tokens.last
        case encoding 
        when 'ANSEL', 'ANSI'
          @transcoder = Iconv.new("UTF-8//TRANSLIT//IGNORE", "LATIN1")
        else
          @transcoder = Iconv.new("UTF-8//TRANSLIT//IGNORE", "ASCII")
        end
      end
    
      def tokenize
        tokens = [ ]
        tokens = @ged.gets.split
        @token = tokens.last
        @id = tokens[1]
        tokens
      end
    
      def parse_individual(id)
        tokens = [ ]
        tokens = tokenize
        while tokens.first > '0' do
          if tokens[1] == 'NAME' then
            name = tokens[2..tokens.length-1]
            @names[id => name]
          end 
          if tokens[1] == 'BIRT' then 
            parse_birth(id)
          end
          if tokens[1] == 'FAMC' then
            @parents[id => tokens.last]
          end 
          tokens = tokenize
        end
      end

      def parse_birth(id)
        tokens = [ ]
        rollup = [ ]
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
            rollup[0] = p.first
            if @birthplaces_rollup.has_key?(rollup) then
              @birthplaces_rollup[rollup] += 1
            else
              @birthplaces_rollup[rollup] = 1
            end
            @births[id] = p
          end
          tokens = @ged.gets.split(' ',3)
          @token = tokens.last
        end
      end

  end
  
end
