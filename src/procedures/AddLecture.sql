CREATE PROCEDURE AddLecture
   @MeetingID int,
   @SubjectTitle int,
   @Date DATETIME,
   @Lenght int,
   @Teacher varchar (50),
   @Room varchar (20) = null,
   @Link varchar (50) = Null

AS
BEGIN
   SET NOCOUNT ON;

   IF NOT @Teacher IN (
       SELECT Email FROM Teachers WHERE Email = @Teacher
   )
   BEGIN
       PRINT 'Error: Teacher does not exist.';
       RETURN;
   END

   IF @Lenght > 240
   BEGIN
       PRINT 'Lecture is too long.';
       RETURN;
   END

   SELECT @Teacher = TeacherID
   FROM Teachers
   WHERE Email = @Teacher;

   IF NOT @MeetingID IN (
       SELECT MeetingID FROM Meetings WHERE MeetingID = @MeetingID
   )
   BEGIN
       PRINT 'Error: Meeting does not exist.';
       RETURN;
   END

   SELECT @MeetingID = MeetingID
    FROM Meetings
    WHERE MeetingID = @MeetingID;

   IF NOT @SubjectTitle IN (
       SELECT SubjectName FROM Subjects WHERE SubjectName = @SubjectTitle
   )
   BEGIN
       PRINT 'Error: Subject does not exist.';
       RETURN;
   END

   SELECT @SubjectTitle = SubjectID
    FROM Subjects
    WHERE SubjectName = @SubjectTitle;

   IF @Date < GETDATE()
    BEGIN
         PRINT 'Error: Date is in the past.';
         RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM Lecture
        WHERE MeetingID = @MeetingID AND (
            (@Date >= Lecture.Date AND @Date <= DATEADD(MINUTE, Lecture.Length, Lecture.Date)) OR
            (Lecture.Date >= @Date AND Lecture.Date <= DATEADD(MINUTE, @Lenght, @Date))
        )
    )
    BEGIN
        PRINT 'Error: Lecture overlaps with another module.';
        RETURN;
    END

   IF NOT @Room IN (
       SELECT RoomName FROM Room
   )
   BEGIN
       PRINT 'Error: Room does not exist.';
       RETURN;
   END

   SELECT @Room = RoomID
   FROM Room
   WHERE Room.RoomName = @Room;
   
   IF EXISTS (
        SELECT 1
        FROM Lecture
        WHERE RoomID = @Room AND (
            (@Date >= Lecture.Date AND @Date <= DATEADD(MINUTE, Lecture.Length, Lecture.Date)) OR
            (Lecture.Date >= @Date AND Lecture.Date <= DATEADD(MINUTE, @Lenght, @Date))
        )
    )
    BEGIN
        PRINT 'Error: Room is taken module.';
        RETURN;
    END

    IF @Link IS NOT NULL AND @Room IS NOT NULL
    BEGIN
         PRINT 'Error: Cannot have both link and room.';
         RETURN;
    END

    IF @Link IS NULL AND @Room IS NULL
    BEGIN
         PRINT 'Error: Must have either link or room.';
         RETURN;
    END

   INSERT INTO Lecture (MeetingID, SubjectID, TeacherID, Date, Length, RoomID, Link)
    VALUES (@MeetingID, @SubjectTitle, @Teacher, @Date, @Lenght, @Room, @Link);

   PRINT 'Lecture added successfully.';
END;

grant execute on dbo.AddGrade to Coordinator;
go

