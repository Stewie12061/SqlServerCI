IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0037]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0037]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo kiểm kê hàng hóa
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/10/2016 by Phan Hải Long
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Thy on 04/04/2018: bổ sung trường theo yêu cầu http://192.168.0.204:8069/web?db=ASERP#id=3834&view_type=form&model=project.issue&action=390
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
---- 
CREATE PROCEDURE [dbo].[MP0037]
( 
		@DivisionID NVARCHAR(50),
		@VoucherID NVARCHAR(50)
)
AS 

SET NOCOUNT ON 
DECLARE @sSql NVARCHAR(MAX) = ''

SET @sSQL = '
SELECT MT1802.TypeTab, MT1801.DivisionID, MT1801.VoucherDate, MT1801.ProductDate, MT1801.VoucherNo, MT1801.ObjectID, AT1202.ObjectName, MT1802.ProductID, A02.InventoryName AS ProductName, MT1802.ProductUnitID,
MT1801.QuantityChoose, MT1801.RateChoose, MT1801.QuantityQualify, MT1801.RateQualify, MT1801.QuantityNotQualify, MT1801.RateNotQualify, MT1801.ReImportQuantity,
MT1801.QuantityControl, MT1801.Parameter01, MT1801.Parameter02, MT1801.Parameter03,
MT1801.TeamID, HT1101.TeamName, MT1801.VisorsID, HV1400.FullName AS VisorsName, MT1802.LimitDate, ISNULL(MT1802.ActualQuantity, 0) as ActualQuantity, ISNULL(MT1802.ErrorQuantity, 0) as ErrorQuantity, 
ISNULL((Case when IsImport = 1 AND MT1802.TypeTab = 2 then MT1802.ActualQuantity 
			 when IsImport = 1 AND MT1802.TypeTab = 3 then MT1802.ErrorQuantity else 0 END), 0) AS ImportQuantity, 
MT1802.ErrorTypeID, AT0148.ProErrorName,
MT1802.Parameter11 AS DParameter11, MT1802.Parameter12 AS DParameter12, MT1802.Parameter13 AS DParameter13, MT1802.Parameter14 AS DParameter14, GETDATE() AS CurrentDateTime,
MT1802.BeginTime, MT1802.EndTime, MT1802.ActualTime, MT1802.Shift, MT1802.IsImport, MT1802.WarehouseID, AT1303.WarehouseName,
MT1802.S01ID, MT1802.S02ID, MT1802.S03ID, MT1802.S04ID, MT1802.S05ID, MT1802.S06ID, MT1802.S07ID, MT1802.S08ID, MT1802.S09ID, MT1802.S10ID, MT1802.S11ID, MT1802.S12ID, MT1802.S13ID, MT1802.S14ID, MT1802.S15ID,
MT1802.S16ID, MT1802.S17ID, MT1802.S18ID, MT1802.S19ID, MT1802.S20ID, MT1802.Ana01ID, MT1802.Ana02ID, MT1802.Ana03ID, MT1802.Ana04ID, MT1802.Ana05ID, MT1802.Ana06ID, MT1802.Ana07ID, MT1802.Ana08ID,
MT1802.Ana09ID, MT1802.Ana10ID, ISNULL(A11.AnaName,'''') Ana01Name, ISNULL(A12.AnaName,'''') Ana02Name, ISNULL(A13.AnaName,'''') Ana03Name, ISNULL(A14.AnaName,'''') Ana04Name, ISNULL(A15.AnaName,'''') Ana05Name, 
ISNULL(A16.AnaName,'''') Ana06Name, ISNULL(A17.AnaName,'''') Ana07Name, ISNULL(A18.AnaName,'''') Ana08Name, ISNULL(A19.AnaName,'''') Ana09Name, ISNULL(A20.AnaName,'''') Ana10Name
FROM MT1802 WITH (NOLOCK)
INNER JOIN MT1801 WITH (NOLOCK) ON MT1801.DivisionID = MT1802.DivisionID AND MT1801.VoucherID = MT1802.VoucherID
LEFT JOIN HT1101 WITH (NOLOCK) ON HT1101.DivisionID = MT1801.DivisionID AND HT1101.TeamID = MT1801.TeamID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = MT1801.ObjectID
LEFT JOIN HV1400 WITH (NOLOCK) ON HV1400.DivisionID = MT1801.DivisionID AND HV1400.EmployeeID = MT1801.VisorsID
LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = MT1802.ProductID AND A02.DivisionID IN (MT1802.DivisionID,''@@@'')
LEFT JOIN AT0148 WITH (NOLOCK) ON MT1801.DivisionID = AT0148.DivisionID AND MT1802.ErrorTypeID = AT0148.ProErrorID
LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WarehouseID = MT1802.WarehouseID
LEFT JOIN AT1011 A11 WITH (NOLOCK) ON A11.AnaID = MT1802.Ana01ID AND A11. AnaTypeID = ''A01'' 
LEFT JOIN AT1011 A12 WITH (NOLOCK) ON A12.AnaID = MT1802.Ana02ID AND A12. AnaTypeID = ''A02''
LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID = MT1802.Ana03ID AND A13. AnaTypeID = ''A03''
LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID = MT1802.Ana04ID AND A14. AnaTypeID = ''A04''
LEFT JOIN AT1011 A15 WITH (NOLOCK) ON A15.AnaID = MT1802.Ana05ID AND A15. AnaTypeID = ''A05''
LEFT JOIN AT1011 A16 WITH (NOLOCK) ON A16.AnaID = MT1802.Ana06ID AND A16. AnaTypeID = ''A06''
LEFT JOIN AT1011 A17 WITH (NOLOCK) ON A17.AnaID = MT1802.Ana07ID AND A17. AnaTypeID = ''A07''
LEFT JOIN AT1011 A18 WITH (NOLOCK) ON A18.AnaID = MT1802.Ana08ID AND A18. AnaTypeID = ''A08''
LEFT JOIN AT1011 A19 WITH (NOLOCK) ON A19.AnaID = MT1802.Ana09ID AND A19. AnaTypeID = ''A09''
LEFT JOIN AT1011 A20 WITH (NOLOCK) ON A20.AnaID = MT1802.Ana10ID AND A20. AnaTypeID = ''A10''
WHERE MT1801.DivisionID = ''' + @DivisionID + '''
AND MT1802.VoucherID = ''' + @VoucherID + '''
AND (MT1802.TypeTab = 2 OR MT1802.TypeTab = 3)
ORDER BY MT1802.TypeTab, MT1802.Orders 
'
--PRINT @sSQL

EXEC(@sSQL)


SET NOCOUNT OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
