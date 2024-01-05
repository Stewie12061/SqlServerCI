IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30191]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30191]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--- Created by Nhựt Trường on 26/02/2022: Báo cáo tổng hợp doanh số sale out (CustomizeIndex = 57 ---- ANGEL)
--- Modified on 12/05/2022 by Nhựt Trường: Bổ sung trường Period để điều chỉnh nhóm theo kỳ khi in/xuất excel.
--- Modified on 04/07/2022 by Nhựt Trường: Bổ sung điều kiện kiểm tra khi các điều kiện lọc truyền vào là null.
--- Modified on 22/07/2022 by Nhựt Trường: Điều chỉnh lấy tiền thực hiện theo nguyên tệ thay quy đổi.
--- Modified on 29/07/2022 by Nhựt Trường: [2022/07/IS/0177] - Bổ sung sort lại dữ liệu.
--- Modified on 11/08/2022 by Nhựt Trường: Điều chỉnh lấy DealerID thay ObjectID khi lấy dữ liệu OT2001.
--- Modified on 23/11/2022 by Văn Tài	 : Fix lỗi luồng chuẩn.
--- Modified on 25/04/2023 by Tiến Thành : [2023/04/IS/0022] - Chỉnh sữa store lỗi không thể in xuất
--- Modified on 24/05/2023 by Anh Đô: Fix lỗi không lọc được theo Nhóm mặt hàng
--- Modified on 18/07/2023 by Nhựt Trường: [2023/07/IS/0208] - Fix lỗi sai cú pháp từ 'Modified on 25/04/2023 by Tiến Thành : [2023/04/IS/0022] - Chỉnh sữa store lỗi không thể in xuất'.
/*
 * exec SOP30191 'ANG', 201601, 201601, '01/01/2016', '01/31/2016', '', 'KPP.HAG.0001', 'KPP.HYE.0001', 'HMP', 'MPB' , 0
 */

CREATE PROCEDURE [dbo].[SOP30191] 
(
	@DivisionID			NVARCHAR(50),	--Biến môi trường
	@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME,
	@ListSaleID			NVARCHAR(MAX), 
	@ListDealerID		NVARCHAR(MAX), 
	@ListSUPID			NVARCHAR(MAX), 
	@ListASMID			NVARCHAR(MAX), 
	@ListInventoryID	NVARCHAR(MAX),
	@PeriodIDList		NVARCHAR(MAX)
)
AS
DECLARE @sSQL			NVARCHAR(MAX),
		@sSQL1			NVARCHAR(MAX),
		@sSQL2			NVARCHAR(MAX),
		@sWhere			NVARCHAR(MAX),
		@sWhere2		NVARCHAR(MAX),
		@sWhere3		NVARCHAR(MAX),
		@StrSaleID		NVARCHAR(MAX),
		@StrDealerID	NVARCHAR(MAX),
		@StrSUPID		NVARCHAR(MAX),
		@StrASMID		NVARCHAR(MAX),
		@StrInventoryID	NVARCHAR(MAX),
		@CustomerName	INT

