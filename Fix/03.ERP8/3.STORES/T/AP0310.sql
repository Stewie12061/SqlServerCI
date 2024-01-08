IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AP0310]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AP0310]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


---- Created by Nguyen Van Nhan.
---- Created Date 12/02/2004
---- Bao cao doi chieu cong no theo mat hang
/********************************************
'* Edited by: [GS] [To Oanh] [29/07/2010]
'********************************************/
--- Modified by Phương Thảo on 06/10/2017: Bổ sung biến @ReportID
--- Modified by Đức Thông   on 16/12/2020: Thêm biến @SqlFilter: Câu where lấy từ mh AF0013 khi bấm nút lọc



CREATE PROCEDURE [dbo].[AP0310]  @DivisionID as nvarchar(50),
				@FromObjectID as nvarchar(50),
				@ToObjectID as nvarchar(50),
				@FromAccountID as nvarchar(50),
				@ToAccountID as nvarchar(50),
				@CurrencyID as nvarchar(50),
				@FromInventoryID as nvarchar(50),
				@ToInventoryID as nvarchar(50),
				@IsDetail as tinyint,
				@IsDate as tinyint,
				@FromMonth as int,
				@FromYear as int,
				@ToMonth as int,
				@ToYear as int,				
				@FromDate as Datetime,
				@ToDate as Datetime,
				@ReportID as Varchar(50) = 'AR0310',
				@SqlFilter as NVarchar(250) = ''
AS
DECLARE @CustomerName int

Select top 1 @CustomerName = CustomerName from CustomerIndex

	If @IsDetail = 1 --- Chi tiet theo mat hang cua tung hoa don
	BEGIN
		--Print ' P1'
		IF @CustomerName = 57
			Exec AP0308_AG 	@DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID,@CurrencyID, @FromInventoryID, @ToInventoryID,
			@IsDate, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate
		ELSE
			Exec AP0308 	@DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID,@CurrencyID, @FromInventoryID, @ToInventoryID,
						@IsDate, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @ReportID, @SqlFilter
	END
	Else

		Exec AP0309 	@DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID, @CurrencyID, @FromInventoryID, @ToInventoryID,
				@IsDate, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate
		--Print ' P2'

GO


