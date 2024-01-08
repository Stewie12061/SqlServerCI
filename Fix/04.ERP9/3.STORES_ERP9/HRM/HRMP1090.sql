IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1090]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1090]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRMF1090: Chấm công ngày/tháng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo on 13/12/2023
---- 
/*-- <Example>
	

ze=25,@IsSearch=1,@AbsentTypeID=N'',@AbsentName=N'',@UnitID=N'',@IsMonth=N'',@FromDate=NULL
,@ToDate=NULL,@IsPeriod=1,@PeriodList=N'12/2023'',''11/2023'',''10/2023'',''09/2023'',''08/2023''
,''07/2023'',''06/2023'',''05/2023'',''04/2023'',''03/2023'',''02/2023'',''01/2023'
,''ANGI-SS001'',''BBA-SELLIN'',''BRVT-SS001''
,''DIEUVAN-001'',''DIEUVAN-002'',''DIEUVAN-003'',''HCNS-001'',''HCNS-002'',''HCNS-003'',''HCNS-004''
,''HCQ12-SS001'',''KDTT-001'',''KDTT-002'',''KDTT-003'',''MAR-001'',''MAR-002'',''MAR-003''
,''MTA1-ASM001'',''NM-NV01'',''NM-NV02'',''NM-NV03'',''NMT-ASM001'',''QUNG-SS001'',''TM-001''
,''TM-002'',''TM-003'',''UNASSIGNED'',''VP-ADMIN'',''VP-KT04'',''VP-KT05'',''VP-KT06'',''VP-SO01''
,''VP-SO02'',''VP-SO03'',''VP-SO04'',''VP-SO05'',''VP-SO06'',''VP-SO07'',''VP-SO08'',''VP-SO09'',''VP-SO10'',''VP-TGD'
----*/

CREATE PROCEDURE HRMP1090
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @AbsentTypeID VARCHAR(50),
	 @AbsentName VARCHAR(50),
	 @UnitID VARCHAR(50),
	 @IsMonth VARCHAR(50),
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @IsPeriod INT = 0,
	 @PeriodList VARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @OrderBy = 'HT13.IsMonth'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HT13.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HT13.DivisionID = '''+@DivisionID+''' '

IF  @IsSearch = 1
BEGIN
	
	IF ISNULL(@AbsentTypeID,'') <> '' SET @sWhere = @sWhere + '
	   AND HT13.AbsentTypeID LIKE ''%'+@AbsentTypeID+'%'' '
	IF ISNULL(@AbsentName,'') <> '' SET @sWhere = @sWhere + '
	   AND HT13.AbsentName = '''+@AbsentName+''' '
	IF ISNULL(@UnitID,'') <> '' SET @sWhere = @sWhere + '
	   AND HT13.UnitID LIKE ''%'+@UnitID+'%'' '
	IF ISNULL(@IsMonth,'') <> '' SET @sWhere = @sWhere + '
	   AND HT13.IsMonth LIKE ''%'+@IsMonth+'%'' '
    -- Check Para FromDate và ToDate _ Begin add
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT13.CreateDate >= ''' + @FromDateText + '''
												OR HT13.CreateDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT13.CreateDate <= ''' + @ToDateText + ''' 
												OR HT13.CreateDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (HT13.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										OR HT13.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HT13.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
	-- Check Para FromDate và ToDate _ End add
	
END
SET @sWhere = @sWhere + ' AND ISNULL(HT13.DeleteFlg,0) = 0 '
SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		HT13.APK
		, HT13.DivisionID-- đơn vị
		, HT13.AbsentTypeID -- mã 
        , HT13.AbsentName--tên
		, HT13.UnitID
		, HT91.Description AS UnitName
		, HT99.Description AS IsMonthName
		, HT13.IsMonth
		, HT13.CreateDate
		, HT13.CreateDate
		, HT13.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT13.CreateUserID) CreateUserID
		, HT13.CreateDate
		, HT13.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT13.LastModifyUserID) LastModifyUserID
		, HT13.LastModifyDate
	FROM HT1013  HT13 WITH (NOLOCK)
		LEFT JOIN HT0099 HT99   WITH (NOLOCK) ON HT99.ID = HT13.IsMonth AND  HT99.CodeMaster = ''IsMonth''
		LEFT JOIN HT0099 HT91   WITH (NOLOCK) ON HT91.ID = HT13.UnitID AND  HT91.CodeMaster = ''UnitID''
	WHERE '+@sWhere +'
	ORDER BY '+@OrderBy+'
	
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
