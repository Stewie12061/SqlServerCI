IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20063]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20063]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Master: màn hình Kế thừa đơn hàng gia công
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Văn Tài on 06/01/2019
----Updated by Văn Tài on 14/01/2020: Điều chỉnh Left Join cho trường hợp mặt hàng không sử dụng quy cách.
----Updated by Văn Tài on 21/02/2020: Điều chỉnh vị trí where để tránh double dòng dữ liệu.
----Updated by Kiều Nga on 09/07/2020: Bổ sung lọc theo đk đơn hàng gia công

-- <Example>
---- 
/*-- <Example>
	exec SOP20063 @DivisionID=N'MTH',@UserID=N'HOCHUY',@PageNumber=1,@PageSize=25,@IsDate=1,
	@FromDate='2019-10-20 00:00:00',@ToDate='2019-11-21 00:00:00',@FromMonth=NULL,@FromYear=NULL,
	@ToMonth=NULL,@ToYear=NULL,@PriorityID=N'',
	@Ana01ID=N'',@Ana02ID=N'',@Ana03ID=N'',@Ana04ID=N'',@Ana05ID=N'',
	@Ana06ID=N'',@Ana07ID=N'',@Ana08ID=N'',@Ana09ID=N'',@Ana10ID=N'',@ScreenID=NULL,@ConditionOpportunityID=NULL
----*/

CREATE PROCEDURE SOP20063
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	 
	 @IsDate TINYINT, ---- 0: Radiobutton từ kỳ có check
					  ---- 1: Radiobutton từ ngày có check
	 @APKPOT2061 VARCHAR(50),
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @PriorityID VARCHAR(50),
	 @VoucherNo VARCHAR(50),
	 @Ana01ID NVARCHAR(50),
	 @Ana02ID NVARCHAR(50),
	 @Ana03ID NVARCHAR(50),
	 @Ana04ID NVARCHAR(50),
	 @Ana05ID NVARCHAR(50),
	 @Ana06ID NVARCHAR(50),
	 @Ana07ID NVARCHAR(50),
	 @Ana08ID NVARCHAR(50),
	 @Ana09ID NVARCHAR(50),
	 @Ana10ID NVARCHAR(50),
	 @ScreenID NVARCHAR(250) ='',
	 @ObjectName NVARCHAR(250) ='',
	 @ConditionOpportunityID nvarchar(max),
	 @Type INT = 0 -- 0 : Đơn hàng bán ,1 : đơn hàng gia công
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',	
		@sSQL1 NVARCHAR(MAX) = N'',
		@sSQL2 NVARCHAR(MAX) = N'',
		@sSQL3 NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@sJoin VARCHAR(MAX) = N'',
		@Customerindex INT,
		@ListSOT0002 NVARCHAR(MAX) = N'',
		@ParentScreenID VARCHAR = ''

SET @Customerindex = (SELECT CustomerName FROM CustomerIndex)
SET @ListSOT0002 = ISNULL((SELECT VoucherOutSource FROM SOT0002 WITH (NOLOCK)), '')
SET @OrderBy = 'T1.VoucherNo'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@ListSOT0002,'') <> ''
	BEGIN
		SET @ListSOT0002 = REPLACE(@ListSOT0002, ',', ''',''')
	END

IF @IsDate = 0 
	BEGIN
		SET @sWhere = @sWhere + N'
			AND T1.TranMonth + T1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
	END
ELSE
	BEGIN
		IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
			SET @sWhere = @sWhere + N'
				AND T1.OrderDate >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+''''
		IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
			SET @sWhere = @sWhere + N'
				AND T1.OrderDate <= '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
		IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
			SET @sWhere = @sWhere + N'
				AND T1.OrderDate BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''' '
	END

-- Số chứng từ
IF ISNULL(@VoucherNo, '') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T1.VoucherNo LIKE ''' + @VoucherNo + '%'' )'
	END

IF ISNULL(@Ana01ID,'') <> ''
	BEGIN
		IF(@Customerindex = 114)
			BEGIN
    			SET @sWhere = @sWhere + ' AND T2.Ana01ID IN (''' + @Ana01ID + ''')'
			END
		ELSE
			BEGIN
  				SET @sWhere = @sWhere + ' AND (T2.Ana01ID like ''' + @Ana01ID + '%'' OR A11.AnaName like N''%' + @Ana01ID + '%'')'
			END
	END

