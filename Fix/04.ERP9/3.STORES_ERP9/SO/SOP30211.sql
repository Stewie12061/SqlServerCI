IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30211]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30211]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--- Created by Nhựt Trường on 26/02/2022: Báo cáo tổng hợp doanh số sale NPP (CustomizeIndex = 57 ---- ANGEL)
--- Modified on 12/05/2022 by Nhựt Trường: Bổ sung trường Period để điều chỉnh nhóm theo kỳ khi in/xuất excel.
--- Modified on 04/07/2022 by Nhựt Trường: Bổ sung điều kiện kiểm tra khi các điều kiện lọc truyền vào là null.
/*
 * exec SOP30211 'ANG', 201601, 201601, '01/01/2016', '01/31/2016', '', 'KPP.HAG.0001', 'KPP.HYE.0001', 'HMP', 'MPB' , 0
 */ 

CREATE PROCEDURE [dbo].[SOP30211] 
(
	@DivisionID			 NVARCHAR(50),	--Biến môi trường
	@IsDate				 TINYINT,		--1: Theo ngày; 0: Theo kỳ
	@FromDate			 DATETIME, 
	@ToDate				 DATETIME,
	@PeriodIDList		 NVARCHAR(MAX),
	@ListArea			 NVARCHAR(MAX),
	@ListInventoryTypeID NVARCHAR(MAX),
	@ListDealerID		 NVARCHAR(MAX), 
	@ListSUPID			 NVARCHAR(MAX), 
	@ListASMID			 NVARCHAR(MAX),
	@ListADMIN			 NVARCHAR(MAX),
	@ListQLADMIN		 NVARCHAR(MAX),
	@IsDeclare			 TINYINT		-- 1: Đã khai báo target
										-- 0: Chưa khai báo tagert
)
AS
DECLARE @sSQL				NVARCHAR(MAX) = '',
		@sSQL1				NVARCHAR(MAX) = '',
		@sSQL2				NVARCHAR(MAX) = '',
		@sSQL3				NVARCHAR(MAX) = '',
		@sWhere				NVARCHAR(MAX) = '',
		@sWhere2			NVARCHAR(MAX) = '',
		@sWhere3			NVARCHAR(MAX) = '',
		@StrArea			NVARCHAR(MAX) = '',
		@StrInventoryTypeID	NVARCHAR(MAX) = '',
		@StrSaleID			NVARCHAR(MAX) = '',
		@StrDealerID		NVARCHAR(MAX) = '',
		@StrSUPID			NVARCHAR(MAX) = '',
		@StrASMID			NVARCHAR(MAX) = '',
		@StrADMIN			NVARCHAR(MAX) = '',
		@StrQLADMIN			NVARCHAR(MAX) = '',
		@Period				NVARCHAR(MAX) = '',
		@GroupByPeriod		NVARCHAR(MAX) = '',
		@n1 decimal(28,8) = 1,
		@n2 decimal(28,8) = 2

