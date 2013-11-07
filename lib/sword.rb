require'hobbit';require'tilt';class Sword<Hobbit::Base;def self._;s=[];Dir['**/*'].each{|f|
(t=Tilt[f])?get("/#{f.chomp File.extname f}#{Rack::Mime::MIME_TYPES.key m=t.default_mime_type}"){
response.headers['Content-Type']=m;t.new(f).render}:s<<"/#{f}"};use Rack::Static,:urls=>s;get('*'){
($v=nil;raise)if$v==$v=env['REQUEST_PATH'];(k=self.class).instance_eval{routes['GET']=[]};k._
response.redirect$v}end end
