IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Nghiệp vụ Phiếu thông tin tư vấn (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa , Date: 27/09/2018
-- <Example>
/*



EXEC EDMP2000 @DivisionID, @DivisionList, @UserID VARCHAR(50), @LanguageID VARCHAR(50),	@PageNumber INT,@PageSize INT,
		@VoucherNo VARCHAR(50), @VoucherDateFrom DATETIME, @VoucherDateTo DATETIME, @ParentName NVARCHAR(250), @Telephone VARCHAR(20),
		@Address NVARCHAR(250),	@Email VARCHAR(50),	@StudentName rNVARCHAR(250),	@StudentDateBirth DATETIME,
		@ResultID VARCHAR(50), @Status VARCHAR(50),
		@SearchWhere NVARCHAR(MAX) = NULL -- Lọc nâng cao

EXEC EDMP2000 @DivisionID= 'VS', @DivisionList = 'VS', @UserID = '', @LanguageID = '', @PageNumber = 1, @PageSize = 25,
		@VoucherNo ='', @VoucherDateFrom ='',@VoucherDateTo ='', 
		@ParentName ='', @Telephone='',
		@Address ='',	@Email ='',	@StudentName ='',	@StudentDateBirth='',
		@ResultID ='',	@Status='',
		@SearchWhere = '' 



*/
CREATE PROCEDURE EDMP2000 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@UserID VARCHAR(50),
	    @LanguageID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@VoucherNo VARCHAR(50), 
		@VoucherDateFrom DATETIME,
		@VoucherDateTo DATETIME,
		@ParentName NVARCHAR(250),
		@Telephone VARCHAR(20),
		@Address NVARCHAR(250),
		@Email VARCHAR(50),
		@StudentName NVARCHAR(250),
		@StudentDateBirth DATETIME,
		@ResultID VARCHAR(50),
		@Status VARCHAR(50),
		@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
		
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'CreateDate DESC'
	SET @sWhere = ' 1 = 1 '


	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND T1.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND T1.DivisionID = '''+@DivisionID+''''

	IF ISNULL(@VoucherNo, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.VoucherNo LIKE ''%'+@VoucherNo+'%'''

	IF (ISNULL(@VoucherDateFrom, '') <> '' AND ISNULL(@VoucherDateTo, '') = '') 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.VoucherDate,120), 126) >= '''+CONVERT(VARCHAR(10),@VoucherDateFrom,126)+''' '
	IF (ISNULL(@VoucherDateFrom, '') = '' AND ISNULL(@VoucherDateTo, '') <> '') 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.VoucherDate,120), 126) <= '''+CONVERT(VARCHAR(10),@VoucherDateTo,126)+''' '
	IF (ISNULL(@VoucherDateFrom, '') <> '' AND ISNULL(@VoucherDateTo, '') <> '') 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.VoucherDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@VoucherDateFrom,126)+''' AND '''+CONVERT(VARCHAR(10),@VoucherDateTo,126)+''' '
	IF ISNULL(@ParentName, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ParentName  LIKE N''%'+@ParentName +'%'''

	IF ISNULL(@Telephone, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.Telephone  LIKE ''%'+@Telephone +'%'''

	IF ISNULL(@Address, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.Address  LIKE N''%'+@Address +'%'''

	IF ISNULL(@Email, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.Email  LIKE ''%'+@Email +'%'''

	IF ISNULL(@StudentName, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.StudentName  LIKE N''%'+@StudentName +'%'''
	
	IF @StudentDateBirth IS NOT NULL
		SET @sWhere = @sWhere + ' AND T1.StudentDateBirth >= ''' + CONVERT(VARCHAR(10), @StudentDateBirth, 112)+''' '

	IF ISNULL(@ResultID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ResultID  LIKE ''%'+@ResultID +'%'''

		--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 
					
SET @sSQL = N'
SELECT A.* , '+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'B.Description' ELSE 'B.DescriptionE' END +' AS StatusName 
INTO #EDMP2000
FROM 
(

SELECT 
T1.APK,T1.DivisionID,T1.VoucherNo, T1.VoucherDate, T1.ParentID, T1.ParentName,T1.ParentDateBirth, T1.Telephone,
T1.Address, T1.Email, T1.StudentID, T1.StudentName, T1.StudentDateBirth,  
'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T5.Description' ELSE 'T5.DescriptionE' END +' as Sex, 
'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.Description' ELSE 'T3.DescriptionE' END +' as ResultName, 
T1.DateFrom,T1.DateTo,
CASE WHEN  ISNULL(T1.Amount,1) - SUM(ISNULL(T6.ConvertedAmount, 0)) = 0 
												THEN 1
												ELSE 0 END AS Status,
T1.Amount,T1.Information, T1.CreateDate

FROM EDMT2000 T1  WITH (NOLOCK)
LEFT JOIN EDMT0099  T3 WITH (NOLOCK) ON T1.ResultID = T3.ID AND T3.Disabled = 0 AND T3.CodeMaster=''ConsultancyResult''
LEFT JOIN EDMT0099  T4 WITH (NOLOCK) ON T1.Status = T4.ID AND T4.Disabled = 0 AND T4.CodeMaster=''PaymentStatus''
LEFT JOIN EDMT0099  T5 WITH (NOLOCK) ON T1.Sex = T5.ID AND T5.Disabled = 0 AND T5.CodeMaster=''Sex''
LEFT JOIN AT9000    T6 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.APK) = T6.InheritVoucherID 
AND CONVERT(VARCHAR(50),T1.APK) = T6.InheritTransactionID AND T1.StudentID = T6.ObjectID AND T6.InheritTableID = ''EDMT2000'' 
WHERE '+@sWhere+' AND T1.DeleteFlg = 0
GROUP BY T1.APK,T1.DivisionID,T1.VoucherNo, T1.VoucherDate, T1.ParentID, T1.ParentName,T1.ParentDateBirth, T1.Telephone,
T1.Address, T1.Email, T1.StudentID, T1.StudentName, T1.StudentDateBirth, T5.Description,T5.DescriptionE,T3.Description,T3.DescriptionE,
T1.DateFrom,T1.DateTo,T1.Amount,T1.Information,T1.CreateDate

) A 
LEFT JOIN EDMT0099  B WITH (NOLOCK) ON A.Status = B.ID AND B.Disabled = 0 AND B.CodeMaster=''PaymentStatus''




SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP2000 AS Temp
'+@SearchWhere +' 
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'



--PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
