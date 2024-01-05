IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP1001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LMP1001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






---- Created on 22/06/2017 by Bảo Anh
---- Load danh mục hình thức tín dụng
---- Modified by Tiểu Mai on 27/09/2017: Bổ sung tham số @CreditTypeID (Loại tín dụng)
---- Modified by Như Hàn on 03/06/2019: Sửa kiểu dữ liệu Disabled, IsCommon để lọc được dữ liệu
---- Modified by Bích Thảo on 21/04/2020: Lấy thêm DisabledName, IsCommonName để hiển thị trên file Excel
---- LMP1001 'AS','VTD',N'Vay tín dụng',N'',0,0,1,8,0
/*
exec LMP1001 @DivisionID=N'AS',@CreditFormID=NULL,@PageNumber=1,@PageSize=10,@CreditFormName=NULL,@Notes=N'',@Disabled=NULL,@IsCommon=NULL,@IsExcel=N'0',@CreditTypeID = 0

*/

CREATE PROCEDURE [dbo].[LMP1001]
(
		@DivisionID varchar(50),
		@CreditFormID varchar(50),
		@CreditFormName as nvarchar(250),
		@Notes as nvarchar(250)='',
		@Disabled VARCHAR(5),
		@IsCommon VARCHAR(5),
		@PageNumber INT,
        @PageSize INT,
		@IsExcel BIT, --1: thực hiện xuất file Excel; 0: Thực hiện Filter
		@CreditTypeID TINYINT = NULL,	--- 0: Vay tín dụng, 1: Bảo lãnh, 2: Bảo lãnh L/C
		@IsCheckAll TINYINT,
		@CreditFormList VARCHAR(MAX)
)		
AS
Declare @SQL nvarchar(max),
		@sWhere nvarchar(max),
		@TotalRow nVARCHAR(50)

SET @TotalRow = N''
IF  @PageNumber = 1 SET @TotalRow = N'COUNT(*) OVER ()' ELSE SET @TotalRow = N'NULL'

SET @sWhere = N'' 
IF Isnull(@CreditFormID,'') <> ''
	SET @sWhere = @sWhere + N' AND CreditFormID like N''%' + @CreditFormID + '%'''

IF Isnull(@CreditFormName,'') <> ''
	SET @sWhere = @sWhere + N' AND CreditFormName like N''%' + @CreditFormName + '%'''

IF Isnull(@Notes,'') <> ''
	SET @sWhere = @sWhere + N' AND Notes like N''%' + @Notes + '%'''

IF ISNULL(@Disabled,'') <> ''
	SET @sWhere = @sWhere + N' AND Disabled = ' + STR(@Disabled)

IF ISNULL(@IsCommon,'') <> ''
	SET @sWhere = @sWhere + N' AND IsCommon = ' + STR(@IsCommon)

IF @CreditTypeID IS NOT NULL
	SET @sWhere = @sWhere + N' AND CreditTypeID = ' + LTRIM(@CreditTypeID)

IF @IsExcel = 1 AND ISNULL(@IsCheckAll,0) = 0
BEGIN
	SET @CreditFormList = ''''+@CreditFormList+''''
	SET @sWhere = @sWhere + N'
	AND LMT1001.CreditFormID IN ('+@CreditFormList+')'
END

SET @SQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY CreditFormID) AS RowNum, '+@TotalRow+N' AS TotalRow,
LMT1001.*, CASE WHEN LMT1001.CreditTypeID = 0 THEN N''Vay tín dụng'' WHEN LMT1001.CreditTypeID = 1 THEN N''Bảo lãnh'' WHEN LMT1001.CreditTypeID = 2 THEN N''Bảo lãnh L/C'' END AS CreditTypeName, D12.Description as DisabledName
, D13.Description as IsCommonName
FROM LMT1001 WITH (NOLOCK)
left join AT0099 D12 With (NOLOCK) on LMT1001.Disabled = D12.ID and D12.CodeMaster = ''AT00000004''
left join AT0099 D13 With (NOLOCK) on LMT1001.IsCommon = D13.ID and D13.CodeMaster = ''AT00000004''
WHERE DivisionID in (N''@@@'', N''' + @DivisionID + ''')' + @sWhere

SET @SQL = @SQL + N'
ORDER BY CreditFormID'

IF @IsExcel = 0
	SET @SQL = @SQL+N'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--PRINT(@SQL)
EXEC(@SQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
