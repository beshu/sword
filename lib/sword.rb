require'hobbit';require'tilt';class Sword<Hobbit::Base;def self._;s=[];Dir['**/*'].each{|f|(t=Tilt[
f])?get("/#{f.chomp File.extname f}#{(@@r=Rack::Mime::MIME_TYPES).key m=t.default_mime_type}"){(@@h=
lambda{|m|response.headers['Content-Type']=m}).call m;t.new(f).render}:s<<"/#{f}"};use Rack::Static,
:urls=>s;get(i="/favicon.ico"){@@h.call@@r['.ico'];File.read"#{File.dirname __FILE__}#{i}"};get('*'
){(@@p=0;raise)if(@@p||=0)==@@p=env['REQUEST_PATH'];(k=self.class).instance_eval{routes['GET']=[]}
k._;response.redirect@@p}end end
