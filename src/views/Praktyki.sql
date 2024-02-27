create view dbo.Praktyki as
SELECT S.StudentID, S.FirstName + ' ' + S.LastName AS 'Imie i Nazwisko', P.CompanyName, P.BegginingDate, P.EndDate, P.IsCompleted FROM Students AS S
RIGHT JOIN Practises AS P ON S.StudentID = P.StudentID
UNION
SELECT S2.StudentID, S2.FirstName + ' ' + S2.LastName,'Praktyki nieodbyte', NULL, NULL, NULL FROM Students AS S2
WHERE S2.StudentID NOT IN (SELECT S.StudentID FROM Students AS S RIGHT JOIN Practises AS P ON S.StudentID = P.StudentID)
go

grant select on Praktyki to Director
go

