use u_wojtas
go

create role HeadAdministrator authorization dbo
go

grant alter any role, create function, create procedure, create table, create view, execute on database :: u_wojtas to HeadAdministrator
go

grant delete, insert, select, update on dbo.AttendanceAndGrade to HeadAdministrator
go

grant alter, control, delete, insert, select, update on dbo.Cities to HeadAdministrator
go

grant delete, insert, select, update on dbo.Coordinator to HeadAdministrator
go

grant delete, insert, select, update on dbo.Countries to HeadAdministrator
go

grant delete, insert, select, update on dbo.Courses to HeadAdministrator
go

grant delete, insert, select, update on dbo.FieldType to HeadAdministrator
go

grant delete, insert, select, update on dbo.Grades to HeadAdministrator
go

grant delete, insert, select, update on dbo.Languages to HeadAdministrator
go

grant delete, insert, select, update on dbo.Lecture to HeadAdministrator
go

grant delete, insert, select, update on dbo.LecturePresence to HeadAdministrator
go

grant delete, insert, select, update on dbo.Meetings to HeadAdministrator
go

grant delete, insert, select, update on dbo.ModulePresence to HeadAdministrator
go

grant delete, insert, select, update on dbo.Modules to HeadAdministrator
go

grant delete, insert, select, update on dbo.[Order] to HeadAdministrator
go

grant delete, insert, select, update on dbo.OrderDetails to HeadAdministrator
go

grant delete, insert, select, update on dbo.Postponed to HeadAdministrator
go

grant delete, insert, select, update on dbo.Practises to HeadAdministrator
go

grant delete, insert, select, update on dbo.ProductType to HeadAdministrator
go

grant delete, insert, select, update on dbo.Products to HeadAdministrator
go

grant delete, insert, select, update on dbo.Room to HeadAdministrator
go

grant delete, insert, select, update on dbo.Students to HeadAdministrator
go

grant delete, insert, select, update on dbo.Studies to HeadAdministrator
go

grant delete, insert, select, update on dbo.SubjectGrade to HeadAdministrator
go

grant delete, insert, select, update on dbo.Subjects to HeadAdministrator
go

grant delete, insert, select, update on dbo.Teachers to HeadAdministrator
go

grant delete, insert, select, update on dbo.Translators to HeadAdministrator
go

grant delete, insert, select, update on dbo.TranslatorsLanguage to HeadAdministrator
go

grant delete, insert, select, update on dbo.Webinars to HeadAdministrator
go

grant delete, insert, select, update on dbo.passedCourse to HeadAdministrator
go

grant delete, insert, select, update on dbo.passedStudies to HeadAdministrator
go

grant alter on [Microsoft.SqlServer.Types] to HeadAdministrator
go

