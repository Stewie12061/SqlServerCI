IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP0064]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP0064]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Bao cao sổ chi tiết vật tư
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 22/07/2014 by Le Thi Thu Hien 
---- 
---- Modified on 03/09/2014 by Le Thi Thu Hien : Bổ sung ShopID và InventoryID vào mã để hiển thị lên (Mantis 0022696)
---- Modified on 26/10/2016 by phan thanh hoàng vũ: Sửa lại cách lấy dữ liệu mới hoàn toàn: do lấy sai số dư dầu và cuối so với báo cáo bảng cân đối tồn kho
---- Modified on 28/08/2017 by phan thanh hoàng vũ: Sửa điều kiện kết
---- Modified on 28/04/2018 by phan thanh hoàng vũ: Bổ sung điều kiện Search: Kho và mặt hàng
---- Modified on 15/06/2018 by phan thanh hoàng vũ: Lấy tên hàng thẳng trong bàng POST0030 không lấy trong bảng nhập xuất
---- Modified on 22/08/2018 by Tra Giang: Fix lỗi hiển thị sai tên mặt hàng
-- <Example>
/*
 exec POSP0064 @DivisionID=N'HCM',@UserID=N'ASOFTADMIN',@IsPeriod=0,@FromDate='2016-01-01 00:00:00',@ToDate='2018-10-31 00:00:00',
@FromTranMonth=10,@FromTranYear=2016,@ToTranMonth=10,@ToTranYear=2016,@ListShopID=N'50C2101', @FromWareHouseID = '50EAMBTD'
, @ToWareHouseID = ''

*/
CREATE PROCEDURE POSP0064
( 
		@DivisionID AS NVARCHAR(Max),
		@UserID AS NVARCHAR(Max),
		@IsPeriod AS TINYINT,
		@FromDate AS DATETIME,
		@ToDate AS DATETIME,
		@FromTranMonth AS INT,
		@FromTranYear AS INT,
		@ToTranMonth AS INT,
		@ToTranYear AS INT,
		@ListShopID AS NVARCHAR(Max),
		@FromWareHouseID AS NVARCHAR(50) = NULL,
		@ToWareHouseID AS NVARCHAR(50) = NULL,
		@FromInventoryID AS NVARCHAR(50)= NULL,
		@ToInventoryID AS NVARCHAR(50) = NULL,
		@ListInventoryID AS NVARCHAR(Max) =NULL
) 
AS 
DECLARE @sSQL01 AS NVARCHAR(MAX),
		@sSQL02 AS NVARCHAR(MAX),
		@sSQL03 AS NVARCHAR(MAX),
		@sWHERE_COMMON AS NVARCHAR(MAX),
		@sWHERE_POST0038_DD AS NVARCHAR(MAX),
		@sWHERE_POST0015_DD AS NVARCHAR(MAX),
		@sWHERE_POST0027_DD AS NVARCHAR(MAX),
		@sWHERE_POST0015_PS AS NVARCHAR(MAX),
		@sWHERE_POST0027_PS AS NVARCHAR(MAX)


		SET @sWHERE_COMMON = ''
		SET @sWHERE_POST0038_DD = ''
		SET @sWHERE_POST0015_DD = ''
		SET @sWHERE_POST0027_DD = ''
		SET @sWHERE_POST0015_PS = ''
		SET @sWHERE_POST0027_PS = ''

		IF Isnull(@DivisionID, '') != ''
		BEGIN
			SET @sWHERE_COMMON = @sWHERE_COMMON + N' AND M.DivisionID IN ('''+@DivisionID+''') '
		END

		IF Isnull(@ListShopID, '%') != '%' 
		BEGIN
			SET @sWHERE_COMMON = @sWHERE_COMMON + N' AND M.ShopID IN ('''+@ListShopID+''') '
		END

		--Search theo mặt hàng  (Dữ liệu mặt hàng nhiều nên dùng control từ mặt hàng , đến mặt hàng
		IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
			SET @sWHERE_COMMON = @sWHERE_COMMON + ' AND D.InventoryID > = N'''+@FromInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
			SET @sWHERE_COMMON = @sWHERE_COMMON + ' AND D.InventoryID < = N'''+@ToInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
			SET @sWHERE_COMMON = @sWHERE_COMMON + ' AND D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''
		ELSE 
			SET @sWHERE_COMMON = @sWHERE_COMMON

		IF Isnull(@ListInventoryID, '') != '' 
		BEGIN
			SET @sWHERE_COMMON = @sWHERE_COMMON + N' AND D.InventoryID IN ('''+@ListInventoryID+''') '
		END
			
		--Search theo kho  (Dữ liệu kho nhiều nên dùng control từ kho , đến kho
		IF Isnull(@FromWareHouseID, '')!= '' and Isnull(@ToWareHouseID, '') = ''
		BEGIN
			SET @sWHERE_POST0038_DD = @sWHERE_COMMON + ' AND D.WareHouseID > = N'''+@FromWareHouseID +''''
			SET @sWHERE_POST0015_DD = @sWHERE_COMMON + ' AND D.WareHouseID > = N'''+@FromWareHouseID +''''
			SET @sWHERE_POST0027_DD = @sWHERE_COMMON + ' AND M.WareHouseID > = N'''+@FromWareHouseID +''''
			SET @sWHERE_POST0015_PS = @sWHERE_COMMON + ' AND D.WareHouseID > = N'''+@FromWareHouseID +''''
			SET @sWHERE_POST0027_PS = @sWHERE_COMMON + ' AND M.WareHouseID > = N'''+@FromWareHouseID +''''
		END
		ELSE IF Isnull(@FromWareHouseID, '') = '' and Isnull(@ToWareHouseID, '') != ''
		BEGIN
			SET @sWHERE_POST0038_DD = @sWHERE_COMMON + ' AND D.WareHouseID < = N'''+@ToWareHouseID +''''
			SET @sWHERE_POST0015_DD = @sWHERE_COMMON + ' AND D.WareHouseID < = N'''+@ToWareHouseID +''''
			SET @sWHERE_POST0027_DD = @sWHERE_COMMON + ' AND M.WareHouseID < = N'''+@ToWareHouseID +''''
			SET @sWHERE_POST0015_PS = @sWHERE_COMMON + ' AND D.WareHouseID < = N'''+@ToWareHouseID +''''
			SET @sWHERE_POST0027_PS = @sWHERE_COMMON + ' AND M.WareHouseID < = N'''+@ToWareHouseID +''''
		END
		ELSE IF Isnull(@FromWareHouseID, '') != '' and Isnull(@ToWareHouseID, '') != ''
		BEGIN
			SET @sWHERE_POST0038_DD = @sWHERE_COMMON + ' AND D.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
			SET @sWHERE_POST0015_DD = @sWHERE_COMMON + ' AND D.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
			SET @sWHERE_POST0027_DD = @sWHERE_COMMON + ' AND M.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
			SET @sWHERE_POST0015_PS = @sWHERE_COMMON + ' AND D.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
			SET @sWHERE_POST0027_PS = @sWHERE_COMMON + ' AND M.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
		END
		ELSE 
		BEGIN
			SET @sWHERE_POST0038_DD = @sWHERE_COMMON
			SET @sWHERE_POST0015_DD = @sWHERE_COMMON
			SET @sWHERE_POST0027_DD = @sWHERE_COMMON
			SET @sWHERE_POST0015_PS = @sWHERE_COMMON
			SET @sWHERE_POST0027_PS = @sWHERE_COMMON
		END

		
		IF @IsPeriod = 0
		BEGIN
			
			SET @sWHERE_POST0038_DD = @sWHERE_POST0038_DD + N'AND CONVERT(NVARCHAR(10), M.VoucherDate,21) <= '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' '
			SET @sWHERE_POST0015_DD = @sWHERE_POST0015_DD + N'AND CONVERT(NVARCHAR(10), M.VoucherDate,21) < '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' '
			SET @sWHERE_POST0027_DD = @sWHERE_POST0027_DD + N'AND CONVERT(NVARCHAR(10), M.VoucherDate,21) < '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' '
			SET @sWHERE_POST0015_PS = @sWHERE_POST0015_PS + N' AND CONVERT(NVARCHAR(10),M.VoucherDate,21) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,21)+''' '
			SET @sWHERE_POST0027_PS = @sWHERE_POST0027_PS + N' AND CONVERT(NVARCHAR(10),M.VoucherDate,21) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,21)+''' '
		END

		IF @IsPeriod = 1
		BEGIN

			SET @sWHERE_POST0038_DD = @sWHERE_POST0038_DD + N' AND M.TranYear*100+M.TranMonth <= '+STR(@FromTranYear*100+@FromTranMonth)+' '
			SET @sWHERE_POST0015_DD = @sWHERE_POST0015_DD + N' AND M.TranYear*100+M.TranMonth < '+STR(@FromTranYear*100+@FromTranMonth)+' '
			SET @sWHERE_POST0027_DD = @sWHERE_POST0027_DD + N' AND M.TranYear*100+M.TranMonth < '+STR(@FromTranYear*100+@FromTranMonth)+' '
			SET @sWHERE_POST0015_PS = @sWHERE_POST0015_PS + N' AND M.TranYear*100+M.TranMonth BETWEEN '+STR(@FromTranYear*100+@FromTranMonth)+' AND '+STR(@ToTranYear*100+@ToTranMonth)+' '
			SET @sWHERE_POST0027_PS = @sWHERE_POST0027_PS + N' AND M.TranYear*100+M.TranMonth BETWEEN '+STR(@FromTranYear*100+@FromTranMonth)+' AND '+STR(@ToTranYear*100+@ToTranMonth)+' '

		END

