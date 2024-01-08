IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20232A]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20232A]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load dữ liệu màn hình kế thừa phiếu báo giá Sale (Detail).
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Đình hòa Date 03/06/2021
-- Edit by: Đình hòa Date 25/06/2021 : Bổ sung load cá cột mới
-- Update by : Kiều Nga Date 31/08/2021 : Bổ sung load dòng có check kế thừa sang báo giá kinh doanh
-- Update by : Kiều Nga Date 10/09/2021 : Bổ sung lấy thêm đính kèm AttachFileName

-- <Example>

 CREATE PROCEDURE [dbo].[SOP20232A] 
 (
	 @DivisionID NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @ScreenID VARCHAR(50) =''
)
AS

DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50),
		@sWhere NVARCHAR (MAX) ='',
		@sJoin NVARCHAR (MAX) ='',
		@sSelect NVARCHAR (MAX) =''

IF @ScreenID ='SOF2121' OR @ScreenID ='SOF2141KT'
BEGIN
	SET @sWhere = ' AND S2.IsInherit = 1'
END

SET @sWhere =  @sWhere +' AND (S2.QuoQuantity - ISNULL(S36.Quantity,0))  >0 '
SET @sSelect = ' , (S2.QuoQuantity - ISNULL(S36.Quantity,0)) as QuoQuantity'

IF @ScreenID ='SOF2001'
BEGIN
    SET @sJoin = ' LEFT JOIN (SELECT DivisionID,InheritVoucherID,SUM(OrderQuantity) as Quantity 
				             FROM OT2002 WITH(NOLOCK) WHERE InheritTableID =''SOT2121'' GROUP BY DivisionID,InheritVoucherID) S36 ON  S2.DivisionID = S36.DivisionID AND S2.APK = S36.InheritVoucherID 
					'
END
ELSE IF @ScreenID ='SOF2121'
BEGIN
    SET @sJoin = ' LEFT JOIN (SELECT DivisionID,InheritVoucherID,SUM(QuoQuantity) as Quantity 
				             FROM SOT2121 WITH(NOLOCK) WHERE InheritTableID =''SOT2121'' GROUP BY DivisionID,InheritVoucherID) S36 ON  S2.DivisionID = S36.DivisionID AND S2.APK = S36.InheritVoucherID 
					'
END
ELSE IF @ScreenID ='SOF2141KT' OR @ScreenID ='SOF2141SALE'
BEGIN
    SET @sJoin = ' LEFT JOIN (SELECT DivisionID,InheritVoucherID,SUM(Quantity) as Quantity 
				             FROM SOT2141 WITH(NOLOCK) WHERE InheritTableID =''SOT2121'' GROUP BY DivisionID,InheritVoucherID) S36 ON  S2.DivisionID = S36.DivisionID AND S2.APK = S36.InheritVoucherID 
					'
END

SET @sSQL = 'SELECT COUNT(*) OVER() AS TotalRow, ROW_NUMBER() OVER (ORDER BY S2.InventoryID) AS RowNum
, S2.APK, S2.DivisionID ,S2.InventoryID, S2.Area, S2.QuoCoefficient, S2.Specification, S2.UnitPriceInherit, S2.UnitPrice, S2.OriginalAmount, S2.ConvertedAmount
, S2.VATPercent, S2.VATConvertedAmount, S2.VATOriginalAmount, S2.Notes, S3.InventoryName, S4.UnitName, S5.VATGroupName, S2.UnitID, S2.VATGroupID
, S26.AnaName AS Ana01Name, S27.AnaName AS Ana02Name, S28.AnaName AS Ana03Name, S29.AnaName AS Ana04Name, S30.AnaName AS Ana05Name
, S31.AnaName AS Ana06Name, S32.AnaName AS Ana07Name, S33.AnaName AS Ana08Name, S34.AnaName AS Ana09Name, S35.AnaName AS Ana10Name
, S6.StandardName AS S01Name, S7.StandardName AS S02Name, S8.StandardName AS S03Name, S9.StandardName AS S04Name, S10.StandardName AS S05Name, S11.StandardName AS S06Name
, S12.StandardName AS S07Name, S13.StandardName AS S08Name , S14.StandardName AS S09Name, S15.StandardName AS S10Name , S16.StandardName AS S11Name, S17.StandardName AS S12Name 
, S18.StandardName AS S13Name, S19.StandardName AS S14Name , S20.StandardName AS S15Name, S21.StandardName AS S16Name, S22.StandardName AS S17Name, S23.StandardName AS S18Name
, S24.StandardName AS S19Name, S25.StandardName AS S20Name
, S2.S01ID, S2.S02ID, S2.S03ID, S2.S04ID, S2.S05ID, S2.S06ID, S2.S07ID, S2.S08ID, S2.S09ID, S2.S10ID, S2.S11ID, S2.S12ID
, S2.S13ID, S2.S14ID, S2.S15ID, S2.S16ID, S2.S17ID, S2.S18ID, S2.S19ID, S2.S20ID
, S2.Ana01ID, S2.Ana02ID, S2.Ana03ID, S2.Ana04ID, S2.Ana05ID, S2.Ana06ID, S2.Ana07ID, S2.Ana08ID, S2.Ana09ID, S2.Ana10ID
, S2.FirePrice, S2.LengthSize, S2.WithSize, S2.HeightSize, S2.LipSize,S2.AttachFileName '+@sSelect+'
FROM SOT2120 S1 WITH(NOLOCK)
LEFT JOIN SOT2121 S2 WITH(NOLOCK) ON S1.APK = S2.APKMaster AND S1.DivisionID = S2.DivisionID
LEFT JOIN AT1302 S3 WITH(NOLOCK) ON S2.InventoryID = S3.InventoryID AND S3.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT1304 S4 WITH(NOLOCK) ON S2.UnitID = S4.UnitID AND  S4.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT1010 S5 WITH(NOLOCK) ON S2.VATGroupID = S5.VATGroupID AND S5.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S6 WITH(NOLOCK) ON S2.S01ID = S6.StandardID AND S6.StandardTypeID = ''S01'' AND S6.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S7 WITH(NOLOCK) ON S2.S02ID = S7.StandardID AND S7.StandardTypeID = ''S02'' AND S7.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S8 WITH(NOLOCK) ON S2.S03ID = S8.StandardID AND S8.StandardTypeID = ''S03'' AND S8.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S9 WITH(NOLOCK) ON S2.S04ID = S9.StandardID AND S9.StandardTypeID = ''S04'' AND S9.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S10 WITH(NOLOCK) ON S2.S05ID = S10.StandardID AND S10.StandardTypeID = ''S05'' AND S10.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S11 WITH(NOLOCK) ON S2.S06ID = S11.StandardID AND S11.StandardTypeID = ''S06'' AND S11.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S12 WITH(NOLOCK) ON S2.S07ID = S12.StandardID AND S12.StandardTypeID = ''S07'' AND S12.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S13 WITH(NOLOCK) ON S2.S08ID = S13.StandardID AND S13.StandardTypeID = ''S08'' AND S13.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S14 WITH(NOLOCK) ON S2.S09ID = S14.StandardID AND S14.StandardTypeID = ''S09'' AND S14.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S15 WITH(NOLOCK) ON S2.S10ID = S15.StandardID AND S15.StandardTypeID = ''S10'' AND S15.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S16 WITH(NOLOCK) ON S2.S11ID = S16.StandardID AND S16.StandardTypeID = ''S11'' AND S16.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S17 WITH(NOLOCK) ON S2.S12ID = S17.StandardID AND S17.StandardTypeID = ''S12'' AND S17.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S18 WITH(NOLOCK) ON S2.S13ID = S18.StandardID AND S18.StandardTypeID = ''S13'' AND S18.DivisionID IN(''@@@'', S1.DivisionID)'

