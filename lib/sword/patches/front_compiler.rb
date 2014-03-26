Sword::Patch.new 'front-compiler' do
  def FrontCompiler.compact_file(*args)
    @instance ||= FrontCompiler.new
    @instance.compact_file(*args)
  end
end
