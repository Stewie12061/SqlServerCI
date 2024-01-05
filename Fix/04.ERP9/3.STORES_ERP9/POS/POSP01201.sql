IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'POSP01201') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE POSP01201
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form POSP01201 Danh muc mức hoa hồng theo doanh thu tích lũy
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 17/08/2017
-- <Example> EXEC POSP01201 'KY', '','50', '250', '0.05', '', '','', 1, 20

CREATE PROCEDURE POSP01201 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @FromIncome nvarchar(100),
        @ToIncome nvarchar(100),
		@CommissionRate nvarchar(100),
		@IsCommon nvarchar(100),
		@Disabled nvarchar(100),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
		
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'M.FromIncome'

	IF @PageNumber = 1 
		SET @TotalRow = 'COUNT(*) OVER ()' 
	ELSE 
		SET @TotalRow = 'NULL'
	
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')) '
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID in ('''+@DivisionID+''', ''@@@'')) '
		
		
	IF isnull(@CommissionRate,'') != ''
		SET @sWhere = @sWhere + ' AND cast(M.CommissionRate as Varchar(50)) like N''%'+@CommissionRate+'%'' '
	IF ISNULL(@FromIncome,'') != ''
		SET @sWhere = @sWhere + ' AND cast(ISNULL(M.FromIncome,0) as Varchar(50)) LIKE N''%'+@FromIncome+'%''  '
	IF ISNULL(@ToIncome,'') != ''
		SET @sWhere = @sWhere + ' AND cast(ISNULL(M.ToIncome,0) as Varchar(50)) LIKE N''%'+@ToIncome+'%''  '
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

SET @sSQL = ' SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
					, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID 
					, M.FromIncome, M.ToIncome, M.CommissionRate, M.Description, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM POST01201 M With (NOLOCK) 
			WHERE '+@sWhere+'
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)
Print (@sSQL)
