Sword::Patch.new %w[erubis erb] do
  Tilt['erb'].default_mime_type = 'text/html'
end
