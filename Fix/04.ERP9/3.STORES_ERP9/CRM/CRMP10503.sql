IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CRMP10503') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CRMP10503
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- thực hiện btnPrint
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Nguyễn Thị Lệ Huyền, Date: 25/03/2017

--Lưu ý chưa bổ sung phân quyền xem dữ liệu người khác


-- <Example>
----    EXEC CRMP10503 'AS','AS','','','','','','','NV01'
----
CREATE PROCEDURE CRMP10503 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@CauseType NVARCHAR (100),
        @CauseID nvarchar(50),
        @CauseName nvarchar(250),
		@Description nvarchar(250),
        @IsCommon nvarchar(100),
        @Disabled nvarchar(100),
		@UserID  VARCHAR(50)
		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @OrderBy = 'M.CauseID, M.CauseName'

--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''') or M.IsCommon = 1)'
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID = '''+ @DivisionID+''' or M.IsCommon = 1)'		
	IF isnull(@CauseType,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.CauseType,'''') LIKE N''%'+@CauseType+'%'' '	
	IF isnull(@CauseID,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.CauseID, '''') LIKE N''%'+@CauseID+'%'' '
	IF isnull(@CauseName,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.CauseName,'''') LIKE N''%'+@CauseName+'%''  '
	IF isnull(@IsCommon,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF isnull(@Disabled,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

SET @sSQL =	  ' Declare @TempCRMT10501 Table (
					  [APK] UNIQUEIDENTIFIER NOT NULL,
					  [DivisionID] VARCHAR(50) NOT NULL,
					  [CauseType] TINYINT DEFAULT (1) NOT NULL,
					  [CauseID] VARCHAR(50) NOT NULL,
					  [CauseName] NVARCHAR(250) NOT NULL,
					  [Description] NVARCHAR(250) NULL,
					  [IsCommon] TINYINT DEFAULT (0) NOT NULL,
					  [Disabled] TINYINT DEFAULT (0) NOT NULL,
					  [CreateDate] DATETIME NULL,
					  [CreateUserID] VARCHAR(50) NULL,
					  [LastModifyDate] DATETIME NULL,
					  [LastModifyUserID] VARCHAR(50) NULL
						)
				Insert into  @TempCRMT10501 (APK, DivisionID, CauseType, CauseID, CauseName, Description
							, IsCommon, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
				SELECT M.APK, M.DivisionID, M.CauseType, M.CauseID, M.CauseName, M.Description
					   , M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
				FROM CRMT10501 M With (NOLOCK)
				WHERE '+@sWhere+'

				DECLARE @count int
				Select @count = Count(CauseID) From @TempCRMT10501

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID, D10.Description as CauseTypeName, M.CauseID, M.CauseName, M.Description
					, D11.Description as IsCommonName , D12.Description as DisabledName, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
				FROM @TempCRMT10501 M
				LEFT JOIN CRMT0099 D10 With (NOLOCK) on M.CauseType = D10.ID and D10.CodeMaster = ''CRMT00000014''
				LEFT JOIN AT0099 D11 ON M.IsCommon = D11.ID and D11.CodeMaster = ''AT00000004''
				LEFT JOIN AT0099 D12 ON M.Disabled = D12.ID and D12.CodeMaster = ''AT00000004''
				ORDER BY '+@OrderBy			
EXEC (@sSQL)

