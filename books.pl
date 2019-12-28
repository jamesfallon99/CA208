book(monty_python, cleese, comedy, 300).
book(illiad, homer, study, 500).
book(c, richie, study, 150).
book(nt_bible, sams, reference, 480).
book(intersteller, nolan, fiction, 300).
book(life, me, drama, 200).

buildLibrary(Lib) :- findall(book(Title, Author, Genre, Size), book(Title, Author,
Genre, Size), Lib).

is_revision(book(_, _, G, S)) :- G == study; G == reference, S > 300.
revision(B, [B| _]) :- is_revision(B).
revision(B, [_ | T]) :- revision(B,T).


is_holiday(book(_, _, G, S)) :- G \== study, G \== reference, S < 400.
holiday(B, [B|_]) :- is_holiday(B).
holiday(B, [_ | T]) :- holiday(B,T).

is_literary(book(_, _, G, _)) :- G == drama.
literary(B, [B|_]) :- is_literary(B).
literary(B, [_|T]) :- literary(B, T).

is_leisure(book(_, _, G, _)) :- G == comedy; G == fiction.
leisure(B, [B|_]) :- is_leisure(B).
leisure(B, [_|T]) :- leisure(B, T).
