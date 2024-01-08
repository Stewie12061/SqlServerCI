IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2159]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2159]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---- Load Detail Dự trù OT2202
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Trọng Kiên on 23/03/2021
---- Update by: Đức Tuyên Date: 09/03/2023 : Bố sung số PO lên Dự Trù.
-- <Example> EXEC MP2159 @DivisionID = 'BE', @UserID = '', @APK = '9B8430BF-53C2-4EAB-A524-50BC4F2FCA82'
CREATE PROCEDURE MP2159
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

	DECLARE @sSQL NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX) = N''

	SET @OrderBy = N'Orders'

	SET @sSQL = N'
				SELECT  O1.APK, O1.DivisionID, O1.EstimateID, O1.TranMonth, O1.TranYear, O1.ProductID, O1.ProductQuantity
				, O1.PDescription, O1.LinkNo, O1.Orders, O1.UnitID

				,O1.Ana01ID, T01.AnaName As Ana01Name, O1.Ana02ID, T02.AnaName As Ana02Name, O1.Ana03ID, T03.AnaName As Ana03Name,
				O1.Ana04ID, T04.AnaName As Ana04Name, O1.Ana05ID, T05.AnaName As Ana05Name, O1.Ana06ID, T06.AnaName As Ana06Name,
				O1.Ana07ID, T07.AnaName As Ana07Name, O1.Ana08ID, T08.AnaName As Ana08Name, O1.Ana09ID, T09.AnaName As Ana09Name,
				O1.Ana10ID, T10.AnaName As Ana10Name

				, O1.MOTransactionID, O1.MOrderID, O1.SOrderID, O1.MTransactionID, O1.STransactionID
				, O1.RefInfor, O1.ED01, O1.ED02, O1.ED03, O1.ED04
				, O1.ED05, O1.ED06, O1.ED07, O1.ED08, O1.ED09, O1.ED10, O1.ProductName, O1.UnitName, O1.S01ID, O1.S02ID, O1.S03ID
				, O1.S04ID, O1.S05ID, O1.S06ID, O1.S07ID, O1.S08ID, O1.S09ID, O1.S10ID, O1.S11ID, O1.S12ID, O1.S13ID, O1.S14ID, O1.S15ID
				, O1.S16ID, O1.S17ID, O1.S18ID, O1.S19ID, O1.S20ID, O1.VersionBOM, O1.InventoryTP, O1.APK_BomVersion, O1.EDetailID, O1.ApporitionID
				, O1.nvarchar01 , O1.nvarchar02 , O1.nvarchar03 , O1.nvarchar04, O1.nvarchar05, O1.nvarchar06, O1.nvarchar07, O1.nvarchar08, O1.nvarchar09, O1.nvarchar10
				, O1.InheritTableID, O1.InheritVoucherID, O1.InheritTransactionID
				INTO #TempMP2159
				FROM OT2202 O1 WITH (NOLOCK)
					LEFT JOIN OT2201 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK
					LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = O1.Ana01ID AND T01.AnaTypeID = ''A01''
					LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = O1.Ana02ID AND T02.AnaTypeID = ''A02''
					LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = O1.Ana03ID AND T03.AnaTypeID = ''A03''
					LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = O1.Ana04ID AND T04.AnaTypeID = ''A04''
					LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = O1.Ana05ID AND T05.AnaTypeID = ''A05''
					LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = O1.Ana06ID AND T06.AnaTypeID = ''A06''
					LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = O1.Ana07ID AND T07.AnaTypeID = ''A07''
					LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = O1.Ana08ID AND T08.AnaTypeID = ''A08''
					LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = O1.Ana09ID AND T09.AnaTypeID = ''A09''
					LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = O1.Ana10ID AND T10.AnaTypeID = ''A10'' 
				WHERE (CONVERT(VARCHAR(50),O2.APKMaster_9000) = '''+@APK+''' OR CONVERT(VARCHAR(50),O2.APK) = '''+@APK+''') AND O2.DivisionID = ''' + @DivisionID + '''

				DECLARE @Count INT
				SELECT @Count = COUNT(*) FROM #TempMP2159
				
				SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, @Count AS TotalRow
						, APK, DivisionID, EstimateID, TranMonth, TranYear, ProductID, ProductQuantity
						, PDescription, LinkNo, Orders, UnitID, Ana01ID, Ana02ID, Ana03ID, Ana04ID
						, Ana05ID, MOTransactionID, MOrderID, SOrderID, MTransactionID, STransactionID
						, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, RefInfor, ED01, ED02, ED03, ED04
						, ED05, ED06, ED07, ED08, ED09, ED10, ProductName, UnitName, S01ID, S02ID, S03ID
						, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID
						, S16ID, S17ID, S18ID, S19ID, S20ID, VersionBOM, InventoryTP, APK_BomVersion, EDetailID, ApporitionID
						, nvarchar01 , nvarchar02 , nvarchar03 , nvarchar04, nvarchar05, nvarchar06, nvarchar07, nvarchar08, nvarchar09, nvarchar10
						, Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name
						, InheritTableID, InheritVoucherID, InheritTransactionID
				FROM #TempMP2159 WITH (NOLOCK) 
				ORDER BY '+@OrderBy+''

 	 EXEC (@sSQL)
	 PRINT (@sSQL)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
