Sword::Patch.new do
  if RUBY_VERSION < '1.9'
    # Ruby 1.8's hashes are unordered, and that
    # makes htm/html extension inconsistent for
    # each run. This fix is especially important
    # for --compile flag support.
    Rack::Mime::MIME_TYPES.delete('.htm')
  end
end
