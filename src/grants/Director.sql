use u_wojtas
go

create role Director authorization dbo
go

grant delete, insert, select, update on dbo.Postponed to Director
go

grant select on dbo.[Frekwencja na zakonczonych wydarzeniach - done] to Director
go

grant select on dbo.[Harmonogram zajęć dla studentów] to Director
go

grant select on dbo.[Lista dluznikow - done] to Director
go

grant select on dbo.[Lista obecnosci dla kazdego szkolenia - done] to Director
go

grant select on dbo.[Opis kursu] to Director
go

grant select on dbo.[Osoby na wydarzeniach -done] to Director
go

grant select on dbo.Praktyki to Director
go

grant select on dbo.[Przedmioty posiadane przez użytkowników] to Director
go

grant select on dbo.[Raport Bilokacji - done] to Director
go

grant select on dbo.[Raporty finansowe - done] to Director
go

grant select on dbo.[Spis pracowników] to Director
go

grant select on dbo.[Syllabus studiów] to Director
go

