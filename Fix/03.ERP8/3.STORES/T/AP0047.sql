IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0047]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0047]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Created by Tiểu Mai on 16/05/2016
--- Purpose: Tạo mới user đăng nhập khi tạo mới người dùng
--- Modified by Nhật Thanh on 8/12/2021: Bổ sung tạo thông tin nhân viên tại màn hình CF0024 cho angel
-- <Example>
---- EXEC AP0047 'AS', 'NPP.001', 'NPP Quận 3, TP HCM'

CREATE PROCEDURE AP0047
( 
	@DivisionID AS NVARCHAR(20),
	@ObjectID AS NVARCHAR(50),
	@ObjectName AS NVARCHAR(250),
	@CreateUserID AS NVARCHAR(20),
	@Mode AS TINYINT		--- 0: ADD
							--- 1: DELETE
	
) 
AS 
DECLARE @CustomerName int
Set @CustomerName = (Select top 1 CustomerName from CustomerIndex)
IF @Mode = 0
BEGIN
		IF @CustomerName = 57 -- Angel
			IF NOT EXISTS (SELECT TOP 1 1 FROM AT1405 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND UserID = @ObjectID)
			BEGIN 
				INSERT INTO AT1405 (DivisionID, UserID, UserName, [Password], [Disabled], CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
				VALUES(@DivisionID, @ObjectID, @ObjectName, NULL, 0, @CreateUserID, GETDATE(), @CreateUserID, GETDATE())	
			END 
		IF NOT EXISTS (SELECT TOP 1 1 FROM AT1103 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND EmployeeID = @ObjectID)
		INSERT INTO AT1103 (DivisionID, EmployeeID, FullName, [Disabled], IsUserID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		VALUES(@DivisionID, @ObjectID, @ObjectName, 0, 1, @CreateUserID, GETDATE(), @CreateUserID, GETDATE())
	
END
ELSE
	BEGIN
		DELETE FROM AT1103
		WHERE DivisionID = @DivisionID AND EmployeeID = @ObjectID

		DELETE FROM AT1402
		WHERE DivisionID = @DivisionID AND UserID = @ObjectID
	END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
