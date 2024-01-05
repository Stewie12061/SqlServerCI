IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2016]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load màn hình chọn học sinh từ kết quả tư vấn
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Văn Tình 10/10/2018
-- <Example>
/*
	exec EDMP2016 @DivisionID=N'VS',@TxtSearch=N'FDSFS',@UserID=N'CALL002',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE EDMP2016 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
SET NOCOUNT ON
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'A.StudentName'

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
SET @TxtSearch = ISNULL(@TxtSearch,'') 

IF @TxtSearch <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND (A.StudentName LIKE N''%' + @TxtSearch + '%'')'

END

SET @sSQL = '
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow  
		, A.VoucherNo, A.VoucherDate, A.DivisionID, A.StudentName
		, A.StudentDateBirth AS DateOfBirth, A.[Sex] AS SexID
		, A.Telephone, A.Address, Email, A.APK AS APKConsultant
	FROM EDMT2000 A WITH(NOLOCK) 
	WHERE A.DivisionID = ''' + @DivisionID + '''  ' + @sWhere + '
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY 

'
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
