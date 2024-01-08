IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by: Khanh Van on 23/10/2013
---- Purpose: Kiem tra thong tin ton tai tren cac bang co lien quan truoc khi xoa
---- Modified by Tiểu Mai on 06/03/2017: Bổ sung kiểm tra sửa/xóa chấm công theo sản phẩm cho Bourbon (HF0410)

CREATE PROCEDURE 	[dbo].[HP9000]		
				@DivisionID as nvarchar(50), 
				@DataID as nvarchar(50),
				@TranMonth int,
				@TranYear int ,
				@FormID as nvarchar(50)
 AS

Declare @Status as tinyint,
	@Message  as nvarchar(250)
	Set @Status =0


IF @FormID ='HF0320'
Begin
If Exists (Select 1 From HT0322 inner join HT0323 
on HT0322.DivisionID = HT0323.DivisionID and HT0322.VoucherID = HT0323.VoucherID Where EmployeeID = @DataID and HT0322.DivisionID = @DivisionID and TranMonth = @TranMonth and TranYear = @TranYear)
	Begin
		Set @Status =1
		Set @Message = N'HFML000481'
		goto EndMess
	End
End
IF @FormID ='HF0332'
Begin
If Exists (Select 1 From HT0322 inner join HT0323 
on HT0322.DivisionID = HT0323.DivisionID and HT0322.VoucherID = HT0323.VoucherID Where EmployeeID = @DataID and HT0322.DivisionID = @DivisionID and TranMonth = @TranMonth and TranYear = @TranYear)
	Begin
		Set @Status =1
		Set @Message = N'HFML000009'
		goto EndMess
	End
END

IF @FormID = 'HF0410'
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM HT3400 H34 WITH (NOLOCK) WHERE H34.DivisionID = @DivisionID AND H34.TranMonth = @TranMonth AND H34.TranYear = @TranYear)
	BEGIN
		SET @Status = 1
		SET @Message = N'HFML000560'
		GOTO  EndMess
	END
END

EndMess:

	Select @Status as Status, @Message as Message

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
