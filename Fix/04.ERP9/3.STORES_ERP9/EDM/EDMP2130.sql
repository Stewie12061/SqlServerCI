IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2130]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2130]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Đăng ký dịch vụ (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 09/10/2018
---- Modified on 25/15/2019 by Khánh Đoan: Bổ sung điều kiện lọc theo khối,lớp
-- <Example>
/*
--Lọc nâng cao 
EXEC EDMP2130 @DivisionID = 'BE', @DivisionList = '',@VoucherNo = '',@GradeID = '',@ReceiptTypeID = '',@ServiceTypeID = '',@UserID = '', @PageNumber = 1, @PageSize = 25,
@LanguageID  = '',@SearchWhere = N' where IsNull(VoucherNo,'''') = N''DD0001'''

--Lọc thường 
exec EDMP2130 @DivisionID=N'BE',@UserID=N'ASOFTADMIN',@LanguageID=N'vi-VN',@DivisionList=N'',@VoucherNo=N'',@GradeID=N'',@ClassID=N'',@ReceiptTypeID=N'',@SchoolYearID= '2019-2020',@TranMonth = 1,@TranYear = 2020,@Cost=N'',@ServiceTypeID=N'',@PageNumber=1,@PageSize=25,@SearchWhere=N''

EXEC EDMP2130 @DivisionID, @DivisionList, @VoucherNo , @GradeID ,@ReceiptType, @Cost,@ServiceType, @UserID, @PageNumber, @PageSize, @SearchWhere,@LanguageID 

*/
CREATE PROCEDURE EDMP2130 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@VoucherNo VARCHAR (50),
		@GradeID VARCHAR(50) ,
		@ClassID VARCHAR(50),
		@ReceiptTypeID VARCHAR(50),
		@SchoolYearID VARCHAR(50),
		@TranMonth VARCHAR(50),
		@TranYear VARCHAR(50), 
		@ServiceTypeID VARCHAR(50),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(MAX) = NULL,--#NULL: Lọc nâng cao; =NULL: Lọc thường
		@LanguageID VARCHAR(50) 
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

SET @OrderBy = 'VoucherNo' 

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE
	SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@VoucherNo, '') <> '' 
	SET @sWhere = @sWhere + N' AND T1.VoucherNo LIKE N''%'+@VoucherNo+'%'''
IF ISNULL(@GradeID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T4.GradeID LIKE N''%'+@GradeID+'%'''
IF ISNULL(@ClassID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T4.ClassID LIKE N''%'+@ClassID+'%'''
IF ISNULL(@ReceiptTypeID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T1.ReceiptTypeID  LIKE N''%'+@ReceiptTypeID +'%'''
IF ISNULL(@ServiceTypeID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T1.ServiceTypeID LIKE N''%'+@ServiceTypeID +'%'''
IF ISNULL(@SchoolYearID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T1.SchoolYearID LIKE N''%'+@SchoolYearID +'%'''

IF @TranMonth <> ''
	SET @sWhere = @sWhere + ' AND T1.TranMonth = '''+@TranMonth +''''

IF @TranYear <> '' 
	SET @sWhere = @sWhere + N' AND T1.TranYear = '''+@TranYear +''''


	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '') 

	END 

SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.VoucherNo , 
T1.ReceiptTypeID,T2.ReceiptTypeName, 
T1.ExtracurricularActivity,T1.ServiceTypeID,
'+CASE WHEN ISNULL(@LanguageID,'''') = 'vi-VN' THEN 'T3.Description' ELSE 'T3.DescriptionE' END+'  as ServiceTypeName, 
Stuff(isnull((	Select  '', '' + X.GradeName From  
												(	Select DISTINCT EDMT2132.APKMaster, EDMT2132.DivisionID, EDMT2132.GradeID, T4.GradeName
													From EDMT2132 WITH (NOLOCK)
													LEFT JOIN EDMT1000 T4 WITH (NOLOCK) ON T4.GradeID = EDMT2132.GradeID
												) X
								Where X.APKMaster = Convert(varchar(50),T1.APK) and X.DivisionID= T1.DivisionID
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS GradeName,
Stuff(isnull((	Select  '', '' + Y.ClassName From  
												(	Select DISTINCT EDMT2133.APKMaster, EDMT2133.DivisionID, EDMT2133.ClassID, T5.ClassName
													From EDMT2133 WITH (NOLOCK)
													LEFT JOIN EDMT1020 T5 WITH (NOLOCK) ON T5.ClassID = EDMT2133.ClassID
												) Y
								Where Y.APKMaster = Convert(varchar(50),T1.APK) and Y.DivisionID= T1.DivisionID
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS ClassName,
T1.SchoolYearID,
CAST (T1.TranMonth AS nvarchar)  + ''/'' + CAST (T1.TranYear AS nvarchar) AS MonthID

INTO #EDMT2130
FROM EDMT2130 T1 WITH (NOLOCK)  
LEFT JOIN EDMT1050 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T2.ReceiptTypeID = T1.ReceiptTypeID
LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T3.ID = T1.ServiceTypeID AND T3.CodeMaster = ''ServiceTypeID''
LEFT JOIN EDMT2131 T4 WITH (NOLOCK)  ON T4.APKMaster = T1.APK AND T4.DeleteFlg = 0 
WHERE '+@sWhere+' AND T1.DeleteFlg = 0 
 
	
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #EDMT2130  AS Temp
'+@SearchWhere +'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


PRINT @sSQL
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
