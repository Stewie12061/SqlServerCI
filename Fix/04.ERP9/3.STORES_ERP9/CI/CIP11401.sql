IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP11401') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP11401
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP11401 In Danh muc kho hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP11401 '','HT'',''Q7','','', 'ASOFTADMIN'

CREATE PROCEDURE CIP11401 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @WareHouseID nvarchar(50),
        @Disabled nvarchar(100),
		@UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @sWhere1 = ''
SET @OrderBy = 'x.DivisionID, x.WareHouseID'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere1 = @sWhere1 + 'DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere1 = @sWhere1 + 'DivisionID IN ('''+@DivisionIDList+''')'
	IF @WareHouseID IS NOT NULL 
		SET @sWhere = @sWhere + '  ISNULL(x.WareHouseID,'''') LIKE N''%'+@WareHouseID+'%'' '
	IF @Disabled IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(x.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
SET @sSQL = '
	SELECT x.DivisionID, x.WareHouseID, x.WareHouseName, x.[Disabled], x.IsCommon
	FROM
	(SELECT case when AT1303.IsCommon =1 then '''' else AT1303.DivisionID end as DivisionID, 
	WareHouseID, AT1303.WareHouseName, [Address], FullName, IsTemp, AT1303.IsCommon, AT1303.Disabled		
	From AT1303
	Where IsCommon = 1 and Disabled = 0  
	Union all
	SELECT case when AT1303.IsCommon =1 then '''' else AT1303.DivisionID end as DivisionID, 
	AT1303.WareHouseID, AT1303.WareHouseName, [Address], FullName, IsTemp, AT1303.IsCommon, AT1303.Disabled		
	From AT1303
	where '+@sWhere1+'
	)x
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'
	Print (@sSQL)
EXEC (@sSQL)