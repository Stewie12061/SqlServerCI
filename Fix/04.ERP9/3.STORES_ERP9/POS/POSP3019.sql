IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3019]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP3019]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- ĐỐI CHIẾU DOANH SỐ BÁN VỚI THỰC TẾ THU TIỀN VÀ CÔNG NỢ – POSR3019
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 03/01/2018
----Edited by: Hoàng vũ on 02/05/2018: Số dư đầu chưa lấy kho
----Modify by: Hoàng vũ on 02/05/2018: Cải tiến câu SQL và sửa lấy số liệu sai
----Modify by: Hoàng vũ on 18/05/2018: Tách xử lý bảng giá trước thuế và bảng giá sal thuế (Hiện tại chỉ đúng với bảng giá sau thuế, còn bảng giá trước thuế vẫn còn bị lệch)
----Modify by: Hoàng vũ on 07/05/2019: Điều kiện thời gian đầu kỳ từ bảng POST0038 chưa lấy điều kiện bằng
-- <Example> EXEC POSP3019 'HCM', 'HCM', 'AEONTANPHU', 'CH-HCM001'',''AEONTANPHU', 0, '2018-01-01', '2018-12-31', 12,2017,01,2018,'','','', '', 'ASOFTADMIN'

CREATE PROCEDURE POSP3019 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@FromTranMonth		AS INT,
	@FromTranYear		AS INT,
	@ToTranMonth		AS INT,
	@ToTranYear			AS INT,
	@ToWareHouseID		VARCHAR(MAX),
	@FromWareHouseID	VARCHAR(MAX),
	@ToInventoryID		VARCHAR(MAX),
	@FromInventoryID	VARCHAR(MAX),
	@UserID				VARCHAR(50)
)
AS
BEGIN
		DECLARE @sSQL   NVARCHAR(MAX),  
				@sSQL1   NVARCHAR(MAX),
				@sSQL2   NVARCHAR(MAX),
				@sSQL3   NVARCHAR(MAX),
				@sSQL4   NVARCHAR(MAX),
				@sWhere NVARCHAR(MAX),
				@Date  NVARCHAR(MAX),
				@sWHERE01 AS NVARCHAR(MAX),
				@sWHERE02 AS NVARCHAR(MAX),
				@sWHERE03 AS NVARCHAR(MAX),
				@sWHERE04 AS NVARCHAR(MAX),
				@sWHERE05 AS NVARCHAR(MAX)
		
		SET @sWhere01 = ''
		SET @sWHERE02 = ''
		SET @sWhere03 = ''
		SET @sWHERE04 = ''
		SET @sWHERE05 = ''
		SET @Date = ''
		SET @sWhere = ''
		--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
		IF Isnull(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.DivisionID  IN ('''+@DivisionID+''')'	
	
		--Nếu Danh sách @ShopIDList trống thì lấy biến môi trường @ShopID
		IF Isnull(@ShopIDList, '')!= ''
			SET @sWhere = @sWhere + ' AND M.ShopID IN ('''+@ShopIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.ShopID  IN ('''+@ShopID+''')'

		IF @IsDate = 1
		BEGIN
			SET @sWhere02 = @sWhere02 + N' AND CONVERT(NVARCHAR(10),M.VoucherDate,21) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,21)+''' '
			SET @sWhere01 = @sWhere01 + N'AND CONVERT(NVARCHAR(10), M.VoucherDate,21) < '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' '
			SET @sWhere05 = @sWhere05 + N'AND CONVERT(NVARCHAR(10), M.VoucherDate,21) <= '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' '
		END

		IF @IsDate = 0
		BEGIN
			SET @sWhere02 = @sWhere01 + N' AND M.TranYear*100+M.TranMonth BETWEEN '+STR(@FromTranYear*100+@FromTranMonth)+' AND '+STR(@ToTranYear*100+@ToTranMonth)+' '
			SET @sWhere01 = @sWhere01 + N' AND M.TranYear*100+M.TranMonth < '+STR(@FromTranYear*100+@FromTranMonth)+' '
			SET @sWhere05 = @sWhere05 + N' AND M.TranYear*100+M.TranMonth <= '+STR(@FromTranYear*100+@FromTranMonth)+' '
		END
		--Search theo Kho hàng  (Dữ liệu theo kho nhiều nên dùng control từ theo kho , đến theo kho
		IF Isnull(@FromWareHouseID, '')!= '' and Isnull(@ToWareHouseID, '') = ''
			SET @sWhere03 = @sWhere03 + ' AND D.WareHouseID > = N'''+@FromWareHouseID +''''
		ELSE IF Isnull(@FromWareHouseID, '') = '' and Isnull(@ToWareHouseID, '') != ''
			SET @sWhere03 = @sWhere03 + ' AND D.WareHouseID < = N'''+@ToWareHouseID +''''
		ELSE IF Isnull(@FromWareHouseID, '') != '' and Isnull(@ToWareHouseID, '') != ''
			SET @sWhere03 = @sWhere03 + ' AND (D.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''')'

		IF Isnull(@FromWareHouseID, '')!= '' and Isnull(@ToWareHouseID, '') = ''
			SET @sWhere04 = @sWhere04 + ' AND M.WareHouseID > = N'''+@FromWareHouseID +''''
		ELSE IF Isnull(@FromWareHouseID, '') = '' and Isnull(@ToWareHouseID, '') != ''
			SET @sWhere04 = @sWhere04 + ' AND M.WareHouseID < = N'''+@ToWareHouseID +''''
		ELSE IF Isnull(@FromWareHouseID, '') != '' and Isnull(@ToWareHouseID, '') != ''
			SET @sWhere04 = @sWhere04 + ' AND (M.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''')'


		--Search theo Mặt hàng  (Dữ liệu Mặt hàng nhiều nên dùng control từ Mặt hàng , đến Mặt hàng
		IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
			SET @sWhere = @sWhere + ' AND D.InventoryID > = N'''+@FromInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID < = N'''+@ToInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND (D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''')'
 	    

		SET @sSQL = N'
			Select	P01.DivisionID, P01.ShopID, P01.WareHouseID, P01.WareHouseName, P01.InventoryID, P01.InventoryName, P01.UnitID
					, Isnull(P01.BeginQuantity, 0.0) + Isnull(P01.ImQuantity, 0.0) - Isnull(P01.ExQuantity, 0.0) AS BeginQuantity, 0.0 as ImQuantity, 0.0 as ExQuantity
			Into #POST191
			FROM (
					SELECT	M.VoucherDate,M.DivisionID, M.ShopID, D.WareHouseID, D.WareHouseName, D.InventoryID, D.InventoryName, D.UnitID, D.Quantity as BeginQuantity, 0 as ImQuantity, 0 as ExQuantity
					FROM POST0038 M WITH (NOLOCK) inner join POST0039 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
					Where M.DeleteFlg =0 ' + @sWhere+ @sWhere05+@sWhere03+'
					Union all
					SELECT	M.VoucherDate,M.DivisionID, M.ShopID, D.WareHouseID, D.WareHouseName,D.InventoryID, D.InventoryName, D.UnitID, 0 as BeginQuantity, D.ActualQuantity as ImQuantity, 0 as ExQuantity
					FROM POST0015 M WITH (NOLOCK) inner join POST00151 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
					Where M.DeleteFlg =0 ' + @sWhere+ @sWhere01+@sWhere03+'
					Union all
					SELECT	M.VoucherDate,M.DivisionID, M.ShopID, M.WareHouseID, M.WareHouseName, D.InventoryID, D.InventoryName, D.UnitID, 0 as BeginQuantity, 0 as ImQuantity, D.ShipQuantity as ExQuantity
					FROM POST0027 M WITH (NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
					Where M.DeleteFlg =0 ' + @sWhere+ @sWhere01+@sWhere04+'
					) P01'
		SET @sSQL1 =N'
			Union all
			SELECT  M.DivisionID, M.ShopID, D.WareHouseID, D.WareHouseName, D.InventoryID, D.InventoryName, D.UnitID, 0.0 as BeginQuantity, D.ActualQuantity as ImQuantity, 0.0 as ExQuantity
			FROM POST0015 M WITH (NOLOCK) inner join POST00151 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
			Where M.DeleteFlg =0 ' + @sWhere+ @sWhere02+@sWhere03+'			
			Union all					
			SELECT	M.DivisionID, M.ShopID, M.WareHouseID, M.WareHouseName, D.InventoryID, D.InventoryName, D.UnitID, 0.0 as BeginQuantity, 0.0 as ImQuantity, D.ShipQuantity as ExQuantity
			FROM POST0027 M WITH (NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
			Where M.DeleteFlg =0 '+ @sWhere + @sWhere02+@sWhere04+''
		SET @sSQL2 =N'	
			Select F.DivisionID, B.DivisionName
					, F01.ShopID, C.ShopName
					, F01.WareHouseID, F01.WareHouseName
					, F.InventoryID, Isnull(F01.InventoryName, F.InventoryName) as InventoryName, A04.UnitName as UnitID
					, E.Notes01
					, Sum(Isnull(F01.BeginQuantity, 0)) as BeginQuantity
					, Sum(Isnull(F01.ImQuantity, 0)) as ImQuantity
					, Sum(Isnull(F01.ExQuantity , 0)) as ExQuantity
					, Sum(Isnull(F01.BeginQuantity, 0))+  Sum(Isnull(F01.ImQuantity, 0))- Sum(Isnull(F01.ExQuantity, 0)) as EndQuantity
			from POST0030 F Left join #POST191 F01 on F.DivisionID = F01.DivisionID and F.ShopID = F01.ShopID and F.InventoryID = F01.InventoryID
				  			LEFT join AT1302 E WITH (NOLOCK) On E.InventoryID = F.InventoryID
							LEFT JOIN AT1101 B WITH (NOLOCK) ON B.DivisionID = F.DivisionID
							LEFT JOIN POST0010 C WITH (NOLOCK) ON F01.DivisionID = F.DivisionID and F01.ShopID = C.ShopID
							LEFT JOIN AT1304 A04 WITH (NOLOCK) ON F01.UnitID = A04.UnitID
			WHERE (F01.BeginQuantity <> 0 OR F01.ImQuantity <> 0 OR F01.ExQuantity <> 0) 
			Group by  F.DivisionID, B.DivisionName
					, F01.ShopID, C.ShopName
					, F01.WareHouseID, F01.WareHouseName
					, F.InventoryID, Isnull(F01.InventoryName, F.InventoryName), A04.UnitName, E.Notes01
			Order by  F.DivisionID, F01.ShopID, F01.WareHouseID
						 '
		EXEC (@sSQL+ @sSQL1 +@sSQL2)
		Print (@sSQL)
		Print (@sSQL1)
		Print (@sSQL2)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
