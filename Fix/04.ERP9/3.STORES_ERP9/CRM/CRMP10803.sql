IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CRMP10803') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CRMP10803
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Thực thi btnPrint
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
----    EXEC CRMP10803 'AS','AS','','','','','','NV01'
----
CREATE PROCEDURE CRMP10803 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @NextActionID nvarchar(50),
        @NextActionName nvarchar(250),
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
SET @OrderBy = 'M.NextActionID, M.NextActionName'

--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''') or M.IsCommon = 1)'
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID = '''+ @DivisionID+''' or M.IsCommon = 1)'		
		
	IF isnull(@NextActionID,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.NextActionID, '''') LIKE N''%'+@NextActionID+'%'' '
	IF isnull(@NextActionName,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.NextActionName,'''') LIKE N''%'+@NextActionName+'%''  '
	IF isnull(@IsCommon,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF isnull(@Disabled,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

SET @sSQL =	  ' Declare @TempCRMT10801 Table (
					  [APK] UNIQUEIDENTIFIER NOT NULL,
					  [DivisionID] VARCHAR(50) NOT NULL,
					  [NextActionID] VARCHAR(50) NOT NULL,
					  [NextActionName] NVARCHAR(250) NOT NULL,
					  [Description] NVARCHAR(250) NULL,
					  [IsCommon] TINYINT DEFAULT (0) NOT NULL,
					  [Disabled] TINYINT DEFAULT (0) NOT NULL,
					  [CreateDate] DATETIME NULL,
					  [CreateUserID] VARCHAR(50) NULL,
					  [LastModifyDate] DATETIME NULL,
					  [LastModifyUserID] VARCHAR(50) NULL
						)
				Insert into  @TempCRMT10801 (APK, DivisionID, NextActionID, NextActionName, Description
							, IsCommon, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
				SELECT M.APK, M.DivisionID, M.NextActionID, M.NextActionName, M.Description
					   , M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
				FROM CRMT10801 M With (NOLOCK)
				WHERE '+@sWhere+'

				DECLARE @count int
				Select @count = Count(NextActionID) From @TempCRMT10801

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID, M.NextActionID, M.NextActionName, M.Description
					, D10.Description as IsCommonName , D11.Description as DisabledName, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
				FROM @TempCRMT10801 M
				LEFT JOIN AT0099 D10 ON M.IsCommon = D10.ID and D10.CodeMaster = ''AT00000004''
				LEFT JOIN AT0099 D11 ON M.Disabled = D11.ID and D11.CodeMaster = ''AT00000004''
				ORDER BY '+@OrderBy
EXEC (@sSQL)

