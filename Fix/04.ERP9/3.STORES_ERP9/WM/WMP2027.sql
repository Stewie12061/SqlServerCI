IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2027]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2027]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid detail màn hình kế thừa phiếu yêu cầu nhập, xuất, VCNB 
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
----Modified by: Nhật Thanh, Date: 25/04/2023 - Bổ sung load số lô
----Modified by: Anh Đô, Date: 10/08/2023 - Select thêm cột Ana06Name
----Modify by: Thanh Lượng on 15/09/2023 - Cập nhật : [2023/09/TA/0070] - Xử lý bổ sung trường Specification (Customize PANGLOBE).
----Modify by: Trọng Phúc on 22/11/2023 -  Cập nhật : [2023/11/TA/0199] - Xử lý bổ sung trường quy cách (Customize NKC).
----Modify by: Trọng Phúc on 28/11/2023 -  Cập nhật : [2023/11/TA/0237] - Xử lý bổ sung trường mã xe, mã tài xế (Customize NKC).
----Modified by: Bi Phan on   14/12/2023 -  Cập nhật : [2023/12/TA/0131] - Xuất kho: Bổ sung cột check hàng khuyến mãi.

-- <Example>
---- 
/*-- <Example>
	WMP2027 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @LstAPKMaster = 'D3D8249A-8AB7-4B73-8563-2BFB6CCE8305'
	
	WMP2027 @DivisionID, @UserID, @PageNumber, @PageSize, @LstAPKMaster
----*/

CREATE PROCEDURE WMP2027
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LstAPKMaster VARCHAR(MAX)  ---- Danh sách APK check chọn ở lưới master
)
AS 
DECLARE @sSQL NVARCHAR(MAX), 
	@TotalRow NVARCHAR(50) = N'',
	@CustomerIndex VARCHAR(50),
	@Temp VARCHAR(50) = N''
SELECT @CustomerIndex = CustomerName FROM CustomerIndex
IF @CustomerIndex = 166
BEGIN
	SET @Temp = ', T1.DriverID, T1.CarID'
