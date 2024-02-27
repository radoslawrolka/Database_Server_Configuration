use u_wojtas
go

create role Coordinator authorization dbo
go

grant delete, insert, select, update on dbo.Coordinator to Coordinator
go

grant delete, insert, select, update on dbo.Courses to Coordinator
go

grant delete, insert, select, update on dbo.FieldType to Coordinator
go

grant delete, insert, select, update on dbo.Grades to Coordinator
go

grant delete, insert, select, update on dbo.Lecture to Coordinator
go

grant delete, insert, select, update on dbo.LecturePresence to Coordinator
go

grant delete, insert, select, update on dbo.Meetings to Coordinator
go

grant delete, insert, select, update on dbo.ModulePresence to Coordinator
go

grant delete, insert, select, update on dbo.Modules to Coordinator
go

grant delete, insert, select, update on dbo.Room to Coordinator
go

grant delete, insert, select, update on dbo.Studies to Coordinator
go

grant delete, insert, select, update on dbo.SubjectGrade to Coordinator
go

grant delete, insert, select, update on dbo.Subjects to Coordinator
go

grant delete, insert, select, update on dbo.Webinars to Coordinator
go

grant delete, insert, select, update on dbo.passedCourse to Coordinator
go

grant delete, insert, select, update on dbo.passedStudies to Coordinator
go

grant execute on dbo.AddGrade to Coordinator
go

