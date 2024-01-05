IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CRMP10403') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CRMP10403
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
----Editted by: Hoàng Vũ, Date: 27/04/2017  Cải tiến tốc độ, nếu Division là @@@ thì hiển thị null
----Editted by: Hoàng Vũ, Date: 23/05/2017  Bổ sung load thêm cột [loại giai đoạn]: StageType, StageTypeName, IsSystem, Rate
-- <Example>
----    EXEC CRMP10403 'AS','AS','','','','','','NV01'
----
CREATE PROCEDURE CRMP10403 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @StageID nvarchar(50),
        @StageName nvarchar(250),
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
SET @OrderBy = 'M.OrderNo'

--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''') or M.IsCommon = 1)'
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID = '''+ @DivisionID+''' or M.IsCommon = 1)'		
		
	IF isnull(@StageID,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.StageID, '''') LIKE N''%'+@StageID+'%'' '
	IF isnull(@StageName,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.StageName,'''') LIKE N''%'+@StageName+'%''  '
	IF isnull(@IsCommon,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF isnull(@Disabled,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

SET @sSQL =	  ' Declare @TempCRMT10401 Table (
					  [APK] UNIQUEIDENTIFIER NOT NULL,
					  [DivisionID] VARCHAR(50) NULL,
					  [StageID] VARCHAR(50) NOT NULL,
					  [StageName] NVARCHAR(250) NULL,
					  [OrderNo] INT NULL,
					  [Description] NVARCHAR(250) NULL,
					  [IsCommon] TINYINT DEFAULT (0) NULL,
					  [StageType] int NULL,  
					  [StageTypeName] varchar(250) NULL, 
					  [IsSystem] TINYINT NULL, 
					  [Rate] DECIMAL(28,8) DEFAULT (0) NULL, 
					  [Disabled] TINYINT DEFAULT (0) NULL,
					  [CreateDate] DATETIME NULL,
					  [CreateUserID] VARCHAR(50) NULL,
					  [LastModifyDate] DATETIME NULL,
					  [LastModifyUserID] VARCHAR(50) NULL
						)
				Insert into  @TempCRMT10401 (APK, DivisionID, StageID, StageName, OrderNo, Description
							, IsCommon, Disabled, StageType, IsSystem, Rate, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
				SELECT M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID, M.StageID, M.StageName, M.OrderNo, M.Description
					   , M.IsCommon, M.Disabled, M.StageType, M.IsSystem, M.Rate
					   , M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
				FROM CRMT10401 M With (NOLOCK)  
				WHERE '+@sWhere+'

				DECLARE @count int
				Select @count = Count(StageID) From @TempCRMT10401

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, M.DivisionID, M.StageID, M.StageName, M.OrderNo, M.Description
					   , D10.Description as IsCommonName , D11.Description as DisabledName, M.StageType,  D.Description as StageTypeName, M.IsSystem, M.Rate
					   , M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
				FROM @TempCRMT10401 M
				LEFT JOIN AT0099 D10 ON M.IsCommon = D10.ID and D10.CodeMaster = ''AT00000004''
				LEFT JOIN AT0099 D11 ON M.Disabled = D11.ID and D11.CodeMaster = ''AT00000004''
				left join CRMT0099 D With (NOLOCK) on M.StageType = D.ID and D.CodeMaster = ''CRMT00000020''
				ORDER BY '+@OrderBy
EXEC (@sSQL)