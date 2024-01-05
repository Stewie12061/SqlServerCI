IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP11902') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP11902
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP11902 In Danh muc loại tiền
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP11902 '','HT'',''Q7','','', 'ASOFTADMIN'

CREATE PROCEDURE CIP11902 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @CurrencyID nvarchar(50),
        @ExchangeRate nvarchar(100),
		@UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @OrderBy = 'A.DivisionID, A.CurrencyID'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + '(A.DivisionID = '''+ @DivisionID+''' or IsCommon =1)'
	Else 
		SET @sWhere = @sWhere + '(A.DivisionID IN ('''+@DivisionIDList+''') or IsCommon =1)'
	IF @CurrencyID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND A.CurrencyID LIKE N''%'+@CurrencyID+'%'' '
	IF @ExchangeRate !=''
		SET @sWhere = @sWhere + ' AND ISNULL(A.ExchangeRate,0) = '+@ExchangeRate+' '
SET @sSQL = '
	SELECT 
	A.DivisionID, A.CurrencyID, A.CurrencyName, A.ExchangeRate	
	From AT1004 A
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'

EXEC (@sSQL)
