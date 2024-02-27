CREATE view dbo.[Harmonogram zajęć dla studentów] as
    SELECT Students.StudentID,
           Products.ProductID,
           CONCAT(Students.FirstName, ' ', Students.LastName) AS 'Name',
           (CASE
                WHEN ProductType.ProductTypeID = 1 THEN 'Webinar'
                WHEN ProductType.ProductTypeID = 2 THEN 'Module'
                WHEN ProductType.ProductTypeID = 4 OR ProductType.ProductTypeID = 3 THEN 'Lecture'
                ELSE ''
               END)                                           AS 'Type',
           (CASE
                WHEN ProductType.ProductTypeID = 1 THEN Webinars.Title
                WHEN ProductType.ProductTypeID = 2 THEN Modules.Title
                WHEN ProductType.ProductTypeID = 4 THEN Studies.Name
                WHEN ProductTYpe.ProductTypeID = 3 THEN S.name
                ELSE '' END)                                  as 'Title',
           (CASE
                WHEN ProductType.ProductTypeID = 1 THEN Webinars.CreatedDate
                WHEN ProductType.ProductTypeID = 2 THEN Modules.Date
                WHEN ProductType.ProductTypeID = 4 THEN L.Date
                WHEN ProductType.ProductTypeID = 3 THEN L1.Date
                ELSE NULL
               END)                                           AS 'Data'
    FROM Students
             INNER JOIN [Order] ON Students.StudentID = [Order].StudentID
             INNER JOIN OrderDetails ON [Order].OrderID = OrderDetails.OrderDetailsID
             INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
             INNER JOIN ProductType ON Products.ProductTypeID = ProductType.ProductTypeID
             LEFT OUTER JOIN Webinars ON Products.ProductID = Webinars.WebinarID
             LEFT OUTER JOIN dbo.Courses C ON Products.ProductID = C.CourseID
             LEFT OUTER JOIN Meetings ON Products.ProductID = Meetings.MeetingID
             LEFT OUTER JOIN Studies ON Products.ProductID = Studies.StudyID
             LEFT OUTER JOIN Meetings M ON Studies.StudyID = M.MeetingID
             LEFT OUTER JOIN Lecture ON Meetings.MeetingID = Lecture.MeetingID
             LEFT OUTER JOIN Lecture L ON M.MeetingID = L.MeetingID
             LEFT OUTER JOIN Modules ON C.CourseID = Modules.CourseID
             LEFT OUTER JOIN Lecture L1 ON Meetings.MeetingID = L1.MeetingID
             LEFT OUTER JOIN Studies S ON Meetings.StudyID = S.StudyID
go

grant select on [Harmonogram zajęć dla studentów] to Director
go

