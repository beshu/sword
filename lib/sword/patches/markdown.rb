Sword::Patch.new %w[redcarpet rdiscount maruku bluecloth] do
  Tilt['md'].default_mime_type = 'text/html'
end