--- SALE
IF CHARINDEX('%',@ListSaleID) > 0 OR ISNULL(@ListSaleID,'') = ''
BEGIN
	SET @StrSaleID = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrSaleID = N'IN ('''+@ListSaleID+''')'
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

---- InventoryID
IF CHARINDEX('%',@ListInventoryID) > 0 OR ISNULL(@ListInventoryID,'') = ''
BEGIN
	SET @StrInventoryID = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrInventoryID = N'IN ('''+@ListInventoryID+''')'
END

SET @CustomerName = (Select top 1 CustomerName from CustomerIndex)
SET @sWhere = ''
SET @sWhere2 = ''
SET @sWhere3 = ''

IF @IsDate = 0
BEGIN
	SET @sWhere = @sWhere + 'AND (Case When  OT2001.TranMonth <10 then ''0''+rtrim(ltrim(str(OT2001.TranMonth)))+''/''
										+ltrim(Rtrim(str(OT2001.TranYear))) Else rtrim(ltrim(str(OT2001.TranMonth)))+''/''
										+ltrim(Rtrim(str(OT2001.TranYear))) End) IN ('''+@PeriodIDList+''')'
	SET @sWhere2 = @sWhere2 + 'AND #TEMP1.TranMonth + #TEMP1.TranYear * 100 BETWEEN DATEPART(year, AT0161.FromDate)*100 + DATEPART(month, AT0161.FromDate) AND DATEPART(year, AT0161.ToDate)*100 + DATEPART(month, AT0161.ToDate)'
	SET @sWhere3 = @sWhere3 + 'AND (Case When  DATEPART(month, AT0161.FromDate) <10 then ''0''+rtrim(ltrim(str(DATEPART(month, AT0161.FromDate))))+''/''
										+ltrim(Rtrim(str(DATEPART(year, AT0161.FromDate)))) Else rtrim(ltrim(str(DATEPART(month, AT0161.FromDate))))+''/''
										+ltrim(Rtrim(str(DATEPART(year, AT0161.FromDate)))) End) IN ('''+@PeriodIDList+''')'								
END	
ELSE
BEGIN
	SET @sWhere = @sWhere + 'And (convert(nvarchar(10),OT2001.OrderDate,21)  BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''')'
	SET @sWhere2 = @sWhere2 + 'AND #TEMP1.OrderDate BETWEEN AT0161.FromDate AND AT0161.ToDate'	
	SET @sWhere3 = @sWhere3 + 'AND DATEPART(year, AT0161.FromDate)*100 + DATEPART(month, AT0161.FromDate) >= '+Convert(Nvarchar(10),DATEPART(year,@FromDate)*100 + DATEPART(month,@FromDate))+' AND DATEPART(year, AT0161.ToDate)*100 + DATEPART(month, AT0161.ToDate) <= '+Convert(Nvarchar(10),DATEPART(year,@ToDate)*100 + DATEPART(month,@ToDate))+''							
END	

