IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00711]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00711]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Báo cáo bảng cân đối nhập xuất tồn - POS
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 10/06/2016 by Phan thanh hoang vu: In báo cáo bảng cân đối nhập xuất tồn
---- Edit by 28/06/2016 by Hoàng Vũ: bổ sung DeleteFlg, những nghiệp vụ đã bị xóa không hiện lên
---- Edit by 08/06/2017 by Hoàng Vũ: Bổ sung With nolock và bổ sung dùng chung
---- Edit by 02/05/2018 by Hoàng Vũ: Bổ sung điều kiện search kho
---- Edit by 10/05/2018 by Hoàng Vũ: Cải tiến tốc độ câu SQL
---- Edit by 10/05/2018 by Hoàng Vũ: Khai báo biến truyền vào bị giới hạn độ dài nên sai số liệu
---- Edit by 22/08/2018 by Trà Giang: Fix lỗi hiển thị sai tên mặt hàng
---- Edit by 06/05/2019 by Trà Giang: Bỏ kết chuyển bảng POST0030
---- Edit by 17/11/2020 by Huỳnh Thử: Bổ sung điều kiện Phân loại 1, 2, 3
---- Edit by 14/12/2020 by Hoài Phong: Bổ sung điều kiện Danh mục AnaId
---- Edit by 18/10/2021 by Nhựt Trường: Bổ sung trường StatusInventory.
-- <Example> EXEC POSP00711 'HCM', NULL, '50C2101', NULL, 1, '2015-01-01', '2018-12-12', 1, 2015, 12, 2018, NULL, NULL, NULL,NULL, NULL

CREATE PROCEDURE POSP00711 ( 
		@DivisionID		AS NVARCHAR(Max),
		@DivisionIDList AS NVARCHAR(Max) = NULL,
		@ShopID			AS NVARCHAR(Max),
		@ShopIDList		AS NVARCHAR(Max) = NULL,
		@IsDate			AS TINYINT,
		@FromDate		AS DATETIME,
		@ToDate			AS DATETIME,
		@FromMonth		AS INT,
		@FromYear		AS INT,
		@ToMonth		AS INT,
		@ToYear			AS INT,
		@FromWareHouseID	as NVARCHAR(250) = NULL,
		@ToWareHouseID	as NVARCHAR(250) = NULL,
		@FromInventoryID AS NVARCHAR(250) = NULL,
		@ToInventoryID	AS NVARCHAR(250) = NULL,
		@UserID			AS NVARCHAR(50),
		@ListInventoryID AS NVARCHAR(Max) = NULL,
		@S1 AS NVARCHAR(Max) = NULL,		
		@S2 AS NVARCHAR(Max) = NULL,
		@S3 AS NVARCHAR(Max) = NULL,
		@AnaID AS NVARCHAR(Max) = NULL
) 
AS 
		DECLARE @sSQLBegin   NVARCHAR(MAX),  
				@sSQLImport   NVARCHAR(MAX),  
				@sSQLExport   NVARCHAR(MAX),  
				@sSQLResult   NVARCHAR(MAX),  
				@sWhere NVARCHAR(MAX),
				@sWHERE_POST0038_DD AS NVARCHAR(MAX),
				@sWHERE_POST0015_DD AS NVARCHAR(MAX),
				@sWHERE_POST0027_DD AS NVARCHAR(MAX),
				@sWHERE_POST0015_PS AS NVARCHAR(MAX),
				@sWHERE_POST0027_PS AS NVARCHAR(MAX),
				@LEFTJOINAT1302 AS NVARCHAR(MAX)
		SET @sWhere = ' '
		SET @sWHERE_POST0038_DD = ' '
		SET @sWHERE_POST0015_DD = ' '
		SET @sWHERE_POST0027_DD = ' '
		SET @sWHERE_POST0015_PS = ' '
		SET @sWHERE_POST0027_PS = ' '
		SET @sSQLBegin = ' '
		SET @sSQLImport = ' '
		SET @sSQLExport = ' '
		SET @sSQLResult = ' '
		

