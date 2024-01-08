IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[OP0171]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OP0171]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
 ---- 
 ---- Do nguon luoi Truy van quan ly tien do san xuat
 -- <Param>
 ---- 
 -- <Return>
 ---- 
 -- <Reference>
 ---- OP/Nghiep vu/ Tien do san xuat/Them, xem, sua - OF0169
 -- <History> 
----- Created by: Trương Ngọc Phương Thảo on 04/05/2017
----- Modify on 
/*-- <Example>
EXEC OP0170 'EM', ''
----*/

CREATE PROCEDURE [dbo].[OP0171]
				@DivisionID as nvarchar(50),				
				@UserID as nvarchar(50),
				@ProgressID as nvarchar(50),
				@VoucherID as nvarchar(50)

AS
SET NOCOUNT ON

DECLARE @ShipDate Datetime, @ApprovedDate Datetime, @AccumulateDay Int

SELECT @ShipDate = Convert(Date,ShipDate), @ApprovedDate = Convert(Date,LastModifyDate), @AccumulateDay = 0
FROM OT2001 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND OrderType = 1 AND ISNULL(IsConfirm,0) = 1
AND Disabled = 0
AND SOrderID = @VoucherID

SELECT OrderNo, DivisionID, ProgressID, Description, StepID, Days, Convert(Int,0) AS TotalDay
INTO #OP0171_OT0169
FROM OT0169
WHERE DivisionID = @DivisionID AND ProgressID = @ProgressID
Order by OrderNo, TransactionID

UPDATE T1
SET @AccumulateDay =  @AccumulateDay + T1.Days,
	TotalDay = @AccumulateDay
FROM #OP0171_OT0169 T1


SELECT DISTINCT @VoucherID AS VoucherID, @ShipDate AS ShipDate, @ApprovedDate AS ApprovedDate,
		T1.StepID, T1.Description AS StepName, T1.OrderNo,
			ISNULL(T2.CompletedDate, @ApprovedDate+TotalDay) AS CompletedDate
FROM #OP0171_OT0169 T1 WITH (NOLOCK)
LEFT JOIN OT0171 T2 WITH (NOLOCK) On T1.DivisionID = T2.DivisionID AND T1.StepID = T2.StepID AND T2.VoucherID = @VoucherID AND T1.OrderNo = T2.OrderNo
WHERE T1.DivisionID = @DivisionID AND T1.ProgressID = @ProgressID
Order by T1.OrderNo

DROP TABLE #OP0171_OT0169

SET NOCOUNT OFF



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

