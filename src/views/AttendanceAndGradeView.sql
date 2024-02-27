CREATE VIEW dbo.AttendanceAndGradeView
AS
WITH avg_grade AS (
    SELECT
        StudentID,
        SubjectID,
        AVG(Grade) AS AverageGrade
    FROM
        SubjectGrade
    GROUP BY
        StudentID,
        SubjectID
),
attendance AS (
    SELECT
        LP.StudentID,
        L.SubjectID,
        SUM(CAST(LP.WasPresent AS int)) * 1.0 / COUNT(*) AS [Percent]
    FROM
        LecturePresence LP
        INNER JOIN Lecture L ON LP.LectureID = L.LectureID
    GROUP BY
        LP.StudentID,
        L.SubjectID
)
SELECT
    ST.StudentID,
    A.SubjectID,
    round(A.[Percent],2) AS [Percent],
    round(AG.AverageGrade,2) AS [AverageGrade],
    CASE
        WHEN A.[Percent] >= 0.8 AND AG.AverageGrade >= 3 THEN 'Pass'
        ELSE 'Fail'
    END AS [Status]
FROM
    Students ST
    INNER JOIN avg_grade AG ON ST.StudentID = AG.StudentID
    INNER JOIN attendance A ON ST.StudentID = A.StudentID
go

