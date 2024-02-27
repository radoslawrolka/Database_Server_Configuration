create view dbo.[Spis pracowników] as
SELECT 'Translator' AS Role, TranslatorID AS ID, FirstName + ' ' + LastName AS [Imie i Nazwisko] FROM Translators
UNION
SELECT 'Coordinator' AS Role, CoordinatorID AS ID, FirstName + ' ' + Lastname AS [Imie i Nazwisko] FROM Coordinator
UNION
SELECT 'Teacher' AS Role, TeacherID AS ID, FirstName + ' ' + Lastname AS [Imie i Nazwisko] FROM Teachers
go

grant select on [Spis pracowników] to Director
go