---->>> Đầu kỳ
		SET @sSQL01 = N'		DECLARE @POSP00641 table 
								(	DivisionID NVARCHAR(50),
									ShopID NVARCHAR(50),
									ShopName NVARCHAR(250),
									WareHouseID NVARCHAR(50),
									WareHouseName NVARCHAR(250),
									InventoryID NVARCHAR(50),
									InventoryName NVARCHAR(250),
									UnitID NVARCHAR(50),
									BeginQuantity Decimal(28,8),
									ImQuantity Decimal(28,8),
									ExQuantity Decimal(28,8)
								)
								Insert into @POSP00641 ( DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, BeginQuantity, ImQuantity, ExQuantity)

								Select	P01.DivisionID, P01.WareHouseID, P01.WareHouseName, P01.InventoryID, P01.InventoryName, P01.UnitID
										, Sum(P01.BeginQuantity) + Sum(P01.ImQuantity) - Sum(P01.ExQuantity) AS BeginQuantity, 0 as ImQuantity, 0 as ExQuantity
								FROM (
										SELECT	M.DivisionID, M.ShopID, P10.ShopName, D.WareHouseID, D.WareHouseName, D.InventoryID, F.InventoryName, D.UnitID
												, D.Quantity as BeginQuantity, 0 as ImQuantity, 0 as ExQuantity
										FROM POST0038 M WITH (NOLOCK) inner join POST0039 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
										left join POST0030 F on M.DivisionID = F.DivisionID and D.ShopID= F.ShopID and F.InventoryID = D.InventoryID
										Inner join POST0010 P10 on P10.ShopID = M.ShopID and P10.DivisionID = D.DivisionID
										Where M.DeleteFlg =0 ' + @sWHERE_POST0038_DD+ '
										Union all
										SELECT	M.DivisionID, M.ShopID, P10.ShopName, D.WareHouseID, D.WareHouseName, D.InventoryID, F.InventoryName, D.UnitID
												, 0 as BeginQuantity, D.ActualQuantity as ImQuantity, 0 as ExQuantity
										FROM POST0015 M WITH (NOLOCK) inner join POST00151 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
										left join POST0030 F on M.DivisionID = F.DivisionID and D.ShopID= F.ShopID and F.InventoryID = D.InventoryID
										Inner join POST0010 P10 on P10.ShopID = M.ShopID and P10.DivisionID = D.DivisionID
										Where M.DeleteFlg =0 ' + @sWHERE_POST0015_DD+'
										Union all
										SELECT	M.DivisionID, M.ShopID, P10.ShopName, M.WareHouseID, M.WareHouseName, D.InventoryID, F.InventoryName, D.UnitID
												, 0 as BeginQuantity, 0 as ImQuantity, D.ShipQuantity as ExQuantity
										FROM POST0027 M WITH (NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
										left join POST0030 F on M.DivisionID = F.DivisionID and D.ShopID= F.ShopID and F.InventoryID = D.InventoryID
										Inner join POST0010 P10 on P10.ShopID = M.ShopID and P10.DivisionID = M.DivisionID
										Where M.DeleteFlg =0 ' + @sWHERE_POST0027_DD+'
										) P01
								GROUP BY P01.DivisionID, P01.WareHouseID, P01.WareHouseName, P01.InventoryID, P01.InventoryName, P01.UnitID '
---->>>>>> Phiếu nhập-phiếu xuất
		SET @sSQL02 = N'DECLARE @POSP00642 table 
								(	TransactionTypeID int, 
									DivisionID NVARCHAR(50),
									ShopID NVARCHAR(50),
									ShopName NVARCHAR(250),
									WareHouseID NVARCHAR(50),
									WareHouseName NVARCHAR(250),
									InventoryID NVARCHAR(50),
									InventoryName NVARCHAR(250),
									UnitID NVARCHAR(50),
									ImQuantity Decimal(28,8),
									ExQuantity Decimal(28,8),
									APK NVARCHAR(50),
									VoucherDate Datetime,
									ImVoucherNo NVARCHAR(50),
									ExVoucherNo NVARCHAR(50),
									ERPVoucherNo NVARCHAR(50),
									Description  NVARCHAR(250)
								)
							Insert into @POSP00642 ( TransactionTypeID, DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, ImQuantity
													, ExQuantity, APK,  VoucherDate, ImVoucherNo, ExVoucherNo, ERPVoucherNo, Description)
 
							SELECT	1 AS TransactionTypeID, M.DivisionID, D.WareHouseID, D.WareHouseName, D.InventoryID, A.InventoryName
									, D.UnitID, D.ActualQuantity as ImQuantity, 0 as ExQuantity
									, M.APK,  M.VoucherDate, M.VoucherNo AS ImVoucherNo, '''' AS ExVoucherNo
									, D.EVoucherNo AS ERPVoucherNo
									, M.Description	
							FROM POST0015 M WITH (NOLOCK) inner join POST00151 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
							left join POST0030 F on M.DivisionID = F.DivisionID and D.ShopID= F.ShopID and F.InventoryID = D.InventoryID
							Left join POST0010 P10 on M.DivisionID = P10.DivisionID and D.ShopID= P10.ShopID
							left join AT1302 A on A.InventoryID=F.InventoryID
							Where M.DeleteFlg =0 ' + @sWHERE_POST0015_PS+'
							 Union all 
							SELECT	2 as TransactionTypeID, M.DivisionID, M.WarehouseID, M.WareHouseName, D.InventoryID, A.InventoryName
									, D.UnitID, 0 as ImQuantity, D.ShipQuantity as ExQuantity
									, M.APK,  M.VoucherDate, '''' AS ImVoucherNo, M.VoucherNo AS ExVoucherNo
									, '''' AS ERPVoucherNo, M.Description
							FROM POST0027 M WITH (NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
							left join POST0030 F on M.DivisionID = F.DivisionID and D.ShopID= F.ShopID and F.InventoryID = D.InventoryID
							Left join POST0010 P10 on M.DivisionID = P10.DivisionID and D.ShopID= P10.ShopID
							left join AT1302 A on A.InventoryID=F.InventoryID
							Where M.DeleteFlg =0 ' + @sWHERE_POST0027_PS+'
							'
---->>>>>> Lấy kết quả

		SET @sSQL03 = N' 
						Select M.APK, M.VoucherDate, M.ImVoucherNo, M.ExVoucherNo, M.ERPVoucherNo, M.Description, M.TransactionTypeID
							, M.WarehouseID, M.WarehouseName, M.InventoryID, M.InventoryName, M.UnitID, M.BeginQuantity, M.ImQuantity, M.ExQuantity
						From
							(
									--Lấy số dư có nhập hoặc xuất						
									Select 
										M.APK,  M.VoucherDate, M.ImVoucherNo, M.ExVoucherNo, M.ERPVoucherNo, M.Description, M.TransactionTypeID
										, Isnull(M.ShopID, D.ShopID) as ShopID, isnull(M.ShopName, D.ShopName) as ShopName
										, isnull(M.WarehouseID, D.WarehouseID) as WarehouseID, isnull(M.WareHouseName, D.WareHouseName) as WarehouseName
										, M.InventoryID, M.InventoryName, M.UnitID
										, Isnull(D.BeginQuantity, 0) as BeginQuantity
										, Isnull(M.ImQuantity, 0) as ImQuantity
										, Isnull(M.ExQuantity , 0) as ExQuantity 
									from  @POSP00642 M Left join @POSP00641 D on M.DivisionID = D.DivisionID and M.WarehouseID = D.WarehouseID and M.InventoryID = D.InventoryID
									union all
									--Lấy số dư không có nhập xuất						
									Select 
										NULL as APK, NULL as VoucherDate, NULL as ImVoucherNo, NULL as ExVoucherNo, NULL as ERPVoucherNo, NULL as Description, 0 as TransactionTypeID
										, M.ShopID, M.ShopName
										, M.WarehouseID, M. WareHouseName
										, M.InventoryID, M.InventoryName, M.UnitID
										, Isnull(M.BeginQuantity, 0) as BeginQuantity
										, 0 as ImQuantity
										, 0 as ExQuantity 
									from @POSP00641 M Left join @POSP00642 D on M.DivisionID = D.DivisionID and M.WarehouseID = D.WarehouseID and M.InventoryID = D.InventoryID
									Where D.APK is null
							) M
						Where M.BeginQuantity <> 0 Or M.ImQuantity <> 0 Or M.ExQuantity <> 0
						Order by M.WarehouseID, M.InventoryID, M.VoucherDate
						'

EXEC(@sSQL01+@sSQL02+@sSQL03)
--Print (@sSQL01)
--Print (@sSQL02)
--Print (@sSQL03)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
