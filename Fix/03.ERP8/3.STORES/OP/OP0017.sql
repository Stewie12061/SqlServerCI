IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created by Hoàng Vũ	Date: 05/08/2015
--- Store OP0017 thay thế Store OP0011 (lấy view tự sinh ra OV0012) (Customize Secoin index = 43 )
--- Purpose: Load detail kế thừa đơn hàng sản xuất từ đơn hàng bán
--- Modify on 26/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
--- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
--- EXEC OP0017 'AS', 'DHB_BD_01_2014_0001', 'DHSX_BD_01_2014_0044', 'NV003'

CREATE PROCEDURE [dbo].[OP0017] 
(
	@DivisionID nvarchar(50),
	@SOrderID nvarchar(50), --ID truyền trên master xuống Detail của màn hình kế thừa đơn hàng 
	@PVoucherID nvarchar(50), -- Chính là ID của phiếu đang mở lên sửa, trường hợp thêm thì truyền ''
	@UserID nvarchar(50)
)
AS

Declare @sSQL01 AS varchar(max),
		@sSQL02 AS varchar(max),
		@sSQL03 AS varchar(max),
		@CustomerName INT,		
		@sWHERE AS VARCHAR(MAX),
		@SOrderIDRecognition VARCHAR(max)
			
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex)

		----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
		DECLARE @sSQLPer AS NVARCHAR(MAX),
				@sWHEREPer AS NVARCHAR(MAX)
		SET @sSQLPer = ''
		SET @sWHEREPer = ''		

		IF EXISTS (SELECT TOP 1 1 FROM OT0001 WHERE DivisionID = @DivisionID AND IsPermissionView = 1) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
			BEGIN
				SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = OT2001.DivisionID 
													AND AT0010.AdminUserID = '''+@UserID+''' 
													AND AT0010.UserID = OT2001.CreateUserID '
				SET @sWHEREPer = ' AND (OT2001.CreateUserID = AT0010.UserID
										OR  OT2001.CreateUserID = '''+@UserID+''') '		
			END

		-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác		

