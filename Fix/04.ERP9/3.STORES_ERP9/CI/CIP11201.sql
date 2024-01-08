IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP11201') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP11201
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIR11201 In Danh muc khách hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 12/04/2016
-- <Example>
----    EXEC CIP11201 '','','','','','','','','ASOFTADMIN'
----
CREATE PROCEDURE CIP11201 ( 
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @DivisionName nvarchar(250),
		@Address nvarchar(100), 
		@Email nvarchar(100),
		@Tel nvarchar(100), 
		@Fax nvarchar(50),
		@ContactPerson nvarchar(50),
        @Disabled nvarchar(100),
		@UserID  VARCHAR(50)
		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere = ''
SET @OrderBy = 'AT01.DivisionID'

--Check Para DivisionIDList null then get DivisionID 
	
	IF @DivisionName IS NOT NULL 
		SET @sWhere = @sWhere + ' ISNULL(AT01.DivisionName,'''') LIKE N''%'+@DivisionName+'%''  '
	IF @Address IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT01.Address,'''') LIKE N''%'+@Address+'%'' '
	IF @Email IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT01.Email,'''') LIKE N''%'+@Email+'%'' '
	IF @Tel IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT01.Tel,'''') LIKE N''%'+@Tel+'%'' '
	IF @Fax IS NOT NULL
		SET @sWhere = @sWhere + ' AND ISNULL(AT01.Fax, '''') LIKE N''%'+@Fax+'%'' '
	IF @ContactPerson IS NOT NULL SET 
		@sWhere = @sWhere + ' AND ISNULL(AT01.ContactPerson,'''') LIKE N''%'+@ContactPerson+'%'' '
	IF @Disabled IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT01.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
	IF (@DivisionIDList IS NOT NULL and @DivisionIDList !='')
		SET @sWhere = @sWhere + 'AND AT01.DivisionID IN ('''+@DivisionIDList+''')'
SET @sSQL = '
	SELECT 
	AT01.DivisionID, AT01.DivisionName, AT01.Tel, AT01.Fax, AT01.Address,  
	AT01.VATNO	
	From AT1101 AT01
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'
EXEC (@sSQL)
