IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP2504]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP2504]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by:  	Vo Thanh Huong,  Created date 28/12/2005
---- Purpose: thong tin ton kho cua mat hang
---- Edit by: Dang Le Bao Quynh; Date: 03/10/2008
---- Copy viec tao view OV2801 tu store OP2501 sang.
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [03/08/2010]
'**************************************************************/
---- Modified by Tiểu Mai on 25/05/2017: Chỉnh sửa danh mục dùng chung
--- Modified by Hồng Thảo on 09/01/2019: Bổ sung điều kiện lấy mặt hàng từ kho có ký tự %C và %T (khách hàng Phúc Long Cust=32) 
--- Modified by My Tuyen on 11/10/2019: Bo sung lay them so ton cua kho GH01 (khách hàng Phúc Long Cust=32) 

CREATE PROCEDURE OP2504
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
		@Index TINYINT,
		@CustomerName INT,
		@sWhere NVARCHAR(MAX)= ''

SET @CustomerName=(SELECT TOP 1 CustomerName FROM CustomerIndex)

IF @CustomerName = 32 SET @sWhere = @sWhere + '
	AND (WarehouseID  LIKE ''CT%'' OR WarehouseID LIKE ''NM%'' OR WarehouseID LIKE ''GH01%'') '

SET @sSQL = '
SELECT DivisionID, InventoryID, WareHouseID, 
	SUM(CASE WHEN TypeID <> ''PO'' AND Finish <> 1 THEN OrderQuantity - ActualQuantity ELSE 0 END) SQuantity,
	SUM(CASE WHEN TypeID = ''PO'' AND Finish <> 1  THEN OrderQuantity - ActualQuantity ELSE 0 END) PQuantity
FROM OV2800
GROUP BY DivisionID, InventoryID, WareHouseID'

If NOT EXISTS (SELECT TOP 1 1 FROM sysObjects WHERE XType = 'V' AND Name = 'OV2801')
	EXEC('CREATE VIEW OV2801 -----------tao boi Op2504
		AS ' + @sSQL)
ELSE 
	EXEC('ALTER VIEW OV2801 -----------tao boi Op2504 
		AS ' + @sSQL)

SET @sSQL = '
SELECT ISNULL(V00.DivisionID, V01.DivisionID) DivisionID,
	ISNULL(V00.WareHouseID,V01.WareHouseID) WareHouseID,
	CASE WHEN ENDQuantity = 0 THEN NULL ELSE ENDQuantity END  ENDQuantity,
	CASE WHEN SQuantity = 0 THEN NULL ELSE SQuantity END SQuantity,
	CASE WHEN PQuantity = 0  THEN NULL ELSE PQuantity END PQuantity,
	ISNULL(ENDQuantity,0) - ISNULL(SQuantity, 0) +  ISNULL(PQuantity, 0) ReadyQuantity,
	CASE WHEN ISNULL(MaxQuantity,0) = 0 THEN NULL ELSE MaxQuantity END MaxQuantity, 
	CASE WHEN ISNULL(MinQuantity, 0) = 0 THEN NULL ELSE MinQuantity END MinQuantity
FROM OV2801 V00
	FULL JOIN 
		(SELECT TOP 100 PERCENT DivisionID, InventoryID, WareHouseID, SUM(ISNULL(DebitQuantity,0)) - SUM(ISNULL(CreditQuantity,0)) ENDQuantity
		 FROM OV2401 
	     WHERE DivisionID = '''+@DivisionID+''' and InventoryID = '''+@InventoryID+'''
		 GROUP BY DivisionID, WareHouseID, InventoryID
		 HAVING SUM(ISNULL(DebitQuantity, 0)) - SUM(ISNULL(CreditQuantity,0)) <> 0
		 ORDER BY DivisionID, WareHouseID, InventoryID 
		)V01 ON V00.WareHouseID = V01.WareHouseID AND V00.InventoryID = V01.InventoryID AND V00.DivisionID = V01.DivisionID
	LEFT JOIN AT1314 T01 WITH (NOLOCK) ON T01.InventoryID = ISNULL(V00.InventoryID, V01.InventoryID) AND
		ISNULL (V00.WareHouseID, V01.WareHouseID) LIKE T01.WareHouseID
WHERE ISNULL(V00.InventoryID, V01.InventoryID) =  ''' + isnull(@InventoryID,'') + '''
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
'+@sWhere +'
---isnull(V00.InventoryID, V01.InventoryID) =  '''+ISNULL(@InventoryID,'')+'''
'

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'OV2504')
	EXEC('CREATE VIEW OV2504	--Created by OP2504
		AS '+ @sSQL)
ELSE
	EXEC('ALTER VIEW OV2504 		--Created by OP2504
			AS '+ @sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
