IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3208_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3208_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---Created by: Bao Anh, date: 24/12/2009
---purpose: Load detail cho form ke thua nhieu don hang mua o phieu nhap kho
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [29/07/2010]
'* Edited by : [GS] [Tan Phu] [28/06/2012] Bo sung them truong ObjectID
---Modified on 26/10/2015 by Tiểu Mai: bổ sung thêm 20 trường quy cách hàng hóa, không sinh view
---Modified by Bảo Thy on 18/05/2017: Sửa danh mục dùng chung
---Modified by Hải Long on 05/07/2017: Sửa lỗi khi biến @ConditionIV = ''
---- Modified on 08/05/2019 by Tra Giang: Bổ sung chỉ hiển thị các dòng mặt hàng có quản lý tồn kho (dịch vụ) 
---- Modified on 13/06/2019 by Tra Giang: Thêm trường tên quy cách 
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---  Modified on 23/07/2021 by Huỳnh Thử	: Bổ sung cột Đơn vị tính quy đổi
---- Modified on 26/07/2021 by Kiều Nga: Fix lỗi lập phiếu nhập kho kế thừa từ đơn hàng mua lỗi không hiển thị số đơn hàng mua
'**************************************************************/
CREATE PROCEDURE [dbo].[AP3208_QC] 
    @DivisionID NVARCHAR(50),
    @lstPOrderID NVARCHAR(4000),
    -- Thêm mới   : ''
    -- Hiệu chỉnh : Số chứng từ đang sửa
    @VoucherID NVARCHAR(50), 
    @ConnID NVARCHAR(100),
    @ConditionIV NVARCHAR(500),
    @IsUsedConditionIV NVARCHAR(500)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX)

SET @DivisionID = ISNULL(@DivisionID, '')
SET @lstPOrderID = ISNULL(@lstPOrderID, '')
SET @VoucherID = ISNULL(@VoucherID, '')
SET @ConnID = ISNULL(@ConnID, '')

SET @lstPOrderID = REPLACE(@lstPOrderID, ',', ''',''')
IF(@ConditionIV = ' ') set @ConditionIV = ''''''

