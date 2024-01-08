IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo huê hồng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 27/11/2020
-- <Example>
---- 
/*-- <Example>
	
----*/

CREATE PROCEDURE HRMP3022
( 
	 @DivisionID        NVARCHAR(50),
	 @DivisionIDList	NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
	 @UserID            NVARCHAR(50),
	 @FromMonth			INT, 
	 @ToMonth			INT, 
	 @FromYear		    INT,
	 @ToYear			INT
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',	
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'T1.TranYear,T1.TranMonth,T1.VoucherNo,T1.ObjectID,T1.InventoryID'


IF @DivisionIDList IS NULL or @DivisionIDList = ''
	SET @sWhere = @sWhere + ' T1.DivisionID = '''+ @DivisionID+''''
Else 
	SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionIDList+''')'

SET @sWhere = @sWhere + N'
			AND T1.TranMonth + T1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''

SET @sSQL = @sSQL + N'
SELECT T1.APK,LTRIM(Str(T1.TranMonth)) +''/''+LTRIM(Str(T1.TranYear)) as Period,T1.DivisionID,T1.ObjectID,T3.ObjectName,T1.InventoryID,T4.InventoryName,T1.EmployeeID,T2.FullName as EmployeeName,T1.VoucherNo
,T1.PayAmount,T1.Amount,T1.BonusRate01,T1.BonusRate02,T1.BonusRate03,T1.BonusRate04,T1.RevenueAmount,T1.CreateDate,T1.CreateUserID
FROM HRMT2160 T1 WITH (NOLOCK) 
LEFT JOIN AT1103 T2 WITH (NOLOCK) ON T1.EmployeeID = T2.EmployeeID
LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T1.ObjectID = T3.ObjectID
LEFT JOIN AT1302 T4 WITH (NOLOCK) ON T1.InventoryID = T4.InventoryID

WHERE ' +@sWhere+ '
		ORDER BY ' + @OrderBy

EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
