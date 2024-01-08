IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---		Load màn hình Danh mục phiếu yêu cầu khách hàng (CRMF2100)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Học Huy, Date: 02/12/2019
--- Modified on 17/04/2020 by Kiều Nga: Chỉnh lại đk lọc Sản phẩm
--- Modified on 06/09/2022 by Hoài Bảo: Cập nhật điều kiện lọc theo ngày, kỳ
/* <Example>
EXEC CRMP2100 @DivisionID=N'MTH',@DivisionIDList=N'',
	@FromDate='2020-01-06 00:00:00',@ToDate='2020-01-06 00:00:00',
	@PeriodIDList=N'',@VoucherNo=N'',@ObjectID=N'',@InventoryID=N'',@PaperTypeID=N'',
	@APKList=NULL,@IsPeriod=0,@IsExcel=0,
	@PageNumber=1,@PageSize=25,@SearchWhere=N''
*/
 CREATE PROCEDURE CRMP2100
(
 	@DivisionID VARCHAR(50),
    @DivisionIDList NVARCHAR(2000),
    @PageNumber INT,
    @PageSize INT,
	@IsPeriod TINYINT, -- 1:Datetime; 0:Period
    @FromDate DATETIME,
    @ToDate DATETIME,
	@PeriodIDList NVARCHAR(MAX),
	@VoucherNo NVARCHAR(50),
	@ObjectID NVARCHAR(50),
	@InventoryID NVARCHAR(250),
	@PaperTypeID NVARCHAR(250),
	@IsExcel BIT, -- 1: Thực hiện xuất file Excel; 0: Thực hiện load danh sách
	@APKList NVARCHAR(MAX),
	@SearchWhere NVARCHAR(MAX) = NULL --- # NULL: Lọc nâng cao; = NULL: Lọc thường
	--@ConditionID NVARCHAR(MAX)
)
AS
DECLARE @sSQL01 NVARCHAR (MAX),
		@sJoin VARCHAR(MAX) = '',
        @sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

		IF  @PageNumber = 1 
			SET @TotalRow = 'COUNT(*) OVER ()' 
		ELSE 
			SET @TotalRow = 'NULL'
      	SET @sWhere = ' 1 = 1 '
	    SET @OrderBy = 'CreateDate DESC'

		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
		SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
/*
IF @APKList IS NOT NULL
BEGIN
	CREATE TABLE #TAM (APK VARCHAR(50))
	INSERT INTO #TAM (APK)
	SELECT X.Data.query('APK').value('.', 'VARCHAR(50)') AS APK
	FROM @APKList.nodes('//Data') AS X (Data)
END	
	*/
IF ISNULL(@SearchWhere, '') = '' --Lọc thường
	BEGIN
		-- Nếu DivisionIDList bằng rỗng thì lấy DivisionID 
		IF ISNULL(@DivisionIDList, '') != '' 
			SET @sWhere = @sWhere + '
		AND C00.DivisionID IN (''' + @DivisionIDList + ''')'
		ELSE 
			SET @sWhere = @sWhere + '
		AND C00.DivisionID IN (''' + @DivisionID + ''')'

		IF ISNULL(@VoucherNo, '') != ''
			SET @sWhere = @sWhere + ' 
		AND ISNULL(C00.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '

		IF ISNULL(@ObjectID, '') != ''
			SET @sWhere = @sWhere + ' 
		AND (ISNULL(C00.ObjectID, '''')  LIKE N''%' + @ObjectID + '%''
			OR ISNULL(A22.ObjectName, '''')  LIKE N''%' + @ObjectID + '%'')'
		
		IF ISNULL(@InventoryID, '') != ''
			SET @sWhere = @sWhere + ' 
		AND (ISNULL(C01.InventoryID, '''') LIKE N''%' + @InventoryID + '%'' 
		OR ISNULL(A32.InventoryName, '''')  LIKE N''%' + @InventoryID + '%'')'

		IF ISNULL(@PaperTypeID, '') != ''
			SET @sWhere = @sWhere + ' 
		AND ISNULL(C01.PaperTypeID, '''')  LIKE N''%' + @PaperTypeID + '%'' '

		--IF @IsPeriod = 0
		--	SET @sWhere = @sWhere + ' 
		--AND CONVERT(VARCHAR(10),C00.VoucherDate,112) 
		--	BETWEEN ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' AND ' + CONVERT(VARCHAR(10), @ToDate, 112) + ' '
		--IF @IsPeriod = 1
		--	SET @sWhere = @sWhere + ' 
		--AND 
		--	(
		--		CASE WHEN MONTH(C00.VoucherDate) < 10 THEN ''0'' 
		--			+ RTRIM(LTRIM(STR(MONTH(C00.VoucherDate)))) + ''/'' 
		--			+ LTRIM(RTRIM(STR(YEAR(C00.VoucherDate)))) 
		--		ELSE RTRIM(LTRIM(STR(MONTH(C00.VoucherDate))))+''/'' 
		--			+ LTRIM(RTRIM(STR(YEAR(C00.VoucherDate)))) END
		--	) IN (''' + @PeriodIDList + ''')'
		-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (C00.VoucherDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (C00.VoucherDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (C00.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodIDList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(C00.VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodIDList + ''') '
		END


		IF ISNULL(@InventoryID, '') != '' OR ISNULL(@PaperTypeID, '') != ''

		--BEGIN 
		--	SET @sJoin = @sJoin + ''
		--END
		
		-- Nếu giá trị NULL thì set về rỗng
		SET @SearchWhere = ISNULL(@SearchWhere, '')
	END

--IF ISNULL(ConditionID, '') != ''
--	SET @sWhere = @sWhere + ' AND ISNULL(C00.CreateUserID,'''') IN (N'''+ConditionID+''' )'

--Lấy Distinct
SET @sSQL01 = N'	
	SELECT C00.CreateDate, C00.APK, C00.DivisionID, C00.VoucherNo, C00.VoucherDate, C00.ObjectID, A22.ObjectName,
		C01.InventoryID, A32.InventoryName, C01.PaperTypeID, C99.Description, C01.ActualQuantity
	INTO #CRMP2100
	FROM CRMT2100 C00 WITH (NOLOCK)
		LEFT JOIN CRMT2101 C01 WITH (NOLOCK) ON C00.DivisionID = C01.DivisionID AND C00.APK = C01.APKMaster
		LEFT JOIN AT1202 A22 WITH (NOLOCK) ON C00.DivisionID = A22.DivisionID AND C00.ObjectID = A22.ObjectID
		LEFT JOIN AT1302 A32 WITH (NOLOCK) ON C00.DivisionID = A32.DivisionID AND C01.InventoryID = A32.InventoryID
		LEFT JOIN CRMT0099 C99 WITH (NOLOCK) ON C01.PaperTypeID = C99.ID AND C99.CodeMaster = ''CRMT00000022''
	' + @sJoin + '
	WHERE ' + @sWhere + ' 
		AND ISNULL(C00.DeleteFlg, 0) = 0 

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, ' + @TotalRow + ' AS TotalRow,	
		APK, DivisionID, VoucherNo, VoucherDate, ObjectName ObjectID, 
		InventoryName InventoryID, Description PaperTypeID, ActualQuantity
	FROM #CRMP2100 	' + @SearchWhere + '
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	

EXEC (@sSQL01)
--PRINT @sSQL01



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
