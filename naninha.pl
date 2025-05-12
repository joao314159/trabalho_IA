:- dynamic aqui/1, localizacao/2, tem/1, escondido/1, naninha_demoniaca/1. %modificação

comodo(cozinha).
comodo(escritorio).
comodo(entrada).
comodo('sala de jantar').

comodo(lavanderia).

localizacao(mesa, escritorio).
localizacao(lanterna, escritorio).
localizacao(maca,cozinha).
localizacao(biscoitos,cozinha).
localizacao(brocolis, cozinha).
localizacao(naninha, lavanderia).
localizacao(computador, escritorio).

localizacao(caixa, escritorio). %modificação
localizacao(agua-benta,lavanderia).  %modificação


porta(escritorio, entrada).
porta(cozinha, escritorio).
porta(entrada, 'sala de jantar').
porta(cozinha,lavanderia).
porta('sala de jantar', cozinha).

aqui(cozinha).

%modificações

escondido(nao).
naninha_demoniaca(sim).

esconda :-
    tem(caixa),
    retract(escondido(_)),
	asserta(escondido(sim)),
	write('Voce esta seguro ').



%regras

conecta(X,Y):-porta(X,Y).
conecta(X,Y):-porta(Y,X).


lista_coisas(Lugar):-
    localizacao(X, Lugar),
    write(X),
    nl, fail.

lista_coisas(_).

lista_conexoes(Lugar):-
    conecta(Lugar,X),
    write(X),
    nl, fail.

lista_conexoes(_).

veja:-
   aqui(Lugar),
   write('Voce esta no/na '), write(Lugar),
   nl,
   write('Voce pode ver: '), nl,
   lista_coisas(Lugar),
   write('Voce pode ir: '), nl,
   lista_conexoes(Lugar).

%modificação
naninha_esta_em_lugar(Lugar):-
    localizacao(naninha,Lugar).


pode_ir(Lugar):-
    aqui(X),
    conecta(X, Lugar).
pode_ir(_):-
    write('Voce nao pode ir ate la'), nl, fail.


mova(Lugar):-
    retract(aqui(_)),
    asserta(aqui(Lugar)).

pegue(X):-
    pode_pegar(X),
    pegue_objeto(X).

pegue(_).

pode_pegar(Coisa):-
    aqui(Lugar),
    localizacao(Coisa,Lugar).

pode_pegar(Coisa):-
    write('Nao existe nenhuma (a) '), write(Coisa),
          write(' aqui.'), nl, fail.

pegue_objeto(X):-
    retract(localizacao(X,_)),
    asserta(tem(X)),
    write('Peguei!'), nl.


goto(Lugar):-
    
    
    
    desafio(goto(Lugar)),
    pode_ir(Lugar),
    mova(Lugar), veja,
    
    %modificações
    naninha_esta_em_lugar(Lugar),
    pode_pegar(naninha),
    escondido(nao),
    naninha_demoniaca(sim),
    write(''),
    write(''),
    write('MORREU'),
    write(''),
    write(''),
    do(fim),
    fim_condicao(fim).
    
    
   

goto(_).

desafio(goto(lavanderia)):-
        tem(lanterna),!.

desafio(goto(lavanderia)):-
    write('Esta escuro e você tem medo do escuro'),nl, !, fail.

desafio(_).





loop:-
    write('Bem-vindo(a) a busca da naninha'),
    nl,
    repeat,
    write('>naninha> '),
    read(X),
    desafio(X),
    do(X), (X=fim,!; nl,
    fim_condicao(X)).

do(goto(X)):-goto(X),!.
do(tem(X)):-tem(X),!.
do(veja):-veja,!.
do(pegue(X)):-pegue(X), !.
do(fim).
do(esconda) :- esconda,!. %modificação
do(_):- write('Comando invalido').

fim_condicao(fim):-write('Você encerrou o jogo.').
fim_condicao(_):-  
    tem(naninha),
    write('Parabéns, voce ganhou').
