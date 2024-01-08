IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP1000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)     
DROP PROCEDURE [DBO].[BP1000]  
GO  
SET QUOTED_IDENTIFIER ON  
GO  
SET ANSI_NULLS ON  
GO

--- Created by B.Anh	Date: 02/05/2018	
--- Purpose: Kiem tra neu so seri da phat sinh nghiep vu thi khong cho sua

CREATE PROCEDURE BP1000 @DivisionID varchar(50), @SeriNo varchar(50)
  AS

Declare @Status as tinyint,
		@Message AS NVARCHAR(500)

Set @Status =0
SET @Message = ''

If exists (Select top 1 1  From BT1002 WITH (NOLOCK) Where DivisionID = @DivisionID And SeriNo = @SeriNo)
	Begin
		 Set @Status =1
		 Set @Message = '00ML000159'
		GOTO RETURN_VALUES
	End

---- Tra ra gia tri
RETURN_VALUES:
Select @Status as Status, @Message AS [Message]
  
GO  
SET QUOTED_IDENTIFIER OFF  
GO  
SET ANSI_NULLS ON  
GO
