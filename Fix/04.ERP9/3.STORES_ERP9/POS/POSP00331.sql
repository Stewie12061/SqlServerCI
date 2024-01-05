IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00331]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP00331]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load dữ liệu lên In Danh mục loại thẻ
---- 
---- 
----
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng on 09/06/2016 
-- <Example>
----    EXEC POSP00331 'KC','AS','','','',''
----
CREATE PROCEDURE POSP00331 ( 
        @DivisionID VARCHAR(50),
		@DivisionIDList NVARCHAR(2000),
        @TypeNo varchar(50),
		@TypeName nvarchar(250),
		@DisabledName nvarchar(50),
		@IsCommon nvarchar(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
	SET @sWhere = ''
	SET @OrderBy = 'DivisionID'

	
--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL 
		SET @sWhere = @sWhere + 'DivisionID = '''+ @DivisionID+''' Or IsCommon =1'
	Else 
		SET @sWhere = @sWhere + 'DivisionID IN ('''+@DivisionIDList+''') Or IsCommon =1'
	IF isnull(@TypeNo, '') != ''
	 SET 
		@sWhere = @sWhere + ' AND TypeNo LIKE ''%'+@TypeNo+'%'' '
	IF isnull(@TypeName, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(TypeName,'''') LIKE N''%'+@TypeName+'%''  '
	IF isnull(@DisabledName, '') != ''
			SET @sWhere = @sWhere + ' AND ISNULL(Disabled,0) =''' +@DisabledName+''''
	IF isnull(@IsCommon, '') != '' SET @sWhere = @sWhere + ' AND ISNULL(IsCommon,0) = '''+@IsCommon+''''
	SET @sSQL = '
	SELECT  APK ,DivisionID
	, TypeNo, TypeName, FromScore, ToScore, DiscountRate, POST0021.[Disabled], IsCommon, AT0099.Description as DisabledName
	FROM POST0021 With (NOLOCK)
	left join AT0099 on ID = POST0021.Disabled and CodeMaster =''AT00000004''
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy
	EXEC (@sSQL)
--Print (@sSQL)