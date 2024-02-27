CREATE PROCEDURE AddModule
   @CourseName varchar(50),
   @Title varchar (50),
   @Date DATETIME,
   @Lenght int,
   @Teacher varchar (50),
   @Moduletype varchar (20),
   @Field varchar (30),
   @Room varchar (20) = null,
   @Link varchar (50) = Null,
   @Limit int = Null

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
       PRINT 'Module is too long.';
       RETURN;
   END

   SELECT @Teacher = TeacherID
   FROM Teachers
   WHERE Email = @Teacher;

   IF NOT @CourseName IN (
       SELECT Title FROM Courses WHERE Title = @CourseName
   )
   BEGIN
       PRINT 'Error: Course does not exist.';
       RETURN;
   END

   SELECT @CourseName = CourseID
   FROM Courses
   WHERE Title = @CourseName;

   IF @Date < GETDATE()
    BEGIN
         PRINT 'Error: Date is in the past.';
         RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM Modules
        WHERE CourseID = @CourseName
        AND (
            (@Date >= Modules.Date AND @Date <= DATEADD(MINUTE, Modules.Length, Modules.Date)) OR
            (Modules.Date >= @Date AND Modules.Date <= DATEADD(MINUTE, @Lenght, @Date))
        )
    )
    BEGIN
        PRINT 'Error: Module overlaps with another module.';
        RETURN;
    END

   IF NOT @Moduletype IN (
       SELECT Name FROM ModuleType
   )
   BEGIN
         PRINT 'Error: Module type does not exist.';
         RETURN;
   END

   SELECT @Moduletype = ModuleTypeID
   FROM ModuleType
   WHERE ModuleType.Name = @Moduletype;

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

   IF NOT @Field IN (
       SELECT Name FROM FieldType
   )
   BEGIN
       INSERT INTO FieldType (Name) VALUES (@Field);
   END

   SELECT @Field = FieldTypeID
   FROM FieldType
   WHERE FieldType.Name = @Field;

   IF @Limit IS NOT NULL AND @Limit < 5
    BEGIN
         PRINT 'Error: Limit is too low.';
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

    IF @Moduletype IN (2, 3) AND (@Link IS NULL OR @Room IS NOT NULL)
    BEGIN
         PRINT 'Error: online module Link must be set and room must be null.';
         RETURN;
    END

    IF @Moduletype = 1 AND (@Link IS NOT NULL OR @Room IS NULL)
    BEGIN
         PRINT 'Error: in-person module must be null and room must be set.';
         RETURN;
    END

   INSERT INTO Modules (CourseID, Title, Date, Length, TeacherID, ModuleType, Link, Limit, FieldID)
   VALUES (@CourseName, @Title, @Date, @Lenght, @Teacher, @Moduletype, @Link, @Limit, @Field);

   PRINT 'Module added successfully.';
END;
grant execute on dbo.AddGrade to Coordinator;
go

