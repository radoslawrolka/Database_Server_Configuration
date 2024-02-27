CREATE view dbo.[Opis kursu] as
    SELECT C.CourseID,
           C.Title         as 'Course Title',
           M.Title         as 'Module Name',
           M.Date          as 'Module Date',
           ModuleType.Name as 'Module Type',
           M.RoomID        as 'Room',
           M.Link          as 'Link',
           FieldType.Name  as 'Field'
    FROM Courses as C
             LEFT OUTER JOIN Modules as M ON C.CourseID = M.CourseID
             LEFT OUTER JOIN ModuleType ON M.ModuleType = ModuleType.ModuleTypeID
             LEFT OUTER JOIN FieldType ON M.FieldID = FieldType.FieldTypeID
go

grant select on [Opis kursu] to Director
go

