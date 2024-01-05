IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP11301') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP11301
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP11301 In Danh muc loại mặt hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP11301 '','HT'',''Q7','','', 'ASOFTADMIN'

CREATE PROCEDURE CIP11301 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @InventoryTypeID nvarchar(50),
        @Disabled nvarchar(100),
		@UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @OrderBy = 'A.DivisionID, A.InventoryTypeID'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'A.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere + 'A.DivisionID IN ('''+@DivisionIDList+''')'
	IF @InventoryTypeID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND A.InventoryTypeID LIKE N''%'+@InventoryTypeID+'%'' '
	IF @Disabled IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(A.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
SET @sSQL = '
	SELECT 
	A.DivisionID, A.InventoryTypeID, A.InventoryTypeName, A.Disabled		
	From AT1301 A
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'

EXEC (@sSQL)
