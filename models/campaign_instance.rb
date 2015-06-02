class Job
  include SuckerPunch::Job

  def perform(data)
    puts data
  end

  def later(sec, data)
    after(sec) { perform(data) }
  end
  
end