---- Area
IF CHARINDEX('%',@ListArea) > 0 OR ISNULL(@ListArea,'') = ''
BEGIN
	SET @StrArea = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrArea = N'IN ('''+@ListArea+''')'
END

---- InventoryTypeID
IF CHARINDEX('%',@ListInventoryTypeID) > 0 OR ISNULL(@ListInventoryTypeID,'') = ''
BEGIN
	SET @StrInventoryTypeID = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrInventoryTypeID = N'IN ('''+@ListInventoryTypeID+''')'
END

---- DEALER
IF CHARINDEX('%',@ListDealerID) > 0 OR ISNULL(@ListDealerID,'') = ''
BEGIN
	SET @StrDealerID = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrDealerID = N'IN ('''+@ListDealerID+''')'
END

---- SUPID
IF CHARINDEX('%',@ListSUPID) > 0 OR ISNULL(@ListSUPID,'') = ''
BEGIN
	SET @StrSUPID = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrSUPID = N'IN ('''+@ListSUPID+''')'
END

---- ASMID
IF CHARINDEX('%',@ListASMID) > 0 OR ISNULL(@ListASMID,'') = ''
BEGIN
	SET @StrASMID = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrASMID = N'IN ('''+@ListASMID+''')'
END

---- ADMIN
IF CHARINDEX('%',@ListADMIN) > 0 OR ISNULL(@ListADMIN,'') = ''
BEGIN
	SET @StrADMIN = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrADMIN = N'IN ('''+@ListADMIN+''')'
END

---- QLADMIN
IF CHARINDEX('%',@ListQLADMIN) > 0 OR ISNULL(@ListQLADMIN,'') = ''
BEGIN
	SET @StrQLADMIN = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrQLADMIN = N'IN ('''+@ListQLADMIN+''')'
END
		
SET @sWhere = ''
SET @sWhere2 = ''
SET @sWhere3 = ''

IF @IsDate = 0
BEGIN
	SET @sWhere = @sWhere + 'AND (Case When  OT2001.TranMonth <10 then ''0''+rtrim(ltrim(str(OT2001.TranMonth)))+''/''
										+ltrim(Rtrim(str(OT2001.TranYear))) Else rtrim(ltrim(str(OT2001.TranMonth)))+''/''
										+ltrim(Rtrim(str(OT2001.TranYear))) End) IN ('''+@PeriodIDList+''')'
	IF @IsDeclare = 1
		SET @sWhere2 = @sWhere2 + 'AND #TEMP1.TranMonth + #TEMP1.TranYear * 100 BETWEEN DATEPART(year, #TEMP22.FromDate)*100 + DATEPART(month, #TEMP22.FromDate) AND DATEPART(year, #TEMP22.ToDate)*100 + DATEPART(month, #TEMP22.ToDate)'
	IF @IsDeclare = 0
		SET @sWhere2 = @sWhere2 + 'AND #TEMP1.TranMonth + #TEMP1.TranYear * 100 BETWEEN DATEPART(year, AT0161.FromDate)*100 + DATEPART(month, AT0161.FromDate) AND DATEPART(year, AT0161.ToDate)*100 + DATEPART(month, AT0161.ToDate)'
	SET @sWhere3 = @sWhere3 + 'AND (Case When  DATEPART(month, AT0161.FromDate) <10 then ''0''+rtrim(ltrim(str(DATEPART(month, AT0161.FromDate))))+''/''
										+ltrim(Rtrim(str(DATEPART(year, AT0161.FromDate)))) Else rtrim(ltrim(str(DATEPART(month, AT0161.FromDate))))+''/''
										+ltrim(Rtrim(str(DATEPART(year, AT0161.FromDate)))) End) IN ('''+@PeriodIDList+''')'
END	
ELSE
BEGIN
	SET @sWhere = @sWhere + 'And (OT2001.OrderDate  BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''')'
	--SET @sWhere2 = @sWhere2 + 'AND #TEMP1.OrderDate BETWEEN AT0161.FromDate AND AT0161.ToDate'
	SET @sWhere3 = @sWhere3 + 'AND DATEPART(year, AT0161.FromDate)*100 + DATEPART(month, AT0161.FromDate) >= '+Convert(Nvarchar(10),DATEPART(year,@FromDate)*100 + DATEPART(month,@FromDate))+' AND DATEPART(year, AT0161.ToDate)*100 + DATEPART(month, AT0161.ToDate) <= '+Convert(Nvarchar(10),DATEPART(year,@ToDate)*100 + DATEPART(month,@ToDate))+''										
END	

