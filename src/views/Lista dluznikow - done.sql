CREATE view dbo.[Lista dluznikow - done] as
    SELECT S.StudentID,
           S.FirstName,
           S.LastName,
           D.deficit
    FROM Students S
             INNER JOIN
         (SELECT O.StudentID, SUM(OD.Price - O.Paid) AS 'deficit'
          FROM [Order] O
                   INNER JOIN OrderDetails OD on O.OrderID = OD.OrderID
                   INNER JOIN Products P on OD.ProductID = P.ProductID
                   INNER JOIN ProductType PT on P.ProductTypeID = PT.ProductTypeID
                   left JOIN Webinars W on P.ProductID = W.WebinarID
                   left JOIN Studies ST on P.ProductID = ST.StudyID
                   left JOIN Courses C on P.ProductID = C.CourseID
          WHERE O.Paid < OD.Price
            and ((PT.Name = 'Webinar' and W.CreatedDate > GETDATE()) or
                 (PT.Name = 'Course' and C.StartingDate > DATEADD(day, 3, GETDATE())) or
              --(PT.Name = 'Study'   and 1) or
                 (PT.Name = 'Meeting' and (SELECT MIN(L.Date)
                                           FROM Lecture L
                                                    INNER JOIN Meetings M on L.MeetingID = M.MeetingID
                                           WHERE M.MeetingID = P.ProductID) > DATEADD(day, 3, GETDATE()))
              )
          GROUP BY O.StudentID) D on D.StudentID = S.StudentID
go

grant select on [Lista dluznikow - done] to Director
go

