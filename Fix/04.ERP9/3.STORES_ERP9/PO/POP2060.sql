IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2060]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2060]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load truy vấn Book Cont đơn hàng xuất khẩu
 -- <Return>
 ---- 
 -- <Reference>
 ---- PO ERP9.0 \ Nghiệp vụ \ Book Cont đơn hàng xuất khẩu (POF2060)
 -- <History>
 ----Created by Văn Tài on 03/07/2018

 /*-- <Example>

 	EXEC POP2060 
	@DivisionID = N'MTH'
   , @UserID = N'ASOFTADMIN'
   , @PageNumber = N'1'
   , @PageSize = N'50'
   , @IsDate = N'1'
   , @FromDate = N'2019-12-31'
   , @ToDate = N'2019-12-31'
   , @PeriodList = N'11/2019'',''12/2019'
   , @DivisionList = N'MTH'
   , @VoucherNo = N''
   , @ObjectName = N''
   , @ShipBrand = N''
   , @PortName = N''
   , @SearchWhere = N''

 ----*/
 
CREATE PROCEDURE POP2060
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @PageNumber INT,
  @PageSize INT,
  @IsDate INT,
  @FromDate DATETIME,
  @ToDate DATETIME,
  @PeriodList VARCHAR(MAX),
  @DivisionList VARCHAR(MAX),
  @VoucherNo VARCHAR(50),
  @ObjectName NVARCHAR(100),
  @ShipBrand NVARCHAR(100),
  @PortName NVARCHAR(100),
  @SearchWhere NVARCHAR(Max) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
) 
AS
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N''

-- Order | Page
SET @OrderBy = 'Temp.VoucherDate, Temp.VoucherNo'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

--- DivisionID
IF ISNULL(@DivisionList, '') <> ''
BEGIN
	SET @sWhere = @sWhere + ' T1.DivisionID IN (''' + @DivisionList + ''')
	'
END
ELSE 
	SET @sWhere = @sWhere + ' T1.DivisionID = ''' + @DivisionID + ''' 
	' 

-- Từ ngày | Theo kỳ
IF ISNULL(@IsDate, 0) = 1
BEGIN

	SET @sWhere = @sWhere + ' AND T1.VoucherDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 120) 
						  + ' '' AND ''' + CONVERT(VARCHAR(10), @ToDate,120) + ''' 
	'
END
ELSE
BEGIN
	-- Danh sách kỳ
	IF ISNULL(@PeriodList, '') <> ''
	BEGIN
		SET @sWhere = @sWhere + N' AND (
										 CASE WHEN T1.TranMonth < 10 
											  THEN N''0'' + LTRIM(RTRIM(STR(T1.TranMonth))) 
											  ELSE LTRIM(RTRIM(STR(T1.TranMonth))) 
											  END 
										  + N''/'' + LTRIM(RTRIM(STR(T1.TranYear)))  
										  IN (''' + @PeriodList + ''')  
										)
		'
	END
END

-- Số phiếu
IF ISNULL(@VoucherNo, '') <> ''
BEGIN
	SET @sWhere = @sWhere + N' AND T1.VoucherNo LIKE N''%' + @VoucherNo + '%'' 
	'
END

-- TODO Khách hàng

-- Hãng tàu
IF ISNULL(@ShipBrand, '') <> ''
BEGIN
	SET @sWhere = @sWhere + N' AND T1.ShipBrand LIKE N''%' + @ShipBrand + '%'' 
	'
END

-- Cảng
IF ISNULL(@PortName, '') <> ''
BEGIN
	SET @sWhere = @sWhere + N' AND T1.PortName LIKE N''%' + @PortName + '%'' 
	'
END

SET @sWhere = @sWhere + N' AND T1.DeleteFlag = 0
' 

-- Nếu có lọc nâng cao thì không dùng các lọc theo control.
IF ISNULL(@SearchWhere,'') <> ''
BEGIN
	SET  @sWhere=' 1 = 1 
	'
END
	
BEGIN
	SET @sSQL = 'SELECT DISTINCT
	T1.DivisionID
	, T1.APK
	, T1.VoucherNo
	, T1.VoucherDate
	, SUBSTRING((SELECT '' , '' + T62.ObjectID AS [text()]
            FROM 
				(
					SELECT DISTINCT T02.ObjectID
					FROM POT2062 T02
					WHERE T02.DivisionID = T1.DivisionID
							AND T02.APKMaster = T1.APK
				) T62
            ORDER BY T62.ObjectID
            FOR XML PATH ('''')
        ), 3, 1000) 
		AS ObjectName
	, T1.DepartureDate
	, T1.ArrivalDate
	, T1.PortName
	, T1.Closingtime
	, T1.Forwarder
	, T1.ShipBrand
	, T1.ContQuantity
	, T1.Description
	, T1.CreateDate
	, T1.CreateUserID
	, T1.LastModifyDate
	, T1.LastModifyUserID
	INTO #POP2060
	FROM POT2061 T1
	WHERE 
	' 
	+ @sWhere 

	+ ' 
	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum
	, ' + @TotalRow + ' AS TotalRow
	, * 
	FROM #POP2060 AS Temp
	' + CASE WHEN ISNULL(@SearchWhere, '') <> '' 
			 THEN @SearchWhere 
			 ELSE '' 
		END+'
	ORDER BY ' + @OrderBy + ' 
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY'

	PRINT(@sSQL)
	EXEC(@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
