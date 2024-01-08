IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP12001') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP12001
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP12001 In Danh muc nhóm thuế
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP12001 '','HT'',''Q7','','', 'ASOFTADMIN'

CREATE PROCEDURE CIP12001 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @VATGroupID nvarchar(50),
        @VATGroupName nvarchar(100),
		@UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @OrderBy = 'A.DivisionID, A.VATGroupID'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'A.DivisionID = '''+ @DivisionID+'''Or IsCommon =1 '
	Else 
		SET @sWhere = @sWhere + 'A.DivisionID IN ('''+@DivisionIDList+''')Or IsCommon =1 '
	IF @VATGroupID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND A.VATGroupID LIKE N''%'+@VATGroupID+'%'' '
	IF @VATGroupName IS NOT NULL 
		SET @sWhere = @sWhere + ' AND A.VATGroupName LIKE N''%'+@VATGroupName+'%'' '
SET @sSQL = '
	SELECT 
	A.DivisionID, A.VATGroupID, A.VATGroupName, A.VATRate	
	From AT1010 A
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'
print (@sSQL)
EXEC (@sSQL)