END
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT T1.APK, T2.APK AS APKMaster, T1.DivisionID, T2.VoucherNo, T1.InventoryID, AT1302.InventoryName, AT1302.Specification,
	T1.UnitID, AT1304.UnitName, T1.UnitPrice, T1.Ana01ID, T1.Ana02ID, T1.Ana03ID, T1.IsProInventoryID,
	T1.Ana04ID, T1.Ana05ID, T1.Ana06ID, T1.Ana07ID, T1.Ana08ID, T1.Ana09ID, T1.Ana10ID, SUM(T1.ActualQuantity) AS Quantity, SourceNo
	, A06.AnaName AS Ana06Name
	, AT01.StandardID AS S01ID, AT02.StandardID AS S02ID, AT03.StandardID AS S03ID, AT04.StandardID AS S04ID, AT05.StandardID AS S05ID
	, AT06.StandardID AS S06ID, AT07.StandardID AS S07ID, AT08.StandardID AS S08ID, AT09.StandardID AS S09ID, AT10.StandardID AS S10ID
	, AT11.StandardID AS S11ID, AT12.StandardID AS S12ID, AT13.StandardID AS S13ID, AT14.StandardID AS S14ID, AT15.StandardID AS S15ID
	, AT16.StandardID AS S16ID, AT17.StandardID AS S17ID, AT18.StandardID AS S18ID, AT19.StandardID AS S19ID, AT20.StandardID AS S20ID
	'+@Temp+'
	FROM WT0096 T1 WITH (NOLOCK)
	LEFT JOIN WT0095 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.InventoryID = AT1302.InventoryID 
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (T1.DivisionID, ''@@@'') AND AT1302.UnitID = AT1304.UnitID 
	--LEFT JOIN CSMT1080 WITH (NOLOCK) ON CSMT1080.DivisionID IN (CSMT1080.DivisionID, ''@@@'') AND CSMT1080.ModelID=AT1302.I03ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaID = T1.Ana06ID AND A06.AnaTypeID = ''A06'' AND A06.DivisionID IN (T1.DivisionID, ''@@@'')
	LEFT JOIN AT1323 AT01 WITH (NOLOCK) ON AT01.InventoryID = AT1302.InventoryID AND AT01.StandardTypeID = N''S01''
	LEFT JOIN AT1323 AT02 WITH (NOLOCK) ON AT02.InventoryID = AT1302.InventoryID AND AT02.StandardTypeID = N''S02''
	LEFT JOIN AT1323 AT03 WITH (NOLOCK) ON AT03.InventoryID = AT1302.InventoryID AND AT03.StandardTypeID = N''S03''
	LEFT JOIN AT1323 AT04 WITH (NOLOCK) ON AT04.InventoryID = AT1302.InventoryID AND AT04.StandardTypeID = N''S04''
	LEFT JOIN AT1323 AT05 WITH (NOLOCK) ON AT05.InventoryID = AT1302.InventoryID AND AT05.StandardTypeID = N''S05''
	LEFT JOIN AT1323 AT06 WITH (NOLOCK) ON AT06.InventoryID = AT1302.InventoryID AND AT06.StandardTypeID = N''S06''
	LEFT JOIN AT1323 AT07 WITH (NOLOCK) ON AT07.InventoryID = AT1302.InventoryID AND AT07.StandardTypeID = N''S07''
	LEFT JOIN AT1323 AT08 WITH (NOLOCK) ON AT08.InventoryID = AT1302.InventoryID AND AT08.StandardTypeID = N''S08''
	LEFT JOIN AT1323 AT09 WITH (NOLOCK) ON AT09.InventoryID = AT1302.InventoryID AND AT09.StandardTypeID = N''S09''
	LEFT JOIN AT1323 AT10 WITH (NOLOCK) ON AT10.InventoryID = AT1302.InventoryID AND AT10.StandardTypeID = N''S10''
	LEFT JOIN AT1323 AT11 WITH (NOLOCK) ON AT11.InventoryID = AT1302.InventoryID AND AT11.StandardTypeID = N''S11''
	LEFT JOIN AT1323 AT12 WITH (NOLOCK) ON AT12.InventoryID = AT1302.InventoryID AND AT12.StandardTypeID = N''S12''
	LEFT JOIN AT1323 AT13 WITH (NOLOCK) ON AT13.InventoryID = AT1302.InventoryID AND AT13.StandardTypeID = N''S13''
	LEFT JOIN AT1323 AT14 WITH (NOLOCK) ON AT14.InventoryID = AT1302.InventoryID AND AT14.StandardTypeID = N''S14''
	LEFT JOIN AT1323 AT15 WITH (NOLOCK) ON AT15.InventoryID = AT1302.InventoryID AND AT15.StandardTypeID = N''S15''
	LEFT JOIN AT1323 AT16 WITH (NOLOCK) ON AT16.InventoryID = AT1302.InventoryID AND AT16.StandardTypeID = N''S16''
	LEFT JOIN AT1323 AT17 WITH (NOLOCK) ON AT17.InventoryID = AT1302.InventoryID AND AT17.StandardTypeID = N''S17''
	LEFT JOIN AT1323 AT18 WITH (NOLOCK) ON AT18.InventoryID = AT1302.InventoryID AND AT18.StandardTypeID = N''S18''
	LEFT JOIN AT1323 AT19 WITH (NOLOCK) ON AT19.InventoryID = AT1302.InventoryID AND AT19.StandardTypeID = N''S19''
	LEFT JOIN AT1323 AT20 WITH (NOLOCK) ON AT20.InventoryID = AT1302.InventoryID AND AT20.StandardTypeID = N''S20''

	WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.VoucherID IN ('''+@LstAPKMaster+''')
		AND NOT EXISTS (SELECT TOP 1 1 FROM WMT2007 WITH (NOLOCK) WHERE T1.DivisionID = WMT2007.DivisionID AND WMT2007.InheritAPKMaster = T2.APK 
						AND T1.APK = WMT2007.InheritAPK AND WMT2007.InheritTableID = ''WMT2080'')

	GROUP BY T1.APK, T2.APK, T1.DivisionID, T2.VoucherNo, T1.InventoryID, AT1302.InventoryName, T1.UnitID, AT1304.UnitName, T1.UnitPrice, 
	T1.Ana01ID, T1.Ana02ID, T1.Ana03ID, T1.Ana04ID, T1.Ana05ID, T1.Ana06ID, T1.Ana07ID, T1.Ana08ID, T1.Ana09ID, T1.Ana10ID,SourceNo, T1.IsProInventoryID
	, A06.AnaName,AT1302.Specification, AT01.StandardID, AT02.StandardID, AT03.StandardID, AT04.StandardID, AT05.StandardID
		, AT06.StandardID, AT07.StandardID, AT08.StandardID, AT09.StandardID, AT10.StandardID
		, AT11.StandardID, AT12.StandardID, AT13.StandardID, AT14.StandardID, AT15.StandardID
		, AT16.StandardID, AT17.StandardID, AT18.StandardID, AT19.StandardID, AT20.StandardID
		'+@Temp+'

)Temp 
ORDER BY VoucherNo
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY	
'

PRINT (@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
