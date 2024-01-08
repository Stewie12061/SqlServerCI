IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP2504_SAVI]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP2504_SAVI]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- OP2504_SAVI 'LG', 8, 2014, '%'
--- Modified by Văn Tài	  on 28/09/2020: Tách store customize
--- Modified by Văn Tài	  on 30/09/2020: Đi theo kiểm tra loại mặt hàng sử dụng trên app.
--- Modified by Đức Thông on 16/10/2020: SUM số lượng cuối kì thay vì số lượng đầu kì
--- Modified by Đức Thông on 06/01/2021: [SAVI] 2021/01/IS/0079: Bỏ kết với Danh mục định mức tồn kho hàng hóa (AT1314) vì SAVI không xài xử lí lấy cột động

CREATE PROCEDURE OP2504_SAVI
(
	@DivisionID NVARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@InventoryID NVARCHAR(50)	
)				
AS
DECLARE @sSQL NVARCHAR(MAX),
	    @IsColumn TINYINT,
		@RowField NVARCHAR(50),
		@Caption VARCHAR(150),
		@AmountType1 NVARCHAR(50),
		@AmountType2 NVARCHAR(50),
		@AmountType3 NVARCHAR(50),
		@AmountType4 NVARCHAR(50),
		@AmountType5 NVARCHAR(50),
		@ColumnID NVARCHAR(50),
		@Sign1 NVARCHAR(50),
	 	@Sign2 NVARCHAR(50),
		@Sign3 NVARCHAR(50),
		@Sign4 NVARCHAR(50),
		@Sign5 NVARCHAR(50),
		@SQL NVARCHAR(4000) = '',
		@Cur CURSOR,
		@Index TINYINT

SET @sSQL = '
SELECT DivisionID, InventoryID, WareHouseID, 
	SUM(CASE WHEN TypeID <> ''PO'' AND Finish <> 1 THEN OrderQuantity - ActualQuantity ELSE 0 END) SQuantity,
	SUM(CASE WHEN TypeID = ''PO'' AND Finish <> 1  THEN OrderQuantity - ActualQuantity ELSE 0 END) PQuantity
FROM OV2800
GROUP BY DivisionID, InventoryID, WareHouseID'


If NOT EXISTS (SELECT TOP 1 1 FROM sysObjects WHERE XType = 'V' AND Name = 'OV2801')
	EXEC('CREATE VIEW OV2801 -----------tao boi OP2504LAVO
		AS ' + @sSQL)
ELSE 
	EXEC('ALTER VIEW OV2801 -----------tao boi OP2504LAVO 
		AS ' + @sSQL)

SET @sSQL = '
SELECT ISNULL(V00.DivisionID, V01.DivisionID) DivisionID
	 , ISNULL(V00.WareHouseID,V01.WareHouseID) WareHouseID
	 , CASE WHEN ENDQuantity = 0 
			THEN NULL 
			ELSE ENDQuantity 
		END ENDQuantity
	 , CASE WHEN SQuantity = 0 
			THEN NULL 
			ELSE SQuantity 
		END SQuantity
	 , CASE WHEN PQuantity = 0 
			THEN NULL 
			ELSE PQuantity 
		END PQuantity
	 , ISNULL(ENDQuantity, 0) - ISNULL(SQuantity, 0) +  ISNULL(PQuantity, 0) ReadyQuantity
	 , ISNULL(V00.InventoryID, V01.InventoryID) InventoryID
	 , V01.TranMonth
	 , V01.TranYear
FROM OV2801 V00
	FULL JOIN 
		(
			SELECT TOP 100 PERCENT O41.DivisionID
				, O41.InventoryID
				, O41.WareHouseID
				, SUM(O41.EndQuantity) ENDQuantity
				, O41.TranMonth
				, O41.TranYear
			FROM OV2403 O41
				LEFT JOIN AT1302 A02 ON A02.DivisionID = O41.DivisionID AND A02.InventoryID = O41.InventoryID
			WHERE O41.DivisionID = '''+@DivisionID+'''
					AND O41.InventoryID LIKE  ''%'+ISNULL(@InventoryID,'%')+'%''
			GROUP BY O41.DivisionID
					, O41.WareHouseID
					, O41.InventoryID
					, O41.TranMonth
					, O41.TranYear
			HAVING SUM(O41.EndQuantity) <> 0
			ORDER BY O41.DivisionID, O41.WareHouseID, O41.InventoryID 
		) V01 ON ISNULL(V00.DivisionID, '''') = ISNULL(V01.DivisionID, '''')
					AND ISNULL(V00.WareHouseID, '''') = ISNULL(V01.WareHouseID, '''')
					AND ISNULL(V00.InventoryID, '''') = ISNULL(V01.InventoryID, '''')
	INNER JOIN AT1302 A02 ON A02.DivisionID IN (''@@@'', ISNULL(V00.DivisionID, V01.DivisionID))
							AND A02.InventoryID = ISNULL(V00.InventoryID, V01.InventoryID)
	INNER JOIN AT1301 A01 ON A01.DivisionID IN (''@@@'' , ISNULL(V00.DivisionID, V01.DivisionID))
							AND ISNULL(A01.InventoryTypeID, '''') = ISNULL(A02.InventoryTypeID, '''')
WHERE 
		ISNULL(A01.IsUseApp, 0) = 1
		AND ISNULL(V00.InventoryID, V01.InventoryID) LIKE ''%'+ISNULL(@InventoryID,'%')+'%'' 
		AND (ISNULL(EndQuantity,0) <> 0 OR ISNULL(SQuantity,0) <> 0 OR PQuantity <> 0) 
		AND ISNULL(V00.DivisionID, V01.DivisionID)  = ''' + @DivisionID + ''''



IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'OV2506')
BEGIN
	PRINT ('CREATE VIEW OV2506 AS '+@sSQL)
	EXEC('CREATE VIEW OV2506 AS '+@sSQL)
END
ELSE
BEGIN
	EXEC('ALTER VIEW OV2506 AS '+@sSQL)
	PRINT ('CREATE VIEW OV2506 AS '+@sSQL)
END
PRINT 'TTTTTT999'

SET @sSQL = 'SELECT '+@SQL+' * 
FROM OV2506 	
WHERE 	DivisionID = '''+@DivisionID+''' 
---isnull(V00.InventoryID, V01.InventoryID) =  '''+ISNULL(@InventoryID,'')+'''
'

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'OV2504')
	EXEC('CREATE VIEW OV2504	--Created by OP2504_SAVI
		AS '+ @sSQL)
ELSE
	EXEC('ALTER VIEW OV2504 		--Created by OP2504_SAVI
			AS '+ @sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO