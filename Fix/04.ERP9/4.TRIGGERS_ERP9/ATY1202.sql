IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ATY1202]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].ATY1202
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [dbo].ATY1202 ON [dbo].[AT1202]  FOR INSERT
AS
DECLARE @DivisionID NVARCHAR(50),
		@ObjectID VARCHAR(50),
		@ObjectTypeID VARCHAR(50),
		@ObjectName NVARCHAR(250),
		@CreateUserID VARCHAR(50)
		
SELECT @DivisionID = DivisionID, @ObjectID = ObjectID, @ObjectTypeID = ObjectTypeID, @ObjectName = ObjectName, @CreateUserID = CreateUserID
FROM INSERTED

IF (@ObjectTypeID = 'H1' OR @ObjectTypeID = 'H2' OR @ObjectTypeID = 'H3' OR  @ObjectTypeID = 'H4' 
	OR  @ObjectTypeID = 'H5' OR  @ObjectTypeID = 'H6' OR  @ObjectTypeID = 'H7')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM MTT2000 WHERE DivisionID = @DivisionID AND StudentID = @ObjectID)
	INSERT INTO MTT2000 (DivisionID, TranMonth, TranYear, S, StudentID, StudentName,ClassDate, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	VALUES (@DivisionID, MONTH(GETDATE()), YEAR(GETDATE()), @ObjectTypeID, @ObjectID, @ObjectName, GETDATE(), @CreateUserID, GETDATE(), @CreateUserID, GETDATE() )	
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
