require 'yaml'

class AddLink

  def initialize

    if $*[0] != nil
      #@file = 'archive.yml'
      @file = $*[0]
    else
      @file = 'details.yml'
    end

    file = File.open(@file, 'r') ;

    @pubs = YAML::load(file) ;

    file.close ;

    @new = Hash.new

    @ask = [ {:name => "Title"},
             {:year => "Year"},
             {:desc => "Description"},
             {:view => "View URL"},
             {:file => "File URL"},
             {:cite => "Reference"} ]

  end

  def add

    puts "\nPlease enter the details of new publication\n\n"

    @ask.each do |h|

      h.each_pair do |k,v|

        print "\t#{v}: "
        @new[k]=STDIN.gets.chop

      end

    end

    print "\nAre these details correct? "

    self.add unless STDIN.gets =~ /y.*/i

  end


  def fixup

    # TODO - add URL checking .. e.g.
    # for Gdocs 'chrome=' bit has to
    # be thrown out for proper viewer

    # perhaps titles can be capitalized

    # also year can be checked ..

    # NORE - for a gdocs url we only
    # need 'srcid=' bit and then just
    # prepend this to it:
    # https://docs.google.com/viewer?a=v&pid=explorer&[srcid=]

  end

  def write

    @pubs += [@new] ;

    File.open(@file, 'w') { |file| file.write(@pubs.to_yaml) } ;

    puts "\nWritten the details of #{@new[:name]}.\n\n"

  end

end

pub = AddLink.new ; pub.add ; pub.write
