# Context Managers
[![Gem Version](https://badge.fury.io/rb/context_manager.svg)](https://badge.fury.io/rb/context_manager)

Python like context mangers in Ruby. Context managers allow you to allocate and release resources precisely when you want to.

**Install**
```
gem install context_manager
```

**Write you own context manager**

A sample context manager to open and close a file. Similarly, you can write your own.
```
def open(filename)
  f = File.open(filename)
  
  close_file = finish do |file|
    file.close
  end

  [f, close_file]
end
```

**Calling the context manager**
```
require 'context_manager'

with open('filename.txt') do |file|
  file.read
end
```

## Examples

**1. Connect to DB**
```
def connect_db
  # harcoding DB values to keep the example simple
  conn = Mysql2::Client.new(
    host: 'localhost',
    username: 'root',
    password: 'root',
    database: "my_database"
  )
  close_conn = finish { |conn| conn.close }
  [conn, close_conn]
end
```
Call with the DB context manager
```
with connect_db do |conn|
  result = conn.query("select * from users limit 1")
  result.first
end
```

**2. Read from a file and write to other file**

You can even write a nested context manager. For example, If you want to read contents from a file and write it to some other file.

Context manager that opens file in read mode
```
def open(filename)
  f = File.open(filename)
  close_file = finish { |file| file.close }
  [f, close_file]
end
```
Context manager that opens file in write mode
```
def write(filename)
  f = File.open(filename, 'w')
  close_file = finish { |file| file.close }
  [f, close_file]
end
```
Call write context manager inside read
```
with open('read_from_file.txt') do |read_file|
  with write('write_to_file.txt') do |write_file|
    write_file.write read_file.read
  end
end
```
