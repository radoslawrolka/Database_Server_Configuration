use u_wojtas
go

create role Student authorization dbo
go

grant execute on dbo.BuyCourse to Student
go

grant execute on dbo.BuyStudy to Student
go

grant execute on dbo.BuyWebinar to Student
go

grant execute on dbo.GetClasses to Student
go