--Điều kiện Search
	
		--Check Para DivisionIDList null then get DivisionID 
		IF Isnull(@DivisionIDList,'') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
		Else
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+ @DivisionID+''')' 
			
		--Check Para @ShopIDList null then get ShopID 
		IF Isnull(@ShopIDList,'') != ''
			SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopIDList+''')'
		Else 
			SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopID+''')'
		
		IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
			SET @sWhere = @sWhere + ' AND D.InventoryID > = N'''+@FromInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID < = N'''+@ToInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''
		ELSE
			SET @sWhere = @sWhere

		IF Isnull(@ListInventoryID, '') <> ''
			SET @sWhere = @sWhere + ' AND D.InventoryID IN ('''+@ListInventoryID+''')'
		-- Search theo phân loại
		if(IsNull(@S1,'') <> '')
			SET @sWhere  = @sWhere +' AND AT02.S1 = '''+@S1+''''
		if(IsNull(@S2,'') <> '')
			SET @sWhere  = @sWhere +' AND AT02.S2 = '''+@S2+''''
		if(IsNull(@S3,'') <> '')
			SET @sWhere  = @sWhere +' AND AT02.S3 = '''+@S3+''''
		if(IsNull(@AnaID,'') <> '')
			SET @sWhere  = @sWhere +' AND AT02.I01ID = '''+@AnaID+''''
		SET @LEFTJOINAT1302 = N'LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.InventoryID = D.InventoryID'
		--Search theo kho  (Dữ liệu kho nhiều nên dùng control từ kho , đến kho
		IF Isnull(@FromWareHouseID, '')!= '' and Isnull(@ToWareHouseID, '') = ''
		BEGIN
			SET @sWHERE_POST0038_DD = @sWhere + ' AND D.WareHouseID > = N'''+@FromWareHouseID +''''
			SET @sWHERE_POST0015_DD = @sWhere + ' AND D.WareHouseID > = N'''+@FromWareHouseID +''''
			SET @sWHERE_POST0027_DD = @sWhere + ' AND M.WareHouseID > = N'''+@FromWareHouseID +''''
			SET @sWHERE_POST0015_PS = @sWhere + ' AND D.WareHouseID > = N'''+@FromWareHouseID +''''
			SET @sWHERE_POST0027_PS = @sWhere + ' AND M.WareHouseID > = N'''+@FromWareHouseID +''''
		END
		ELSE IF Isnull(@FromWareHouseID, '') = '' and Isnull(@ToWareHouseID, '') != ''
		BEGIN
			SET @sWHERE_POST0038_DD = @sWhere + ' AND D.WareHouseID < = N'''+@ToWareHouseID +''''
			SET @sWHERE_POST0015_DD = @sWhere + ' AND D.WareHouseID < = N'''+@ToWareHouseID +''''
			SET @sWHERE_POST0027_DD = @sWhere + ' AND M.WareHouseID < = N'''+@ToWareHouseID +''''
			SET @sWHERE_POST0015_PS = @sWhere + ' AND D.WareHouseID < = N'''+@ToWareHouseID +''''
			SET @sWHERE_POST0027_PS = @sWhere + ' AND M.WareHouseID < = N'''+@ToWareHouseID +''''
		END
		ELSE IF Isnull(@FromWareHouseID, '') != '' and Isnull(@ToWareHouseID, '') != ''
		BEGIN
			SET @sWHERE_POST0038_DD = @sWhere + ' AND D.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
			SET @sWHERE_POST0015_DD = @sWhere + ' AND D.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
			SET @sWHERE_POST0027_DD = @sWhere + ' AND M.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
			SET @sWHERE_POST0015_PS = @sWhere + ' AND D.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
			SET @sWHERE_POST0027_PS = @sWhere + ' AND M.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
		END
		ELSE
		BEGIN
			SET @sWHERE_POST0038_DD = @sWhere
			SET @sWHERE_POST0015_DD = @sWhere
			SET @sWHERE_POST0027_DD = @sWhere
			SET @sWHERE_POST0015_PS = @sWhere
			SET @sWHERE_POST0027_PS = @sWhere
		END

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
			SET @sWHERE_POST0015_PS = @sWHERE_POST0015_PS + N' AND M.TranYear*100+M.TranMonth BETWEEN '+STR(@FromYear*100+@FromMonth)+' AND '+STR(@ToYear*100+@ToMonth)+' '
			SET @sWHERE_POST0027_PS = @sWHERE_POST0027_PS + N' AND M.TranYear*100+M.TranMonth BETWEEN '+STR(@FromYear*100+@FromMonth)+' AND '+STR(@ToYear*100+@ToMonth)+' '

		END
			
		--Lấy đầu kỳ
		SET @sSQLBegin = N' DECLARE @POSP00711 table 
								(	DivisionID NVARCHAR(50),
									ShopID NVARCHAR(50),
									WareHouseID NVARCHAR(50),
									InventoryID NVARCHAR(50),
									UnitID NVARCHAR(50),
									BeginQuantity Decimal(28,8),
									ImQuantity Decimal(28,8),
									ExQuantity Decimal(28,8),
									StatusInventory INT
								)
							Insert into @POSP00711 ( DivisionID, ShopID, WareHouseID, InventoryID, UnitID, BeginQuantity, ImQuantity, ExQuantity, StatusInventory)
							Select	P01.DivisionID, P01.ShopID, P01.WareHouseID, P01.InventoryID, P01.UnitID
									, Isnull(P01.BeginQuantity, 0) + Isnull(P01.ImQuantity, 0) - Isnull(P01.ExQuantity, 0) AS BeginQuantity, 0 as ImQuantity, 0 as ExQuantity
									, ISNULL(StatusInventory,0) AS StatusInventory
							FROM (
									SELECT	M.DivisionID, M.ShopID, D.WareHouseID, D.InventoryID, D.UnitID, D.Quantity as BeginQuantity, 0 as ImQuantity, 0 as ExQuantity,
											ISNULL(StatusInventory,0) AS StatusInventory
									FROM POST0038 M WITH (NOLOCK) inner join POST0039 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									'+@LEFTJOINAT1302+'
									Where M.DeleteFlg =0 ' + @sWHERE_POST0038_DD+ '
									Union all
									SELECT	M.DivisionID, M.ShopID, D.WareHouseID, D.InventoryID, D.UnitID, 0 as BeginQuantity, D.ActualQuantity as ImQuantity, 0 as ExQuantity,
											ISNULL(StatusInventory,0) AS StatusInventory
									FROM POST0015 M WITH (NOLOCK) inner join POST00151 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									'+@LEFTJOINAT1302+'
									Where M.DeleteFlg =0 ' + @sWHERE_POST0015_DD+'
									Union all
									SELECT	M.DivisionID, M.ShopID, M.WareHouseID, D.InventoryID, D.UnitID, 0 as BeginQuantity, 0 as ImQuantity, D.ShipQuantity as ExQuantity,
											ISNULL(StatusInventory,0) AS StatusInventory
									FROM POST0027 M WITH (NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									'+@LEFTJOINAT1302+'
									Where M.DeleteFlg =0 ' + @sWHERE_POST0027_DD+'
									) P01 '
		--Lấy phiếu nhập
		SET @sSQLImport = N' Union all 
							 SELECT	M.DivisionID, M.ShopID, D.WareHouseID, D.InventoryID, D.UnitID, 0 as BeginQuantity, D.ActualQuantity as ImQuantity, 0 as ExQuantity,
									ISNULL(StatusInventory,0) AS StatusInventory
							 FROM POST0015 M WITH (NOLOCK) inner join POST00151 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
							 '+@LEFTJOINAT1302+'
							 Where M.DeleteFlg =0 ' + @sWHERE_POST0015_PS+' '
		--Lấy phiếu xuất
		SET @sSQLExport = N' Union all 
							 SELECT	M.DivisionID, M.ShopID, M.WareHouseID, D.InventoryID, D.UnitID, 0 as BeginQuantity, 0 as ImQuantity, D.ShipQuantity as ExQuantity,
									ISNULL(StatusInventory,0) AS StatusInventory
							 FROM POST0027 M WITH (NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
							 '+@LEFTJOINAT1302+'
							 Where M.DeleteFlg =0 ' + @sWHERE_POST0027_PS+' '
		--Lấy kết quả
		SET @sSQLResult = N' Select R.DivisionID, R.WareHouseID, R.WareHouseID+''-''+P03.WareHouseName as WareHouseName, R.InventoryID,B.AnaName, A.InventoryName, P04.UnitName as UnitID, P04.UnitName
									, Sum(R.BeginQuantity) as BeginQuantity
									, Sum(R.ImQuantity) as ImQuantity
									, Sum(R.ExQuantity) as ExQuantity
									, Sum(R.BeginQuantity) + Sum(R.ImQuantity) - Sum(R.ExQuantity) as EndQuantity
									, R.StatusInventory
							 From	@POSP00711 R Left join AT1303 P03 WITH (NOLOCK) ON R.WareHouseID = P03.WareHouseID
												 left join AT1302 A on A.InventoryID=R.InventoryID
												 left join AT1015 B on B.AnaID=A.I01ID		
												 Left join AT1304 P04 WITH (NOLOCK) ON R.UnitID = P04.UnitID
							 Group by R.DivisionID, R.WareHouseID, P03.WareHouseName, R.InventoryID, A.InventoryName, B.AnaName, P04.UnitName, R.StatusInventory
							 Order by R.DivisionID,B.AnaName,A.InventoryName, R.WareHouseID'
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
