IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP11002') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP11002
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP11002 Danh muc Mã phân tích mặt hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP11002 'HT','','','','','','', 'ASOFTADMIN'
----
CREATE PROCEDURE CIP11002 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @STypeID nvarchar(50),
        @S nvarchar(250),
		@SName nvarchar(250),
		@IsCommon VARCHAR(50),
        @Disabled nvarchar(100),
		@UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere = ''
SET @OrderBy = 'AT1310.DivisionID, AT1310.STypeID'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'AT1310.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere + 'AT1310.DivisionID IN ('''+@DivisionIDList+''')'
	IF @STypeID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND AT1310.STypeID LIKE N''%'+@STypeID+'%'' '
	IF @S IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1310.S,'''') LIKE N''%'+@S+'%''  '
	IF @SName IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT1310.SName,'''') LIKE N''%'+@SName+'%'' '
	IF @IsCommon IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT1310.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF @Disabled IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1310.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
SET @sSQL = '
	SELECT  
	AT1310.DivisionID, AT1310.STypeID, AT1310.S, AT1310.SName, AT1310.IsCommon, AT1310.Disabled		
	From AT1310
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'

EXEC (@sSQL)