IF @IsDeclare = 1
BEGIN
	------ Lấy số lượng hàng bán theo MPT đơn hàng bán		
	SET @sSQL = '
	SELECT OT2001.DivisionID,-- OT2001.OrderDate, 
	OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,  --AT1302.I04ID,     
		   SUM(ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0)) AS ConvertedAmountAfterVAT,   
		   SUM(ISNULL(OT2002.ConvertedAmount, 0)) AS ConvertedAmountAfterVAT2,    
		   OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	INTO #TEMP1		
	FROM OT2002 WITH (NOLOCK)
	LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID in (''@@@'',OT2002.DivisionID) AND OT2002.InventoryID = AT1302.InventoryID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',OT2001.DivisionID) AND AT1202.ObjectID = OT2001.ObjectID
	WHERE OT2002.DivisionID = '''+@DivisionID+'''
		  AND ISNULL(OT2002.IsProInventoryID,0) <> 1
		  AND ISNULL(OT2001.OrderStatus,0) = 1
		  AND ISNULL(OT2001.OrderType,0) = 0
		  AND ISNULL(AT1202.O01ID,'''') '+@StrArea+'
		  AND AT1302.I08ID '+@StrInventoryTypeID+'
		  AND OT2001.ObjectID '+@StrDealerID+'
		  AND OT2001.Ana05ID '+@StrQLADMIN+'
		  AND OT2001.Ana04ID '+@StrADMIN+'
		  AND OT2001.Ana03ID '+@StrASMID+'
		  AND OT2001.Ana02ID '+@StrSUPID+'
		  ' + @sWhere +'
		  AND ISNULL(OT2001.Ana02ID, '''') <> ''''
	GROUP BY OT2001.DivisionID, --OT2001.OrderDate, 
	OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,  --AT1302.I04ID,
			 OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	'

	SET @sSQL1 = '
	SELECT AT0161.DivisionID, AT0161.ObjectID, AT0161.FromDate, AT0161.ToDate,
	SUM(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth02,
	(ISNULL(AT0161.SalesQuarter,0)) AS SalesQuarter,
	AT0161.SOAna01ID, AT0161.SOAna02ID, AT0161.SOAna03ID,AT0161.SOAna04ID, AT0161.SOAna05ID, 
	AT0161.InventoryTypeID
	INTO #TEMP22
	FROM AT0161 WITH (NOLOCK)
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',AT0161.DivisionID) AND AT1202.ObjectID = AT0161.ObjectID
	WHERE ISNULL(AT1202.O01ID,'''') '+@StrArea+'
		  AND AT0161.InventoryTypeID '+@StrInventoryTypeID+'
		  AND AT0161.ObjectID '+@StrDealerID+'
		  AND AT0161.SOAna05ID '+@StrQLADMIN+'
		  AND AT0161.SOAna04ID '+@StrADMIN+'
		  AND AT0161.SOAna03ID '+@StrASMID+'
		  AND AT0161.SOAna02ID '+@StrSUPID+'
	'+@sWhere3+'
	GROUP BY AT0161.DivisionID, AT0161.ObjectID, AT0161.FromDate, AT0161.ToDate, 
	AT0161.SOAna01ID, AT0161.SOAna02ID, AT0161.SOAna03ID,AT0161.SOAna04ID, AT0161.SOAna05ID, 
	AT0161.InventoryTypeID,AT0161.SalesQuarter

	SELECT ISNULL(#TEMP22.DivisionID, #TEMP1.DivisionID) AS DivisionID, ISNULL(#TEMP22.ObjectID, #TEMP1.ObjectID) AS ObjectID, 
	AT1202.Note AS ObjectName, MAX(ISNULL(#TEMP22.SalesMonth02,0)) AS SalesMonth02,MAX(ISNULL(#TEMP22.SalesQuarter,0)) AS SalesQuarter,
	SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT,0)) AS ConvertedAmountAfterVAT, SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT2,0)) AS ConvertedAmountAfterVAT2,
	ISNULL(#TEMP22.SOAna01ID, #TEMP1.Ana01ID) AS Ana01ID, ISNULL(#TEMP22.SOAna02ID, #TEMP1.Ana02ID) AS Ana02ID, ISNULL(#TEMP22.SOAna03ID, #TEMP1.Ana03ID) AS Ana03ID, 
	ISNULL(#TEMP22.SOAna04ID, #TEMP1.Ana04ID) AS Ana04ID, ISNULL(#TEMP22.SOAna05ID, #TEMP1.Ana05ID) AS Ana05ID, 
	ISNULL(#TEMP22.InventoryTypeID, #TEMP1.I08ID) AS InventoryTypeID, FromDate, ToDate
	INTO #TEMP2
	FROM #TEMP22
	LEFT JOIN #TEMP1 ON #TEMP22.DivisionID in (''@@@'',#TEMP1.DivisionID) AND #TEMP22.InventoryTypeID = #TEMP1.I08ID AND #TEMP22.ObjectID = #TEMP1.ObjectID 
	AND #TEMP22.SOAna01ID = #TEMP1.Ana01ID AND #TEMP22.SOAna02ID = #TEMP1.Ana02ID AND #TEMP22.SOAna03ID = #TEMP1.Ana03ID 
	AND #TEMP22.SOAna04ID = #TEMP1.Ana04ID AND #TEMP22.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',ISNULL(#TEMP22.DivisionID, #TEMP1.DivisionID)) AND AT1202.ObjectID = ISNULL(#TEMP22.ObjectID, #TEMP1.ObjectID)
	WHERE ISNULL(AT1202.O01ID,'''') '+@StrArea+'
		  AND ISNULL(#TEMP22.InventoryTypeID, #TEMP1.I08ID) '+@StrInventoryTypeID+'
		  AND ISNULL(#TEMP22.ObjectID, #TEMP1.ObjectID) '+@StrDealerID+'
		  AND ISNULL(#TEMP22.SOAna05ID, #TEMP1.Ana05ID) '+@StrQLADMIN+'
	GROUP BY ISNULL(#TEMP22.DivisionID, #TEMP1.DivisionID), ISNULL(#TEMP22.ObjectID, #TEMP1.ObjectID), AT1202.Note, 
	ISNULL(#TEMP22.SOAna01ID, #TEMP1.Ana01ID), ISNULL(#TEMP22.SOAna02ID, #TEMP1.Ana02ID), ISNULL(#TEMP22.SOAna03ID, #TEMP1.Ana03ID), 
	ISNULL(#TEMP22.SOAna04ID, #TEMP1.Ana04ID), ISNULL(#TEMP22.SOAna05ID, #TEMP1.Ana05ID),
	ISNULL(#TEMP22.InventoryTypeID, #TEMP1.I08ID), FromDate, ToDate
	'

	SET @Period = N'
	, (Case When  DATEPART(month, FromDate) <10 then ''0''+rtrim(ltrim(str(DATEPART(month, FromDate))))+''/''
		 										+ltrim(Rtrim(str(DATEPART(year, FromDate)))) Else rtrim(ltrim(str(DATEPART(month, FromDate))))+''/''
		 										+ltrim(Rtrim(str(DATEPART(year, FromDate)))) End) AS Period'
	SET @GroupByPeriod = N'FromDate'
END
ELSE
BEGIN
	------ Lấy số lượng hàng bán theo MPT đơn hàng bán		
	SET @sSQL = '
	SELECT OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,        
		   SUM(ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0)) AS ConvertedAmountAfterVAT,   
		   SUM(ISNULL(OT2002.ConvertedAmount, 0)) AS ConvertedAmountAfterVAT2,    
		   OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	INTO #TEMP1		
	FROM OT2002 WITH (NOLOCK)
	LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID in (''@@@'',OT2002.DivisionID) AND OT2002.InventoryID = AT1302.InventoryID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',OT2001.DivisionID) AND AT1202.ObjectID = OT2001.ObjectID
	WHERE OT2002.DivisionID = '''+@DivisionID+'''
		  AND ISNULL(OT2002.IsProInventoryID,0) <> 1
		  AND ISNULL(OT2001.OrderStatus,0) = 1
		  AND ISNULL(OT2001.OrderType,0) = 0
		  AND ISNULL(AT1202.O01ID,'''') '+@StrArea+'
		  AND ISNULL(AT1302.I08ID,'''') '+@StrInventoryTypeID+'
		  AND ISNULL(OT2001.ObjectID,'''') '+@StrDealerID+'
		  AND ISNULL(OT2001.Ana05ID,'''') '+@StrQLADMIN+'
		  --AND ISNULL(OT2001.Ana04ID,'''') '+@StrADMIN+'
		  --AND ISNULL(OT2001.Ana03ID,'''') '+@StrASMID+'
		  --AND ISNULL(OT2001.Ana02ID,'''') '+@StrSUPID+'
		  ' + @sWhere +'
		  AND ISNULL(OT2001.Ana02ID, '''') <> ''''
	GROUP BY OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,
			 OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	'

	SET @sSQL1 = '
	SELECT #TEMP1.DivisionID, #TEMP1.ObjectID, AT1202.Note AS ObjectName, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth02,MAX(ISNULL(AT0161.SalesQuarter,0)) AS SalesQuarter,
	SUM(#TEMP1.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP1.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2,
	#TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID, #TEMP1.Ana04ID, #TEMP1.Ana05ID, #TEMP1.I08ID AS InventoryTypeID, TranMonth, TranYear
	INTO #TEMP2
	FROM #TEMP1
	LEFT JOIN AT0161 WITH (NOLOCK) ON AT0161.DivisionID in (''@@@'',#TEMP1.DivisionID) AND AT0161.InventoryTypeID = #TEMP1.I08ID AND AT0161.ObjectID = #TEMP1.ObjectID 
	AND AT0161.SOAna01ID = #TEMP1.Ana01ID AND AT0161.SOAna02ID = #TEMP1.Ana02ID AND AT0161.SOAna03ID = #TEMP1.Ana03ID AND AT0161.SOAna04ID = #TEMP1.Ana04ID AND AT0161.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',#TEMP1.DivisionID) AND AT1202.ObjectID = #TEMP1.ObjectID
	WHERE AT0161.DivisionID IS NULL 
	GROUP BY #TEMP1.DivisionID, #TEMP1.ObjectID, AT1202.Note, #TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID, #TEMP1.Ana04ID, #TEMP1.Ana05ID, #TEMP1.I08ID, TranMonth, TranYear
	'

	SET @Period = N'
	, CASE WHEN TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(CONVERT(NVARCHAR(10),TranMonth))) ELSE CONVERT(NVARCHAR(10),TranMonth) END
	  + ''/'' + CONVERT(NVARCHAR(10),TranYear) AS Period'
	SET @GroupByPeriod = N'TranMonth, TranYear'	
END

SET @sSQL2 = '
	SELECT #TEMP2.ObjectID, #TEMP2.ObjectName, SUM(ISNULL(#TEMP2.SalesMonth02,0)) AS SalesMonth02, (ISNULL(#TEMP2.SalesQuarter,0)) AS SalesQuarter,
	SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2,
	#TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName,
	#TEMP2.Ana02ID, O02.AnaName as AnaName02, O07.UserName as UserName02
	'+@Period+'
	FROM #TEMP2
	LEFT JOIN AT1015 ON AT1015.DivisionID in (''@@@'',#TEMP2.DivisionID) AND AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
	LEFT JOIN OT1002 O02 ON #TEMP2.DivisionID in (''@@@'',O02.DivisionID) AND O02.AnaID = #TEMP2.Ana02ID AND O02.AnaTypeID = ''S02''
	LEFT JOIN OT1005 O07 ON O07.DivisionID in (''@@@'',#TEMP2.DivisionID) AND O07.AnaTypeID LIKE ''S02''
	WHERE ISNULL(AT1015.AnaName,'''') <> ''''
	GROUP BY #TEMP2.Ana02ID, AT1015.AnaName, O02.AnaName, O07.UserName, #TEMP2.ObjectID, #TEMP2.ObjectName, #TEMP2.InventoryTypeID, AT1015.AnaName, #TEMP2.SalesQuarter, '+@GroupByPeriod+'
	ORDER BY '+@GroupByPeriod+', #TEMP2.InventoryTypeID, #TEMP2.Ana02ID
	'

SET @sSQL3 = '
SELECT #TEMP2.Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, 
O03.AnaName as AnaName03, NULL as AnaName04, NULL as AnaName05,  
O08.UserName as UserName03, NULL as UserName04, NULL as UserName05, #TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName,
SUM(#TEMP2.SalesMonth02) AS SalesMonth, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
'+@Period+'
FROM #TEMP2
LEFT JOIN OT1002 O03 ON #TEMP2.DivisionID in (''@@@'',O03.DivisionID) AND O03.AnaID = #TEMP2.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN OT1005 O08 ON O08.DivisionID in (''@@@'',#TEMP2.DivisionID) AND O08.AnaTypeID LIKE ''S03''
LEFT JOIN AT1015 ON AT1015.DivisionID in (''@@@'',#TEMP2.DivisionID) AND AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
WHERE ISNULL(#TEMP2.Ana03ID,'''') <> '''' AND ISNULL(AT1015.AnaName,'''') <> ''''
GROUP BY #TEMP2.Ana03ID, O03.AnaName, O08.UserName, #TEMP2.InventoryTypeID, AT1015.AnaName, '+@GroupByPeriod+'
UNION ALL
SELECT NULL AS Ana03ID, #TEMP2.Ana04ID AS Ana04ID, NULL AS Ana05ID, 
NULL as AnaName03, O04.AnaName as AnaName04, NULL as AnaName05,  
NULL as UserName03, O09.UserName as UserName04, NULL as UserName05, #TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName,
SUM(#TEMP2.SalesMonth02) AS SalesMonth, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
'+@Period+'
FROM #TEMP2
LEFT JOIN OT1002 O04 ON #TEMP2.DivisionID in (''@@@'',O04.DivisionID) AND O04.AnaID = #TEMP2.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN OT1005 O09 ON O09.DivisionID in (''@@@'',#TEMP2.DivisionID) AND O09.AnaTypeID LIKE ''S04''
LEFT JOIN AT1015 ON AT1015.DivisionID in (''@@@'',#TEMP2.DivisionID) AND AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
WHERE ISNULL(#TEMP2.Ana03ID,'''') <> '''' AND ISNULL(AT1015.AnaName,'''') <> ''''
GROUP BY #TEMP2.Ana04ID, O04.AnaName, O09.UserName, #TEMP2.InventoryTypeID, AT1015.AnaName, '+@GroupByPeriod+'
UNION ALL
SELECT NULL AS Ana03ID, NULL AS Ana04ID, #TEMP2.Ana05ID,
NULL as AnaName03, NULL as AnaName04, O05.AnaName as AnaName05,  
NULL as UserName03, NULL as UserName04, O10.UserName as UserName05, #TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName,
SUM(#TEMP2.SalesMonth02) AS SalesMonth, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
'+@Period+'
FROM #TEMP2
LEFT JOIN OT1002 O05 ON #TEMP2.DivisionID in (''@@@'',O05.DivisionID) AND O05.AnaID = #TEMP2.Ana05ID AND O05.AnaTypeID = ''S05''
LEFT JOIN OT1005 O10 ON O10.DivisionID in (''@@@'',#TEMP2.DivisionID) AND O10.AnaTypeID LIKE ''S05''
LEFT JOIN AT1015 ON AT1015.DivisionID in (''@@@'',#TEMP2.DivisionID) AND AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
WHERE ISNULL(#TEMP2.Ana03ID,'''') <> '''' AND ISNULL(AT1015.AnaName,'''') <> ''''
GROUP BY #TEMP2.Ana05ID, O05.AnaName, O10.UserName, #TEMP2.InventoryTypeID, AT1015.AnaName, '+@GroupByPeriod+'
ORDER BY Period, Ana03ID DESC, Ana04ID DESC, Ana05ID DESC
'

PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3
EXEC (@sSQL+ @sSQL1 + @sSQL2 + @sSQL3)	


















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
