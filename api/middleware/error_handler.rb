class ErrorHandler
  def self.handle(error)
    case error
    when ArgumentError
      [400, { 'Content-Type' => 'text/plain' }, ['Bad Request: ' + error.message]]
    when JSON::ParserError
      [400, { 'Content-Type' => 'text/plain' }, ['Invalid JSON: ' + error.message]]
    when Sinatra::NotFound
      [404, { 'Content-Type' => 'text/plain' }, ['Not Found: ' + error.message]]
    else
      [500, { 'Content-Type' => 'text/plain' }, ['Internal Server Error: ' + error.message]]
    end
  end
end
