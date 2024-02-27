CREATE TRIGGER trg_UpdateAttendanceAndGradeView
ON dbo.LecturePresence
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE av
    SET
        [Percent] = a.[Percent],
        AverageGrade = ag.AverageGrade,
        [Status] = CASE WHEN a.[Percent] >= 0.8 AND ag.AverageGrade >= 3 THEN 'Pass' ELSE 'Fail' END
    FROM
        dbo.AttendanceAndGrade av
        INNER JOIN inserted i ON av.StudentID = i.StudentID
        LEFT JOIN (
            SELECT
                LP.StudentID,
                L.SubjectID,
                SUM(CAST(LP.WasPresent AS int)) * 1.0 / COUNT(*) AS [Percent]
            FROM
                inserted i
                INNER JOIN LecturePresence LP ON i.LectureID = LP.LectureID
                INNER JOIN Lecture L ON LP.LectureID = L.LectureID
            GROUP BY
                LP.StudentID,
                L.SubjectID
        ) a ON av.StudentID = a.StudentID AND av.SubjectID = a.SubjectID
        LEFT JOIN (
            SELECT
                StudentID,
                SubjectID,
                AVG(Grade) AS AverageGrade
            FROM
                SubjectGrade
            GROUP BY
                StudentID,
                SubjectID
        ) ag ON av.StudentID = ag.StudentID AND av.SubjectID = ag.SubjectID;
END;
go

