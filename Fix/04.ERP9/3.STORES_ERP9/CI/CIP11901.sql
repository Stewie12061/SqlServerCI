IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP11901') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP11901
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP11901 Danh muc loại tiền
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP11901 '','HT'',''Q7','','','','khô','', 'ASOFTADMIN',1,10

CREATE PROCEDURE CIP11901 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @CurrencyID nvarchar(50),
        @CurrencyName nvarchar(250) = '',
        @ExchangeRate nvarchar(100),
        @Operator nvarchar(100),
        @Disabled NVARCHAR(100),
        @IsCommon NVARCHAR(100),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50)
        
        
SET @sWhere = ''
SET @TotalRow=''
SET @OrderBy = 'A.DivisionID, A.CurrencyID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + '(A.DivisionID = '''+ @DivisionID+''' or IsCommon =1 )'
	Else 
		SET @sWhere = @sWhere + '(A.DivisionID IN ('''+@DivisionIDList+''') or IsCommon =1 ) '
	IF @CurrencyID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND A.CurrencyID LIKE N''%'+@CurrencyID+'%'' '
		
	IF @CurrencyName IS NOT NULL 
		SET @sWhere = @sWhere + ' AND A.CurrencyName LIKE N''%'+@CurrencyName+'%'' '
		
	IF @ExchangeRate !=''
		SET @sWhere = @sWhere + ' AND ISNULL(A.ExchangeRate,0) = '+@ExchangeRate+' '
	IF @Disabled IS NOT NULL 
		SET @sWhere = @sWhere + ' AND (ISNULL(A.Disabled,'''') LIKE N''%'+@Disabled+'%'' 
										or ISNULL(A03.Description,'''') LIKE N''%'+@Disabled+'%'')'
	IF @IsCommon IS NOT NULL 
		SET @sWhere = @sWhere + ' AND (ISNULL(A.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' 
										or ISNULL(A02.Description,'''') LIKE N''%'+@IsCommon+'%'')'
	IF @Operator IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(A01.ID,'''') LIKE N''%'+@Operator+'%'''
SET @sSQL = '
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	, A.APK,
	  A.DivisionID,
      A.CurrencyID,
      A.CurrencyName,
      A.ExchangeRate,
      A.ExchangeRateDecimal,
      A01.Description AS Operator,
      A.Disabled,
      A.CreateDate,
      A.CreateUserID,
      A.LastModifyDate,
      A.LastModifyUserID,
      A.IsCommon, A02.Description as IsCommonName,
      A03.Description as DisabledName
    
      FROM AT1004 A
      LEFT JOIN AT0099 A01 ON A.Operator=A01.ID AND A01.CodeMaster =''AT00000017''
      LEFT JOIN AT0099 A02 ON A.IsCommon=A02.ID AND A02.CodeMaster =''AT00000004''
      LEFT JOIN AT0099 A03 ON A.Disabled=A03.ID AND A03.CodeMaster =''AT00000004''
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
	'

EXEC (@sSQL)
