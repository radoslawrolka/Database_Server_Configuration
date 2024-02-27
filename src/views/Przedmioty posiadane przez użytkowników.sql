CREATE view dbo.[Przedmioty posiadane przez użytkowników] as
    SELECT Students.StudentID,
           CONCAT(Students.FirstName, ' ', Students.LastName) as 'Name',
           ProductType.Name                                   as 'Type',
           (SELECT CASE
                       WHEN ProductType.ProductTypeID = 1 THEN Webinars.Title
                       WHEN ProductType.ProductTypeID = 2 THEN C.Title
                       WHEN ProductType.ProductTypeID = 4 THEN Studies.Name
                       WHEN ProductType.ProductTypeID = 3 THEN ''
                       ELSE ''
                       END AS ProductType)                    as 'Title'
    FROM Students
             INNER JOIN [Order] ON Students.StudentID = [Order].StudentID
             INNER JOIN OrderDetails ON [Order].OrderID = OrderDetails.OrderDetailsID
             INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
             INNER JOIN ProductType ON Products.ProductTypeID = ProductType.ProductTypeID
             LEFT OUTER JOIN Webinars ON Products.ProductID = Webinars.WebinarID
             LEFT OUTER JOIN dbo.Courses C on Products.ProductID = C.CourseID
             LEFT OUTER JOIN Meetings ON Products.ProductID = Meetings.MeetingID
             LEFT OUTER JOIN Studies ON Products.ProductID = Studies.StudyID
go

grant select on [Przedmioty posiadane przez użytkowników] to Director
go

