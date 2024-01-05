IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP20271]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP20271]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load dữ liệu đã chọn kế thừa ra màn hình cập nhật nhập, xuất, vcnb
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Khả Vi, Date: 08/03/2018
----Modified by: Kim Thư, Date: 05/07/2018 - Fix load detail chưa kế thừa hết
----Modified by: Kim Thư, Date: 06/08/2017 - Fix load dữ liệu kế thừa từ table của ERP9
----Modified by: Bảo Anh, Date: 11/10/2018 - Fix lỗi không lên APKDetail, ActualQuantity khi mặt hàng không QL serial/vị trí
 ---Modified by: Thanh Lượng on 16/10/2023 - Cập nhật bổ sung trường Specification
----Modified by: Trọng Phúc on 22/11/2023 -  Cập nhật : [2023/11/TA/0199] - Xử lý bổ sung trường quy cách (Customize NKC).
----Modified by: Trọng Phúc on 28/11/2023 -  Cập nhật : [2023/11/TA/0237] - Xử lý bổ sung trường mã xe, mã tài xế (Customize NKC).
----Modified by: Trọng Phúc on 08/12/2023 -  Cập nhật : [2023/11/TA/0237] - Hiển thị tên xe, tên tài xế (Customize NKC).
----Modified by: Bi Phan on   14/12/2023 -  Cập nhật : [2023/12/TA/0131] - Xuất kho: Bổ sung cột check hàng khuyến mãi.
-- <Example>
---- 
/*-- <Example>
	WMP20271 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @LstAPKMaster = 'D3D8249A-8AB7-4B73-8563-2BFB6CCE8305', @FormID'=WMF2025', @Mode=1
	
	WMP20271 @DivisionID, @UserID, @PageNumber, @PageSize, @LstAPKMaster, @FormID, @Mode
----*/

CREATE PROCEDURE WMP20271
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LstAPKDetail VARCHAR(MAX),  ---- Danh sách APK check chọn ở lưới master
	 @FormID VARCHAR (50),
	 @Mode TINYINT -- 1: Load dữ liệu ra lưới detail 1 / detail 2
)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@CustomerIndex INT,
		@FirmAnalyst VARCHAR(50), 
		@ModelAnalyst VARCHAR(50),
		@ProductTypeAnalyst VARCHAR(50)

SELECT @CustomerIndex = CustomerName FROM CustomerIndex

IF @CustomerIndex = 88 ---- VIETFIRST
BEGIN
	SELECT @FirmAnalyst = FirmAnalyst, @ModelAnalyst = ModelAnalyst, @ProductTypeAnalyst =  ProductTypeAnalyst
	FROM CSMT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID
END

IF @Mode=1
BEGIN
	SET @sSQL = '
		SELECT T2.InventoryID, T4.InventoryName, T4.UnitID, T5.UnitName, T4.'+@ModelAnalyst+'ID AS ModelID, T7.ModelName, T4.'+@ProductTypeAnalyst+'ID AS InventoryTypeID, T6.AnaName AS InventoryTypeName,
		T4.'+@FirmAnalyst+'ID AS FirmID, T8.AnaName AS FirmName, T4.IsSerialized,
		T2.ActualQuantity AS [ActualQuantity], T1.APK AS InheritAPKMaster, T2.APK as InheritAPK, ''WMT2080'' AS InheritTableID
		
		FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.APK=T2.APKMaster AND T1.DivisionID = T2.DivisionID
						LEFT JOIN WMT2082 T3 ON T1.APK=T3.APKMaster AND T2.APK=T3.APKDetail AND T1.DivisionID = T3.DivisionID
						LEFT JOIN AT1302 T4 ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.InventoryID=T2.InventoryID
						LEFT JOIN AT1304 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID, ''@@@'') AND T4.UnitID = T5.UnitID 
						LEFT JOIN AT1015 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID, ''@@@'') AND T6.AnaTypeID = '''+@ProductTypeAnalyst+'''  
							AND T4.'+@ProductTypeAnalyst+'ID = T6.AnaID
						LEFT JOIN CSMT1080 T7 WITH (NOLOCK) ON T7.DivisionID IN (T1.DivisionID, ''@@@'') AND T4.'+@ModelAnalyst+'ID = T7.ModelID
						LEFT JOIN AT1015 T8 WITH (NOLOCK) ON T8.DivisionID IN (T1.DivisionID, ''@@@'') AND T8.AnaTypeID = '''+@FirmAnalyst+''' 
							AND T4.'+@FirmAnalyst+'ID = T8.AnaID
		WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.APK IN ('''+@LstAPKDetail+''')
		GROUP BY T2.InventoryID,T4.InventoryName, T4.UnitID, T5.UnitName, T4.'+@ModelAnalyst+'ID, T7.ModelName, T4.'+@ProductTypeAnalyst+'ID, T6.AnaName,
					T4.IsSerialized, T4.'+@FirmAnalyst+'ID, T8.AnaName, T2.APK, T1.APK, T2.ActualQuantity
	'
