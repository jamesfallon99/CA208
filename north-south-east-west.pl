north(a,f).
north(b,g).
north(c,h).
north(d,i).
north(e,j).
north(f,k).
north(g,l).
north(h,m).
north(i,n).
north(j,o).
north(k,p).
north(l,q).
north(m,r).
north(n,s).
north(o,t).

west(a,b).
west(b,c).
west(c,d).
west(d,e).
west(f,g).
west(g,h).
west(h,i).
west(i,j).

west(k,l).
west(l,m).
west(m,n).
west(n,o).
west(p,q).
west(q,r).
west(r,s).
west(s,t).

south(X,Y) :- north(Y,X).
south-west(X,Y) :- south(X,Z),west(Z,Y).
south-east(X,Y) :- south(X,Z), west(Y,Z).

north-west(X,Y) :- north(Z,Y), west(X,Z).
north-east(X,Y) :- north(Z,Y), west(Z,X).

east(X,Y) :- west(Y,X).
