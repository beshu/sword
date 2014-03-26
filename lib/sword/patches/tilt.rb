Sword::Patch.new 'tilt' do
  %w[erb md].each do |extension|
    Tilt[extension].default_mime_type = 'text/html'
  end
end
