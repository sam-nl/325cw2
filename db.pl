%lex:
det(singular,(det(the))) --> [the].
det(plural,(det(the))) --> [the].

det(singular,det(a)) --> [a].

det(plural,det(two)) --> [two].

n(animate,singular,n(woman))--> [woman].
n(animate,plural,n(women))--> [women].

n(animate,singular,n(man))--> [man].
n(animate,plural,n(men))--> [men].

n(inanimate,singular,n(apple))--> [apple].
n(inanimate,plural,n(apples))--> [apples].

n(inanimate,singular,n(room))--> [room].
n(inanimate,plural,n(rooms))--> [rooms].

n(inanimate,singular,n(chair))--> [chair].
n(inanimate,plural,n(chairs))--> [chairs].

v(animate,tv,first,singular,v(know))--> [know].
v(animate,tv,second,singular,v(know))--> [know].
v(animate,tv,third,singular,v(know))--> [know].
v(animate,tv,_,plural,v(knows))--> [knows].

v(animate,tv,first,singular,v(see))--> [see].
v(animate,tv,second,singular,v(see))--> [see].
v(animate,tv,third,singular,v(see))--> [see].
v(animate,tv,_,plural,v(sees))--> [sees].

v(animate,tv,first,singular,v(hire))--> [hire].
v(animate,tv,second,singular,v(hire))--> [hire].
v(animate,tv,third,singular,v(hire))--> [hire].
v(animate,tv,_,plural,v(hires))--> [hires].

v(inanimate,iv,first,singular,v(fall))--> [fall].
v(inanimate,iv,second,singular,v(fall))--> [fall].
v(inanimate,iv,third,singular,v(fall))--> [fall].
v(inanimate,iv,_,plural,v(falls))--> [falls].

v(animate,iv,first,singular,v(sleep))--> [sleep].
v(animate,iv,second,singular,v(sleep))--> [sleep].
v(animate,iv,third,singular,v(sleep))--> [sleep].
v(animate,iv,_,plural,v(sleeps))--> [sleeps].

prep(prep(on))--> [on].

prep(prep(in))--> [in].

prep(prep(under))--> [under].

adj(adj(short))--> [short].

adj(adj(tall))--> [tall].

adj(adj(young))--> [young].

adj(adj(old))--> [old].

adj(adj(red))--> [red].

pro(first,singular,object,pro(him))--> [him].
pro(third,singular,subject,pro(he))--> [he].

pro(first,singular,object,pro(her))--> [her].
pro(third,singular,subject,pro(she))--> [she].

pro(first,plural,object,pro(them))--> [them].
pro(third,plural,subject,pro(they))--> [they].

pro(first,plural,object,pro(us))--> [us].
pro(third,plural,subject,pro(we))--> [we].

pro(first,singular,subject,pro(i))--> [i].
pro(first,singular,object,pro(me))--> [me].

pro(second,singular,object,pro(you))--> [you].
pro(second,plural,object,pro(you))--> [you].
pro(second,singular,subject,pro(you))--> [you].
pro(second,plural,subject,pro(you))--> [you].

pro(third,singular,object,pro(it))--> [it].
pro(third,singular,subject,pro(it))--> [it].

%phrases:
%A = obj/subj B = plural/single, C= animate

np(C,_,B,_,np(Det,N))--> det(B,Det), nbar(C,B,N).
np(C,_,B,_,np(Det,N,PP))--> det(B,Det), nbar(C,B,N), pp(PP).

np(_,first,B,A,np(Pro)) --> pro(first,B,A,Pro).
np(_,second,B,A,np(Pro)) --> pro(second,B,A,Pro).
np(_,third,B,A,np(Pro)) --> pro(third,B,A,Pro).

vp(C,B,vp(V,NP))--> v(C,_,_,B,V), np(_,_,_,object,NP).
vp(C,B,vp(V))--> v(C,_,_,B,V).

nbar(C,B,nbar(N))--> n(C,B,N) | jp(B,N).

jp(B,jp(J,N))--> adj(J), n(_,B,N).
jp(B,jp(J,JP))--> adj(J), jp(B,JP).

pp(pp(P,NP))--> prep(P), np(_,_,_,_,NP).

%sentences:
%
%inanimate:
s(s(NP,VP))--> np(_,first,singular,subject,NP), vp(inanimate,singular,VP).
s(s(NP,VP))--> np(_,third,singular,subject,NP), vp(inanimate,plural,VP).
s(s(NP,VP))--> np(_,third,plural,subject,NP), vp(inanimate,singular,VP).
s(s(NP,VP))--> np(_,second,singular,subject,NP), vp(inanimate,singular,VP).
s(s(NP,VP))--> np(_,second,plural,subject,NP), vp(inanimate,singular,VP).

%animate
s(s(NP,VP))--> np(animate,first,singular,subject,NP), vp(_,singular,VP).
s(s(NP,VP))--> np(animate,third,singular,subject,NP), vp(_,plural,VP).
s(s(NP,VP))--> np(animate,third,plural,subject,NP), vp(_,singular,VP).
s(s(NP,VP))--> np(animate,second,singular,subject,NP), vp(_,singular,VP).
s(s(NP,VP))--> np(animate,second,plural,subject,NP), vp(_,singular,VP).

