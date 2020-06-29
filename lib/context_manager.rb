class ContextNotFound < StandardError; end

def finish(&block)
  Proc.new { |obj| block.call(obj) }
end

def with(*args)
  begin
    arg = args[0]
    yield_obj = arg[0]
  rescue
    raise ContextNotFound, 'no context found'
  end

  raise ContextNotFound, 'no context found' if yield_obj.nil?

  begin
    yield yield_obj
  ensure
    arg[1].call(yield_obj)
  end
end