IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00152]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00152]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
--- Load Grid danh sách
-- <Param>
----
-- <Return>
----
-- <Reference>
----KindVoucherID = 3: là Phiếu chuyển kho nội bộ
----IsCheck = 1: Đã duyệt phiếu đề nghị chuyển kho nội bộ
----Status = 0: Trạng thái phiếu d94 hoàn tất
-- <History>
----Created by: Hoàng Vũ
----Edited by: Hoàng Vũ: Bổ sung chức năng dùng chung
----Edited by: Hoàng Vũ: Bổ sung tham số cửa hàng, lấy ra tất cả các kho của cửa hàng để kế thừa nhập kho
----Edited by: Hoàng Vũ: Bổ sung điều kiện where cho số lượng nhận và số lượng xuất
----Edited by: Trà Giang: Kiểm tra nếu có check vào điều chuyển hàng qua shop thì load ds phiếu được tạo từ N/vụ trả hàng
----Edited by: Nhật Thanh: Bổ sung Isnull trường hợp không có refno với phiếu phiếu đề nghị xuất/ trả hàng
----Edited by: Thanh Lượng on 27/09/2023: [2023/09/TA/0204] - Bổ sung điều kiện không load những mặt hàng đã check "hoàn thành"(status !=1)(Customize ThanhLiem).

-- <Example>
/*
   Exec POSP00152 NULL,null ,'2013-01-01', '2014-12-31', null
   Exec POSP00152 'KC','PX' ,'2013-01-01', '2014-12-31', ''
*/

 CREATE PROCEDURE POSP00152