/*
---------------------
tests: (animate testing at bottom)
1
?- s(Tree,[the,woman,sees,the,apples],[]).
Tree = s(np(det(the), nbar(n(woman))), vp(v(sees), np(det(the), nbar(n(apples))))) .
2
?- s(Tree,[a,woman,knows,him],[]).
Tree = s(np(det(a), nbar(n(woman))), vp(v(knows), np(pro(him)))) .
3
?- s(Tree,[two,woman,hires,a,man],[]).
false.
4
?- s(Tree,[she,knows,her],[]).
Tree = s(np(pro(she)), vp(v(knows), np(pro(her)))) .
5
?- s(Tree,[she,know,the,man],[]).
false.
6
?- s(Tree,[us,see,the,apple],[]).
false.
7
?- s(Tree,[we,see,the,apple],[]).
Tree = s(np(pro(we)), vp(v(see), np(det(the), nbar(n(apple))))) .
8
?- s(Tree,[i,know,a,short,man],[]).
Tree = s(np(pro(i)), vp(v(know), np(det(a), nbar(jp(adj(short), n(man)))))) .
9
?- s(Tree,[he,hires,they],[]).
false.
10
?- s(Tree,[two,apples,fall],[]).
Tree = s(np(det(two), nbar(n(apples))), vp(v(fall))) .
11
?- s(Tree,[the,apple,falls],[]).
Tree = s(np(det(the), nbar(n(apple))), vp(v(falls))) .
12
?- s(Tree,[the,apples,fall],[]).
Tree = s(np(det(the), nbar(n(apples))), vp(v(fall))) .
13
?- s(Tree,[i,sleep],[]).
Tree = s(np(pro(i)), vp(v(sleep))) .
14
?- s(Tree,[you,sleep],[]).
Tree = s(np(pro(you)), vp(v(sleep))) .
15
?- s(Tree,[she,sleeps],[]).
Tree = s(np(pro(she)), vp(v(sleeps))) .
16
?- s(Tree,[he,sleep],[]).
false.
17
?- s(Tree,[them,sleep],[]).
false.
18
?- s(Tree,[a,men,sleep],[]).
false.
19
?- s(Tree,[the,tall,woman,sees,the,red],[]).
false.
20
?- s(Tree,[the,young,tall,man,knows,the,old,short,woman],[]).
Tree = s(np(det(the), nbar(jp(adj(young), jp(adj(tall), n(man))))), vp(v(knows), np(det(the), nbar(jp(adj(old), jp(adj(short), n(woman))))))) .
21
?- s(Tree,[the,young,tall,man,knows,the,old,short,woman],[]).
Tree = s(np(det(the), nbar(jp(adj(young), jp(adj(tall), n(man))))), vp(v(knows), np(det(the), nbar(jp(adj(old), jp(adj(short), n(woman))))))) .
22
?- s(Tree,[a,man,tall,knows,the,short,woman],[]).
false.
23
?- s(Tree,[a,man,on,a,chair,sees,a,woman,in,a,room],[]).
Tree = s(np(det(a), nbar(n(man)), pp(prep(on), np(det(a), nbar(n(chair))))), vp(v(sees), np(det(a), nbar(n(woman)), pp(prep(in), np(det(a), nbar(n(room))))))) .
24
?- s(Tree,[a,man,on,a,chair,sees,a,woman,a,room,in],[]).
false.
25 ([write])
?-
s(Tree,[the,tall,young,woman,in,a,room,on,the,chair,in,a,room,in,the,room,sees,the,red,apples,under,the,chair],[]).
Tree = s(np(det(the), nbar(jp(adj(tall), jp(adj(young), n(woman)))), pp(prep(on), np(det(the), nbar(n(chair)), pp(prep(in), np(det(a), nbar(n(room)), pp(prep(in), np(det(the), nbar(n(room))))))))), vp(v(sees), np(det(the), nbar(jp(adj(red), n(apples))), pp(prep(under), np(det(the), nbar(n(chair)))))))

-----------------------
EXAMPLES:

?-  s(Tree,[she,knows,her],[]).
Tree = s(np(pro(she)), vp(v(knows), np(pro(her)))) .

?- s(Tree, [the, woman, on, two, chairs, in, a, room, sees, two, tall, young, men], []).
Tree = s(np(det(the), nbar(n(woman)), pp(prep(on), np(det(two), nbar(n(chairs)), pp(prep(in), np(det(a), nbar(n(room))))))), vp(v(sees), np(det(two), nbar(jp(adj(tall), jp(adj(young), n(men)))))))

-----------------------
ANIMATE TESTS:

1
?- s(Tree,[the,woman,sees,the,apples],[]).
Tree = s(np(det(the), nbar(n(woman))), vp(v(sees), np(det(the), nbar(n(apples))))) .
2
?- s(Tree,[a,woman,knows,him],[]).
Tree = s(np(det(a), nbar(n(woman))), vp(v(knows), np(pro(him)))) .
3
?- s(Tree,[the,man,sleeps],[]).
Tree = s(np(det(the), nbar(n(man))), vp(v(sleeps))) .
4
?- s(Tree,[the,room,sleeps],[]).
false.
5
?- s(Tree,[the,apple,sees,the,chair],[]).
false.
6
?- s(Tree,[the,rooms,know,the,man],[]).
false.
7
?- s(Tree,[the,apple,falls],[]).
Tree = s(np(det(the), nbar(n(apple))), vp(v(falls))) .
8
?- s(Tree,[the,man,falls],[]).
Tree = s(np(det(the), nbar(n(man))), vp(v(falls))) .
*/











