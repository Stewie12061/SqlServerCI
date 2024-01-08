IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP10902') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP10902
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP10902 Load Gird In Danh muc Mã phân tích đối tượng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 11/04/2016
-- <Example>
----    EXEC CIP10902 'HT','','','','','','', 'ASOFTADMIN'
----
CREATE PROCEDURE CIP10902 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @STypeID nvarchar(50),
        @S nvarchar(50),
		@SName nvarchar(250),
		@IsCommon VARCHAR(50),
        @Disabled nvarchar(100),
		@UserID  VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''

SET @OrderBy = 'AT1207.DivisionID, AT1207.STypeID'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'AT1207.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere + 'AT1207.DivisionID IN ('''+@DivisionIDList+''')'
	IF @STypeID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND AT1207.STypeID LIKE N''%'+@STypeID+'%'' '
	IF @S IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1207.S,'''') LIKE N''%'+@S+'%''  '
	IF @SName IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT1207.SName,'''') LIKE N''%'+@SName+'%'' '
	IF @IsCommon IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT1207.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF @Disabled IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1207.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
SET @sSQL = '
	SELECT  
	AT1207.DivisionID, AT1207.STypeID, AT1207.S, AT1207.SName, AT1207.IsCommon, AT1207.Disabled		
	From AT1207
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'

EXEC (@sSQL)
