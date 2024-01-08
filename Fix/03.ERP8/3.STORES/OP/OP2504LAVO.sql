IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP2504LAVO]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP2504LAVO]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung

-- OP2504LAVO 'LG', 8, 2014, '%'

CREATE PROCEDURE OP2504LAVO
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
		@SQL NVARCHAR(4000),
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
SELECT ISNULL(V00.DivisionID, V01.DivisionID) DivisionID,
	ISNULL(V00.WareHouseID,V01.WareHouseID) WareHouseID,
	CASE WHEN ENDQuantity = 0 THEN NULL ELSE ENDQuantity END  ENDQuantity,
	CASE WHEN SQuantity = 0 THEN NULL ELSE SQuantity END SQuantity,
	CASE WHEN PQuantity = 0  THEN NULL ELSE PQuantity END PQuantity,
	ISNULL(ENDQuantity,0) - ISNULL(SQuantity, 0) +  ISNULL(PQuantity, 0) ReadyQuantity,
	CASE WHEN ISNULL(MaxQuantity,0) = 0 THEN NULL ELSE MaxQuantity END MaxQuantity, 
	CASE WHEN ISNULL(MinQuantity, 0) = 0 THEN NULL ELSE MinQuantity END MinQuantity, ISNULL(V00.InventoryID, V01.InventoryID) InventoryID,
	V01.TranMonth,
	V01.TranYear
FROM OV2801 V00
	FULL JOIN 
		(SELECT TOP 100 PERCENT O41.DivisionID, O41.InventoryID, O41.WareHouseID,
			SUM(O41.BeginQuantity) ENDQuantity, O41.TranMonth, O41.TranYear
		 FROM OV2403 O41
		 LEFT JOIN AT1302 A02 ON A02.DivisionID IN (''@@@'', O41.DivisionID) AND A02.DivisionID = O41.DivisionID AND A02.InventoryID = O41.InventoryID
	     WHERE O41.DivisionID = '''+@DivisionID+'''
	     AND O41.InventoryID LIKE  ''%'+ISNULL(@InventoryID,'%')+'%''
		 GROUP BY O41.DivisionID, O41.WareHouseID, O41.InventoryID, O41.TranMonth, O41.TranYear
		 HAVING SUM(O41.BeginQuantity) <> 0
		 ORDER BY O41.DivisionID, O41.WareHouseID, O41.InventoryID 
		)V01 ON V00.WareHouseID = V01.WareHouseID AND V00.InventoryID = V01.InventoryID AND V00.DivisionID = V01.DivisionID
	LEFT JOIN AT1314 T01 ON T01.InventoryID = ISNULL(V00.InventoryID, V01.InventoryID) AND
		ISNULL (V00.WareHouseID, V01.WareHouseID) LIKE T01.WareHouseID AND T01.DivisionID = V00.DivisionID
	LEFT JOIN AT1302 A02 ON A02.DivisionID IN (''@@@'', V00.DivisionID) AND A02.DivisionID = V00.DivisionID AND A02.InventoryID = ISNULL(V00.InventoryID, V01.InventoryID)
WHERE ISNULL(V00.InventoryID, V01.InventoryID) LIKE ''%'+ISNULL(@InventoryID,'%')+'%'' 
	AND(ISNULL(EndQuantity,0) <> 0 OR ISNULL(SQuantity,0) <> 0 OR PQuantity <> 0) 
	AND ISNULL(V00.DivisionID, V01.DivisionID)  = ''' + @DivisionID + ''''
	
IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'OV2506')
	EXEC('CREATE VIEW OV2506 AS '+@sSQL)
ELSE
	EXEC('ALTER VIEW OV2506 AS '+@sSQL)

 ---------------- Xử lý cột động -----------------------------------------------------------------------
SET @sSQL = '
SELECT '''+@Caption+''' Caption01,'

SET @Index =1		
SET @SQL =''
SET @Cur =  CURSOR SCROLL KEYSET FOR
	SELECT ColumnID, Caption, IsColumn, Sign1, AmountType1, Sign2, AmountType2, Sign3, AmountType3
	FROM OT4010 ORDER BY ColumnID
	
