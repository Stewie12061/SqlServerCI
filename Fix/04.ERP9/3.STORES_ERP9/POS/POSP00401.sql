IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00401]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00401]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load form In báo cáo - Danh mục thời điểm
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao Thị Phượng on 09/06/2016 
----Edited by: Hoàng Vũ on 07/06/2017: Điều chỉnh loại dữ liệu và thêm dùng chung
-- <Example> EXEC POSP00401 'KC', '', 'DVPHL001', 'KC', '','','1',0,'', ''
CREATE PROCEDURE POSP00401
(
	@DivisionID NVARCHAR(50),  
	@DivisionIDList NVARCHAR(MAX),  
	@ShopID NVARCHAR(50),
    @ShopIDList NVARCHAR(MAX),
    @TimeID nvarchar(50),
	@TimeName nvarchar(50),
	@IsSearch BIT, 
    @DisabledName nvarchar(50),
	@IsCommonName nvarchar(50),
	@UserID  nvarchar(50)
)
AS
BEGIN
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @OrderBy = ' P36.TimeID, P36.ShopID, P36.DivisionID '

--Check Para DivisionIDList null then get DivisionID 
IF STR(@IsSearch) = 0 
BEGIN
	SET @sWhere = @sWhere + ' P36.DivisionID in ('''+@DivisionID+''',''@@@'') AND P36.ShopID = '''+@ShopID+''' '
END
IF STR(@IsSearch) = 1
BEGIN
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' P36.DivisionID IN ('''+@DivisionIDList+''',''@@@'')'
	ELSE 
		SET @sWhere = @sWhere + ' P36.DivisionID in ('''+@DivisionID+''',''@@@'')'

	IF Isnull(@ShopIDList, '') != ''
		SET @sWhere = @sWhere + ' AND P36.ShopID IN ('''+@ShopIDList+''') '
	ELSE 
		SET @sWhere = @sWhere + ' AND P36.ShopID = '''+@ShopID+''''

	IF isnull(@TimeID, '') != ''
		SET @sWhere = @sWhere + ' AND P36.TimeID LIKE N''%'+@TimeID+'%''  '

	IF isnull(@TimeName, '') != ''
		SET @sWhere = @sWhere +  ' AND P36.TimeName LIKE N''%'+@TimeName+'%'' '

	IF isnull(@DisabledName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(P36.Disabled,'''') LIKE N'''+@DisabledName+''''
	
	IF isnull(@IsCommonName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(P36.IsCommon,'''') LIKE N'''+@IsCommonName+''''

END
SET @sSQL =	' 
	SELECT Case when P36.IsCommon = 1 then '''' else P36.DivisionID end DivisionID, P36.ShopID, P36.TimeID, P36.TimeName, P36.TimeNameE,
		P36.BeginHour, P36.BeginMinute, (cast(P36.BeginHour AS NVARCHAR(10)) +'':''+ cast(P36.BeginMinute AS NVARCHAR(10))) as  BeginTime,
		P36.EndHour, P36.EndMinute, (cast(P36.EndHour AS NVARCHAR(10)) +'':''+ cast(P36.EndMinute AS NVARCHAR(10))) as EndTime,
		P36.[Description], P36.[Disabled], D2.Description as DisabledName, P36.IsCommon, D1.Description as IsCommonName
	FROM POST0036 P36 With (NOLOCK)
			left join AT0099 D1  WITH (NOLOCK) on D1.ID = P36.[IsCommon] and D1.CodeMaster =''AT00000004''
			left join AT0099 D2  WITH (NOLOCK) on D2.ID = P36.[Disabled] and D2.CodeMaster =''AT00000004''
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy
	EXEC (@sSQL)
END	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
