IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load danh mục loại hình thu (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----	
-- <History>
----Created by: Hồng Thảo, Date: 23/08/2018
---- Modified by on   
-- <Example>
---- 
/*-- <Example>
---Lọc thường 
	EXEC EDMP1050 @DivisionID = 'BE', @DivisionList = '', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @ReceiptTypeID = '', 
	@ReceiptTypeName = '',@AnaRevenueID = N'', @IsCommon = '', @Disabled = '',@SearchWhere = N''

---Lọc nâng cao 
	EXEC EDMP1050 @DivisionID = 'BE', @DivisionList = '', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @ReceiptTypeID = '', 
	@ReceiptTypeName = '',@AnaRevenueID = N'', @IsCommon = '', @Disabled = '', @SearchWhere = N' WHERE ISNULL(ReceiptTypeID,'''') = N''DINHDUONG'''
----*/

CREATE PROCEDURE EDMP1050
( 
	@DivisionID VARCHAR(50),
	@DivisionList VARCHAR(MAX),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@ReceiptTypeID VARCHAR(50),
	@ReceiptTypeName NVARCHAR(250),
	@AnaRevenueID VARCHAR(50),
	@Disabled VARCHAR(50),
	@IsReserve VARCHAR(50),
	@IsTransfer VARCHAR(50),
	@IsCommon VARCHAR(50),
	@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'ReceiptTypeID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND EDMT1050.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE
	SET @sWhere = @sWhere + 'AND EDMT1050.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

IF ISNULL(@ReceiptTypeID,'') <> '' SET @sWhere = @sWhere + '
AND EDMT1050.ReceiptTypeID LIKE N''%'+@ReceiptTypeID+'%'' '	

IF ISNULL(@ReceiptTypeName,'') <> '' SET @sWhere = @sWhere + '
AND EDMT1050.ReceiptTypeName LIKE N''%'+@ReceiptTypeName+'%'' '

IF ISNULL(@AnaRevenueID,'') <> '' SET @sWhere = @sWhere + '
AND EDMT1050.AnaRevenueID LIKE N''%'+@AnaRevenueID+'%'' '	

IF ISNULL(@Disabled, '') <> '' SET @sWhere = @sWhere + N'
AND EDMT1050.Disabled LIKE N''%'+@Disabled+'%'' '	

IF ISNULL(@IsCommon, '') <> '' SET @sWhere = @sWhere + N'
AND EDMT1050.IsCommon LIKE N''%'+@IsCommon+'%'' '	

IF ISNULL(@IsReserve, '') <> '' SET @sWhere = @sWhere + N'
AND EDMT1050.IsReserve LIKE N''%'+@IsReserve+'%'' '	

IF ISNULL(@IsTransfer, '') <> '' SET @sWhere = @sWhere + N'
AND EDMT1050.IsTransfer LIKE N''%'+@IsTransfer+'%'' '	

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END
	

SET @sSQL = @sSQL + N'
SELECT 
EDMT1050.APK,EDMT1050.DivisionID, EDMT1050.ReceiptTypeID, EDMT1050.ReceiptTypeName, EDMT1050.IsCommon, EDMT1050.[Disabled],
EDMT1050.AnaRevenueID,T01.AnaName AS AnaRevenueName, T02.AccountName as AccountID,
EDMT1050.IsObligatory,EDMT1050.IsReserve,EDMT1050.IsTransfer,E2.Description as TypeOfFee, EDMT1050.Note,
STUFF(ISNULL((	SELECT  ''
- '' + X.Description FROM  
												(	SELECT T1.APKMaster, T1.DivisionID, T1.Business, T2.Description
													FROM EDMT1051 T1 WITH (NOLOCK)
													JOIN EDMT0099 T2 WITH (NOLOCK) ON T2.CodeMaster=''BUSINESS'' AND T1.Business=T2.ID
												) X
								WHERE X.APKMaster = CONVERT(VARCHAR(50), EDMT1050.APK)
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS Business,
STUFF(ISNULL((	SELECT  ''
- '' + X.Description FROM  
												(	SELECT T1.APKMaster, T1.DivisionID, T1.StudentStatus, T2.Description
													FROM EDMT1052 T1 WITH (NOLOCK)
													JOIN EDMT0099 T2 WITH (NOLOCK) ON T2.CodeMaster=''StudentStatus'' AND T1.StudentStatus=T2.ID
												) X
								WHERE X.APKMaster = CONVERT(VARCHAR(50), EDMT1050.APK)
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS StudentStatus
INTO #EDMP1050 
FROM EDMT1050 WITH (NOLOCK)
LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T01.AnaID = EDMT1050.AnaRevenueID AND T01.AnaTypeID =  (SELECT SalesAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = '''+@DivisionID+''')
LEFT JOIN AT1005 T02 WITH (NOLOCK) ON T02.AccountID = EDMT1050.AccountID
LEFT JOIN EDMT0099 E2 WITH (NOLOCK) ON E2.CodeMaster=''TypeOfFee'' AND EDMT1050.TypeOfFee=E2.ID

WHERE '+@sWhere +'
ORDER BY '+@OrderBy+' 
	
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP1050 AS Temp
'+@SearchWhere +'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

---PRINT(@sSQL)
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
