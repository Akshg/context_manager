# context_manager
Python like context manager in Ruby

Sample context manager to open and close a file
```
def open(filename)
  f = File.open(filename)
  
  close_file = after do |file|
    file.close
  end

  [f, close_file]
end
```

Calling context manager
```
with open('filename.txt') do |file|
  file.read
end
```