create procedure dbo.AddOrder
    @StudentEmail varchar(255),
    @Date date = NULL,
    @Paid money = NULL
as
begin
    set nocount on;

    declare @StudentID int;

    -- Assuming that Students table has an Email column
    select @StudentID = StudentID
    from dbo.Students
    where Email = @StudentEmail;

    if @Date is null set @Date = getdate();
    if @Paid is null set @Paid = 0;
    if @StudentID is not null
    begin
        insert into dbo.[Order] (StudentID, Paid, Date)
        values (@StudentID, @Paid, @Date);
    end
    else
    begin
        raiserror('Student not found for the given email.', 16, 1);
    end
end
go

