IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00351]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00351]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- LÁY RA DỮ LIỆU TRÊN LƯỚI KHI in- LOAD FORM POSF0034 - DANH MỤC KHU VỰC
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao Thị Phượng on 08/06/2016 
----Edited by: Hoàng Vũ on 07/06/2017: Bổ sung dùng chung
-- <Example>
/*
POSP00351 @DivisionID = 'AS', @DivisionIDList = 'As', @ShopID = 'DVBOT001', @ShopIDList = 'xx', @AreaID ='c', @AreaName = 'x' , 
@iSsEARCH = 1, @DisabledName =1, @IsCommonName = 1, @UserID = ''
*/

CREATE PROCEDURE POSP00351 
(  
	@DivisionID nvarchar(50),
	@DivisionIDList NVARCHAR(MAX),  
    @ShopID nvarchar(50),
    @ShopIDList NVARCHAR(MAX),
    @AreaID nvarchar(50),
	@AreaName nvarchar(250),
	@IsSearch BIT, -- = 1 khi nhấn button "Lọc dữ liệu", = 0 các trường hợp còn lại
    @DisabledName nvarchar(50),
	@IsCommonName nvarchar(50),
	@UserID varchar(50)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''

SET @OrderBy = ' P31.AreaID, P31.ShopID, P31.DivisionID'

--Check Para DivisionIDList null then get DivisionID 
IF STR(@IsSearch) = 0 
BEGIN
	SET @sWhere = @sWhere + ' P31.DivisionID in ('''+@DivisionID+''',''@@@'') AND P31.ShopID = '''+@ShopID+''' '
END

IF STR(@IsSearch) = 1 
BEGIN
	IF Isnull(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' P31.DivisionID IN ('''+@DivisionIDList+''',''@@@'')'
		ELSE 
			SET @sWhere = @sWhere + ' P31.DivisionID in ('''+@DivisionID+''',''@@@'')'
	
	IF ISNULL(@ShopIDList,'') != ''
			SET @sWhere = @sWhere + ' AND P31.ShopID IN ('''+@ShopIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND P31.ShopID = '''+@ShopID+''''

	IF isnull(@AreaID, '') != ''
			SET @sWhere = @sWhere + ' AND P31.AreaID LIKE N''%'+@AreaID+'%'''

	IF isnull(@AreaName, '') != ''
			SET @sWhere = @sWhere +  ' AND P31.AreaName LIKE N''%'+@AreaName+'%'' '
	
	IF Isnull(@DisabledName, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(P31.Disabled,'''') Like N'''+@DisabledName+''''

	IF Isnull(@IsCommonName, '') != ''
			SET @sWhere = @sWhere +  ' AND ISNULL(P31.IsCommon,'''') Like N'''+@IsCommonName+''''

END

SET @sSQL = '
SELECT 
	P31.DivisionID, P31.ShopID, P31.AreaID, P31.AreaName, P31.AreaNameE,
    P31.[Description], P31.[Disabled], D1.Description as DisabledName, P31.IsCommon, D2.Description as IsCommonName, 
	P31.CreateUserID, P31.LastModifyUserID,P31.CreateDate, P31.LastModifyDate 
FROM POST0031 P31 With (NOLOCK) Left join AT0099 D1 With (NOLOCK) on D1.ID = P31.Disabled and D1.CodeMaster=''AT00000004''
								Left join AT0099 D2 With (NOLOCK) on D2.ID = P31.Disabled and D2.CodeMaster=''AT00000004''
WHERE '+@sWhere+'
ORDER BY '+@OrderBy
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
