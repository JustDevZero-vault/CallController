class Setup
  def initialize(*params)
    # Create directories
    FileUtils.mkdir_p("static/uploads/")
      # Create models databases
      DataMapper.auto_migrate!
      # And now we set some SQLite pragmas for performance
  end
end
