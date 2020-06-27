# context manager
Python like context manager in Ruby

Install
```
gem install context_manager
```

A sample context manager to open and close a file. Similarly, you can write your own.
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
