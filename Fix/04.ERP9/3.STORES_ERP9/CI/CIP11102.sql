IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP11102') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP11102
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP11102 In Danh muc Phuong thuc thanh toan
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP11102 '','HT'',''Q7','','','','', 'ASOFTADMIN'

CREATE PROCEDURE CIP11102 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @PaymentID nvarchar(50),
        @PaymentName nvarchar(250),
		@IsCommon VARCHAR(50),
        @Disabled nvarchar(100),
		@UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @OrderBy = 'AT1205.DivisionID, AT1205.PaymentID'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'AT1205.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere + 'AT1205.DivisionID IN ('''+@DivisionIDList+''')'
	IF @PaymentID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND AT1205.PaymentID LIKE N''%'+@PaymentID+'%'' '
	IF @PaymentName IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1205.PaymentName,'''') LIKE N''%'+@PaymentName+'%''  '
	IF @IsCommon IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT1205.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF @Disabled IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1205.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
SET @sSQL = '
	SELECT 
	AT1205.DivisionID, AT1205.PaymentID, AT1205.PaymentName, AT1205.IsCommon, AT1205.Disabled		
	From AT1205
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'

EXEC (@sSQL)
