IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3022_AP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3022_AP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In chi tiet don hang ban trên APP
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 22/10/2020 by Đức Thông
-- <Example>
---- 

CREATE PROCEDURE [dbo].[OP3022_AP] 
			@DivisionID AS nvarchar(50),
			@FromMonth AS int,
			@ToMonth AS int,
			@FromYear AS int,
			@ToYear AS int,
			@FromDate AS datetime,
			@ToDate AS datetime,
			@FromObjectID AS nvarchar(50),
			@ToObjectID AS nvarchar(50),				
			@IsDate AS tinyint,
			@UserID As nvarchar(50)
 AS
DECLARE 	@sSQL varchar(MAX),
			@sSQL1 varchar(MAX),
			@sSQL2 varchar(MAX),
			@GroupField nvarchar(20),
			@sFROM nvarchar(500),
			@sSELECT nvarchar(500), 
			@FromMonthYearText NVARCHAR(20), 
			@ToMonthYearText NVARCHAR(20), 
			@FromDateText NVARCHAR(20), 
			@ToDateText NVARCHAR(20),
			@Condition NVARCHAR(4000),
			@CustomerName INT,
			@sSQL3 NVARCHAR(200) = '',
			@sSQL4 NVARCHAR(100) = ''
			
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

--CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
--INSERT #CustomerName EXEC AP4444
--SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
DECLARE @sSQLPer AS NVARCHAR(MAX),
		@sWHEREPer AS NVARCHAR(MAX)
SET @sSQLPer = ''
SET @sWHEREPer = ''

IF EXISTS (SELECT TOP 1 1 FROM OT0001 WHERE DivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = APT0001.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = APT0001.user_id '
		SET @sWHEREPer = ' (APT0001.user_id = AT0010.UserID
								OR  APT0001.user_id = ''' + @UserID + ''') '
	END

-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác	
--If @UserID<>''
--EXEC AP1409 @DivisionID,'ASOFTOP','VT','VT',@UserID,@UserGroupID,0,@Condition OUTPUT     

SELECT @sFROM = '',  @sSELECT = ''
--IF @IsGroup  = 1 
--	BEGIN
--	EXEC OP4700  	@GroupID,	@GroupField OUTPUT
--	SELECT @sFROM = @sFROM + ' 
--		LEFT JOIN	OV6666 V1 
--			ON		V1.SelectionType = ''' + @GroupID + ''' 
--					AND V1.SelectionID = Convert(nvarchar(50),OV2300.' + @GroupField + ') 
--					AND OV2300.DivisionID = V1.DivisionID' ,
--		@sSELECT = @sSELECT + ', 
--		V1.SelectionID AS GroupID, V1.SelectionName AS GroupName'
				
--	END
--ELSE
--	SET @sSELECT = @sSELECT +  ', 
--		'''' AS GroupID, '''' AS GroupName'	

		----------------------------------------- Chuỗi select

Set @sSQL =  '
SELECT  APT0001.DivisionID,
		VoucherNo,
		order_created_date,
		product_id,
		InventoryName,
		UnitName,
		quantity,
		SalePrice,
		APT0001.VATPercent,
		''VND'' AS CurrencyID,
		quantity * SalePrice AS OriginalAmount
		'


		--------------------------------------------- Chuỗi from + join + where

SET @sSQL1 = '
FROM APT0001 
LEFT JOIN AT1302 WITH (NOLOCK) ON APT0001.product_id = AT1302.InventoryID
LEFT JOIN AT1304 WITH (NOLOCK) ON APT0001.unit = AT1304.UnitID
' + IsNull(@sFROM,'') + '
'+@sSQLPer +

'
WHERE ' + @sWHEREPer + CASE ISNULL(@sWHEREPer, '') WHEN '' THEN '' ELSE 'AND' END + '
		APT0001.DivisionID = ''' + @DivisionID + ''' 
		AND	customer_id between ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''' 
		AND ' + CASE WHEN @IsDate = 1 THEN ' CONVERT(DATETIME,CONVERT(VARCHAR(10),order_created_date,101),101)  BETWEEN ''' + @FromDateText + ''' AND ''' +  @ToDateText  + ''''
				ELSE 	' MONTH(order_created_date) + YEAR(order_created_date) * 100 between ' +  @FromMonthYearText +  ' AND ' + @ToMonthYearText  end

PRINT (@sSQL)
PRINT (@sSQL1)

IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'OV3022_AP')
	DROP VIEW OV3022_AP
EXEC('CREATE VIEW OV3022_AP AS ' + @sSQL + @sSQL1)    --tao boi OP3022_AP
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO