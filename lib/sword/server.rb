require'hobbit';require'tilt';class Sword::Server<Hobbit::Base;M={'application/javascript'=>
'js','text/css'=>'css','text/html'=>'html'};def self.r;s=[];Dir['**/*'].each{|f|(t=Tilt[f]).nil??
s<<"/#{f}":get("/#{f.chomp File.extname f}.#{M[m=t.default_mime_type]}"){response.headers[
'Content-Type']="#{m};charset=utf-8";t.new(f).render}};use Rack::Static,:urls=>s;get('*'){$S==v=
env['REQUEST_PATH']?($S=nil;raise LoadError):((k=self.class).instance_eval{routes['GET']=[]};k.r)
response.redirect$S=v}end;r end
