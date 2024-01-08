IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP203602]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP203602]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid: màn hình kế thừa dự trù NVL sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 17/07/2020
----Modify by  Nhật Quang on 08/03/2023 Cập nhật: Bổ sung thêm mã, tên đối tượng.
----Modify by  Nhật Quang on 13/03/2023 Cập nhật: Bổ sung thêm APK Bomversion.
----Modify by  Đức tuyên  on 15/03/2023 Cập nhật.
----Updated by Nhật Thanh on 28/03/2023: Bổ sung điều kiện chỉ load những phiếu đã duyệt + Loại trừ những phiếu đã kế thừa
----Updated by Nhật Thanh on 07/04/2023: Không tính những phiếu kế thừa nhưng đã xóa
----Modify by: Thanh Lượng on 15/09/2023 - Cập nhật : [2023/09/TA/0070] - Xử lý bổ sung trường Specification (Customize PANGLOBE).
-- <Example>
---- 
/*-- <Example>
	POP203602 @DivisionID = 'AIC', @UserID = '', @PageNumber = 1, @PageSize = 25, @ROrderID = 'sfasdf'
----*/

CREATE PROCEDURE POP203602
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	 
	 @EstimateID NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'T1.Orders'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = @sSQL+'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
 T1.APK,T1.DivisionID,T1.ProductID, T2.InventoryName as ProductName,T2.IsSource AS UnitID,T3.UnitName,T1.ProductQuantity,T1.PDescription
,T1.Ana01ID,T1.Ana02ID,T1.Ana03ID,T1.Ana04ID,T1.Ana05ID,T1.Ana06ID,T1.Ana07ID,T1.Ana08ID,T1.Ana09ID,T1.Ana10ID
,T01.AnaName As Ana01Name,T02.AnaName As Ana02Name,T03.AnaName As Ana03Name,T04.AnaName As Ana04Name,T05.AnaName As Ana05Name,
T06.AnaName As Ana06Name,T07.AnaName As Ana07Name,T08.AnaName As Ana08Name,T09.AnaName As Ana09Name,T10.AnaName As Ana10Name
,T1.EstimateID AS VoucherNo, OT01.ObjectID, AT02.ObjectName, T1.MOrderID AS SOVoucherNo, T1.APK_BomVersion, MT30.RoutingTime
, T1.nvarchar01
, T1.nvarchar02
, T1.nvarchar03
, T1.nvarchar04
, T1.nvarchar05
, T1.nvarchar06
, T1.nvarchar07
, T1.nvarchar08
, T1.nvarchar09
, T1.nvarchar10
, T2.Specification
FROM OT2202 T1 WITH (NOLOCK)
LEFT JOIN OT2201 OT01 WITH (NOLOCK) ON OT01.VoucherNo = T1.EstimateID
--LEFT JOIN OT2001 OT02 WITH (NOLOCK) ON T1.DivisionID = OT02.DivisionID 
--									AND OT02.SOrderID IN (
--															 SELECT RTRIM(LTRIM(VALUE)) AS SOrderID
--															 FROM dbo.StringSplit(T1.MOrderID, '','')
--														  )
--LEFT JOIN OT2002 OT03 WITH (NOLOCK) ON OT03.DivisionID = T1.DivisionID AND OT02.VoucherNo = OT03.SOrderID
--															AND OT03.InventoryID = T1.ProductID 																	  
LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON AT02.ObjectID = OT01.ObjectID
LEFT JOIN AT1302 T2 WITH (NOLOCK) ON T1.ProductID = T2.InventoryID
LEFT JOIN AT1304 T3 WITH (NOLOCK) ON T2.UnitID = T3.UnitID
LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = T1.Ana01ID AND T01.AnaTypeID = ''A01''
LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = T1.Ana02ID AND T02.AnaTypeID = ''A02''
LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = T1.Ana03ID AND T03.AnaTypeID = ''A03''
LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = T1.Ana04ID AND T04.AnaTypeID = ''A04''
LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = T1.Ana05ID AND T05.AnaTypeID = ''A05''
LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = T1.Ana06ID AND T06.AnaTypeID = ''A06''
LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = T1.Ana07ID AND T07.AnaTypeID = ''A07''
LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = T1.Ana08ID AND T08.AnaTypeID = ''A08''
LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = T1.Ana09ID AND T09.AnaTypeID = ''A09''
LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = T1.Ana10ID AND T10.AnaTypeID = ''A10''
LEFT JOIN MT2122 MT22 WITH (NOLOCK) ON T1.DivisionID = MT22.DivisionID 
                                                AND MT22.APK = T1.APK_BomVersion
                                                AND MT22.NodeID = T1.ProductID
LEFT JOIN MT2130 MT30 WITH (NOLOCK) ON T1.DivisionID = MT30.DivisionID 
                                                AND MT22.RoutingID = MT30.RoutingID 
--LEFT JOIN OT2002 OT03 WITH (NOLOCK) ON T03.DivisionID = T1.DivisionID AND OT03.SOrderID IN (
--																	    SELECT RTRIM(LTRIM(VALUE)) AS SOrderID
--																	    FROM dbo.StringSplit(T1.MOrderID, '','')
--																	 ) 
--                                                 AND OT03.InventoryID = T1.ProductID 
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.EstimateID IN ('''+@EstimateID+''') AND OT01.StatusID = 1
AND T1.APK NOT IN (SELECT InheritTransactionID from MT2141 WHERE InheritTransactionID = CONVERT(VARCHAR(50), T1.APK) and ISNULL(DeleteFlg,0)!=1)'


PRINT (@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
