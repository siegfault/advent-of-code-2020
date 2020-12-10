:- module(day07, [load_knowledge/0, load_knowledge/1, can_be_contained_in/3, capacity/2]).

:- use_module(library(clpfd)).
:- use_module(library(pcre)).

% usage:
% $ swipl -s day07.pl
% ?- load_knowledge.
% true
% ?- capacity("shiny gold", Count).
% Count = 32.

load_knowledge :- load_knowledge_from('input/day07/example.txt').
load_knowledge(Filename) :- load_knowledge_from(Filename).
load_knowledge_from(Filename) :-
  open(Filename, read, Stream),
  parse_lines(Stream, Lines),
  maplist(parse_line, Lines, Subs),
  maplist(define_luggage, Subs).

parse_lines(Stream, []) :- at_end_of_stream(Stream), !.
parse_lines(Stream, [Line|Rest]) :-
  read_string(Stream, "\n", "\r", _End, Line),
  parse_lines(Stream, Rest).
parse_line(Line, Sub) :-
  re_matchsub("(?<description_S>\\w+ \\w+) bags contain (?<elements_S>((\\d+ \\w+ \\w+|no other) bag[s ,]*)+)\\.", Line, Sub, []).
parse_elements("no other bags.", ElementList) :- ElementList = [].
parse_elements(ElementString, ElementList) :-
  re_foldl(parse_element, "(?<count>\\d+) (?<description>\\w+ \\w+) bag", ElementString, [], ElementList, []).
parse_element(Match, V0, V1) :-
  append([Match], V0, V1).

% Relationships
define_luggage(Sub) :-
  assert(luggage(Sub.description)),
  parse_elements(Sub.elements, ElementList),
  foldl(define_containment, ElementList, Sub.description, _Description).
define_containment(Element, Description, Description) :-
  atom_number(Element.count, Count),
  assert(contains(Description, Count, Element.description)).

holder(Parent, Element) :- contains(Parent, _, Element).
holder(Parent, Element) :- contains(Parent, _, X), holder(X, Element).

% Query Methods
can_be_contained_in(Element, SortedList, Count) :-
  findall(X, holder(X, Element), List),
  sort(List, SortedList),
  length(SortedList, Count).

capacity(Element, Count) :-
  capacity_including_self(Element, ChildCount),
  Count is ChildCount - 1.

capacity_including_self(Element, Count) :-
  findall([NumberOfChildren,Child|_], contains(Element, NumberOfChildren, Child), List),
  foldl(child_capacity, List, 0, Sum),
  Count is 1 + Sum.

child_capacity(List, V0, Capacity) :-
  [NumberOfChildren,Child,_] = List,
  capacity_including_self(Child, ChildCapacity),
  Capacity is V0 + ChildCapacity * NumberOfChildren.
