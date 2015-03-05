require 'filewatcher'

FileWatcher.new(["a2"]).watch() do |filename, event|
  if(event == :new || event == :changed)
   file = File.open(filename, "rb")
	puts file.read
  end
end