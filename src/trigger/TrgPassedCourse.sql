CREATE TRIGGER TrgPassedCourse
ON ModulePresence
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @PresenceID int
    SET @PresenceID = (SELECT MAX(ModulePresenceID) FROM ModulePresence)
    DECLARE @ModuleID int
    SET @ModuleID = (SELECT ModuleID FROM ModulePresence WHERE ModulePresenceID = @PresenceID)
    DECLARE @StudentID int
    SET @StudentID = (SELECT StudentID FROM ModulePresence WHERE ModulePresenceID = @PresenceID)
    DECLARE @CourseID int
    SET @CourseID = (SELECT CourseID FROM Modules WHERE ModuleID = @ModuleID)
    DECLARE @Course_modules int
    SET @Course_modules = (SELECT COUNT(ModuleID) FROM Modules WHERE CourseID = @CourseID)
    IF (SELECT COUNT(Modules.ModuleID) FROM Modules
        INNER JOIN ModulePresence ON Modules.ModuleID = ModulePresence.ModuleID
        WHERE ModulePresence.StudentID = @StudentID AND Modules.CourseID = @CourseID) > 0.8 * @Course_modules
    BEGIN
        INSERT INTO passedCourse (StudentID, CourseID) VALUES (@StudentID, @CourseID)
    END
    end
go

