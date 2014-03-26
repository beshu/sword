require'rack';require'tilt';class Sword;M=(R=Rack)::Mime::MIME_TYPES.invert;P=
'PATH_INFO';D=File.dirname __FILE__;class<<self;def g(p,&b);@@r[p]=b;end;alias:n
:new;def new;@@x.run n;@@x end;@@x=R::Builder.new;def _;@@s,@@r=[],{};Dir['**/*'
].each{|f|(t=Tilt[f])?g("/#{f.chomp File.extname f}#{M[m=t.default_mime_type]}"
){q m;t.new(f).render(self)}:@@s<<"/#{f}"};@@x.use(R::Static,:urls=>@@s);g(i=
'/favicon'<<z='.ico'){q M.key z;File.read"#{D}#{i}"}end end;def q t;@c.headers[
'Content-Type']=t;end;def call a;@a=a;@b=R::Request.new@a;@c=R::Response.new;l=
@@r[@b.path_info];@c.write instance_eval(&l ?l:proc{|e|@@r[i="#{(n=@a[P]).chomp(
'/')}/index.html"]?call(@a.merge P=>i)[-1]:(@@x.instance_eval{@use.clear};Sword.
_;@@r[n]||@@s.include?(n)?@c.redirect(n):Tilt.new("#{D}/404.erb").render(n))})
@c.finish end end