IF ISNULL(@Ana02ID,'') <> ''
	BEGIN
		IF(@Customerindex = 114)
			BEGIN
				SET @sWhere = @sWhere + ' AND T2.Ana02ID IN (''' + @Ana02ID + ''')'
			END
		ELSE
			BEGIN
				SET @sWhere = @sWhere + ' AND (T2.Ana02ID like ''' + @Ana02ID + '%'' OR A11.AnaName like N''%' + @Ana02ID + '%'')'
			END
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A12 WITH (NOLOCK) ON T2.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''' 
	END

IF ISNULL(@Ana03ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana03ID like ''%' + @Ana03ID + '%'' OR A13.AnaName like N''%' + @Ana03ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A13 WITH (NOLOCK) ON T2.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''' 
	END

IF ISNULL(@Ana04ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana04ID like ''%' + @Ana04ID + '%'' OR A14.AnaName like N''%' + @Ana04ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A14 WITH (NOLOCK) ON T2.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04'''
	END

IF ISNULL(@Ana05ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana05ID like ''%' + @Ana05ID + '%'' OR A15.AnaName like N''%' + @Ana05ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A15 WITH (NOLOCK) ON T2.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''' 
	END

IF ISNULL(@Ana06ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana06ID like ''%' + @Ana06ID + '%'' OR A16.AnaName like N''%' + @Ana06ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A16 WITH (NOLOCK) ON T2.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06'''
	END

IF ISNULL(@Ana07ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana07ID like ''%' + @Ana07ID + '%'' OR A17.AnaName like N''%' + @Ana07ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A17 WITH (NOLOCK) ON T2.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''' 
	END

IF ISNULL(@Ana08ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana08ID like ''%' + @Ana08ID + '%'' OR A18.AnaName like N''%' + @Ana08ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A18 WITH (NOLOCK) ON T2.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''' 
	END

IF ISNULL(@Ana09ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana09ID like ''%' + @Ana09ID + '%'' OR A19.AnaName like N''%' + @Ana09ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A19 WITH (NOLOCK) ON T2.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''' 
	END

IF ISNULL(@Ana10ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana10ID like ''%' + @Ana10ID + '%'' OR A20.AnaName like N''%' + @Ana10ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A20 WITH (NOLOCK) ON T2.Ana10ID = A20.AnaID AND A20.AnaTypeID = ''A10'''
	END

IF ISNULL(@ObjectName,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T1.ObjectID LIKE ''%' + @ObjectName + '%'' OR T1.ObjectName LIKE N''%' + @ObjectName + '%'')'
	END

IF ISNULL(@ConditionOpportunityID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(T1.CreateUserID,'''') IN (N'''+@ConditionOpportunityID+''' )'

--Phan quyen theo nghiep vu
SET @sWhere = @sWhere + dbo.GetPermissionVoucherNo(@UserID,'T1.VoucherNo')

IF(@Type = 1)
	SET @sWhere = @sWhere +' AND ISNULL(T1.ClassifyID,'''') IN (''' + @ListSOT0002 +''')'
ELSE
	SET @sWhere = @sWhere +' AND  ISNULL(T1.ClassifyID,'''') NOT IN (''' + @ListSOT0002 +''')'

SET @sSQL = @sSQL + N'
		SELECT DISTINCT T1.APK APKMaster, T1.DivisionID
			, T1.SOrderID
			, T1.VoucherNo, T1.VoucherTypeID
			, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes
		INTO #OT2001
		FROM OT2001 T1 WITH (NOLOCK) 
			LEFT JOIN OT2002 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID
													AND T2.SOrderID = T1.SOrderID
			-- Tiến độ giao hàng: không liên quan
			-- LEFT JOIN OT2003 T3 WITH (NOLOCK) ON T1.SOrderID = T3.SOrderID
		' + @sJoin + '	
		WHERE T1.DivisionID = '''+ @DivisionID + '''
			AND ISNULL(T1.IsShipDate, 0) = 0
			AND ISNULL(T1.OrderStatus, 0) = 1
			-- AND T1.SOrderID IS NOT NULL AND T3.SOrderID IS NULL '

		+@sWhere +''

SET @sSQL1 = N' AND ( ISNULL(T2.OrderQuantity, 0) 
				- ISNULL(
						  (SELECT SUM(ISNULL(T62.Quantity, 0))
							FROM POT2062 T62 WITH(NOLOCK)
							INNER JOIN POT2061 T61 WITH(NOLOCK) ON T61.DivisionID = T62.DivisionID
														AND T61.APK = T62.APKMaster
							LEFT JOIN OT8899 T89 WITH(NOLOCK) ON T89.DivisionID = T62.DivisionID
																	AND T89.VoucherID = T62.SOrderID
																	AND ISNULL(T89.TransactionID, '''') = ISNULL(T62.InheritTransactionID, '''')
																	AND ISNULL(T89.S01ID, '''') = ISNULL(T62.S01ID, '''')
																	AND ISNULL(T89.S02ID, '''') = ISNULL(T62.S02ID, '''')
																	AND ISNULL(T89.S03ID, '''') = ISNULL(T62.S03ID, '''')
																	AND ISNULL(T89.S04ID, '''') = ISNULL(T62.S04ID, '''')
																	AND ISNULL(T89.S05ID, '''') = ISNULL(T62.S05ID, '''')
																	AND ISNULL(T89.S06ID, '''') = ISNULL(T62.S06ID, '''')
																	AND ISNULL(T89.S07ID, '''') = ISNULL(T62.S07ID, '''')
																	AND ISNULL(T89.S08ID, '''') = ISNULL(T62.S08ID, '''')
																	AND ISNULL(T89.S09ID, '''') = ISNULL(T62.S09ID, '''')
																	AND ISNULL(T89.S10ID, '''') = ISNULL(T62.S10ID, '''')
																	AND ISNULL(T89.S11ID, '''') = ISNULL(T62.S11ID, '''')
																	AND ISNULL(T89.S12ID, '''') = ISNULL(T62.S12ID, '''')
																	AND ISNULL(T89.S13ID, '''') = ISNULL(T62.S13ID, '''')
																	AND ISNULL(T89.S14ID, '''') = ISNULL(T62.S14ID, '''')
																	AND ISNULL(T89.S15ID, '''') = ISNULL(T62.S15ID, '''')
																	AND ISNULL(T89.S16ID, '''') = ISNULL(T62.S16ID, '''')
																	AND ISNULL(T89.S17ID, '''') = ISNULL(T62.S17ID, '''')
																	AND ISNULL(T89.S18ID, '''') = ISNULL(T62.S18ID, '''')
																	AND ISNULL(T89.S19ID, '''') = ISNULL(T62.S19ID, '''')
																	AND ISNULL(T89.S20ID, '''') = ISNULL(T62.S20ID, '''')
							WHERE T62.DivisionID = T1.DivisionID
									AND T61.DeleteFlag = 0
									AND T62.SOrderID = T2.SOrderID
									AND T62.InheritTransactionID = T2.TransactionID '
									+ CASE WHEN ISNULL(@APKPOT2061, '') = '' 
										   THEN '' 
										   ELSE ' AND T61.APK <> N''' + @APKPOT2061 + '''' 
										   END
				+ ' ), 0) ) > 0' 
	

SET @sSQL2 = ' 
	SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate DESC, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
	, T1.APKMaster, T1.DivisionID
	, T1.SOrderID
	, T1.VoucherNo, T1.VoucherTypeID
	, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes
	-- , T2.OrderQuantity
	FROM #OT2001 T1
	'



SET @sSQL3 = N'	ORDER BY '+@OrderBy+' 
	OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY
	'

PRINT (@sSQL)
PRINT (@sSQL1)
PRINT (@sSQL2)
PRINT (@sSQL3)
EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
