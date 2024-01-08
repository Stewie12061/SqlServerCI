IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP3014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP3014]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo: Book-cont đơn hàng xuất khẩu.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Văn Tài on 06/01/2019
----Modify on 02/02/2021 by Kiều Nga: chuyển control từ kỳ, đến kỳ sang chọn kỳ
----Modify on 14/02/2023 by Anh Đô: Cập nhật giá trị cột Booking từ 'x' và 'o' sang 'Đã đặt' và 'Chưa đặt'
-- <Example>
---- 
/*-- <Example>
	
----*/

CREATE PROCEDURE POP3014
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @DivisionIDList	NVARCHAR(MAX),
	 @IsDate INT, ---- 1: là ngày, 0: là kỳ
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @PeriodList NVARCHAR(MAX)='',	
	 @VoucherNo VARCHAR(50),
	 @ObjectID NVARCHAR(250) =''
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
SET @OrderBy = 'T1.VoucherNo'

--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhere = ' AND T1.DivisionID IN ('''+@DivisionIDList+''')'
ELSE 
	SET @sWhere = ' AND T1.DivisionID = N'''+@DivisionID+''''	

IF @IsDate = 1 
	BEGIN
	SET @sWhere = @sWhere +  ' AND (CASE WHEN T1.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T1.TranMonth)))+''/''+ltrim(Rtrim(str(T1.TranYear))) IN ('''+@PeriodList +''')'
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

-- Khách hàng
IF ISNULL(@ObjectID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND T1.ObjectID IN (''' + @ObjectID + ''')'
	END

--IF ISNULL(@ConditionOpportunityID, '') != ''
--	SET @sWhere = @sWhere + ' AND ISNULL(T1.CreateUserID,'''') IN (N'''+@ConditionOpportunityID+''' )'

--Phan quyen theo nghiep vu
SET @sWhere = @sWhere + dbo.GetPermissionVoucherNo(@UserID,'T1.VoucherNo')

SET @sSQL = @sSQL + N'
		SELECT DISTINCT T1.VoucherNo
		, T61.PackedTime
		, T61.DepartureDate
		, T61.ArrivalDate
		, T61.PortName
		, T61.ClosingTime
		, T61.Forwarder
		, T61.ShipBrand
		, T61.ContQuantity
		, T1.ObjectName
		, CASE WHEN (T61.VoucherNo IS NULL) THEN N''Chưa đặt'' ELSE N''Đã đặt'' END AS Booking
		INTO #OT2001
		FROM OT2001 T1 WITH (NOLOCK) 
			LEFT JOIN OT2002 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID
													AND T2.SOrderID = T1.SOrderID
			LEFT JOIN POT2062 T62 WITH (NOLOCK) ON T62.DivisionID = T1.DivisionID AND T62.SOrderID = T1.SOrderID
			LEFT JOIN POT2061 T61 WITH (NOLOCK) ON T61.DivisionID = T62.DivisionID AND T61.APK = T62.APKMaster
		' + @sJoin + '	
		WHERE ISNULL(T1.OrderStatus, 0) = 1 
			'

		+@sWhere + '
		ORDER BY ' + @OrderBy

SET @sSQL1 = N' '
	

SET @sSQL2 = ' 
	SELECT ROW_NUMBER() OVER (ORDER BY T1.VoucherNo) AS RowNum
	, T1.*
	FROM #OT2001 T1
	ORDER BY ' + @OrderBy



SET @sSQL3 = N'	'

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
