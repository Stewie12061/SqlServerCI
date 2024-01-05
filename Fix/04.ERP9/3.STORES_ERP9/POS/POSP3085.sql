IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3085]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3085]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo tồn kho linh kiện vật tư
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 25/11/2019 by Kiều Nga
-- <Example> 

CREATE PROCEDURE POSP3085 ( 
		@DivisionID		AS NVARCHAR(Max),
		@DivisionIDList AS NVARCHAR(Max) = NULL,
		@ShopID			AS NVARCHAR(Max),
		@ShopIDList		AS NVARCHAR(Max) = NULL,
		@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
		@FromDate			DATETIME, 
		@ToDate				DATETIME,
		@FromYear           AS INT,
		@FromMonth          AS INT,
		@PeriodIDList		NVARCHAR(2000),
		@ListInventoryID AS NVARCHAR(Max) = NULL
) 
AS 
		DECLARE @sSQLBegin   NVARCHAR(MAX)='',  
				@sSQLImport   NVARCHAR(MAX)='',  
				@sSQLExport   NVARCHAR(MAX)='',  
				@sSQLResult   NVARCHAR(MAX)='',  
				@sWhere NVARCHAR(MAX)='',
				@sWHERE_POST0038_DD AS NVARCHAR(MAX) ='',
				@sWHERE_POST0015_DD AS NVARCHAR(MAX) ='',
				@sWHERE_POST0027_DD AS NVARCHAR(MAX) ='',
				@sWHERE_POST0015_PS AS NVARCHAR(MAX) ='',
				@sWHERE_POST0027_PS AS NVARCHAR(MAX) =''

