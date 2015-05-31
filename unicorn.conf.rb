$UNICORN = 1
$CALLCONTROLLER_PID = Process.pid
$CALLCONTROLLER_VERSION = 0.08
$DBG = 0 #debug?

FileUtils.mkdir("log") unless File.directory?("log")

listen 3000
worker_processes 1
pid ".callcontroller.pid"
stderr_path "log/callcontroller.log"
stdout_path "log/callcontroller.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true