SET @sSQL1 = N'
LEFT JOIN AT0128 S19 WITH(NOLOCK) ON S2.S14ID = S19.StandardID AND S19.StandardTypeID = ''S14'' AND S19.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S20 WITH(NOLOCK) ON S2.S15ID = S20.StandardID AND S20.StandardTypeID = ''S15'' AND S20.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S21 WITH(NOLOCK) ON S2.S16ID = S21.StandardID AND S21.StandardTypeID = ''S16'' AND S21.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S22 WITH(NOLOCK) ON S2.S17ID = S22.StandardID AND S22.StandardTypeID = ''S17'' AND S22.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S23 WITH(NOLOCK) ON S2.S18ID = S23.StandardID AND S23.StandardTypeID = ''S18'' AND S23.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S24 WITH(NOLOCK) ON S2.S19ID = S24.StandardID AND S24.StandardTypeID = ''S19'' AND S24.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S25 WITH(NOLOCK) ON S2.S20ID = S25.StandardID AND S25.StandardTypeID = ''S20'' AND S25.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT1011 S26 WITH(NOLOCK) ON S26.DivisionID IN (S1.DivisionID,''@@@'') AND S2.Ana01ID = S26.AnaID AND S26.AnaTypeID = ''A01''
LEFT JOIN AT1011 S27 WITH(NOLOCK) ON S27.DivisionID IN (S1.DivisionID,''@@@'') AND S2.Ana02ID = S27.AnaID AND S27.AnaTypeID = ''A02''
LEFT JOIN AT1011 S28 WITH(NOLOCK) ON S28.DivisionID IN (S1.DivisionID,''@@@'') AND S2.Ana03ID = S28.AnaID AND S28.AnaTypeID = ''A03''
LEFT JOIN AT1011 S29 WITH(NOLOCK) ON S29.DivisionID IN (S1.DivisionID,''@@@'') AND S2.Ana04ID = S29.AnaID AND S29.AnaTypeID = ''A04''
LEFT JOIN AT1011 S30 WITH(NOLOCK) ON S30.DivisionID IN (S1.DivisionID,''@@@'') AND S2.Ana05ID = S30.AnaID AND S30.AnaTypeID = ''A05''
LEFT JOIN AT1011 S31 WITH(NOLOCK) ON S31.DivisionID IN (S1.DivisionID,''@@@'') AND S2.Ana06ID = S31.AnaID AND S31.AnaTypeID = ''A06''
LEFT JOIN AT1011 S32 WITH(NOLOCK) ON S32.DivisionID IN (S1.DivisionID,''@@@'') AND S2.Ana07ID = S32.AnaID AND S32.AnaTypeID = ''A07''
LEFT JOIN AT1011 S33 WITH(NOLOCK) ON S33.DivisionID IN (S1.DivisionID,''@@@'') AND S2.Ana08ID = S33.AnaID AND S33.AnaTypeID = ''A08''
LEFT JOIN AT1011 S34 WITH(NOLOCK) ON S34.DivisionID IN (S1.DivisionID,''@@@'') AND S2.Ana09ID = S34.AnaID AND S34.AnaTypeID = ''A09''
LEFT JOIN AT1011 S35 WITH(NOLOCK) ON S35.DivisionID IN (S1.DivisionID,''@@@'') AND S2.Ana10ID = S35.AnaID AND S35.AnaTypeID = ''A10''
'+@sJoin+'
WHERE S1.DivisionID = '''+@DivisionID+''' AND S2.APKMaster IN  ('''+ @APK +''') '+@sWhere+'
ORDER BY S2.OrderInv,S2.CreateDate '

PRINT(@sSQL)
PRINT(@sSQL1)
EXEC (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