--Điều kiện Search
		--Check Para DivisionIDList null then get DivisionID 
		IF Isnull(@DivisionIDList,'') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
		Else
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+ @DivisionID+''')' 

		IF Isnull(@ListInventoryID, '') <> ''
			SET @sWhere = @sWhere + ' AND D.InventoryID IN ('''+@ListInventoryID+''')'

		--Check Para @ShopIDList null then get ShopID 
		IF Isnull(@ShopIDList,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopIDList+''')'
			--SET @sWhere = @sWhere + ' And R.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopIDList+'''))'
			SET @sWHERE_POST0038_DD = @sWhere + ' And D.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopIDList+'''))'
			SET @sWHERE_POST0015_DD = @sWhere + ' And D.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopIDList+'''))'
			SET @sWHERE_POST0027_DD = @sWhere + ' And M.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopIDList+'''))'
			SET @sWHERE_POST0015_PS = @sWhere + ' And D.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopIDList+'''))'
			SET @sWHERE_POST0027_PS = @sWhere + ' And M.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopIDList+'''))'

		END
		Else
		BEGIN
			SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopID+''')'
			--SET @sWhere = @sWhere + ' And R.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopID+'''))'
			SET @sWHERE_POST0038_DD = @sWhere + ' And D.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopID+'''))'
			SET @sWHERE_POST0015_DD = @sWhere + ' And D.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopID+'''))'
			SET @sWHERE_POST0027_DD = @sWhere + ' And M.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopID+'''))'
			SET @sWHERE_POST0015_PS = @sWhere + ' And D.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopID+'''))'
			SET @sWHERE_POST0027_PS = @sWhere + ' And M.WareHouseID IN (select BrokenWareHouseID from POST0010 where ShopID IN ('''+@ShopID+'''))'

		END

		--IF @IsDate = 1	
		--	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,R.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		--ELSE
		--	SET @sWhere = @sWhere + ' AND (Case When  Month(R.VoucherDate) <10 then ''0''+rtrim(ltrim(str(Month(R.VoucherDate))))+''/''+ltrim(Rtrim(str(Year(R.VoucherDate)))) Else rtrim(ltrim(str(Month(R.VoucherDate))))+''/''+ltrim(Rtrim(str(Year(R.VoucherDate)))) End) IN ('''+@PeriodIDList+''')'


        IF @IsDate = 1	
		BEGIN
			SET @sWHERE_POST0038_DD = @sWHERE_POST0038_DD + N'AND CONVERT(NVARCHAR(10), M.VoucherDate,21) <= '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' '
			SET @sWHERE_POST0015_DD = @sWHERE_POST0015_DD + N'AND CONVERT(NVARCHAR(10), M.VoucherDate,21) < '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' '
			SET @sWHERE_POST0027_DD = @sWHERE_POST0027_DD + N'AND CONVERT(NVARCHAR(10), M.VoucherDate,21) < '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' '
			SET @sWHERE_POST0015_PS = @sWHERE_POST0015_PS + N' AND CONVERT(NVARCHAR(10),M.VoucherDate,21) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,21)+''' '
			SET @sWHERE_POST0027_PS = @sWHERE_POST0027_PS + N' AND CONVERT(NVARCHAR(10),M.VoucherDate,21) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,21)+''' '
		END
		ELSE
		BEGIN
			SET @sWHERE_POST0038_DD = @sWHERE_POST0038_DD + N' AND M.TranYear*100+M.TranMonth <= '+STR(@FromYear*100+@FromMonth)+' '
			SET @sWHERE_POST0015_DD = @sWHERE_POST0015_DD + N' AND M.TranYear*100+M.TranMonth < '+STR(@FromYear*100+@FromMonth)+' '
			SET @sWHERE_POST0027_DD = @sWHERE_POST0027_DD + N' AND M.TranYear*100+M.TranMonth < '+STR(@FromYear*100+@FromMonth)+' '
			SET @sWHERE_POST0015_PS = @sWHERE_POST0015_PS + N' AND (Case When M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
			SET @sWHERE_POST0027_PS = @sWHERE_POST0027_PS + N' AND (Case When M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'

		END

			
		--Lấy đầu kỳ
		SET @sSQLBegin = N' DECLARE @POSP00711 table 
								(	VoucherDate Datetime,
									DivisionID NVARCHAR(50),
									ShopID NVARCHAR(50),
									WareHouseID NVARCHAR(50),
									InventoryID NVARCHAR(50),
									UnitID NVARCHAR(50),
									BeginQuantity Decimal(28,8),
									ImQuantity Decimal(28,8),
									ExQuantity Decimal(28,8)
								)
							Insert into @POSP00711 (DivisionID, ShopID, WareHouseID, InventoryID, UnitID, BeginQuantity, ImQuantity, ExQuantity)
							Select P01.DivisionID, P01.ShopID, P01.WareHouseID, P01.InventoryID, P01.UnitID
									, Isnull(P01.BeginQuantity, 0) + Isnull(P01.ImQuantity, 0) - Isnull(P01.ExQuantity, 0) AS BeginQuantity, 0 as ImQuantity, 0 as ExQuantity
							FROM (
									SELECT	M.DivisionID, M.ShopID, D.WareHouseID, D.InventoryID, D.UnitID, D.Quantity as BeginQuantity, 0 as ImQuantity, 0 as ExQuantity
									FROM POST0038 M WITH (NOLOCK) inner join POST0039 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									Where M.DeleteFlg =0 ' + @sWHERE_POST0038_DD+ '
									Union all
									SELECT	M.DivisionID, M.ShopID, D.WareHouseID, D.InventoryID, D.UnitID, 0 as BeginQuantity, D.ActualQuantity as ImQuantity, 0 as ExQuantity
									FROM POST0015 M WITH (NOLOCK) inner join POST00151 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									Where M.DeleteFlg =0  ' + @sWHERE_POST0015_DD+'
									Union all
									SELECT	M.DivisionID, M.ShopID, M.WareHouseID, D.InventoryID, D.UnitID, 0 as BeginQuantity, 0 as ImQuantity, D.ShipQuantity as ExQuantity
									FROM POST0027 M WITH (NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									Where M.DeleteFlg =0  ' + @sWHERE_POST0027_DD+'
									) P01 '
		--Lấy phiếu nhập
		SET @sSQLImport = N' Union all 
							 SELECT	M.DivisionID, M.ShopID, D.WareHouseID, D.InventoryID, D.UnitID, 0 as BeginQuantity, D.ActualQuantity as ImQuantity, 0 as ExQuantity
							 FROM POST0015 M WITH (NOLOCK) inner join POST00151 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
							 Where M.DeleteFlg =0 ' + @sWHERE_POST0015_PS+' '
		--Lấy phiếu xuất
		SET @sSQLExport = N' Union all 
							 SELECT	M.DivisionID, M.ShopID, M.WareHouseID, D.InventoryID, D.UnitID, 0 as BeginQuantity, 0 as ImQuantity, D.ShipQuantity as ExQuantity
							 FROM POST0027 M WITH (NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
							 Where M.DeleteFlg =0 ' + @sWHERE_POST0027_PS+' '
		--Lấy kết quả
		SET @sSQLResult = N' Select R.DivisionID, R.WareHouseID, R.WareHouseID+''-''+P03.WareHouseName as WareHouseName, R.InventoryID, A.InventoryName, P04.UnitName as UnitID, P04.UnitName
									, Sum(R.BeginQuantity) as BeginQuantity
									, Sum(R.ImQuantity) as ImQuantity
									, Sum(R.ExQuantity) as ExQuantity
									, Sum(R.BeginQuantity) + Sum(R.ImQuantity) - Sum(R.ExQuantity) as EndQuantity
							 From	@POSP00711 R Left join AT1303 P03 WITH (NOLOCK) ON R.WareHouseID = P03.WareHouseID
												 left join AT1302 A on A.InventoryID=R.InventoryID
												 Left join AT1304 P04 WITH (NOLOCK) ON R.UnitID = P04.UnitID
							  Group by R.DivisionID, R.WareHouseID, P03.WareHouseName, R.InventoryID, A.InventoryName,  P04.UnitName 
							  Order by R.DivisionID, R.WareHouseID, R.InventoryID'
		EXEC(@sSQLBegin + @sSQLImport+@sSQLExport +@sSQLResult)
		Print (@sSQLBegin)
		Print (@sSQLImport)
		Print (@sSQLExport)
		Print (@sSQLResult)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
