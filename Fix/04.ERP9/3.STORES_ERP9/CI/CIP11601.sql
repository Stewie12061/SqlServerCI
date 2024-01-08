IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP11601') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP11601
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP11601 In Danh sách tài khoản
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP11601 '','HT'',''Q7','','', 'ASOFTADMIN'

CREATE PROCEDURE CIP11601 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @AccountID nvarchar(50),
        @GroupID nvarchar(50),
		@UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @sWhere1 = ''
SET @OrderBy = 'A.DivisionID, A.AccountID, A.GroupID'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere1 = @sWhere1 + 'and DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere1 = @sWhere1 + 'and DivisionID IN ('''+@DivisionIDList+''')'
	IF ISNULL( @AccountID,'') !=''
		SET @sWhere = @sWhere + '  and A.AccountID LIKE N''%'+@AccountID+'%'' '
	IF ISNULL( @GroupID,'') !=''
		SET @sWhere = @sWhere + ' AND A.GroupID LIKE N''%'+@GroupID+'%'' '
SET @sSQL = '
	SELECT A.DivisionID, A.GroupID, A.AccountID, A.AccountName, A.IsCommon
	FROM
	(SELECT case when AT1005.IsCommon =1 then '''' else AT1005.DivisionID end as DivisionID, AccountID,
	        AccountName, [Disabled], GroupID, IsCommon
	From AT1005
	Where IsCommon = 1 and Disabled = 0  
	Union all
	SELECT case when AT1005.IsCommon =1 then '''' else AT1005.DivisionID end as DivisionID, AccountID,
	        AccountName, [Disabled], GroupID, IsCommon
	From AT1005
	where 1 =1 '+@sWhere1+'
	)A
	WHERE 1=1 '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'

EXEC (@sSQL)
