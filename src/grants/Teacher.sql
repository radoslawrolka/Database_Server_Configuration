use u_wojtas
go

create role Teacher authorization dbo
go

grant delete, insert, update on dbo.LecturePresence to Teacher
go

grant delete, insert, update on dbo.ModulePresence to Teacher
go

grant execute on dbo.AddGrade to Teacher
go

