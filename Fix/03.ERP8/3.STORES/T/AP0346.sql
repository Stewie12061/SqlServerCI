IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0346]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0346]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Nhập xuất tồn theo kho (ANGEL)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 03/11/2016 by Hải Long
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
-- <Example>

CREATE PROCEDURE AP0346
(
    @DivisionID AS nvarchar(50), 
    @FromPeriod AS INT,
    @ToPeriod AS INT,
    @FromDate AS datetime, 
    @ToDate AS datetime, 
    @FromWareHouseID as nvarchar(50),
    @ToWareHouseID as nvarchar(50),
    @FromAccountID AS nvarchar(50), 
    @ToAccountID AS nvarchar(50), 
    @IsDate AS tinyint
)
AS

DECLARE 
	@sSQL1 AS nvarchar(4000), 
	@sSQL2 AS nvarchar(4000),  
	@sSQL3 AS nvarchar(4000),
	@sSQL4 AS nvarchar(4000),
	@sSQL5 AS nvarchar(4000),
	@FromDateText NVARCHAR(20), 
	@ToDateText NVARCHAR(20),
	@LastDateMonth NVARCHAR(20),
	@FromMonth AS int, 
    @ToMonth AS int, 
    @FromYear AS int, 
    @ToYear AS int	
		
	
SET @FromYear = CONVERT(INT, LEFT(@FromPeriod, 4))
SET @ToYear = CONVERT(INT, LEFT(@ToPeriod, 4))
SET @FromMonth = CONVERT(INT, RIGHT(@FromPeriod, 2))
SET @ToMonth = CONVERT(INT, RIGHT(@ToPeriod, 2))
	
IF @IsDate = 0
	BEGIN
		SET @FromDateText = Convert(varchar(50), @FromMonth) + '/01/' + Convert(varchar(50), @FromYear)
		SET @ToDateText = Convert(varchar(50), @ToMonth) + '/01/' + Convert(varchar(50), @ToYear)
		SET @LastDateMonth = SUBSTRING(CONVERT(NVARCHAR(20), (DATEADD(d,-1,DATEADD(mm, DATEDIFF(m,0,@ToDateText)+1,0))), 101),4,2)
		SET @ToDateText = Convert(varchar(50), @ToMonth) + '/' + @LastDateMonth + '/' + Convert(varchar(50), @ToYear)	
	END
ELSE
	BEGIN
		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
		SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'		
	END
		
--PRINT @FromDateText
--PRINT @ToDateText

SET @sSQL1 = N'
	SELECT DivisionID, InventoryID, InventoryName, UnitID, I05ID, UnitName, InventoryAccountID, WareHouseName,
	SUM(SignQuantity) AS BeginQuantity, 
	SUM(SignAmount) AS BeginAmount
	INTO #TEMP1
	FROM AV7000 		
	WHERE DivisionID LIKE ''' + @DivisionID + '''
	AND (VoucherDate < ''' + @FromDateText + ''' OR D_C = ''BD'')
	AND InventoryAccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''
	AND ISNULL(WareHouseID, '''') BETWEEN ''' + @FromWareHouseID + ''' AND ''' + @ToWareHouseID + '''
	GROUP BY DivisionID, InventoryID, InventoryName, UnitID, I05ID, UnitName, InventoryAccountID, WareHouseName'
		

SET @sSQL2 = N'
	SELECT DivisionID, InventoryID, InventoryName, UnitID, I05ID, UnitName,
	BeginQuantity, 
	BeginAmount, 
	0 AS DebitQuantity, 
	0 AS CreditQuantity, 
	0 AS DebitAmount, 
	0 AS CreditAmount, 
	0 AS EndQuantity, 
	0 AS EndAmount, 
	InventoryAccountID AS AccountID,
	NULL AS ImCorAccountID,
	NULL AS ExCorAccountID,
	WareHouseName			   			   
	INTO #TEMP2
	FROM #TEMP1'
SET @sSQL3 =	'
	UNION ALL			
	SELECT 
	DivisionID, InventoryID, InventoryName, UnitID, I05ID, UnitName, 
	0 AS BeginQuantity, 
	0 AS BeginAmount, 
	SUM(CASE WHEN D_C = ''D'' THEN ISNULL(ActualQuantity, 0) ELSE 0 END) AS DebitQuantity, 
	SUM(CASE WHEN D_C = ''C'' THEN ISNULL(ActualQuantity, 0) ELSE 0 END) AS CreditQuantity, 
	SUM(CASE WHEN D_C = ''D'' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS DebitAmount, 
	SUM(CASE WHEN D_C = ''C'' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS CreditAmount, 
	0 AS EndQuantity, 
	0 AS EndAmount, 
	(CASE WHEN D_C = ''D'' THEN DebitAccountID ELSE CreditAccountID END) AS AccountID,
	(CASE WHEN D_C = ''D'' THEN CreditAccountID ELSE NULL END) AS ImCorAccountID,
	(CASE WHEN D_C = ''C'' THEN DebitAccountID ELSE NULL END) AS ExCorAccountID,
	WareHouseName
	FROM AV7000 
    WHERE IsTemp = 0 	
    AND D_C IN (''D'', ''C'') 
    AND DivisionID LIKE ''' + @DivisionID + ''' 
    AND InventoryAccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''
    AND VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
    AND ISNULL(WareHouseID, '''') BETWEEN ''' + @FromWareHouseID + ''' AND ''' + @ToWareHouseID + '''
    GROUP BY 
    DivisionID, InventoryID, InventoryName, UnitID, I05ID, UnitName, 
    DebitAccountID, CreditAccountID, D_C, WareHouseName'
                      	
-----------------------------------------------------

SET @sSQL4 = N'
	SELECT DivisionID, InventoryID, InventoryName, UnitID, I05ID, UnitName,
	SUM(BeginQuantity) AS BeginQuantity, 
	SUM(BeginAmount) AS BeginAmount, 
	DebitQuantity, 
	CreditQuantity, 
	DebitAmount, 
	CreditAmount, 
	SUM(BeginQuantity) + DebitQuantity - CreditQuantity AS EndQuantity, 
	SUM(BeginAmount) + DebitAmount - CreditAmount AS EndAmount, 
	AccountID, ImCorAccountID, ExCorAccountID, WareHouseName
	INTO #TEMP3
	FROM #TEMP2 
	GROUP BY 
	DivisionID, InventoryID, InventoryName, UnitID, I05ID, UnitName, 
	DebitQuantity, DebitAmount, CreditQuantity, CreditAmount,  
	AccountID, ImCorAccountID, ExCorAccountID, WareHouseName'
	

SET @sSQL5 = N'
	SELECT #TEMP3.DivisionID, InventoryID, InventoryName, UnitID, UnitName, I05ID, 
	BeginQuantity, BeginAmount, 
	DebitQuantity, CreditQuantity, 
	EndQuantity,  EndAmount, 
	DebitAmount, CreditAmount, 
	#TEMP3.AccountID, ImCorAccountID, ExCorAccountID, AT1005.AccountName, WareHouseName								 
	FROM #TEMP3 
	LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = #TEMP3.AccountID
	WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
	CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <>0 )
	OR (DebitQuantity <> 0 AND ImCorAccountID IS NOT NULL) OR (CreditQuantity <> 0 AND ExCorAccountID IS NOT NULL)'
		 
EXEC(@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sSQL5)
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3
PRINT @sSQL4
PRINT @sSQL5		

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