END
ELSE
BEGIN
	IF @FormID='WMF2028'
	BEGIN
		SET @sSQL = '
			SELECT	T2.APK AS APKDetail, T2.InventoryID AS DetailInventoryID, T4.InventoryName AS DetailInventoryName,
					ISNULL(T3.ActualQuantity, T2.ActualQuantity) AS [DetailQuantity],
					T3.SerialNo, T3.LocationID, T3.IsExport
			FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.APK=T2.APKMaster AND T1.DivisionID = T2.DivisionID
							LEFT JOIN WMT2082 T3 ON T1.APK=T3.APKMaster AND T2.APK=T3.APKDetail AND T1.DivisionID = T3.DivisionID
							LEFT JOIN AT1302 T4 ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.InventoryID=T2.InventoryID
			WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.APK IN ('''+@LstAPKDetail+''')

		'
	END
	ELSE IF (@FormID='WMF2025' OR @FormID='WMF2029') AND @Mode= 3
	BEGIN
		DECLARE @temp VARCHAR(150) = ''
		DECLARE @tempJoin VARCHAR(250) = ''
		IF @CustomerIndex = 166
		BEGIN
			SET @temp = ', T1.DriverID, T1.CarID, A03.FullName as DriverName, C30.AssetName as CarName'
			SET @tempJoin = 'LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A03.EmployeeID = T1.DriverID
								LEFT JOIN CIT1300 C30 WITH (NOLOCK) ON C30.AssetID = T1.CarID'
		END
		ELSE
		BEGIN
			SET @temp = ''
			SET @tempJoin = ''
		END
			SET @sSQL = '
			SELECT  
				T1.APK, T1.DivisionID, T1.TransactionID, T1.VoucherID, T1.BatchID, T1.InventoryID, T1.UnitID, T1.ActualQuantity,
				 T1.UnitPrice, T1.OriginalAmount, T1.ConvertedAmount, T1.OriginalAmount AS ActualAmount, T1.Notes, T1.TranMonth, T1.TranYear, T1.CurrencyID, T1.ExchangeRate,
				  T1.SaleUnitPrice, T1.SaleAmount, T1.DiscountAmount, T1.SourceNo, T1.DebitAccountID, T4.AccountName AS DebitAccountName, T1.CreditAccountID, T5.AccountName AS CreditAccountName, T1.LocationID, 
				  T1.ImLocationID, T1.LimitDate, T1.Orders, T1.ConversionFactor, T1.ReTransactionID, T1.ReVoucherID, T1.Ana01ID, T1.Ana02ID,
				   T1.Ana03ID, T1.PeriodID, T1.ProductID, T1.OrderID, T1.InventoryName1, T1.Ana04ID, T1.Ana05ID, T1.OTransactionID, T1.ReSPVoucherID, T1.IsProInventoryID,
				   T1.ReSPTransactionID, T1.ETransactionID, T1.MTransactionID, T1.Parameter01, T1.Parameter02, T1.Parameter03, T1.Parameter04, 
				   T1.Parameter05, T1.ConvertedQuantity, T1.ConvertedPrice, T1.ConvertedUnitID, T1.MOrderID, T1.SOrderID, T1.STransactionID,
					T1.Ana06ID, T1.Ana07ID, T1.Ana08ID, T1.Ana09ID, T1.Ana10ID, T1.LocationCode, T1.Location01ID, T1.Location02ID, T1.Location03ID, 
					T1.Location04ID, T1.Location05ID, T1.MarkQuantity, T1.OExpenseConvertedAmount, T1.WVoucherID, T1.Notes01, T1.Notes02, T1.Notes03, 
					T1.Notes04, T1.Notes05, T1.Notes06, T1.Notes07, T1.Notes08, T1.Notes09, T1.Notes10, T1.Notes11, T1.Notes12, T1.Notes13, T1.Notes14, 
					T1.Notes15, T1.StandardPrice, T1.StandardAmount, T1.InheritTableID, T1.InheritVoucherID, T1.InheritTransactionID,
					T2.InventoryName, AT1304.UnitName, T2.Specification, AT01.StandardID AS S01ID, AT02.StandardID AS S02ID, AT03.StandardID AS S03ID, 
					AT04.StandardID AS S04ID, AT05.StandardID AS S05ID, AT06.StandardID AS S06ID, AT07.StandardID AS S07ID, AT08.StandardID AS S08ID, 
					AT09.StandardID AS S09ID, AT10.StandardID AS S10ID, AT11.StandardID AS S11ID, AT12.StandardID AS S12ID, AT13.StandardID AS S13ID, 
					AT14.StandardID AS S14ID, AT15.StandardID AS S15ID, AT16.StandardID AS S16ID, AT17.StandardID AS S17ID, AT18.StandardID AS S18ID, 
					AT19.StandardID AS S19ID, AT20.StandardID AS S20ID '+@temp+'
				FROM WT0096 T1 WITH (NOLOCK)				
					LEFT JOIN AT1302 T2 WITH (NOLOCK) ON T1.InventoryID = T2.InventoryID AND T2.DivisionID IN (T1.DivisionID,''@@@'')
					LEFT JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID  = T1.UnitID and AT1304.DivisionID IN (T1.DivisionID,''@@@'')
					LEFT JOIN AT1005 T4 WITH (NOLOCK) ON T4.AccountID = T1.DebitAccountID AND T4.DivisionID IN (T1.DivisionID, ''@@@'')
					LEFT JOIN AT1005 T5 WITH (NOLOCK) ON T5.AccountID = T1.CreditAccountID AND T5.DivisionID IN (T1.DivisionID, ''@@@'')
					LEFT JOIN AT1323 AT01 WITH (NOLOCK) ON AT01.InventoryID = T2.InventoryID AND AT01.StandardTypeID = N''S01''
					LEFT JOIN AT1323 AT02 WITH (NOLOCK) ON AT02.InventoryID = T2.InventoryID AND AT02.StandardTypeID = N''S02''
					LEFT JOIN AT1323 AT03 WITH (NOLOCK) ON AT03.InventoryID = T2.InventoryID AND AT03.StandardTypeID = N''S03''
					LEFT JOIN AT1323 AT04 WITH (NOLOCK) ON AT04.InventoryID = T2.InventoryID AND AT04.StandardTypeID = N''S04''
					LEFT JOIN AT1323 AT05 WITH (NOLOCK) ON AT05.InventoryID = T2.InventoryID AND AT05.StandardTypeID = N''S05''
					LEFT JOIN AT1323 AT06 WITH (NOLOCK) ON AT06.InventoryID = T2.InventoryID AND AT06.StandardTypeID = N''S06''
					LEFT JOIN AT1323 AT07 WITH (NOLOCK) ON AT07.InventoryID = T2.InventoryID AND AT07.StandardTypeID = N''S07''
					LEFT JOIN AT1323 AT08 WITH (NOLOCK) ON AT08.InventoryID = T2.InventoryID AND AT08.StandardTypeID = N''S08''
					LEFT JOIN AT1323 AT09 WITH (NOLOCK) ON AT09.InventoryID = T2.InventoryID AND AT09.StandardTypeID = N''S09''
					LEFT JOIN AT1323 AT10 WITH (NOLOCK) ON AT10.InventoryID = T2.InventoryID AND AT10.StandardTypeID = N''S10''
					LEFT JOIN AT1323 AT11 WITH (NOLOCK) ON AT11.InventoryID = T2.InventoryID AND AT11.StandardTypeID = N''S11''
					LEFT JOIN AT1323 AT12 WITH (NOLOCK) ON AT12.InventoryID = T2.InventoryID AND AT12.StandardTypeID = N''S12''
					LEFT JOIN AT1323 AT13 WITH (NOLOCK) ON AT13.InventoryID = T2.InventoryID AND AT13.StandardTypeID = N''S13''
					LEFT JOIN AT1323 AT14 WITH (NOLOCK) ON AT14.InventoryID = T2.InventoryID AND AT14.StandardTypeID = N''S14''
					LEFT JOIN AT1323 AT15 WITH (NOLOCK) ON AT15.InventoryID = T2.InventoryID AND AT15.StandardTypeID = N''S15''
					LEFT JOIN AT1323 AT16 WITH (NOLOCK) ON AT16.InventoryID = T2.InventoryID AND AT16.StandardTypeID = N''S16''
					LEFT JOIN AT1323 AT17 WITH (NOLOCK) ON AT17.InventoryID = T2.InventoryID AND AT17.StandardTypeID = N''S17''
					LEFT JOIN AT1323 AT18 WITH (NOLOCK) ON AT18.InventoryID = T2.InventoryID AND AT18.StandardTypeID = N''S18''
					LEFT JOIN AT1323 AT19 WITH (NOLOCK) ON AT19.InventoryID = T2.InventoryID AND AT19.StandardTypeID = N''S19''
					LEFT JOIN AT1323 AT20 WITH (NOLOCK) ON AT20.InventoryID = T2.InventoryID AND AT20.StandardTypeID = N''S20''
					'+@tempJoin+'
				WHERE T1.APK IN ('''+@LstAPKDetail+''')
				ORDER BY T1.Orders DESC'
	END
	ELSE
	BEGIN
		SET @sSQL = '
			SELECT	T2.APK AS APKDetail, T2.InventoryID AS DetailInventoryID, T4.InventoryName AS DetailInventoryName
					--ISNULL(T3.ActualQuantity, T2.ActualQuantity)
					--T3.SerialNo, T3.LocationID
			FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.APK=T2.APKMaster AND T1.DivisionID = T2.DivisionID
							--LEFT JOIN WMT2082 T3 ON T1.APK=T3.APKMaster AND T2.APK=T3.APKDetail AND T1.DivisionID = T3.DivisionID
							LEFT JOIN AT1302 T4 ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.InventoryID=T2.InventoryID
			WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.APK IN ('''+@LstAPKDetail+''')
		'
	END
END


EXEC (@sSQL)
PRINT (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
