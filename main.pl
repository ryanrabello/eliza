pat([bye],[bye]).
pat([hello | _ ], [hello, there]).
pat([i,am | Rest],[why, are, you | Rest]).
pat(List, Rand_fam_resp) :- family(X),member(X,List).
pat(Anything,[tell,me,more,"."]).

family(family).
family(sister).
family(brother).
family(sibling).
family(mother).
family(mom).
family(father).
family(dad).
family(uncle).
family(aunt).
family(cousin).
family(grandfather).
family(grandpa).
family(grandmother).
family(grandma).
family(neice).
family(nephew).

Rand_fam_resp :-  N is random(4),
                  nth0(N, [
                  "Tell me more about your family.",
                  "How would you describe your family?",
                  "Do you have a good relationship with your parents?",
                  Rand_response,
                  "], Elem),
                  write(Elem).

Rand_response :- N is random(4),
                  nth0(N, [
                  "Tell me more.",
                  "Go on",
                  "Why?",
                  "How has the last month been going for you?",
                  "Please continue."
                  "], Elem),
                  write(Elem).



out([]) :- nl.
out([Head|Tail]) :- write(Head),write(' '),out(Tail).

my_char_type(46,period) :- !.

read_string(X) :- get0(Y), char_to_array(Y,X).

char_to_array(10,[]) :- !.
char_to_array(-1,[]) :- !.
char_to_array(X,[X|Rest]) :- read_string(Rest).

in(List) :- read_string(InputL),atom_chars(InputS,InputL),atomic_list_concat(List," ",InputS),write(List).
talk(Output,UserInput) :- out(Output),in(UserInput).

eliza :- rap(['Hey there, I\'m Eliza. How are you feeling right now?']).

rap([bye]) :- write("I look forward to seeing you at our next session. Good bye.").
rap(Output) :-
  talk(Output, UserInput),
  pat(UserInput, NewOutput),
  rap(NewOutput).
