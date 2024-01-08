IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00372]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00372]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- LOAD DỮ LIỆU TRÊN LƯỚI KHI IN - LOAD FORM POSF0052 DANH MỤC BÀN
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:  Cao Thị Phượng on 08/06/2016 
-- <Example>
/*
POSP00372 @DivisionID = 'KC', @DivisionIDList = 'PL', @ShopID = 'DVPHL001', @ShopIDList = 'DVPHL001', @AreaIDList ='', @TableID = NULL, @TableName = null,
 @ISSEARCH = 1, @DisabledName=1, @IsCommonName = 1,  @UserID = ''
*/

CREATE PROCEDURE POSP00372 
(
	@DivisionID nvarchar(50),
	@DivisionIDList NVARCHAR(MAX),  
    @ShopID nvarchar(50),
    @ShopIDList NVARCHAR(MAX),
    @AreaIDList nvarchar(MAX),
    @TableID nvarchar(50),
	@TableName nvarchar(50),
	@IsSearch BIT, -- IsSearch = 1 khi nhấn "Lọc Dữ liệu"
    @DisabledName nvarchar(50),
	@IsCommonName nvarchar(50),
	@UserID varchar(50)
)
AS
BEGIN
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @OrderBy = ' P32.TableID, P32.AreaID, P32.ShopID, P32.DivisionID'

--Check Para DivisionIDList null then get DivisionID 

IF STR(@IsSearch) = 0 
BEGIN
	SET @sWhere = @sWhere + ' P32.DivisionID in ('''+@DivisionID+''',''@@@'') AND P32.ShopID = '''+@ShopID+''' '
END
IF STR(@IsSearch) = 1
BEGIN
	IF Isnull(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' P32.DivisionID IN ('''+@DivisionIDList+''',''@@@'')'
		ELSE 
			SET @sWhere = @sWhere + ' P32.DivisionID in ('''+@DivisionID+''',''@@@'')'

	IF Isnull(@ShopIDList, '') != ''
			SET @sWhere = @sWhere + ' AND P32.ShopID IN ('''+@ShopIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND P32.ShopID = '''+@ShopID+''''

	IF isnull(@AreaIDList, '') != ''
			SET @sWhere = @sWhere + ' AND P32.AreaID in ('''+@AreaIDList+''')'

	IF isnull(@TableID, '') != ''
			SET @sWhere = @sWhere + ' AND P32.TableID LIKE N''%'+@TableID+'%'''

	IF isnull(@TableName, '') != ''
			SET @sWhere = @sWhere +  ' AND P32.TableName LIKE N''%'+@TableName+'%'''

	IF Isnull(@DisabledName, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(P32.Disabled,'''') Like N'''+@DisabledName+''''

	IF Isnull(@IsCommonName, '') != ''
				SET @sWhere = @sWhere +  ' AND ISNULL(P32.IsCommon,'''') Like N'''+@IsCommonName+''''

END

SET @sSQL = '
SELECT  
	P32.DivisionID, P32.ShopID, P32.AreaID, P32.TableID, P32.TableName,
    P32.TableNameE, P32.[Description], P32.[Disabled], D1.Description as DisabledName, 
	P32.IsCommon, D2.Description as IsComomnName, P32.CreateUserID, P32.CreateDate,
    P32.LastModifyUserID, P32.LastModifyDate
FROM POST0032 P32 With (NOLOCK) left join AT0099 D1 With (NOLOCK) on D1.ID= P32.Disabled and  D1.CodeMaster =''AT00000004''
								left join AT0099 D2 With (NOLOCK) on D2.ID= P32.IsCommon and  D2.CodeMaster =''AT00000004''
WHERE '+@sWhere+'
ORDER BY '+@OrderBy

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
