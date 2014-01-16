require'tilt';require'rack';class Sword;M=(R=Rack)::Mime::MIME_TYPES.invert;P=
'PATH_INFO';class<<self;def g(p,&b);r[p]=b;end;alias:m:new;def new;x.run m;x end
def r;@r||={};end;def x;@x||=R::Builder.new;end;def w;@r={};@x.instance_eval{
@use.clear};_ end;def _;@@t,s=0,[];Dir['**/*'].each{|f|(t=Tilt[f])?g("/#{f.chomp(
File.extname f)}#{M[m=t.default_mime_type]}"){q m;t.new(f).render(self)}:s<<"/#{
f}"};x.use(R::Static,:urls=>s);g(i='/favicon'<<z='.ico'){q M.key z;File.read"#{
File.dirname __FILE__}#{i}"}end end;def q t;@c.headers['Content-Type']=t end;def
call a;@a=a;@b=R::Request.new@a;@c=R::Response.new;l=Sword.r[@b.path_info];@c.
write instance_eval(&l ?l:proc{|e|@@t<2?e.instance_eval{@@t+=1;@c=call(@a.merge({
P=>"#{@a[P].chomp'/'}/index.html"}))[-1];@@t=0}:((@@t=0;raise@@p='NOT FOUND')if(
@@p||=0)==@@p=@a['REQUEST_PATH'];e.class.w;@c.redirect@@p)});@c.finish end end
