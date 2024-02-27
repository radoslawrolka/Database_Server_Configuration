CREATE view dbo.[Frekwencja na zakonczonych wydarzeniach - done] as
    SELECT MP.ModuleID                                                                       AS ID,
           'Module'                                                                          AS Type,
           COUNT(CASE WHEN MP.WasPresent = 1 THEN 1 END)                                     AS NumberOfWasPresents,
           COUNT(DISTINCT MP.StudentID)                                                      AS TotalParticipants,
           Round(COUNT(CASE WHEN MP.WasPresent = 1 THEN 1 END) / CAST(COUNT(*) AS Float), 2) AS Percentage
    FROM ModulePresence MP
    GROUP BY MP.ModuleID

    UNION

    SELECT LP.LectureID                                                                      AS ID,
           'Lecture'                                                                         AS Type,
           COUNT(CASE WHEN LP.WasPresent = 1 THEN 1 END)                                     AS NumberOfWasPresents,
           COUNT(DISTINCT LP.StudentID)                                                      AS TotalParticipants,
           ROUND(COUNT(CASE WHEN LP.WasPresent = 1 THEN 1 END) / Cast(COUNT(*) as Float), 2) AS Percentage
    FROM LecturePresence LP
    GROUP BY LP.LectureID
go

grant select on [Frekwencja na zakonczonych wydarzeniach - done] to Director
go

