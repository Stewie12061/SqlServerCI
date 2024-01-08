IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0134_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0134_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Tieu Mai.
---- Created Date 17/03/2017
---- Purpose: Kiem tra rang buoc du lieu cho phep Sua tai man hinh WF0133

/* 
exec WP0134 @Divisionid=N'ANG',@Tranmonth=2,@Tranyear=2017,@Voucherid=N'AR201700000283',@Tableid=N'AT2006',@Batchid=N'AR201700000283',@Fromid=N'WF0133'

*/


CREATE PROCEDURE [dbo].[WP0134_AG] 	
				@DivisionID nvarchar(50),
				@TranMonth int,
				@TranYear int,
				@VoucherID nvarchar(50),
				@TableID  nvarchar(50),
				@BatchID as nvarchar(50),
				@FromID as nvarchar(50)
AS

Declare @Status as tinyint,
	@EngMessage as nvarchar(250),
	@VieMessage as nvarchar(250)

	SET @Status =0
	SET @EngMessage =''
	SET @VieMessage=''

IF @FromID ='WF0133'		----- Danh sách phieu nhập-xuất-VCNB tại màn hình truy vấn ngược chi tiết nhập xuất tồn WF0133
BEGIN
	Exec AP0701 @DivisionID,@TranMonth,	@TranYear,@VoucherID, @FromID, @Status  output, @EngMessage  output, @VieMessage output
	Goto EndMess
End


--================================================
	EndMess:
	Select @FromID, @Status as Status, @EngMessage as EngMessage, @VieMessage as VieMessage





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
