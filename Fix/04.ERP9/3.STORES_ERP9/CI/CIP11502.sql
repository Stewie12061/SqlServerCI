IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP11502') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP11502
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP11502 Danh muc đối tượng khi in
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao THị Phượng Date: 14/04/2016
----Modify by: Tiến Thành: 31/03/2023 - Đổi giá trị của Boolean thành X
-- <Example>
----    EXEC CIP11502 'HT','','','','','','','','','0','1','','', 'ASOFTADMIN'
----
CREATE PROCEDURE CIP11502 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @ObjectTypeID nvarchar(50),
        @ObjectID nvarchar(50),
        @ObjectName nvarchar(250),
		@Address nvarchar(100), 
		@Email nvarchar(100),
		@Tel nvarchar(100), 
		@IsUpdateName nvarchar(100),
		@IsSupplier nvarchar(100),
        @IsCustomer nvarchar(100),
        @IsDealer nvarchar(100) = '',
        @IsCommon nvarchar(100),
        @Disabled nvarchar(100),
		@UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @OrderBy = 'AT1202.DivisionID, AT1202.ObjectTypeID, AT1202.ObjectID'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'AT1202.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere + ' AT1202.DivisionID IN ('''+@DivisionIDList+''')'
		
	IF @ObjectID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.ObjectID, '''') LIKE N''%'+@ObjectID+'%'' '
	IF @ObjectName IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.ObjectName,'''') LIKE N''%'+@ObjectName+'%''  '
	IF @Address IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT1202.Address,'''') LIKE N''%'+@Address+'%'' '
	IF @Email IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT1202.Email,'''') LIKE N''%'+@Email+'%'' '
	IF @Tel IS NOT NULL 
		SET @sWhere = @sWhere +  'AND ISNULL(AT1202.Tel,'''') LIKE N''%'+@Tel+'%'' '
	IF @IsUpdateName IS NOT NULL
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.IsUpdateName, '''') LIKE N''%'+@IsUpdateName+'%'' '
	IF @IsSupplier IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.IsSupplier,'''') LIKE N''%'+@IsSupplier+'%'' '
	IF @IsCustomer IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.IsCustomer,'''') LIKE N''%'+@IsCustomer+'%'' '
	IF @IsCommon IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF @IsDealer IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.IsDealer,'''') LIKE N''%'+@IsDealer+'%'' '
	IF @ObjectTypeID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.ObjectTypeID,'''') LIKE N''%'+@ObjectTypeID+'%'' '
	IF @Disabled IS NOT NULL 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
SET @sSQL = N'
	SELECT AT1202.DivisionID, ISNULL(AT1201.ObjectTypeName, '''') AS ObjectTypeID,
	AT1202.ObjectID, AT1202.ObjectName,  AT1202.Address, 
	AT1202.Tel, AT1202.VATNo, AT1202.Contactor, AT1202.Fax,
	CASE WHEN ISNULL(AT1202.IsSupplier,0) = 1 THEN ''X'' END AS IsSupplier, 
	CASE WHEN ISNULL(AT1202.IsCustomer,0) = 1 THEN ''X'' END AS IsCustomer, 
	CASE WHEN ISNULL(AT1202.IsDealer,0) = 1 THEN ''X'' END AS IsDealer, 
	CASE WHEN ISNULL(AT1202.IsUpdateName,0) = 1 THEN ''X'' END AS IsUpdateName
FROM AT1202 	
LEFT JOIN AT1201 ON AT1202.ObjectTypeID = AT1201.ObjectTypeId
Where '+@sWhere+'	
ORDER BY '+@OrderBy+''
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
