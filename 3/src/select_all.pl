:- dynamic university/4.% ID, Name, President, VicePresident
:- dynamic faculty/3.   % ID, UniversityID, Area(of specialization)
:- dynamic department/4.% ID, FacultyID, TypeID, Discipline
:- dynamic lab/2.       % ID, DepartmentID

:- multifile university/4.
:- multifile faculty/3.
:- multifile department/4.
:- multifile lab/2.

:- ensure_loaded('table_print.pl').

selectAll :-
    writeln('--- TABLE LISTING ---'),
    writeln('Which table do you want to see?'),
    write('(1 - university, 2 - faculty, 3 - department, 4 - lab): '),
    read(Nm),
    selectAll(Nm).
selectAll(1) :- selectAll(% list all universities
    university,
    ['ID', 'Name', 'President', 'VP'],
    [   5,     20,          40,   40]).
selectAll(2) :- selectAll(% list all faculties
    faculty,
    ['ID', 'UniversityID', 'Name'],
    [   5,             15,     20]).
selectAll(3) :- selectAll(% list all departments
    department,
    ['ID', 'FacultyID', 'TypeID', 'Discipline'],
    [   5,          15,       10,           30]).
selectAll(4) :- selectAll(%list all labs
    lab,
    ['ID', 'DepartmentID'],
    [   5,             15]).

% predicate arity has to be equal to length of both lists
selectAll(Predicate, ColumnNameList, ColumnSizeList) :-
    writeStartEndSeparator(ColumnSizeList),
    writeRow(ColumnNameList, ColumnSizeList),
    length(ColumnNameList, NColumns),
    length(PredicateArgList, NColumns),% Predicate ArgList is now list of free vars
    apply(Predicate, PredicateArgList),
    writeSeparator(ColumnSizeList),
    writeRow(PredicateArgList, ColumnSizeList),
    fail; writeStartEndSeparator(ColumnSizeList).
    % length calculation separate, because when backtracked TotalWidth is free var
