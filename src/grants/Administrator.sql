use u_wojtas
go

create role Administrator authorization dbo
go

grant create function, create procedure, create view, execute on database :: u_wojtas to Administrator
go

grant delete, insert, select, update on dbo.Cities to Administrator
go

grant delete, insert, select, update on dbo.Coordinator to Administrator
go

grant delete, insert, select, update on dbo.Countries to Administrator
go

grant delete, insert, select, update on dbo.Courses to Administrator
go

grant delete, insert, select, update on dbo.FieldType to Administrator
go

grant delete, insert, select, update on dbo.Grades to Administrator
go

grant delete, insert, select, update on dbo.Languages to Administrator
go

grant delete, insert, select, update on dbo.Lecture to Administrator
go

grant delete, insert, select, update on dbo.LecturePresence to Administrator
go

grant delete, insert, select, update on dbo.Meetings to Administrator
go

grant delete, insert, select, update on dbo.ModulePresence to Administrator
go

grant delete, insert, select, update on dbo.Modules to Administrator
go

grant delete, insert, select, update on dbo.[Order] to Administrator
go

grant delete, insert, select, update on dbo.OrderDetails to Administrator
go

grant delete, insert, select, update on dbo.Postponed to Administrator
go

grant delete, insert, select, update on dbo.Practises to Administrator
go

grant delete, insert, select, update on dbo.ProductType to Administrator
go

grant delete, insert, select, update on dbo.Products to Administrator
go

grant delete, insert, select, update on dbo.Room to Administrator
go

grant delete, insert, select, update on dbo.Students to Administrator
go

grant delete, insert, select, update on dbo.Studies to Administrator
go

grant delete, insert, select, update on dbo.SubjectGrade to Administrator
go

grant delete, insert, select, update on dbo.Subjects to Administrator
go

grant delete, insert, select, update on dbo.Teachers to Administrator
go

grant delete, insert, select, update on dbo.Translators to Administrator
go

grant delete, insert, select, update on dbo.TranslatorsLanguage to Administrator
go

grant delete, insert, select, update on dbo.Webinars to Administrator
go

grant delete, insert, select, update on dbo.passedCourse to Administrator
go

grant delete, insert, select, update on dbo.passedStudies to Administrator
go

