require'hobbit';require'tilt';class Sword<Hobbit::Base;def self._;s,c,o,@@t=[],
lambda{|x,y|y.response.headers['Content-Type']=x},Rack::Mime::MIME_TYPES.invert,
0;Dir['**/*'].each{|f|(t=Tilt[f])?get("/#{f.chomp File.extname f}#{o[m=t.
default_mime_type]}"){c[m,self];t.new(f).render}:s<<"/#{f}"};use Rack::Static,
:urls=>s;get(i='/favicon'<<z='.ico'){c[o.key(z),self];File.read"#{File.dirname
__FILE__}#{i}"};get('*'){|e|@@t<2?e.instance_eval{@@t+=1;@response=call(@env.
merge p='PATH_INFO'=>"#{@env[p].chomp'/'}/index.html")[-1];@@t=0}:((@@t=0
raise@@p='NOT FOUND')if(@@p||=0)==@@p=env['REQUEST_PATH'];(k=e.class).
instance_eval{routes['GET']=[]};k._;response.redirect@@p)}end end