SET @sSQL01 =' SELECT DISTINCT	
						OT2001.DivisionID, 
						OT2001.ObjectID,
						AT1202.ObjectName, 
						OT2001.VoucherNo, 
						OT2001.OrderDate, 
						OT2001.Notes MNotes, 
						OT2001.Varchar01 AS MTVarchar01,
						OT2001.Varchar02 AS MTVarchar02,
						OT2001.Varchar03 AS MTVarchar03,
						OT2001.Varchar04 AS MTVarchar04,
						OT2001.Varchar05 AS MTVarchar05,
						OT2001.Varchar06 AS MTVarchar06,
						OT2001.Varchar07 AS MTVarchar07,
						OT2001.Varchar08 AS MTVarchar08,
						OT2001.Varchar09 AS MTVarchar09,
						OT2001.Varchar10 AS MTVarchar10,
						OT2001.Varchar11 AS MTVarchar11,
						OT2001.Varchar12 AS MTVarchar12,
						OT2001.Varchar13 AS MTVarchar13,
						OT2001.Varchar14 AS MTVarchar14,
						OT2001.Varchar15 AS MTVarchar15,
						OT2001.Varchar16 AS MTVarchar16,
						OT2001.Varchar17 AS MTVarchar17,
						OT2001.Varchar18 AS MTVarchar18,
						OT2001.Varchar19 AS MTVarchar19,
						OT2001.Varchar20 AS MTVarchar20,
						CAST(0 AS bit) AS IsSelected,
						OT2002.TransactionID,
						AT1302.Barcode,
						OT2002.InventoryID, 
						AT1302.InventoryName, 
						OT2002.UnitID, -- Sử dụng cho cả trường hợp đơn vị tính chuyển đổi
						ISNULL(OT2002.LinkNo, '''') AS LinkNo, 
						OT2002.Description,
						OT2002.Orders, 
						OT2002.RefInfor, 
						OT2002.SOrderID, 
						OT2002.ConvertedSalePrice, 
						OT2002.SalePrice, 
						OT2002.OriginalAmount, 
						OT2002.ConvertedAmount, 
						OT2002.DiscountPercent, 
						OT2002.DiscountConvertedAmount, 
						OT2002.VATPercent, 
						OT2002.VATConvertedAmount, 
						OT2002.Ana01ID, 
						OT2002.Ana02ID, 
						OT2002.Ana03ID, 
						OT2002.Ana04ID, 
						OT2002.Ana05ID,
						OT2002.Ana06ID, 
						OT2002.Ana07ID, 
						OT2002.Ana08ID, 
						OT2002.Ana09ID, 
						OT2002.Ana10ID,
						OT2002.NVarchar01,
						OT2002.NVarchar02,
						OT2002.NVarchar03,
						OT2002.NVarchar04,
						OT2002.NVarchar05,
						OT2002.NVarchar06,
						OT2002.NVarchar07,
						OT2002.NVarchar08,
						OT2002.NVarchar09,
						OT2002.NVarchar10,
						OT2002.Varchar01,
						OT2002.Varchar02,
						OT2002.Varchar03,
						OT2002.Varchar04,
						OT2002.Varchar05,
						OT2002.Varchar06,
						OT2002.Varchar07,
						OT2002.Varchar08,
						OT2002.Varchar09,
						OT2002.Varchar10,
						OT2002.Notes, 
						OT2002.Notes01, 
						OT2002.Notes02,
						OT2002.EndDate,
						OT2002.DeliveryDate, 
						OT2002.ShipDate ,
						ISNULL(OT2001.OrderStatus,0) AS OrderStatus,
						OT2002.OrderQuantity AS Productquantity,
						OT2002.OrderQuantity, 
						OT2002.ConvertedQuantity, 
						Isnull(OT2002.OrderQuantity,0) - Isnull(DHSX01.OrderQuantity,0) + isnull(DHSX02.OrderQuantity,0) AS RemainOrderQuantity,
						Isnull(OT2002.ConvertedQuantity,0) - Isnull(DHSX01.ConvertedQuantity,0) + isnull(DHSX02.ConvertedQuantity,0) AS RemainConvertedQuantity,
						OT2002.ExtraID,AT1311.ExtraName
		FROM OT2002 INNER JOIN OT2001 ON OT2001.SOrderID = OT2002.SOrderID AND OT2002.DivisionID = OT2001.DivisionID and OT2001.OrderType = 0 '	
SET @sSQL02= '	
		LEFT JOIN AT1302 ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
		LEFT JOIN (Select D.DivisionID, D.InheritVoucherID, D.InheritTransactionID, 
											   Sum(D.OrderQuantity) as OrderQuantity, Sum(D.ConvertedQuantity) as ConvertedQuantity
										from OT2002 D Inner join OT2001 M on M.DivisionID = D.DivisionID and M.SOrderID = D.SOrderID and M.OrderType = 1 
										Group by D.DivisionID, D.InheritVoucherID, D.InheritTransactionID
										) as DHSX01 on OT2002.DivisionID = DHSX01.DivisionID 
										and OT2002.SOrderID = DHSX01.InheritVoucherID and OT2002.TransactionID = DHSX01.InheritTransactionID
		LEFT JOIN (Select M.SOrderID, M.DivisionID, D.InheritVoucherID, D.InheritTransactionID, 
											   Sum(D.OrderQuantity) as OrderQuantity, Sum(D.ConvertedQuantity) as ConvertedQuantity
										from OT2002 D Inner join OT2001 M on M.DivisionID = D.DivisionID and M.SOrderID = D.SOrderID and M.OrderType = 1 
										Where M.SOrderID = '''+Isnull(@PVoucherID,'''') +'''
										Group by M.SOrderID, M.DivisionID, D.InheritVoucherID, D.InheritTransactionID
										) as DHSX02 on OT2002.DivisionID = DHSX02.DivisionID 
										and OT2002.SOrderID = DHSX02.InheritVoucherID and OT2002.TransactionID = DHSX02.InheritTransactionID
		LEFT JOIN AT1311 on OT2002.DivisionID = AT1311.DivisionID and OT2002.ExtraID = AT1311.ExtraID
		LEFT JOIN AT1202 ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
		LEFT JOIN AT1301 ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
		LEFT JOIN AT1304 ON AT1304.UnitID = AT1302.UnitID
		LEFT JOIN AT1304  T04 ON T04.UnitID = OT2002.UnitID ' + @sSQLPer+ '
		WHERE Isnull(OT2002.OrderQuantity,0) - Isnull(DHSX01.OrderQuantity,0) + isnull(DHSX02.OrderQuantity,0) >0 
		AND	ISNULL(OT2001.OrderStatus,0) NOT IN (0,3,4,5,9)
		AND OT2001.SOrderID IN ('''+@SOrderID+''')
		'+ @sWHEREPer+
		' Order by OT2002.Orders'	
IF @CustomerName = 43 --- Customize Secoin
Begin	
	
	EXEC(@sSQL01 + @sSQL02)
	--print @sSQL01
	--print @sSQL02
	
End

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
