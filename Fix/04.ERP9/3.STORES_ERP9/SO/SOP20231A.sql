IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20231A]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20231A]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load dữ liệu màn hình kế thừa phiếu báo giá Sale(SGNP).
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Đình hòa Date 03/08/2021
-- Update by : Đình Hoà Date 23/08/2021 : Bổ sung load mã khách hàng(ObjectID) và Bảng giá (PriceListID)
-- Update by : Kiều Nga Date 31/08/2021 : Bổ sung không load lại báo giá đã kế thừa và load báo giá kỹ thuật có check kế thừa sang báo giá kinh doanh

-- <Example>

 CREATE PROCEDURE [dbo].[SOP20231A] 
 (
	 @DivisionID NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @IsDate TINYINT, ---- 0: Radiobutton từ kỳ có check
					  ---- 1: Radiobutton từ ngày có check
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @VoucherNo VARCHAR(50),
	 @ObjectID NVARCHAR(MAX),
	 @PScreenID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX) ='',
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50),
		@sSQL1 NVARCHAR (MAX)



IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND S1.TranMonth + S1.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
		SET @sWhere = @sWhere + N'AND S1.VouCherDate >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'AND S1.VouCherDate <= '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND S1.VouCherDate BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''' '
END


IF ISNULL(@VoucherNo,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND S1.VoucherNo like ''%' + @VoucherNo + '%'''
END

IF ISNULL(@ObjectID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND ( S1.ObjectID Like ''%'+@ObjectID+'%'' OR S3.ObjectName  Like N''%'+@ObjectID+'%'' )'
END

IF @PScreenID = 'SOF2001'
BEGIN
SET @sSQL = 'SELECT DISTINCT
		 S1.APK, S1.DivisionID, S1.VouCherNo, S1.VouCherDate, S1.ExchangeRate, S1.Description, S1.Tel, S1.Address, S1.DeliveryAddress, S1.Transport, S1.Attention1, S1.Dear, S1.Attention2 
		, S2.FullName AS EmployeeName, S3.ObjectName,S4.Description AS OrderStatus, S5.Description AS IsConfirm, S6.Description AS IsSO, S1.ObjectID, S1.PriceListID, S1.Ana01ID, S1.ProjectAddress, S3.Note1 AS AccCoefficient
		,''SOF2001'' as ScreenID
		INTO  #TemSOT2120
		FROM SOT2120 S1 WITH(NOLOCK)
		LEFT JOIN AT1103 S2 WITH(NOLOCK) On S2.DivisionID IN (''@@@'', S1.DivisionID) AND S1.EmployeeID = S2.EmployeeID
		LEFT JOIN AT1202 S3 WITH(NOLOCK) On S3.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ObjectID = S3.ObjectID
		LEFT JOIN AT0099 S4 WITH(NOLOCK) On S1.OrderStatus = S4.ID AND S4.CodeMaster = ''AT00000003'' AND S4.Disabled = 0
		LEFT JOIN OOT0099 S5 WITH(NOLOCK) ON S1.IsConfirm = S5.ID AND S5.CodeMaster = ''Status'' AND S5.Disabled = 0		
		LEFT JOIN AT0099 S6 WITH(NOLOCK) On S1.IsSO = S6.ID AND S6.CodeMaster = ''AT00000004'' AND S6.Disabled = 0
		LEFT JOIN SOT2121 S7 WITH(NOLOCK) On S1.DivisionID = S7.DivisionID AND S1.APK = S7.APKMaster
		LEFT JOIN (SELECT DivisionID,InheritVoucherID,SUM(OrderQuantity) as OrderQuantity 
				  FROM OT2002 WITH(NOLOCK) WHERE InheritTableID =''SOT2121'' GROUP BY DivisionID,InheritVoucherID) S8 ON  S1.DivisionID = S8.DivisionID AND S7.APK = S8.InheritVoucherID
		WHERE S1.DivisionID = '''+@DivisionID+''''+ @sWhere +' AND S1.IsConfirm = 1 AND S1.QuoType = 2 AND S7.QuoQuantity >	ISNULL(S8.OrderQuantity,0)	
		'

SET @sSQL1 ='SELECT ROW_NUMBER() OVER (ORDER BY M.VouCherDate desc) AS RowNum, COUNT(*) OVER () AS TotalRow, M.*
	FROM #TemSOT2120 M '
END
ELSE 
IF @PScreenID = 'SOF2141KT'
BEGIN
SET @sSQL = 'SELECT DISTINCT
		 S1.APK, S1.DivisionID, S1.VouCherNo, S1.VouCherDate, S1.ExchangeRate, S1.Description, S1.Tel, S1.Address, S1.DeliveryAddress, S1.Transport, S1.Attention1, S1.Dear, S1.Attention2 
		, S2.FullName AS EmployeeName, S3.ObjectName,S4.Description AS OrderStatus, S5.Description AS IsConfirm, S6.Description AS IsSO, S1.ObjectID, S1.PriceListID, S1.Ana01ID, S1.ProjectAddress, S3.Note1 AS AccCoefficient
		,''SOF2141KT'' as ScreenID
		INTO  #TemSOT2120
		FROM SOT2120 S1 WITH(NOLOCK)
		LEFT JOIN AT1103 S2 WITH(NOLOCK) On S2.DivisionID IN (''@@@'', S1.DivisionID) AND S1.EmployeeID = S2.EmployeeID
		LEFT JOIN AT1202 S3 WITH(NOLOCK) On S3.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ObjectID = S3.ObjectID
		LEFT JOIN AT0099 S4 WITH(NOLOCK) On S1.OrderStatus = S4.ID AND S4.CodeMaster = ''AT00000003'' AND S4.Disabled = 0
		LEFT JOIN OOT0099 S5 WITH(NOLOCK) ON S1.IsConfirm = S5.ID AND S5.CodeMaster = ''Status'' AND S5.Disabled = 0		
		LEFT JOIN AT0099 S6 WITH(NOLOCK) On S1.IsSO = S6.ID AND S6.CodeMaster = ''AT00000004'' AND S6.Disabled = 0
		LEFT JOIN SOT2121 S7 WITH(NOLOCK) On S1.DivisionID = S7.DivisionID AND S1.APK = S7.APKMaster
		LEFT JOIN (SELECT DivisionID,InheritVoucherID,SUM(Quantity) as Quantity 
				   FROM SOT2141 WITH(NOLOCK) WHERE InheritTableID =''SOT2121'' GROUP BY DivisionID,InheritVoucherID) S8 ON  S1.DivisionID = S8.DivisionID AND S7.APK = S8.InheritVoucherID
		WHERE S1.DivisionID = '''+@DivisionID+''''+ @sWhere +' AND S1.QuoType = 1 AND S7.QuoQuantity >	ISNULL(S8.Quantity,0)
		AND S7.IsInherit = 1
		'

SET @sSQL1 ='SELECT ROW_NUMBER() OVER (ORDER BY M.VouCherDate desc) AS RowNum, COUNT(*) OVER () AS TotalRow, M.*
			FROM #TemSOT2120 M '
END
ELSE
IF @PScreenID = 'SOF2141SALE'
BEGIN
SET @sSQL = 'SELECT DISTINCT
		 S1.APK, S1.DivisionID, S1.VouCherNo, S1.VouCherDate, S1.ExchangeRate, S1.Description, S1.Tel, S1.Address, S1.DeliveryAddress, S1.Transport, S1.Attention1, S1.Dear, S1.Attention2 
		, S2.FullName AS EmployeeName, S3.ObjectName,S4.Description AS OrderStatus, S5.Description AS IsConfirm, S6.Description AS IsSO, S1.ObjectID, S1.PriceListID, S1.Ana01ID, S1.ProjectAddress, S3.Note1 AS AccCoefficient
		,''SOF2141SALE'' as ScreenID
		INTO  #TemSOT2120
		FROM SOT2120 S1 WITH(NOLOCK)
		LEFT JOIN AT1103 S2 WITH(NOLOCK) On S2.DivisionID IN (''@@@'', S1.DivisionID) AND S1.EmployeeID = S2.EmployeeID
		LEFT JOIN AT1202 S3 WITH(NOLOCK) On S3.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ObjectID = S3.ObjectID
		LEFT JOIN AT0099 S4 WITH(NOLOCK) On S1.OrderStatus = S4.ID AND S4.CodeMaster = ''AT00000003'' AND S4.Disabled = 0
		LEFT JOIN OOT0099 S5 WITH(NOLOCK) ON S1.IsConfirm = S5.ID AND S5.CodeMaster = ''Status'' AND S5.Disabled = 0		
		LEFT JOIN AT0099 S6 WITH(NOLOCK) On S1.IsSO = S6.ID AND S6.CodeMaster = ''AT00000004'' AND S6.Disabled = 0
		LEFT JOIN SOT2121 S7 WITH(NOLOCK) On S1.DivisionID = S7.DivisionID AND S1.APK = S7.APKMaster
		LEFT JOIN (SELECT DivisionID,InheritVoucherID,SUM(Quantity) as Quantity 
				   FROM SOT2141 WITH(NOLOCK) WHERE InheritTableID =''SOT2121'' GROUP BY DivisionID,InheritVoucherID) S8 ON  S1.DivisionID = S8.DivisionID AND S7.APK = S8.InheritVoucherID
		WHERE S1.DivisionID = '''+@DivisionID+''''+ @sWhere +' AND S1.IsConfirm = 1 AND S1.QuoType = 2 AND S7.QuoQuantity >	ISNULL(S8.Quantity,0)
		'

SET @sSQL1 ='SELECT ROW_NUMBER() OVER (ORDER BY M.VouCherDate desc) AS RowNum, COUNT(*) OVER () AS TotalRow, M.*
	FROM #TemSOT2120 M '
END
ELSE  
IF  @PScreenID = 'SOF2121'
BEGIN
SET @sSQL = 'SELECT DISTINCT
		 S1.APK, S1.DivisionID, S1.VouCherNo, S1.VouCherDate, S1.ExchangeRate, S1.Description, S1.Tel, S1.Address, S1.DeliveryAddress, S1.Transport, S1.Attention1, S1.Dear, S1.Attention2 
		, S2.FullName AS EmployeeName, S3.ObjectName,S4.Description AS OrderStatus, S5.Description AS IsConfirm, S6.Description AS IsSO, S1.ObjectID, S1.PriceListID, S1.Ana01ID, S1.ProjectAddress, S3.Note1 AS AccCoefficient
		,''SOF2121'' as ScreenID
		INTO  #TemSOT2120
		FROM SOT2120 S1 WITH(NOLOCK)
		LEFT JOIN AT1103 S2 WITH(NOLOCK) On S2.DivisionID IN (''@@@'', S1.DivisionID) AND S1.EmployeeID = S2.EmployeeID
		LEFT JOIN AT1202 S3 WITH(NOLOCK) On S3.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ObjectID = S3.ObjectID
		LEFT JOIN AT0099 S4 WITH(NOLOCK) On S1.OrderStatus = S4.ID AND S4.CodeMaster = ''AT00000003'' AND S4.Disabled = 0
		LEFT JOIN OOT0099 S5 WITH(NOLOCK) ON S1.IsConfirm = S5.ID AND S5.CodeMaster = ''Status'' AND S5.Disabled = 0		
		LEFT JOIN AT0099 S6 WITH(NOLOCK) On S1.IsSO = S6.ID AND S6.CodeMaster = ''AT00000004'' AND S6.Disabled = 0
		LEFT JOIN SOT2121 S7 WITH(NOLOCK) On S1.DivisionID = S7.DivisionID AND S1.APK = S7.APKMaster
		LEFT JOIN (SELECT DivisionID,InheritVoucherID,SUM(QuoQuantity) as QuoQuantity 
				  FROM SOT2121 WITH(NOLOCK) WHERE InheritTableID =''SOT2121'' GROUP BY DivisionID,InheritVoucherID) S8 ON  S1.DivisionID = S8.DivisionID AND S7.APK = S8.InheritVoucherID
		WHERE S1.DivisionID = '''+@DivisionID+''''+ @sWhere +' AND S1.QuoType = 1 AND S7.QuoQuantity >	ISNULL(S8.QuoQuantity,0)
		AND S7.IsInherit = 1
		'

SET @sSQL1 ='SELECT ROW_NUMBER() OVER (ORDER BY M.VouCherDate desc) AS RowNum, COUNT(*) OVER () AS TotalRow, M.*
			FROM #TemSOT2120 M '

END
PRINT(@sSQL)
PRINT(@sSQL1)

EXEC (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
