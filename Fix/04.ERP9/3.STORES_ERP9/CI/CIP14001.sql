IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP14001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP14001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form CIP14001 Danh mục đơn vị tính chuyển đổi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 09/02/2022
----Modified by: Hoài Bảo, Date: 01/03/2022 - Thay đổi các trường load dữ liệu
-- <Example>
----    EXEC CIP14001 'AS','','','','',1,10

CREATE PROCEDURE CIP14001 ( 
        @DivisionID VARCHAR(50),
        @InventoryID NVARCHAR(100),
        @UnitID NVARCHAR(100),
		@IsCommon VARCHAR(50),
		@Disabled VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
		SET @sWhere = ''
	SET @OrderBy = 'AV1399.DivisionID, AV1399.InventoryID'
	
	-- Kiểm tra điều kiện search
	IF ISNULL(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'AND (AV1399.DivisionID = '''+@DivisionID+''' or AV1399.DivisionID = ''@@@'')'
	IF ISNULL(@InventoryID,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(AV1399.InventoryID,'''') LIKE N''%'+@InventoryID+'%'' '
	IF ISNULL(@UnitID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AV1399.UnitID, '''') LIKE N''%'+@UnitID+'%'' '
	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AV1399.IsCommon,'''') LIKE N''%'+ISNULL(@IsCommon, 0)+'%'' '
	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AV1399.Disabled,'''') LIKE N''%'+ISNULL(@Disabled, 0)+'%'' '
	
	--Kiểm tra load mặc định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang
	SET @sSQL = N'   
				Declare @AV1399 TABLE (
				APK UNIQUEIDENTIFIER,
  				DivisionID NVARCHAR(50),
  				InventoryID NVARCHAR(50),
  				InventoryName NVARCHAR(250),
  				UnitID NVARCHAR(50),
				UnitName NVARCHAR(250),
				ConvertUnitID NVARCHAR(50),
				ConvertUnitName NVARCHAR(250),
				Orders INT,
				Example NVARCHAR(500),
  				Disabled TINYINT,
				ConversionFactor DECIMAL(28),
				Operator TINYINT,
				OperatorName NVARCHAR(250),
				locked TINYINT,
				DataType TINYINT,
				DataTypeName NVARCHAR(250),
				FormulaID NVARCHAR(50),
				FormulaName NVARCHAR(250),
				FormulaDes NVARCHAR(500),
				IsCommon TINYINT,
				S01ID NVARCHAR(50), S02ID NVARCHAR(50), S03ID NVARCHAR(50), S04ID NVARCHAR(50), S05ID NVARCHAR(50),
				S06ID NVARCHAR(50), S07ID NVARCHAR(50), S08ID NVARCHAR(50), S09ID NVARCHAR(50), S10ID NVARCHAR(50),
				S11ID NVARCHAR(50), S12ID NVARCHAR(50), S13ID NVARCHAR(50), S14ID NVARCHAR(50), S15ID NVARCHAR(50),
				S16ID NVARCHAR(50), S17ID NVARCHAR(50), S18ID NVARCHAR(50), S19ID NVARCHAR(50), S20ID NVARCHAR(50)
			  )
			INSERT INTO @AV1399
			(
 				APK, DivisionID, InventoryID, InventoryName, UnitID, UnitName, ConvertUnitID, ConvertUnitName, Orders, Example,
  				Disabled, ConversionFactor, Operator, OperatorName, locked, DataType, DataTypeName, FormulaID, FormulaName, FormulaDes, IsCommon,
				S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
			)
			SELECT DISTINCT AT1309.APK, AV.DivisionID, AV.InventoryID, AV.InventoryName, AV.UnitID, AV.UnitName, AV.ConvertUnitID, AV.ConvertUnitName
			, AV.Orders, AV.Example, AV.[Disabled], AV.ConversionFactor, AV.Operator
			, CASE WHEN AV.Operator IS NOT NULL THEN IIF(AV.Operator = 1,N''/ - Chia'',N''* - Nhân'') ELSE NULL END AS OperatorName
			, AV.locked, AV.DataType, IIF(AV.DataType = 1, N''Công thức'', N''Toán tử'') AS DataTypeName, AV.FormulaID, AV.FormulaName, AV.FormulaDes
			, AV.IsCommon, AV.S01ID, AV.S02ID, AV.S03ID, AV.S04ID, AV.S05ID, AV.S06ID, AV.S07ID, AV.S08ID, AV.S09ID, AV.S10ID, AV.S11ID, AV.S12ID, AV.S13ID, AV.S14ID, AV.S15ID
			, AV.S16ID, AV.S17ID, AV.S18ID, AV.S19ID, AV.S20ID
			FROM AV1399 AV
			LEFT JOIN AT1309 ON AT1309.InventoryID = AV.InventoryID AND AV.ConvertUnitID = AT1309.UnitID AND AV.Orders = AT1309.Orders
			'
    set @sSQL01='
						Declare @CountTotal NVARCHAR(Max)
						DECLARE @CountEXEC table (CountRow NVARCHAR(Max))
						IF '+Cast(@PageNumber as varchar(2)) + ' = 1
						Begin
							Insert into @CountEXEC (CountRow)
							Select Count(AV1399.InventoryID) From @AV1399 AV1399 WHERE 1=1 '+ @sWhere +'
						End
    '
    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (Select CountRow from @CountEXEC) AS TotalRow	,
				 APK, AV1399.DivisionID, AV1399.InventoryID, AV1399.InventoryName, AV1399.UnitID, AV1399.UnitName, AV1399.ConvertUnitID, 
				 AV1399.ConvertUnitName, AV1399.Orders, AV1399.Example, AV1399.Disabled, AV1399.ConversionFactor, AV1399.Operator, AV1399.OperatorName, 
				 AV1399.locked, AV1399.DataType, AV1399.DataTypeName, AV1399.FormulaID, AV1399.FormulaName, AV1399.FormulaDes, AV1399.IsCommon, AV1399.S01ID, AV1399.S02ID, 
				 AV1399.S03ID, AV1399.S04ID, AV1399.S05ID, AV1399.S06ID, AV1399.S07ID, AV1399.S08ID, AV1399.S09ID, AV1399.S10ID, AV1399.S11ID, AV1399.S12ID, 
				 AV1399.S13ID, AV1399.S14ID, AV1399.S15ID, AV1399.S16ID, AV1399.S17ID, AV1399.S18ID, AV1399.S19ID, AV1399.S20ID
				 FROM @AV1399 AS AV1399
				 WHERE 1=1 '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

	EXEC (@sSQL+ @sSQL01+@sSQL02)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