(
		@DivisionID varchar(50),
		@VoucherTypeID varchar(50),
		@FromDate datetime,
		@ToDate Datetime,
		@WareHouseID varchar(50), --Lấy từ biến môi trường truyền vào (Kho cửa hàng - trong màn hình thiết lập chung)
		@ShopID varchar(50) = NULL,
		@IsExportCompanyToShop TINYINT
)
AS
Begin
		DECLARE @sSQL NVARCHAR (MAX),
				@sWhere NVARCHAR(MAX),
				@sWhere01 NVARCHAR(MAX),
				@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)
		
		SET @sWhere = ''
	
		
		--Check @DivisionID is Null
		IF Isnull(@DivisionID, '')!=''
			SET @sWhere = @sWhere + ' W.DivisionID ='''+@DivisionID+''''
		
		--Check @VoucherTypeID is Null
		IF Isnull(@VoucherTypeID, '')!=''
			SET @sWhere = @sWhere + ' AND W.VoucherTypeID ='''+@VoucherTypeID+''''
		
		IF @CustomerIndex = 163 --cUSTOMIZE THANHLIEM
		BEGIN
					SET @sWhere = @sWhere + ' and D.status !=1'
		END
		----Check @WarehouseID2 is Null
		--IF Isnull(@WarehouseID, '')!=''
		--	SET @sWhere = @sWhere + ' AND W.WarehouseID ='''+@WarehouseID+''''
		

		--Check @ShopID is Null => Lấy ra nhiều kho [Kho cửa hàng], [Kho trưng bày], [Kho Hỏng]
		IF Isnull(@ShopID, '')!=''
			SET @sWhere = @sWhere + ' AND W.WarehouseID in (Select DisplayWareHouseID from POST0010 With (NOLOCK) Where ShopID = '''+@ShopID+'''
															Union all
															Select BrokenWareHouseID from POST0010 With (NOLOCK) Where ShopID = '''+@ShopID+'''
															Union all
															Select WarehouseID from POST0010 With (NOLOCK) Where ShopID = '''+@ShopID+'''
															) '

	IF @IsExportCompanyToShop = 1
	BEGIN
		SET @sSQL = 'Select Distinct W.VoucherID as APK, W.DivisionID, W.VoucherTypeID, W.VoucherNo,W.RefNo01, W.VoucherDate, W.ObjectID, A.ObjectName, W.Description
							Into #WT0095
					 From WT0095 W With (NOLOCK) 
					 inner join WT0096 D With (NOLOCK) On W.DivisionID = D.DivisionID and W.VoucherID = D.VoucherID
					 Left join AT1202 A With (NOLOCK) on W.ObjectID = A.ObjectID
					 LEFT JOIN POST0022 P2 WITH (NOLOCK) ON W.DivisionID = P2.DivisionID and W.RefNo01 = P2.VoucherNo 
					 LEFT JOIN AT2006 WITH ( NOLOCK) ON W.DivisionID = AT2006.DivisionID AND W.VoucherNo = AT2006.RefNo01 
					 Where' + @sWhere
							+ ' and W.KindVoucherID = 3 and W.IsCheck = 1 
								and (isnull(D.ActualQuantity,0) - Isnull(D.QuantityCompanyToShop,0))>0											-- kế thừa chưa hết 
								and W.VoucherNo in ( SELECT RefNo01 FROM AT2006 WITH (NOLOCK) WHERE   KindVoucherID = 3 )			    		-- đã tạo VCNB 
								and P2.IsRefund = 2																						    	-- Chuyển hàng từ cty qua shop
							    and AT2006.WareHouseID = ( SELECT TransportWareHouseID FROM WT0000 WHERE DefDivisionID = '''+ @DivisionID+ ''') -- kiểm tra VCNB từ kho cty sang kho đi đường.
								And CONVERT(VARCHAR(10), W.VoucherDate,112) between ' 
							+  CONVERT(VARCHAR(10),@Fromdate,112) + ' and ' +  CONVERT(VARCHAR(10),@Todate,112) 
							+ ' order by W.VoucherDate, W.VoucherNo
							
					SELECT  ROW_NUMBER() OVER (ORDER BY W.VoucherDate, W.VoucherNo) AS RowNum
					,  W.APK, W.DivisionID, W.VoucherTypeID, W.VoucherNo,W.RefNo01, W.VoucherDate, W.ObjectID, W.ObjectName, W.Description
					FROM #WT0095 W'
	END
	ELSE
	BEGIN		
		SET @sSQL = 'Select Distinct W.VoucherID as APK, W.DivisionID, W.VoucherTypeID, W.VoucherNo,W.RefNo01, W.VoucherDate, W.ObjectID, A.ObjectName, W.Description
							Into #WT0095
					 From WT0095 W With (NOLOCK) 
					 inner join WT0096 D With (NOLOCK) On W.DivisionID = D.DivisionID and W.VoucherID = D.VoucherID
					 Left join AT1202 A With (NOLOCK) on W.ObjectID = A.ObjectID
					 LEFT JOIN POST0022 P2 WITH (NOLOCK) ON W.DivisionID = P2.DivisionID and W.RefNo01 = P2.VoucherNo 
					 Where' + @sWhere
							+ ' and W.KindVoucherID = 3 and W.IsCheck = 1 and (W.Status = 0 or W.Status = 1 or W.Status is null) 
							and (isnull(D.ActualQuantity,0) - Isnull(D.ReceiveQuantity,0))>0
								And CONVERT(VARCHAR(10), W.VoucherDate,112) between ' 
							+  CONVERT(VARCHAR(10),@Fromdate,112) + ' and ' +  CONVERT(VARCHAR(10),@Todate,112) 
							+ ' and ISNULL(P2.IsRefund,0) != 2 '
							+ ' order by W.VoucherDate, W.VoucherNo

					SELECT  ROW_NUMBER() OVER (ORDER BY W.VoucherDate, W.VoucherNo) AS RowNum
					,  W.APK, W.DivisionID, W.VoucherTypeID, W.VoucherNo,W.RefNo01, W.VoucherDate, W.ObjectID, W.ObjectName, W.Description
					FROM #WT0095 W'
	END			
	
		EXEC (@sSQL)
		print (@sSQL)
End






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
