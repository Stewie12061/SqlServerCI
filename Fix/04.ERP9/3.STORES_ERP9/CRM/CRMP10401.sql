IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10401]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP10401]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form CRMP10401 Danh muc giai đoạn bán hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Nguyễn Thị Lệ Huyền, Date: 20/03/2017
----Editted by: Hoàng Vũ, Date: 27/04/2017  Cải tiến tốc độ, nếu Division là @@@ thì hiển thị null
----Editted by: Hoàng Vũ, Date: 23/05/2017  Bổ sung load thêm cột [loại giai đoạn]: StageType, StageTypeName, IsSystem, Rate
----Editted by: Phan thanh hoàng Vũ, Date: 01/09/2017 Sắp xếp thứ tự giảm dần thao ngày (Record mới nhất sẽ load lên đầu tiên)
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
----Modify by Ngọc Long, Date 30/06/2021: Bổ sung thêm cột: Color, StageNameE, DataFilter
----Modify by Tấn Lộc, Date 10/07/2021: Bổ sung kiểm tra ISNULL cột Color
-- <Example>
----    EXEC CRMP10401 'AS','AS','','','','','','NV01',1,20,''
----
CREATE PROCEDURE CRMP10401 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @StageID nvarchar(50),
        @StageName nvarchar(250),
		@StageType nvarchar(250),
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
		SET @OrderBy = 'M.StageType, M.StageID, M.OrderNo, M.CreateDate DESC, M.Rate '
IF isnull(@SearchWhere,'') =''
Begin
		--Check Para DivisionIDList null then get DivisionID 
			IF Isnull(@DivisionIDList, '') != ''
				SET @sWhere = @sWhere + ' AND (M.DivisionID IN ('''+@DivisionIDList+''') or M.IsCommon = 1)'
			Else 
				SET @sWhere = @sWhere + ' AND (M.DivisionID = '''+ @DivisionID+''' or M.IsCommon = 1)'		
		
			IF isnull(@StageID,'')!='' 
				SET @sWhere = @sWhere + ' AND ISNULL(M.StageID, '''') LIKE N''%'+@StageID+'%'' '
			IF isnull(@StageName,'')!='' 
				SET @sWhere = @sWhere + ' AND ISNULL(M.StageName,'''') LIKE N''%'+@StageName+'%''  '
			IF isnull(@IsCommon,'')!='' 
				SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
			IF isnull(@Disabled,'')!='' 
				SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
			IF ISNULL(@StageType,'') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.StageType, '''') IN (''' + @StageType + ''') '
End
IF isnull(@SearchWhere,'') !=''
Begin
	SET  @sWhere='1 = 1'
End
		SET @sSQL =	  '	SELECT M.APK, M.DivisionID, M.StageID, M.StageName, M.OrderNo, M.Description
							   , M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
							   , M.StageType, D.Description as StageTypeName, M.IsSystem, M.Rate, ISNULL(M.Color,'''') AS Color , M.StageNameE, M.DataFilter
							   into #TempCRMT10401
						FROM CRMT10401 M With (NOLOCK) left join CRMT0099 D With (NOLOCK) on M.StageType = D.ID and D.CodeMaster = ''CRMT00000020''
						WHERE '+@sWhere+'

						DECLARE @count int
						Select @count = Count(StageID) From #TempCRMT10401
							'+Isnull(@SearchWhere,'')+'
						SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
							, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end as DivisionID
							, M.StageID, M.StageName, M.OrderNo, M.Description, M.StageType, M.StageTypeName, M.IsSystem, M.Rate, M.Color, M.StageNameE, M.DataFilter
							, M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
						FROM #TempCRMT10401 M
							'+Isnull(@SearchWhere,'')+'
						ORDER BY '+@OrderBy+'
						OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
						FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
		EXEC (@sSQL)
		
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
