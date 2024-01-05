IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20085]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20085]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load màn hình chọn phiếu thông tin sản xuất
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trọng Kiên
----Modified by Lê Hoàng on 07/05/2021 : Lỗi double dữ liệu
----Modified by Lê Hoàng on 13/05/2021 : Chỉnh sửa cho lọc theo mã hoặc tên đối tượng
----Modified by Kiều Nga on 26/05/2021 : Bỏ đk lọc chứng từ, bổ sung đk lọc Thành phẩm, chỉ load những phiếu có bán thành phẩm
----Modified by Lê Hoàng on 27/05/2021 : Bổ sung biến ScreenID truyền mã màn hình cha
----Modified by Kiều Nga on 10/17/2022 : Fix lỗi không hiển thị số lượng sản xuất khi kế thừa thông tin sản xuất
----Modified by ... on ... :
-- <Example> exec sp_executesql N'SOP20085 @DivisionID=N''HCM'',@TxtSearch=N''77'',@UserID=N''HCM07'',@PageNumber=N''1'',@PageSize=N''25'',@ConditionObjectID=N'''',@IsOrganize=0',N'@CreateUserID nvarchar(5),@LastModifyUserID nvarchar(5),@DivisionID nvarchar(3)',@CreateUserID=N'HCM07',@LastModifyUserID=N'HCM07',@DivisionID=N'HCM'

 CREATE PROCEDURE SOP20085 (
     @DivisionID NVARCHAR(2000),
     @IsDate TINYINT, ---- 0: Lọc theo ngày, 1: Lọc theo kỳ
     @FromDate VARCHAR(50),
     @ToDate VARCHAR(50),
     @FromMonth INT,
     @FromYear INT,
     @ToMonth INT,
     @ToYear INT,
     @ObjectID NVARCHAR(250) = '',
     @Inventory NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ScreenID NVARCHAR(50) = 'SOF2081'
)
AS
DECLARE @sSQL NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText varchar(50),
		@ToDateTex varchar(50)

IF (ISNULL(@FromDate, '') <> '')
	SET @FromDateText = CONVERT(DATETIME, @FromDate, 103)
IF (ISNULL(@ToDate, '') <> '')
	SET @ToDateTex = CONVERT(DATETIME, @ToDate, 103)

SET @TotalRow = ''
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

-- Check Para FromDate và ToDate
    IF @IsDate = 0 
    BEGIN
        SET @sWhere = @sWhere + N'AND S1.TranMonth + S1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
    END
    ELSE
    BEGIN
        IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N'
            AND (S1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateTex + ''')'
        ELSE IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
            SET @sWhere = @sWhere + N'
            AND (S1.VoucherDate >= ''' + @FromDateText + ''')'
        ELSE IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N'
            AND (S1.VoucherDate <= ''' + @ToDateTex + ''')'
    END

IF ISNULL(@ObjectID, '') != ''
    SET @sWhere = @sWhere + ' AND (ISNULL(S1.ObjectID, '''') LIKE N''%' + @ObjectID + '%'' OR ISNULL(A1.ObjectName, '''') like N''%' + @ObjectID + '%'')'

IF ISNULL(@Inventory, '') != ''
    SET @sWhere = @sWhere + ' AND (ISNULL(S1.InventoryID, '''') LIKE N''%' + @Inventory + '%'' OR ISNULL(A2.InventoryName, '''') LIKE N''%' + @Inventory + '%'')'

--IF @ScreenID = 'SOF2081'
--BEGIN
--	SET @sWhere = @sWhere + ' AND ISNULL(S1.SemiProduct,'''') <> '''' '
--END
	  
