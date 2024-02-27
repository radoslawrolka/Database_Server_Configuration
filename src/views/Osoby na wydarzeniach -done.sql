CREATE view dbo.[Osoby na wydarzeniach] as
    SELECT P.ProductID, W.Title, 'Online' as 'Type', Count(*) as 'Count'
    FROM Products P
             INNER JOIN Webinars W ON P.ProductID = W.WebinarID
             Inner Join OrderDetails OD ON P.ProductID = OD.ProductID
    WHERE CreatedDate > getdate()
    GROUP BY P.ProductID, W.Title
    UNION
    SELECT P.ProductID, M.Title, MT.Name, Count(*)
    FROM Products P
             INNER JOIN Courses C ON P.ProductID = C.CourseID
             Inner Join OrderDetails OD ON P.ProductID = OD.ProductID
             Inner Join Modules M ON C.CourseID = M.CourseID
             INNER JOIN ModuleType MT ON M.ModuleType = MT.ModuleTypeID
    WHERE C.StartingDate > getdate()
    GROUP BY P.ProductID, M.Title, MT.Name
    UNION
    SELECT P.ProductID,
           'Lecture' + CAST(L.LectureID AS VARCHAR) AS LectureID,
           CASE
               WHEN L.Link IS NULL THEN 'Offline'
               ELSE 'Online'
               END                                  AS LectureType,
           Count(*)
    FROM Products P
             INNER JOIN OrderDetails OD ON P.ProductID = OD.ProductID
             INNER JOIN Meetings M ON P.ProductID = M.MeetingID
             INNER JOIN Lecture L ON M.MeetingID = L.MeetingID
    WHERE L.Date > getdate()
    GROUP BY P.ProductID, L.LectureID, L.Link
go

grant select on [Osoby na wydarzeniach -done] to Director
go

