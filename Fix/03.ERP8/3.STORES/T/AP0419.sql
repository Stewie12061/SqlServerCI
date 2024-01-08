IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0419]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0419]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Load Danh mục chuyển nhượng - thanh lý SIKICO
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Kiều Nga  on: 28/03/2022
-- <Example>
/*
	 AP0419 @DivisionID = N'CBD',@UserID= N'ASOFTADMIN',@FromDate=N'2018-12-01',@ToDate= N'2018-12-30',@ContractType='4',@StatusID= N'1',@IsContract = '0',@IsDate = N'0'
	
	 AP0419 @DivisionID,@UserID,@FromDate,@ToDate,@All,@ContractType,@StatusID,@IsContract,@IsDate
*/

 CREATE PROCEDURE AP0419
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromMonth AS int,
	@FromYear AS int,
	@ToMonth AS int,
	@ToYear AS int,
	@IsDate AS int,
	@TransactionTypeID TINYINT,
	@PlotID NVARCHAR(50)
)
AS


DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(MAX) = N''

SET @sWhere = @sWhere + ' AND T1.TransactionTypeID = ' + LTRIM(STR(@TransactionTypeID)) + ''

-----lô đất
IF ISNULL(@PlotID,'') <> ''  AND ISNULL(@PlotID,'') <> '%'
SET @sWhere = @sWhere + ' AND T5.PlotID = ''' + @PlotID + ''''

IF @IsDate = 1 
	Set  @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE,T1.CreateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''''
ELSE 
	Set  @sWhere = @sWhere + '
		AND T1.TranMonth + T1.TranYear*100 between '+str(@FromMonth+@FromYear*100)+' and '+str(@ToMonth+@ToYear*100)+''

SET @sSQL = N' 
SELECT DISTINCT T1.APK,T1.DivisionID,T1.ContractNo,T1.NewContractNo,T1.TransactionTypeID,T1.TransactionDate,T3.ObjectName as OldObjectName,T4.ObjectName as NewObjectName,T1.Reason,T1.CreateDate
FROM AT0418 T1 WITH (NOLOCK)
LEFT JOIN CT0155 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ContractNo = T2.ContractNo
LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (T2.DivisionID,''@@@'') AND T3.ObjectID = T2.ObjectID
LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.ObjectID = T1.NewObjectID
LEFT JOIN AT0419 T5  WITH (NOLOCK) ON T1.DivisionID = T5.DivisionID AND T1.APK = T5.APKMaster
WHERE T1.DivisionID = '''+@DivisionID +'''
	'+@sWhere +'
	ORDER BY T1.CreateDate DESC'

PRINT @sSQL
EXEC(@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
