IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[OP0170]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OP0170]
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

CREATE PROCEDURE [dbo].[OP0170]
				@DivisionID as nvarchar(50),				
				@UserID as nvarchar(50)

AS
SET NOCOUNT ON
Declare @SQL NVarchar(4000) = '',
		@SQL1 NVarchar(4000) = ''



SET @SQL = N'
SELECT T1.*, T2.Description AS ProgressName, Convert(Date,null) AS CompletedDate,
Convert(Varchar(20),'''') AS CurrentStepID, Convert(Varchar(20),'''') AS Colors, Convert(Int,0) AS OrderNo
INTO #OP0170_OT0170
FROM OT0170 T1 WITH(NOLOCK)
LEFT JOIN (SELECT DISTINCT DivisionID, ProgressID, Description From OT0169  WITH(NOLOCK)  ) T2 ON T1.DivisionID = T2.DivisionID AND T1.ProgressID = T2.ProgressID

UPDATE T1
SET	T1.CompletedDate = T2.CompletedDate
FROM #OP0170_OT0170 T1
INNER JOIN 
(
SELECT DivisionID, VoucherID, Min(CompletedDate)AS CompletedDate
FROM OT0171 
WHERE GetDate() <= CompletedDate 
GROUP BY DivisionID, VoucherID
)T2 ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID

'
SET @SQL1 = N'
UPDATE T1
SET	T1.CurrentStepID = T2.StepID
FROM #OP0170_OT0170 T1
INNER JOIN OT0171 T2 ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID AND Convert(Date,T1.CompletedDate) = Convert(Date,T2.CompletedDate)


UPDATE T1
SET	T1.OrderNo = T2.OrderNo
FROM #OP0170_OT0170 T1
INNER JOIN OT0171 T2 ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID AND Convert(Date,T1.CompletedDate) = Convert(Date,T2.CompletedDate)


UPDATE T1
SET	T1.Colors = T2.Colors
FROM #OP0170_OT0170 T1
INNER JOIN OT0169 T2 ON T1.DivisionID = T2.DivisionID AND T1.ProgressID = T2.ProgressID AND T1.CurrentStepID = T2.StepID AND T1.OrderNo = T2.OrderNo


SELECT  * FROM #OP0170_OT0170 ORDER BY VoucherNo

drop table #OP0170_OT0170
'
EXEC(@SQL+@SQL1)

SET NOCOUNT OFF



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

