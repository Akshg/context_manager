def after(&block)
  Proc.new do |obj|
    block.call(obj)
  end
end

def with(*args)
  arg = args[0]
  yield_obj = arg[0]
  begin
    yield yield_obj
  ensure
    arg[1].call(yield_obj)
  end
end