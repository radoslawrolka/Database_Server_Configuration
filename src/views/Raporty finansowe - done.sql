CREATE view dbo.[Raporty finansowe - done] as
    SELECT P.ProductID, PT.Name as [Category], W.Title as [Name], ROUND(SUM(Price), 2) as [Income]
    FROM Products AS P
             inner join Webinars as W on P.ProductID = W.WebinarID
             left join ProductType as PT on P.ProductTypeID = PT.ProductTypeID
    WHERE P.ProductID IN (SELECT od.ProductID
                          FROM OrderDetails AS od
                          WHERE od.ProductID NOT IN (SELECT m.MeetingID
                                                     FROM Meetings AS m))
    GROUP BY P.ProductID, PT.Name, W.Title
    UNION
    SELECT P.ProductID, PT.Name, S.Name, ROUND(SUM(Price), 2)
    FROM Products AS P
             inner join Studies as S on P.ProductID = S.StudyID
             left join ProductType as PT on P.ProductTypeID = PT.ProductTypeID
    WHERE P.ProductID IN (SELECT od.ProductID
                          FROM OrderDetails AS od
                          WHERE od.ProductID NOT IN (SELECT m.MeetingID
                                                     FROM Meetings AS m))
    GROUP BY P.ProductID, PT.Name, S.Name
    UNION
    SELECT P.ProductID, PT.Name, C.Title, ROUND(SUM(Price), 2)
    FROM Products AS P
             inner join dbo.Courses C on P.ProductID = C.CourseID
             left join ProductType as PT on P.ProductTypeID = PT.ProductTypeID
    WHERE P.ProductID IN (SELECT od.ProductID
                          FROM OrderDetails AS od
                          WHERE od.ProductID NOT IN (SELECT m.MeetingID
                                                     FROM Meetings AS m))
    GROUP BY P.ProductID, PT.Name, C.Title
    UNION
    SELECT P.ProductID, PT.Name, 'Meeting' + CAST(ProductID as VARCHAR), ROUND(SUM(Price), 2)
    FROM Products AS P
             inner join Meetings as M on P.ProductID = M.MeetingID
             left join ProductType as PT on P.ProductTypeID = PT.ProductTypeID
    WHERE P.ProductID IN (SELECT od.ProductID
                          FROM OrderDetails AS od
                          WHERE od.ProductID NOT IN (SELECT m.MeetingID
                                                     FROM Meetings AS m))
    group by P.ProductID, PT.Name
go

grant select on [Raporty finansowe - done] to Director
go

