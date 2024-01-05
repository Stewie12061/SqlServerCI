IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CRMP10501') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CRMP10501
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CRMP10501 Danh muc lý do
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Nguyễn Thị Lệ Huyền, Date: 21/03/2017
----Edited by: Hoàng vũ, Date: 26/04/2017 Cải tiến tốc độ, lấy thêm trường CauseTypeName và check @@@ thì hiện NULL
----Editted by: Phan thanh hoàng Vũ, Date: 01/09/2017 Sắp xếp thứ tự giảm dần thao ngày (Record mới nhất sẽ load lên đầu tiên)
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
-- <Example>
----    EXEC CRMP10501 'AS','AS','','','','','','','NV01',1,20,''

CREATE PROCEDURE CRMP10501 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@CauseType NVARCHAR (100),
        @CauseID nvarchar(50),
        @CauseName nvarchar(250),
		@Description nvarchar(250),
        @IsCommon nvarchar(100),
        @Disabled nvarchar(100),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(Max) = null
		
) 
AS 
BEGIN
		DECLARE @sSQL NVARCHAR (MAX),
				@sWhere NVARCHAR(MAX),
				@OrderBy NVARCHAR(500)
        
		SET @sWhere = '1 = 1'
		SET @OrderBy = ' M.CreateDate DESC, M.CauseID, M.CauseName'
IF isnull(@SearchWhere,'') =''
Begin
		--Check Para DivisionIDList null then get DivisionID 
			IF Isnull(@DivisionIDList, '') != ''
				SET @sWhere = @sWhere + ' AND (M.DivisionID IN ('''+@DivisionIDList+''') or M.IsCommon = 1)'
			Else 
				SET @sWhere = @sWhere + ' AND (M.DivisionID = '''+ @DivisionID+''' or M.IsCommon = 1)'		
			IF isnull(@CauseType,'')!='' 
				SET @sWhere = @sWhere + ' AND ISNULL(M.CauseType,'''') LIKE N''%'+@CauseType+'%'' '	
			IF isnull(@CauseID,'')!='' 
				SET @sWhere = @sWhere + ' AND ISNULL(M.CauseID, '''') LIKE N''%'+@CauseID+'%'' '
			IF isnull(@CauseName,'')!='' 
				SET @sWhere = @sWhere + ' AND ISNULL(M.CauseName,'''') LIKE N''%'+@CauseName+'%''  '

			IF isnull(@Description,'')!='' 
				SET @sWhere = @sWhere + ' AND ISNULL(M.Description,'''') LIKE N''%'+@Description+'%''  '

			IF isnull(@IsCommon,'')!='' 
				SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
			IF isnull(@Disabled,'')!='' 
				SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
End
IF isnull(@SearchWhere,'') !=''
Begin
	SET  @sWhere='1 = 1'
End
		SET @sSQL =	  ' SELECT M.APK, M.DivisionID, M.CauseType, M.CauseID, M.CauseName, M.Description
							   , M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID, D10.Description as CauseTypeName
							   into #CRMT10501
						FROM CRMT10501 M With (NOLOCK)
						LEFT JOIN CRMT0099 D10 With (NOLOCK) on M.CauseType = D10.ID and D10.CodeMaster = ''CRMT00000014''
						WHERE '+@sWhere+'

						--Cải tiến tốc độ
						DECLARE @count int
						Select @count = Count(CauseID) From #CRMT10501
						'+Isnull(@SearchWhere,'')+'
						SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow, M.APK
							, Case when M.IsCommon = 1 then '''' else M.DivisionID end as DivisionID
							, M.CauseType, M.CauseTypeName, M.CauseID, M.CauseName, M.Description
							, M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
						FROM #CRMT10501 M
						'+Isnull(@SearchWhere,'')+'
						ORDER BY '+@OrderBy+'
						OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
						FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '			
		EXEC (@sSQL)
END