------ Lấy số lượng hàng bán theo MPT don hàng bán		
SET @sSQL = '
SELECT	OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID, AT1302.I04ID,   
		SUM(ISNULL(OT2002.OriginalAmount, 0) + ISNULL(OT2002.VATOriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(DiscountSaleAmountDetail, 0)) AS ConvertedAmountAfterVAT,
		OT2002.InventoryID, OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID--, OT2001.Ana04ID, OT2001.Ana05ID
INTO #TEMP1		
FROM OT2002 WITH (NOLOCK)
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (OT2002.DivisionID,''@@@'') AND OT2002.InventoryID = AT1302.InventoryID
WHERE OT2002.DivisionID = '''+@DivisionID+'''
	AND ISNULL(OT2002.IsProInventoryID,0) <> 1
	AND ISNULL(OT2001.OrderStatus,0) = 1
	AND ISNULL(OT2001.OrderType,0) = 0
	'+ CASE WHEN ISNULL(@ListDealerID, '') != '' THEN +'AND OT2001.DealerID '+ @StrDealerID ELSE '' END +
	'AND ISNULL(OT2001.Ana01ID, '''') '+@StrSaleID+'
	AND ISNULL(OT2001.Ana02ID, '''') '+@StrSUPID+'
	AND ISNULL(OT2001.Ana03ID, '''') '+@StrASMID+'	
	AND ISNULL(AT1302.I04ID, '''') '+@StrInventoryID+'	AND ISNULL(OT2002.InventoryID, '''') '+@StrInventoryID+'	
	AND ISNULL(AT1302.I04ID,'''') <> '''' AND ISNULL(AT1302.I08ID,'''') <> ''''	
	AND ISNULL(OT2001.Ana01ID, '''') <> '''' AND ISNULL(OT2001.Ana02ID, '''') <> '''' AND ISNULL(OT2001.Ana03ID, '''') <> ''''
	'+ @sWhere +'
GROUP BY OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID, AT1302.I04ID,   
		 OT2002.InventoryID, OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID--, OT2001.Ana04ID, OT2001.Ana05ID
'	

IF @CustomerName = 57 OR @CustomerName = 157
	SET @sSQL1 = '
	SELECT ISNULL(#TEMP1.DivisionID,AT0161.DivisionID) AS DivisionID, ISNULL(#TEMP1.ObjectID, AT0161.ObjectID) AS ObjectID,
	ISNULL(#TEMP1.I04ID, AT0161.InventoryTypeID2) AS I04ID, ISNULL(#TEMP1.I08ID, AT0161.InventoryTypeID) AS I08ID,
	MAX(ISNULL(AT0161.Amount,0)) AS SalesMonth01, MAX(ISNULL(AT0161.Amount,0)) AS SalesMonth02, MAX(ISNULL(AT0161.Amount,0)) AS SalesMonth03, 
	--MAX(ISNULL(AT0161.Amount,0)) AS SalesMonth04, MAX(ISNULL(AT0161.Amount,0)) AS SalesMonth05,
	SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT,0)) AS ConvertedAmountAfterVAT, 
	ISNULL(#TEMP1.Ana01ID, AT0161.SOAna01ID) AS Ana01ID, 
	ISNULL(#TEMP1.Ana02ID, AT0161.SOAna02ID) AS Ana02ID, 
	ISNULL(#TEMP1.Ana03ID, AT0161.SOAna03ID) AS Ana03ID,
	--ISNULL(#TEMP1.Ana04ID, AT0161.SOAna04ID) AS Ana04ID, 
	--ISNULL(#TEMP1.Ana05ID, AT0161.SOAna05ID) AS Ana05ID,
	CASE WHEN ISNULL(TranMonth,'''') <> '''' 
	THEN
			  CASE WHEN TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(CONVERT(NVARCHAR(10),TranMonth))) ELSE CONVERT(NVARCHAR(10),TranMonth) END
			  		  + ''/'' + CONVERT(NVARCHAR(10),TranYear)
	ELSE
			 CASE WHEN MonthFromDate < 10 THEN ''0'' + RTRIM(LTRIM(CONVERT(NVARCHAR(10),MonthFromDate))) ELSE CONVERT(NVARCHAR(10),MonthFromDate) END
			 		  + ''/'' + CONVERT(NVARCHAR(10),YearFromDate)
	END AS Period
	INTO #TEMP2
	FROM #TEMP1 WITH (NOLOCK)
	FULL JOIN (SELECT DivisionID, SUM(SalesMonth) AS Amount, InventoryTypeID, InventoryTypeID2, ObjectID, 
				SOAna01ID, SOAna02ID, SOAna03ID,-- SOAna04ID, SOAna05ID,
				DATEPART(month, AT0161.FromDate) AS MonthFromDate, DATEPART(year, AT0161.FromDate) AS YearFromDate,
				DATEPART(month, AT0161.ToDate) AS MonthToDate, DATEPART(year, AT0161.ToDate) AS YearToDate,
				AT0161.FromDate, AT0161.ToDate
				FROM AT0161 
				WHERE DivisionID = '''+@DivisionID+'''
				AND ObjectID '+@StrDealerID+'
				AND ISNULL(SOAna01ID, '''') '+@StrSaleID+'
				AND ISNULL(SOAna02ID, '''') '+@StrSUPID+'
				AND ISNULL(SOAna03ID, '''') '+@StrASMID+'
				AND ISNULL(AT0161.InventoryTypeID,'''') <> '''' AND  ISNULL(AT0161.InventoryTypeID2,'''') <> ''''
				'+ @sWhere3 +'
				GROUP BY DivisionID, InventoryTypeID, InventoryTypeID2, ObjectID, SOAna01ID, SOAna02ID, SOAna03ID,-- SOAna04ID, SOAna05ID
				         FromDate, AT0161.ToDate) AT0161 ON AT0161.DivisionID = #TEMP1.DivisionID AND AT0161.InventoryTypeID = #TEMP1.I08ID AND AT0161.InventoryTypeID2 = #TEMP1.I04ID AND AT0161.ObjectID = #TEMP1.ObjectID 
	AND AT0161.SOAna01ID = #TEMP1.Ana01ID AND AT0161.SOAna02ID = #TEMP1.Ana02ID AND AT0161.SOAna03ID = #TEMP1.Ana03ID --AND AT0161.SOAna04ID = #TEMP1.Ana04ID AND AT0161.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID = #TEMP1.DivisionID AND AT1202.ObjectID = #TEMP1.ObjectID
	GROUP BY ISNULL(#TEMP1.DivisionID,AT0161.DivisionID), 
	ISNULL(#TEMP1.ObjectID, AT0161.ObjectID),
	ISNULL(#TEMP1.I04ID, AT0161.InventoryTypeID2), 
	ISNULL(#TEMP1.I08ID, AT0161.InventoryTypeID),
	ISNULL(#TEMP1.Ana01ID, AT0161.SOAna01ID),
	ISNULL(#TEMP1.Ana02ID, AT0161.SOAna02ID),
	ISNULL(#TEMP1.Ana03ID, AT0161.SOAna03ID),
	--ISNULL(#TEMP1.Ana04ID, AT0161.SOAna04ID),
	--ISNULL(#TEMP1.Ana05ID, AT0161.SOAna05ID)
	TranMonth, TranYear, MonthFromDate, YearFromDate
	ORDER BY ISNULL(#TEMP1.I04ID, AT0161.InventoryTypeID2), ISNULL(#TEMP1.I08ID, AT0161.InventoryTypeID)
	'
ELSE
	SET @sSQL1 = '
	SELECT #TEMP1.DivisionID, #TEMP1.ObjectID,
	#TEMP1.I04ID, #TEMP1.I08ID,
	MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth01, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth02, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth03, 
	--MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth04, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth05,
	SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT,0)) AS ConvertedAmountAfterVAT, 
	#TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID,-- #TEMP1.Ana04ID, #TEMP1.Ana05ID,
	(CASE WHEN TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(CONVERT(NVARCHAR(10),TranMonth))) ELSE CONVERT(NVARCHAR(10),TranMonth) END)
			  + ''/'' + CONVERT(NVARCHAR(10),TranYear) AS Period
	INTO #TEMP2
	FROM #TEMP1
	LEFT JOIN AT0161 ON AT0161.DivisionID = #TEMP1.DivisionID AND AT0161.InventoryTypeID = #TEMP1.I08ID AND AT0161.InventoryTypeID2 = #TEMP1.I04ID AND AT0161.ObjectID = #TEMP1.ObjectID 
	AND AT0161.SOAna01ID = #TEMP1.Ana01ID AND AT0161.SOAna02ID = #TEMP1.Ana02ID AND AT0161.SOAna03ID = #TEMP1.Ana03ID-- AND AT0161.SOAna04ID = #TEMP1.Ana04ID AND AT0161.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = #TEMP1.ObjectID
	/** WHERE '+@sWhere3+'
	**/
	GROUP BY #TEMP1.DivisionID, #TEMP1.ObjectID,
	#TEMP1.I04ID, #TEMP1.I08ID,
	#TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID,-- #TEMP1.Ana04ID, #TEMP1.Ana05ID,
	TranMonth, TranYear
	'

SET @sSQL2 = '
SELECT 
DivisionID, I08ID, I04ID, ObjectID, SUM(SalesMonth01) AS SalesMonth01, SUM(SalesMonth02) AS SalesMonth02, SUM(SalesMonth03) AS SalesMonth03, SUM(ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, 
Ana01ID, Ana02ID, Ana03ID, Period, ObjectName, InventoryTypeName, InventoryTypeName2,
AnaName01, AnaName02, AnaName03, UserName01, UserName02, UserName03
FROM (
	SELECT #TEMP2.DivisionID, ISNULL(A1.FatherObjectID, #TEMP2.ObjectID) AS ObjectID,
	#TEMP2.I04ID, #TEMP2.I08ID, #TEMP2.SalesMonth01, #TEMP2.SalesMonth02,#TEMP2.SalesMonth03,
	SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, 
	#TEMP2.Ana01ID, #TEMP2.Ana02ID, #TEMP2.Ana03ID, #TEMP2.Period,  
	(SELECT TOP 1 ObjectName FROM AT1202 WITH(NOLOCK) WHERE ObjectID = ISNULL(A1.FatherObjectID, #TEMP2.ObjectID)) AS ObjectName, A4.AnaName as InventoryTypeName, A5.AnaName as InventoryTypeName2,
	O01.AnaName as AnaName01, O02.AnaName as AnaName02, O03.AnaName as AnaName03,-- O04.AnaName as AnaName04, O05.AnaName as AnaName05,  
	O06.UserName as UserName01, O07.UserName as UserName02, O08.UserName as UserName03--, O09.UserName as UserName04, O10.UserName as UserName05
	
	FROM #TEMP2
	LEFT JOIN AT1202 A1 ON #TEMP2.ObjectID = A1.ObjectID
	LEFT JOIN AT1015 A4 ON #TEMP2.I04ID = A4.AnaID AND A4.AnaTypeID = ''I04''
	LEFT JOIN AT1015 A5 ON #TEMP2.I08ID = A5.AnaID AND A5.AnaTypeID = ''I08''
	LEFT JOIN OT1002 O01 ON #TEMP2.DivisionID = O01.DivisionID AND O01.AnaID = #TEMP2.Ana01ID AND O01.AnaTypeID = ''S01''
	LEFT JOIN OT1002 O02 ON #TEMP2.DivisionID = O02.DivisionID AND O02.AnaID = #TEMP2.Ana02ID AND O02.AnaTypeID = ''S02''
	LEFT JOIN OT1002 O03 ON #TEMP2.DivisionID = O03.DivisionID AND O03.AnaID = #TEMP2.Ana03ID AND O03.AnaTypeID = ''S03''
	--LEFT JOIN OT1002 O04 ON #TEMP2.DivisionID = O04.DivisionID AND O04.AnaID = #TEMP2.Ana04ID AND O04.AnaTypeID = ''S04''
	--LEFT JOIN OT1002 O05 ON #TEMP2.DivisionID = O05.DivisionID AND O05.AnaID = #TEMP2.Ana05ID AND O05.AnaTypeID = ''S05''
	LEFT JOIN OT1005 O06 ON O06.DivisionID = #TEMP2.DivisionID AND O06.AnaTypeID LIKE ''S01''
	LEFT JOIN OT1005 O07 ON O07.DivisionID = #TEMP2.DivisionID AND O07.AnaTypeID LIKE ''S02''
	LEFT JOIN OT1005 O08 ON O08.DivisionID = #TEMP2.DivisionID AND O08.AnaTypeID LIKE ''S03''
	--LEFT JOIN OT1005 O09 ON O09.DivisionID = #TEMP2.DivisionID AND O09.AnaTypeID LIKE ''S04''
	--LEFT JOIN OT1005 O10 ON O10.DivisionID = #TEMP2.DivisionID AND O10.AnaTypeID LIKE ''S05''
	
	GROUP BY #TEMP2.DivisionID, ISNULL(A1.FatherObjectID, #TEMP2.ObjectID),
	#TEMP2.I04ID, #TEMP2.I08ID, #TEMP2.SalesMonth01, #TEMP2.SalesMonth02,#TEMP2.SalesMonth03,
	#TEMP2.Ana01ID, #TEMP2.Ana02ID, #TEMP2.Ana03ID, #TEMP2.Period, A4.AnaName, A5.AnaName,
	O01.AnaName, O02.AnaName, O03.AnaName, O06.UserName, O07.UserName, O08.UserName) A
GROUP BY DivisionID, I08ID, I04ID, ObjectID, Ana01ID, Ana02ID, Ana03ID, Period, ObjectName, InventoryTypeName,
		 InventoryTypeName2, AnaName01, AnaName02, AnaName03, UserName01, UserName02, UserName03
Order by DivisionID, ObjectID, I08ID, I04ID, Ana03ID, Ana02ID'


PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
EXEC (@sSQL + @sSQL1 + @sSQL2)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO