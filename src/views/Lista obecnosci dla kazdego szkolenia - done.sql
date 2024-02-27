CREATE view dbo.[Lista obecnosci dla kazdego szkolenia - done] as
    SELECT 'lecture' + cast(LP.LectureID as varchar)
                  as 'Name',
           L.Date as 'date',
           S.StudentID,
           S.FirstName,
           S.LastName,
           LP.WasPresent
    from LecturePresence LP
             inner join Lecture L on L.LectureID = LP.LectureID
             left join Students S on S.StudentID = LP.StudentID
    union
    SELECT 'module' + cast(MP.ModuleID as varchar)
                  as 'Name',
           M.Date as 'date',
           S.StudentID,
           S.FirstName,
           S.LastName,
           MP.WasPresent
    from ModulePresence MP
             inner join Modules M on M.ModuleID = MP.ModuleID
             left join Students S on S.StudentID = MP.StudentID
go

grant select on [Lista obecnosci dla kazdego szkolenia - done] to Director
go