Set @sSQL ='
SELECT 
	'''' as VoucherNo,
    AT2007.OrderID,
    AT2007.OTransactionID AS TransactionID,
    AT2007.InventoryID,
    AT1302.InventoryName, 
    AT2007.UnitID, 
    AT2007.ConvertedUnitID, 
    0 AS IsEditInventoryName,
    AT2007.Parameter01, 
    AT2007.Parameter02, 
    AT2007.Parameter03, 
    AT2007.Parameter04, 
    AT2007.Parameter05, 
    AT2007.ConvertedQuantity, 
    AT2007.ActualQuantity, 
    AT2007.ConvertedPrice, 
    AT2007.UnitPrice, 
    AT2007.OriginalAmount, 
    AT2007.ConvertedAmount, 
    AT1302.IsSource, 
    AT1302.IsLocation, 
    AT1302.IsLimitDate, 
    AT1302.AccountID AS DebitAccountID, 
    AT1302.MethodID, 
    AT1302.IsStocked,
    AT2007.Ana01ID, 
    AT2007.Ana02ID, 
    AT2007.Ana03ID, 
    AT2007.Ana04ID, 
    AT2007.Ana05ID, 
    AT2007.Ana06ID, 
    AT2007.Ana07ID, 
    AT2007.Ana08ID, 
    AT2007.Ana09ID, 
    AT2007.Ana10ID, 
    AT2007.Orders,
    1 AS IsCheck, 
    AT2007.Notes, 
    AT1302.IsDiscount, 
    AT2007.DivisionID,
    AT2006.ObjectID,
    AT2007.Notes AS Description,
	AT2007.SourceNo,
    '''' as S01ID, '''' as S02ID, '''' as S03ID, '''' as S04ID, '''' as S05ID, '''' as S06ID, '''' as S07ID, '''' as S08ID, '''' as S09ID, '''' as S10ID, 
    '''' as S11ID, '''' as S12ID, '''' as S13ID, '''' as S14ID, '''' as S15ID, '''' as S16ID, '''' as S17ID, '''' as S18ID, '''' as S19ID, '''' as S20ID,
	'''' S01Name, '''' S02Name, '''' S03Name, ''''  S04Name, '''' S05Name,
	'''' S06Name, '''' S07Name, '''' S08Name, ''''  S09Name, '''' S10Name,
	'''' S11Name, '''' S12Name, '''' S13Name, ''''  S14Name, '''' S15Name,
	'''' S16Name, '''' S17Name, '''' S18Name, ''''  S19Name, '''' S20Name'
SET @sSQL1 = '
FROM AT2007 WITH (NOLOCK)
    INNER JOIN AT1302 AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID = AT1302.InventoryID 
    INNER JOIN AT2006 WITH (NOLOCK) on AT2007.VoucherID =  AT2006.VoucherID and AT2007.DivisionID =AT2006.DivisionID
    --LEFT JOIN  WT8899 W89 on W89.DivisionID = AT2007.DivisionID AND W89.TableID = ''AT2007'' and W89.VoucherID = AT2007.VoucherID and W89.TransactionID = AT2007.TransactionID
WHERE AT2007.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(''' + @DivisionID + ''')) AND AT1302.IsStocked = 1
	AND (ISNULL(AT2007.InventoryID, ''#'') IN ('+@ConditionIV+') OR '+@IsUsedConditionIV+') 
    AND AT2007.VoucherID = ''' + @VoucherID + ''' '

SET @sSQL2 = '
UNION

SELECT 
	OT3001.VoucherNo,
    OT3002.POrderID AS OrderID,
    OT3002.TransactionID,
    OT3002.InventoryID, 
    ISNULL(OT3002.InventoryCommonName, AT1302.InventoryName) AS InventoryName, 
    AT1302.UnitID, 
    OT3002.UnitID AS ConvertedUnitID, 
    CASE WHEN ISNULL(OT3002.InventoryCommonName, '''') = '''' THEN 0 ELSE 1 END AS IsEditInventoryName, 
    OT3002.Parameter01, 
    OT3002.Parameter02, 
    OT3002.Parameter03, 
    OT3002.Parameter04, 
    OT3002.Parameter05, 
    AQ2904.EndConvertedQuantity AS ConvertedQuantity, 
    AQ2904.EndQuantity AS ActualQuantity, 
    OT3002.ConvertedSalePrice AS ConvertedPrice,
    OT3002.PurchasePrice AS UnitPrice,
    CASE WHEN AQ2904.EndQuantity = AQ2904.OrderQuantity THEN ISNULL(OT3002.OriginalAmount,0) - ISNULL(OT3002.DiscountOriginalAmount, 0) ELSE ISNULL(AQ2904.EndQuantity, 0) * ISNULL(OT3002.PurchasePrice, 0) * (100 - ISNULL(OT3002.DiscountPercent, 0)) / 100 END AS OriginalAmount, 
    CASE WHEN AQ2904.EndQuantity= AQ2904.OrderQuantity THEN ISNULL(OT3002.ConvertedAmount,0) - ISNULL(OT3002.DiscountConvertedAmount, 0) ELSE ISNULL(AQ2904.EndQuantity, 0) * ISNULL(OT3002.PurchasePrice, 0) * (100- ISNULL(OT3002.DiscountPercent, 0)) * ISNULL(ExchangeRate, 0) / 100 END AS ConvertedAmount,
    AT1302.IsSource, 
    AT1302.IsLocation, 
    AT1302.IsLimitDate, 
    AT1302.AccountID AS DebitAccountID, 
    AT1302.MethodID, 
    AT1302.IsStocked,
    OT3002.Ana01ID, 
    OT3002.Ana02ID, 
    OT3002.Ana03ID, 
    OT3002.Ana04ID, 
    OT3002.Ana05ID, 
    OT3002.Ana06ID, 
    OT3002.Ana07ID, 
    OT3002.Ana08ID, 
    OT3002.Ana09ID, 
    OT3002.Ana10ID, 
    OT3002.Orders,
    0 AS IsCheck, 
    OT3001.Notes, 
    AT1302.IsDiscount, 
    OT3002.DivisionID,
    OT3001.ObjectID,
    OT3002.Description,
	OT3002.SourceNo,
    O89.S01ID, O89.S02ID, O89.S03ID, O89.S04ID, O89.S05ID, O89.S06ID, O89.S07ID, O89.S08ID, O89.S09ID, O89.S10ID, 
    O89.S11ID, O89.S12ID, O89.S13ID, O89.S14ID, O89.S15ID, O89.S16ID, O89.S17ID, O89.S18ID, O89.S19ID, O89.S20ID,
	AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
	AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
	AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
	AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name  '
SET @sSQL3 = '
	FROM OT3002 WITH (NOLOCK)
    INNER JOIN OT3001 WITH (NOLOCK) ON OT3001.DivisionID = OT3002.DivisionID AND OT3002.POrderID = OT3001.POrderID
    INNER JOIN AQ2904 WITH (NOLOCK) ON AQ2904.DivisionID = OT3002.DivisionID AND AQ2904.POrderID = OT3002.POrderID and AQ2904.TransactionID = OT3002.TransactionID 
    INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (OT3002.DivisionID,''@@@'') AND OT3002.InventoryID = AT1302.InventoryID 
    LEFT JOIN OT8899 O89 WITH (NOLOCK) ON O89.DivisionID = OT3002.DivisionID AND O89.TransactionID = OT3002.TransactionID AND O89.VoucherID = OT3002.POrderID AND O89.TableID = ''OT3002''
		LEFT JOIN AT0128 AT01 WITH (NOLOCK) ON AT01.StandardID = O89.S01ID AND AT01.StandardTypeID = ''S01''
		LEFT JOIN AT0128 AT02 WITH (NOLOCK) ON AT02.StandardID = O89.S02ID AND AT02.StandardTypeID = ''S02''
		LEFT JOIN AT0128 AT03 WITH (NOLOCK) ON AT03.StandardID = O89.S03ID AND AT03.StandardTypeID = ''S03''
		LEFT JOIN AT0128 AT04 WITH (NOLOCK) ON AT04.StandardID = O89.S04ID AND AT04.StandardTypeID = ''S04''
		LEFT JOIN AT0128 AT05 WITH (NOLOCK) ON AT05.StandardID = O89.S05ID AND AT05.StandardTypeID = ''S05''
		LEFT JOIN AT0128 AT06 WITH (NOLOCK) ON AT06.StandardID = O89.S06ID AND AT06.StandardTypeID = ''S06''
		LEFT JOIN AT0128 AT07 WITH (NOLOCK) ON AT07.StandardID = O89.S07ID AND AT07.StandardTypeID = ''S07''
		LEFT JOIN AT0128 AT08 WITH (NOLOCK) ON AT08.StandardID = O89.S08ID AND AT08.StandardTypeID = ''S08''
		LEFT JOIN AT0128 AT09 WITH (NOLOCK) ON AT09.StandardID = O89.S09ID AND AT09.StandardTypeID = ''S09''
		LEFT JOIN AT0128 AT10 WITH (NOLOCK) ON AT10.StandardID = O89.S10ID AND AT10.StandardTypeID = ''S10''
		LEFT JOIN AT0128 AT11 WITH (NOLOCK) ON AT11.StandardID = O89.S11ID AND AT11.StandardTypeID = ''S11''
		LEFT JOIN AT0128 AT12 WITH (NOLOCK) ON AT12.StandardID = O89.S12ID AND AT12.StandardTypeID = ''S12''
		LEFT JOIN AT0128 AT13 WITH (NOLOCK) ON AT13.StandardID = O89.S13ID AND AT13.StandardTypeID = ''S13''
		LEFT JOIN AT0128 AT14 WITH (NOLOCK) ON AT14.StandardID = O89.S15ID AND AT14.StandardTypeID = ''S14''
		LEFT JOIN AT0128 AT15 WITH (NOLOCK) ON AT15.StandardID = O89.S15ID AND AT15.StandardTypeID = ''S15''
		LEFT JOIN AT0128 AT16 WITH (NOLOCK) ON AT16.StandardID = O89.S16ID AND AT16.StandardTypeID = ''S16''
		LEFT JOIN AT0128 AT17 WITH (NOLOCK) ON AT17.StandardID = O89.S17ID AND AT17.StandardTypeID = ''S17''
		LEFT JOIN AT0128 AT18 WITH (NOLOCK) ON AT18.StandardID = O89.S18ID AND AT18.StandardTypeID = ''S18''
		LEFT JOIN AT0128 AT19 WITH (NOLOCK) ON AT19.StandardID = O89.S19ID AND AT19.StandardTypeID = ''S19''
		LEFT JOIN AT0128 AT20 WITH (NOLOCK) ON AT20.StandardID = O89.S20ID AND AT20.StandardTypeID = ''S20''
WHERE OT3002.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(''' + @DivisionID + '''))
    AND OT3002.POrderID in (''' + @lstPOrderID + ''')
    AND (ISNULL(OT3002.InventoryID, ''#'') IN ('+@ConditionIV+') OR '+@IsUsedConditionIV+')  AND AT1302.IsStocked = 1
' 
--PRINT @sSQL 
--PRINT  @sSQL1
--PRINT  @sSQL2
--PRINT  @sSQL3
EXEC (@sSQL + @sSQL1+ @sSQL2 + @sSQL3)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