SET @sSQL = N'SELECT DISTINCT S1.APK
						, S1.VoucherNo
						, S1.ObjectID
						, A1.ObjectName
						, S1.InventoryID
						, A2.InventoryName
						, A4.UnitName AS UnitNameProduct
						, A2.UnitID AS UnitIDProduct
						, MT22.Version AS BomVersion
						, S1.APK_BomVersion
						, S1.ActualQuantity AS OrderQuantity
						, OT02.Ana01ID, T01.AnaName As Ana01Name, OT02.Ana02ID, T02.AnaName As Ana02Name, OT02.Ana03ID, T03.AnaName As Ana03Name, OT02.Ana04ID, T04.AnaName As Ana04Name, OT02.Ana05ID, T05.AnaName As Ana05Name
						, OT02.Ana06ID, T06.AnaName As Ana06Name, OT02.Ana07ID, T07.AnaName As Ana07Name, OT02.Ana08ID, T08.AnaName As Ana08Name, OT02.Ana09ID, T09.AnaName As Ana09Name, OT02.Ana10ID, T10.AnaName As Ana10Name
						, MT99.S01ID, MT99.S02ID, MT99.S03ID, MT99.S04ID, MT99.S05ID, MT99.S06ID, MT99.S07ID, MT99.S08ID, MT99.S09ID, MT99.S10ID
						, MT99.S11ID, MT99.S12ID, MT99.S13ID, MT99.S14ID, MT99.S15ID, MT99.S16ID, MT99.S17ID, MT99.S18ID, MT99.S19ID, MT99.S20ID

						, M2.UnitID
						, S1.StatusID
						, S4.Description AS StatusName
						, M3.Description AS UnitName
						, M2.RoutingTime
						, CONVERT(VARCHAR, S1.DeliveryTime, 103) AS DeliveryTime
						, '''' AS Notes
						, '+@TotalRow+' AS TotalRow
              FROM SOT2080 S1 WITH (NOLOCK)
				LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = S1.ObjectID
				LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.InventoryID = S1.InventoryID
				LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A2.UnitID = A4.UnitID
				LEFT JOIN MT2122 MT22 WITH (NOLOCK) ON CONVERT(VARCHAR(50), MT22.APK) = S1.APK_BomVersion
				LEFT JOIN MT2123 MT23 WITH (NOLOCK) ON CONVERT(VARCHAR(50), MT23.APK_2120) = S1.APK_BomVersion AND MT23.NodeID = S1.InventoryID
				LEFT JOIN OT2002 OT02 WITH (NOLOCK) ON OT02.DivisionID = S1.DivisionID AND CONVERT(VARCHAR(50), OT02.APK) = S1.InheritAPKDetail
				LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = OT02.Ana01ID AND T01.AnaTypeID = ''A01''
				LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = OT02.Ana02ID AND T02.AnaTypeID = ''A02''
				LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = OT02.Ana03ID AND T03.AnaTypeID = ''A03''
				LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = OT02.Ana04ID AND T04.AnaTypeID = ''A04''
				LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = OT02.Ana05ID AND T05.AnaTypeID = ''A05''
				LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = OT02.Ana06ID AND T06.AnaTypeID = ''A06''
				LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = OT02.Ana07ID AND T07.AnaTypeID = ''A07''
				LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = OT02.Ana08ID AND T08.AnaTypeID = ''A08''
				LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = OT02.Ana09ID AND T09.AnaTypeID = ''A09''
				LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = OT02.Ana10ID AND T10.AnaTypeID = ''A10''
				LEFT JOIN MT8899 MT99 WITH(NOLOCK) ON MT99.TransactionID = CAST(MT23.APK AS VARCHAR(50))

				LEFT JOIN MT2120 M1 WITH (NOLOCK) ON S1.InventoryID = M1.NodeID
				LEFT JOIN MT2130 M2 WITH (NOLOCK) ON M1.RoutingID = M2.RoutingID
				LEFT JOIN MT0099 M3 WITH (NOLOCK) ON M2.UnitID = M3.ID AND M3.CodeMaster = ''RoutingUnit'' AND ISNULL(M3.Disabled, 0)= 0
				LEFT JOIN SOT0099 S4 WITH (NOLOCK) ON S1.StatusID = S4.ID AND S4.CodeMaster = ''SOT2080.StatusID''AND ISNULL(S4.Disabled, 0)= 0
				--- Kiem tra ke thua
				OUTER APPLY
				(
				SELECT TOP 1 OT01.*
				FROM OT2201 OT01 WITH (NOLOCK)
				INNER JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.DivisionID = OT01.DivisionID AND OT02.EstimateID = OT01.EstimateID
				WHERE
					OT01.DivisionID = S1.DivisionID
					AND ISNULL(OT01.DeleteFlg, 0) = 0
					AND ISNULL(OT02.MOrderID, '''') LIKE ''%'' + S1.VoucherNo + ''%''
				) OT01
			  WHERE S1.DivisionID = '''+@DivisionID+''' 
				AND ISNULL(S1.Status, 0) = 1
				AND S1.DeleteFlg = 0 
				AND OT01.APK IS NULL
				' + @sWhere
print  (@sSQL)
EXEC (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