OPEN @Cur
FETCH NEXT FROM  @Cur INTO @ColumnID, @Caption,  @IsColumn, @Sign1, @AmountType1, @Sign2, @AmountType2, @Sign3, @AmountType3
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @SQL = @SQL  + '('
	IF ISNULL(@Sign1, '') <> ''
	BEGIN
		IF ISNULL(@AmountType1, '') = 'DV'												-- hàng đang về
			SET @SQL = @SQL + @Sign1 + ' ISNULL(PQuantity, 0) '
		ELSE IF ISNULL(@AmountType1, '') = 'GC'										    -- hàng giữ chỗ
				SET @SQL = @SQL + @Sign1 + ' ISNULL( SQuantity, 0) '
			 ELSE IF ISNULL(@AmountType1,'') = 'TT'										-- tồn kho thực tế
					 SET @SQL =  @SQL + @Sign1 + ' ISNULL(EndQuantity, 0) '
				  ELSE IF ISNULL(@AmountType1, '') = 'MIN'								-- tồn kho thực tế
							SET @SQL = @SQL + @Sign1 + ' ISNULL(MinQuantity, 0) '
						ELSE IF ISNULL(@AmountType1, '') = 'MAX'						-- tồn kho thực tế
								SET @SQL = @SQL + @Sign1 + ' ISNULL(MaxQuantity, 0) '
	END
	IF ISNULL(@Sign2, '') <> ''
		BEGIN
			IF ISNULL(@AmountType2, '') = 'DV'											-- hàng đang về
				SET @SQL = @SQL + @Sign2 + ' ISNULL(PQuantity, 0) '
			ELSE if ISNULL(@AmountType2, '') = 'GC'										-- hàng giữ chỗ
					SET @SQL = @SQL + @Sign2 + ' ISNULL(SQuantity, 0) '
				 ELSE IF ISNULL(@AmountType2, '') = 'TT'								-- tồn kho thực tế
						 SET @SQL = @SQL + @Sign2 + ' ISNULL(EndQuantity, 0)'
					  ELSE IF ISNULL(@AmountType2, '') = 'MIN'							-- tồn kho thực tế
							  SET @SQL = @SQL + @Sign1 + ' ISNULL(MinQuantity, 0) '
						   ELSE IF ISNULL(@AmountType2, '') = 'MAX'						-- tồn kho thực tế
								   SET @SQL = @SQL + @Sign1 + ' ISNULL(MaxQuantity, 0) '
		END

	IF ISNULL(@Sign3, '') <> ''
		BEGIN
			IF ISNULL(@AmountType3, '') = 'DV'											-- hàng đang về
				SET @SQL = @SQL + @Sign3 + ' ISNULL(PQuantity, 0) '
			ELSE IF ISNULL(@AmountType3, '') = 'GC'										-- hàng giữ chỗ
					SET @SQL = @SQL + @Sign3 + ' ISNULL(SQuantity, 0) '
				 ELSE IF ISNULL(@AmountType3, '') = 'TT'								-- tồn kho thực tế
						 SET @SQL = @SQL + @Sign3 + ' ISNULL(EndQuantity, 0)'
					  ELSE IF ISNULL(@AmountType3, '') = 'MIN'							-- tồn kho thực tế
							  SET @SQL = @SQL + @Sign1 + ' ISNULL(MinQuantity, 0) '
						   ELSE IF ISNULL(@AmountType3, '') = 'MAX'						-- tồn kho thực tế
									SET @SQL = @SQL + @Sign1 + ' ISNULL(MaxQuantity, 0) '
				
		END
	IF ISNULL(@Sign4, '') <> ''
		BEGIN
			IF ISNULL(@AmountType4, '') = 'DV'											-- hàng đang về
			   SET @SQL = @SQL + @Sign4 + ' ISNULL(PQuantity, 0)  '
			ELSE IF ISNULL(@AmountType4, '') = 'GC'										-- hàng giữ chỗ
					SET @SQL = @SQL + @Sign4 + '  ISNULL(SQuantity, 0) '
				 ELSE IF ISNULL(@AmountType4, '') = 'TT'								-- tồn kho thực tế
						 SET @SQL = @SQL + @Sign4 + ' ISNULL(EndQuantity, 0)'
				      ELSE IF ISNULL(@AmountType4, '') = 'MIN'							-- tồn kho thực tế
							  SET @SQL = @SQL + @Sign4 + ' ISNULL(MinQuantity, 0) '
						   ELSE IF ISNULL(@AmountType4, '') = 'MAX'						-- tồn kho thực tế
								   Set @SQL = @SQL + @Sign4 + ' ISNULL(MaxQuantity, 0) '
				
		END
	IF ISNULL(@Sign5, '') <> ''
		BEGIN
			IF ISNULL( @AmountType5, '') = 'DV'											-- hàng đang về
			   SET @SQL = @SQL + @Sign5 + ' ISNULL(PQuantity, 0) '
			ELSE IF ISNULL(@AmountType5, '') = 'GC'										-- hàng giữ chỗ
					SET @SQL = @SQL + @Sign5 + ' ISNULL(SQuantity, 0) '
				 ELSE IF ISNULL(@AmountType5, '') = 'TT'								-- tồn kho thực tế
						 SET @SQL = @SQL + @Sign5 + ' ISNULL(EndQuantity, 0)'
					  ELSE IF ISNULL(@AmountType5, '') = 'MIN'							-- tồn kho thực tế
							  SET @SQL = @SQL + @Sign5 + ' ISNULL(MinQuantity, 0) '
						   ELSE IF ISNULL(@AmountType5, '') = 'MAX'						-- tồn kho thực tế
								   SET @SQL = @SQL + @Sign5 + ' ISNULL(MaxQuantity, 0) '
				
		END
	SET @SQL = @SQL + ') AS ColumnValue' + LTRIM(@Index) + ','
	SET @Index = @Index + 1
	---Print  @SQL
	FETCH NEXT FROM @Cur INTO @ColumnID, @Caption, @IsColumn, @Sign1, @AmountType1, @Sign2, @AmountType2, @Sign3, @AmountType3

END
CLOSE @Cur

SET @sSQL = 'SELECT '+@SQL+' * 
FROM OV2506 	
WHERE 	DivisionID = '''+@DivisionID+''' 
---isnull(V00.InventoryID, V01.InventoryID) =  '''+ISNULL(@InventoryID,'')+'''
'

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'OV2504')
	EXEC('CREATE VIEW OV2504	--Created by OP2504LAVO
		AS '+ @sSQL)
ELSE
	EXEC('ALTER VIEW OV2504 		--Created by OP2504LAVO
			AS '+ @sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
