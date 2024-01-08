IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP9001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP9001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tiểu Mai on 05/12/2016: Bổ sung kiểm tra xóa danh mục phép thâm niên

CREATE PROCEDURE 	[dbo].[HP9001]		
				@DivisionID as nvarchar(50), 
				@DataID as nvarchar(50),
				@TranMonth int,
				@TranYear int ,
				@FormID as nvarchar(50)
 AS

Declare @Status as tinyint,
	@Message  as nvarchar(250)
	Set @Status =0

IF @FormID IN ('HF0392', 'HF0394')
Begin
If Exists (SELECT TOP 1 1 FROM HT1029 WITH (NOLOCK) WHERE SeniorityID = @DataID and HT1029.DivisionID = @DivisionID)
	Begin
		Set @Status =1
		Set @Message = N'HFML000009'
		goto EndMess
	End
END

IF @FormID ='HF0393'
Begin
If Exists (SELECT TOP 1 1 FROM HT1027 WITH (NOLOCK) WHERE SeniorityID = @DataID and DivisionID = @DivisionID)
	Begin
		Set @Status =1
		Set @Message = N'HFML000539'
		goto EndMess
	End
END

IF @FormID IN ('HF0396', 'HF0397')
Begin
If Exists (SELECT TOP 1 1 FROM HT2803 WITH (NOLOCK) WHERE MethodVacationID = @DataID and DivisionID = @DivisionID)
	Begin
		Set @Status =1
		Set @Message = N'HFML000009'
		goto EndMess
	End
END

IF @FormID IN ('HF0398')
Begin
If Exists (SELECT TOP 1 1 FROM HT1029 WITH (NOLOCK) WHERE MethodVacationID = @DataID and DivisionID = @DivisionID)
	Begin
		Set @Status =1
		Set @Message = N'HFML000544'
		goto EndMess
	End
End

EndMess:

	Select @Status as Status, @Message as Message

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
