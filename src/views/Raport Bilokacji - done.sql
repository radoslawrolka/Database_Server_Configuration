CREATE view dbo.[Raport Bilokacji - done] as
    WITH ModulesTable AS (SELECT S.StudentID                     AS Student,
                                 'Module'                        AS Type,
                                 P.ProductID                     AS Product,
                                 M.Date                          AS BeginningDate,
                                 DATEADD(minute, Length, M.Date) AS EndDate,
                                 ModuleID                        AS ID
                          FROM Students AS S
                                   INNER JOIN [Order] AS O ON O.StudentID = S.StudentID
                                   INNER JOIN OrderDetails as OD ON OD.OrderID = O.OrderID
                                   INNER JOIN Products AS P ON P.ProductID = OD.ProductID
                                   LEFT JOIN Courses AS C ON C.CourseID = P.ProductID
                                   LEFT JOIN Modules AS M ON M.CourseID = C.CourseID
                          WHERE M.ModuleType != 3),
         MeetingsTable AS (SELECT S1.StudentID                    AS Student,
                                  'Meeting'                       AS Type,
                                  P.ProductID                     AS Product,
                                  L.Date                          AS BeginningDate,
                                  DATEADD(minute, Length, L.Date) as EndDate,
                                  LectureID                       AS ID
                           FROM Students AS S1
                                    INNER JOIN [Order] AS O ON O.StudentID = S1.StudentID
                                    INNER JOIN OrderDetails as OD ON OD.OrderID = O.OrderID
                                    INNER JOIN Products AS P ON P.ProductID = OD.ProductID
                                    LEFT JOIN Meetings AS M ON M.MeetingID = P.ProductID
                                    LEFT JOIN Lecture AS L ON L.MeetingID = M.MeetingID),
         StudiesTable AS (SELECT S2.StudentID                    AS Student,
                                 'Study'                         AS Type,
                                 P.ProductID                     AS Product,
                                 L.Date                          AS BeginningDate,
                                 DATEADD(minute, Length, L.Date) AS EndDate,
                                 LectureID                       AS ID
                          FROM Students AS S2
                                   INNER JOIN [Order] AS O ON O.StudentID = S2.StudentID
                                   INNER JOIN OrderDetails as OD ON OD.OrderID = O.OrderID
                                   INNER JOIN Products AS P ON P.ProductID = OD.ProductID
                                   LEFT JOIN Studies AS S ON S.StudyID = P.ProductID
                                   LEFT JOIN Meetings AS M ON M.StudyID = S.StudyID
                                   LEFT JOIN Lecture AS L ON L.MeetingID = M.MeetingID),
         UT AS (SELECT T1.Student       AS Student,
                       T1.Type          AS Type,
                       T1.Product       AS Product,
                       T1.BeginningDate AS BeginningDate,
                       T1.EndDate       AS EndDate,
                       T1.ID            AS ID
                FROM ModulesTable as T1
                UNION
                SELECT T2.Student       AS Student,
                       T2.Type          AS Type,
                       T2.Product       AS Product,
                       T2.BeginningDate AS BeginningDate,
                       T2.EndDate       AS EndDate,
                       T2.ID            AS ID
                FROM MeetingsTable as T2
                UNION
                SELECT T3.Student       AS Student,
                       T3.Type          AS Type,
                       T3.Product       AS Product,
                       T3.BeginningDate AS BeginningDate,
                       T3.EndDate       AS EndDate,
                       T3.ID            AS ID
                FROM StudiesTable as T3)
--     SELECT * FROM MeetingsTable
    SELECT T1.Student,
           T1.Type,
           T1.Product,
           T1.ID,
           T1.BeginningDate,
           T1.EndDate,
           T2.Type          AS Type2,
           T2.Product       AS Product2,
           T2.ID            AS ID2,
           T2.BeginningDate AS BeginningDate2,
           T2.EndDate       AS EndDate2
    FROM UT as T1
             INNER JOIN UT as T2 ON T1.Student = T2.Student
    WHERE ((T1.EndDate >= T2.BeginningDate AND T1.EndDate <= T2.EndDate) OR
           (T2.EndDate >= T1.BeginningDate AND T2.EndDate <= T1.EndDate))
      AND T1.BeginningDate > GETDATE()
      AND T2.BeginningDate > GETDATE()
      AND (T1.Product < T2.Product OR (T1.Product = T2.Product AND T1.ID < T2.ID))
go

grant select on [Raport Bilokacji - done] to Director
go

