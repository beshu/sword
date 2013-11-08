require'hobbit';require'tilt';class Sword<Hobbit::Base;def self._;c,o,s=lambda{|
m,s|s.response.headers['Content-Type']=m},Rack::Mime::MIME_TYPES,[];Dir['**/*'].
each{|f|(t=Tilt[f])?get("/#{f.chomp File.extname f}#{o.key m=t.default_mime_type
}"){c.call m,self;t.new(f).render}:s<<"/#{f}"};use Rack::Static,:urls=>s;get(i=
"/favicon.ico"){c.call o['.ico'],self;File.read"#{File.dirname __FILE__}#{i}"}
get('*'){(raise@@p=MethodError)if(@@p||=0)==@@p=env['REQUEST_PATH'];(k=self.
class).instance_eval{routes['GET']=[]};k._;response.redirect@@p}end end
