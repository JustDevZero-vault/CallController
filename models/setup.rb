# -*- coding: utf-8 -*-
class Setup
  def initialize(*params)
    # Create directories
    FileUtils.mkdir_p("public/uploads/")
    FileUtils.touch('.installed')
    # Create models databases
    DataMapper.auto_migrate!(:default)
  end

  def self.one_click_install_exchange
    Spork.spork do
      open('Gemfile', 'a') do |f|
        f.puts 'gem "viewpoint"'
      end
      system "uniq Gemfile > Gemfile.uniq"
      system "mv Gemfile.uniq Gemfile"
      bundle = Gem.bin_path("bundler", "bundle")
      system "#{bundle} install && #{bundle} update"
    end
    Process.waitall
    Spork.spork do
      Process.setsid
      Spork.spork do
        exec "./callcontroler.sh restart"
      end
      exit
    end
  end

end
