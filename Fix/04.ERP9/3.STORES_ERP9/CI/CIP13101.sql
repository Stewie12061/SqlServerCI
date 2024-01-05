IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP13101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP13101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Load Gird danh mục mã phân tích
-- 
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng, Date: 17/05/2016
-- <Example> EXEC CIP13101 'KC','','1','','','','','','','ASOFTADMIN',1,10

CREATE PROCEDURE CIP13101 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @GroupIDName  nvarchar(50), 
        @AnaTypeID nvarchar(50),
		@AnaID nvarchar(50),
		@AnaName nvarchar(100),
     	@Notes nvarchar(100), 
		@DisabledName nvarchar(50),
		@IsCommonName nvarchar(50),
        @UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT		
) 
AS 
DECLARE @sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sSQL03 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@CountTotal NVARCHAR(Max)
		
		SET @sWhere = ''
	SET @OrderBy = 'x.DivisionID, x.GroupID, x.AnaTypeID'

	--Check DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and (x.DivisionID = '''+ @DivisionID+''' or x.IsCommon = 1)'
	Else 
		SET @sWhere = @sWhere + 'and (x.DivisionID IN ('''+@DivisionIDList+''') or x.IsCommon = 1)'
		
	IF Isnull(@GroupIDName,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(x.GroupID, 0) ='+@GroupIDName
	IF isnull(@AnaTypeID,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(x.AnaTypeID,'''') LIKE N''%'+@AnaTypeID+'%'' '
	IF isnull(@AnaID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(x.AnaID, '''') LIKE N''%'+@AnaID+'%'' '
	IF isnull(@AnaName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(x.AnaName,'''') LIKE N''%'+@AnaName+'%'' '
	IF Isnull(@Notes, '') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(x.Notes,'''') LIKE N''%'+@Notes+'%'' '
	IF Isnull(@DisabledName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(x.Disabled,0) ='+@DisabledName
	IF isnull(@IsCommonName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(x.IsCommon,0) = '+@IsCommonName
	--Kiểm tra load mac84 định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	IF @PageNumber = 1
	Begin
		Set @CountTotal = ' SELECT Count(x.AnaID) FROM
							( SELECT DivisionID,AnaID, 1 AS GroupID, AnaTypeID, AnaName, Notes, [Disabled], IsCommon
								 FROM AT1011 With (NOLOCK)
							  UNION ALL 
							  SELECT DivisionID,AnaID ,CASE WHEN AnaTypeID LIKE ''O%'' THEN 2 ELSE 3 END AS GroupID,
							   AnaTypeID, AnaName, Notes, [Disabled], IsCommon 
							  FROM AT1015 With (NOLOCK)
							)x
							WHERE 1=1'+@sWhere
					
	End
		else Set @CountTotal = 'Select 0'
	DECLARE @CountEXEC table (CountRow NVARCHAR(Max))
	Insert into @CountEXEC (CountRow)
	EXEC (@CountTotal)

	SET @sSQL01 = N'
				  SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum,'+(Select CountRow from @CountEXEC)+' AS TotalRow	,
				  x.APK, x.DivisionID,x.TableID, x.GroupID,A01.[Description] AS GroupIDName
				  ,x.AnaID,x.AnaTypeID, x.AnaName, x.AnaNameE, x.Notes, x.Notes01, x.[Disabled], x.RefDate
				  ,x.Amount01, x.Amount02, x.Amount03, x.Amount04, x.Amount05
				  ,x.Note01, x.Note02, x.Note03, x.Note04, x.Note05, x.Amount06
				  ,x.Amount07, x.Amount08, x.Amount09, x.Amount10, x.Note06
				  ,x.Note07, x.Note08, x.Note09, x.Note10, x.IsCommon
				  FROM 
				  (
      				SELECT A.APK,''AT1011'' as TableID,
      					 1 AS GroupID,
						 A.DivisionID, A.AnaID, A.AnaTypeID, A.AnaName, A.AnaNameE, A.Notes, '''' Notes01,
						 A.[Disabled], A.RefDate, A.Amount01, A.Amount02, A.Amount03,
						 A.Amount04, A.Amount05, A.Note01, A.Note02, A.Note03, A.Note04,
						 A.Note05, A.Amount06, A.Amount07, A.Amount08, A.Amount09, A.Amount10,
						 A.Note06, A.Note07, A.Note08, A.Note09, A.Note10, A.IsCommon
					FROM AT1011 A With (NOLOCK)
					UNION ALL
					SELECT B.APK,''AT1015'' as TableID,
						 CASE WHEN B.AnaTypeID like ''O%'' THEN 2 ELSE 3 END AS GroupID,
						 B.DivisionID,  B.AnaID, B.AnaTypeID, B.AnaName, B.AnaNameE, B.Notes, B.Notes01,
						 B.[Disabled],null as RefDate,  null AS Amount01,  null as Amount02,  null AS Amount03,
						  null as Amount04, null as Amount05,  null as Note01, null as Note02, null as Note03,  null as Note04,
						  null as Note05,  null as Amount06,  null as Amount07,  null as Amount08,  null as Amount09,  null as Amount10,
						  null as Note06,  null as Note07,  null as Note08,  null as Note09,  null as Note10, B.IsCommon
					FROM AT1015 B With (NOLOCK)
				  )x'
	set @sSQL02='
				  LEFT JOIN AT0099 A01 With (NOLOCK) ON A01.ID = x.GroupID AND CodeMaster=''AT00000019''
				  WHERE 1=1 '+@sWhere+''
	SET @sSQL03 = '	
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL01+@sSQL02+@sSQL03)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
