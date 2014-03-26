Sword::Patch.new 'compass' do
  Compass.configuration { |c|
    c.output_style     = :compressed
    c.line_comments    = false
    c.relative_assets  = true
    c.cache            = true
    c.sass_dir         = '.'
    c.images_dir       = c.sass_dir
    c.http_images_path = c.sass_dir
    c.http_path        = '/'
    c.http_stylesheets_path = c.http_path
  }

  [Tilt::ScssTemplate, Tilt::SassTemplate].each do |klass|
    klass.class_eval do
      def sass_options
        Compass.sass_engine_options.merge(options).
        merge :filename => eval_file, :line => line
      end
    end
  end
end
