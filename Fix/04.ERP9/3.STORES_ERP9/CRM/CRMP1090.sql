IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP1090]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP1090]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load dữ liệu màn hình Danh mục từ điển hỗ trợ
-- <Param>
-- <Return>
-- <Reference>
-- <History>
---- Created by: Vĩnh Tâm,	Date 19/07/2018
---- Modified by: Vĩnh Tâm	Date 25/01/2021: Bổ sung điều kiện lọc theo Sản phẩm
/* <Example
	EXEC CRMP1090 @DivisionID = 'DTI', @DivisionIDList = '', @SupportDictionaryID = '', @SupportDictionarySubject = '', @KindID = '', @InventoryName = '', @PriorityID = ''
		, @AttachFile = '', @Disabled = '', @IsCommon = '', @UserID = '', @PageNumber = 1, @PageSize = 100, @SearchWhere = ''
 */

CREATE PROCEDURE CRMP1090 ( 
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),
	@SupportDictionaryID NVARCHAR(MAX),
	@SupportDictionarySubject NVARCHAR(MAX),
	@KindID NVARCHAR(MAX),
	@InventoryName NVARCHAR(MAX),
	@PriorityID NVARCHAR(10),
	@AttachFile NVARCHAR(10),
	@Disabled NVARCHAR(10),
	@IsCommon NVARCHAR(10),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@SearchWhere NVARCHAR(MAX) = NULL
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
		
SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = ' M.SupportDictionaryID'

IF ISNULL(@SearchWhere, '') = ''
BEGIN
	-- Check Para DivisionIDList NULL then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = ' M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
	ELSE 
		SET @sWhere = ' M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

	IF ISNULL(@SupportDictionaryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SupportDictionaryID, '''') LIKE N''%' + @SupportDictionaryID + '%'' '

	IF ISNULL(@SupportDictionarySubject, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SupportDictionarySubject, '''') LIKE N''%' + @SupportDictionarySubject + '%'' '

	IF ISNULL(@KindID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.KindID, '''') IN (''' + @KindID + ''') '

	IF ISNULL(@PriorityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.PriorityID, '''') IN (''' + @PriorityID + ''') '

	IF ISNULL(@InventoryName, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.InventoryID, '''') LIKE N''%' + @InventoryName + '%'' OR ISNULL(C05.InventoryName, '''') LIKE N''%' + @InventoryName + '%'') '

	IF ISNULL(@AttachFile, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C03.AttachFile, ''0'') = ' + @AttachFile

	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') = ' + @Disabled

	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon, '''') = ' + @IsCommon
END
ELSE IF ISNULL(@SearchWhere, '') != ''
BEGIN
	SET @sWhere = '1 = 1'
END

SET @sSQL = 'SELECT   M.APK, M.DivisionID, M.SupportDictionaryID, M.SupportDictionarySubject, M.RelatedToTypeID
					, M.PriorityID, C02.Description AS PriorityName, M.TimeFeedback, C01.Description AS TimeFeedbackName
					, M.InventoryID, C05.InventoryName, M.RequestDescription, M.FeedbackDescription, C03.AttachFile
					, M.Disabled, M.IsCommon, M.CreateDate, M.LastModifyDate, M.KindID, C04.Description AS KindName
			INTO #CRMT1090
			FROM CRMT1090 M WITH (NOLOCK)
				LEFT JOIN CRMT0099 C01 WITH (NOLOCK) ON C01.ID = M.TimeFeedback AND C01.CodeMaster = ''CRMT00000027''
				LEFT JOIN CRMT0099 C02 WITH (NOLOCK) ON C02.ID = M.PriorityID AND C02.CodeMaster = ''CRMT00000006''
				LEFT JOIN (
					SELECT S1.RelatedToID, CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END AS AttachFile
					FROM CRMT00002_REL S1 WITH (NOLOCK)
					GROUP BY S1.RelatedToID
				) C03 ON CONVERT(VARCHAR(50), M.APK) = C03.RelatedToID
				LEFT JOIN OOT0099 C04 WITH (NOLOCK) ON C04.CodeMaster = ''OOF2170.TypeOfRequest'' AND C04.ID = M.KindID
				LEFT JOIN AT1302 C05 WITH (NOLOCK) ON M.DivisionID IN (C05.DivisionID, ''@@@'') AND C05.InventoryID = M.InventoryID
			WHERE ' + @sWhere + '

			DECLARE @Count INT
			SELECT @Count = COUNT(SupportDictionaryID)
			FROM #CRMT1090 
			' + ISNULL(@SearchWhere, '') + '

			SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
					, M.APK, M.DivisionID, M.SupportDictionaryID, M.SupportDictionarySubject, M.RelatedToTypeID
					, M.KindName, M.PriorityID, M.PriorityName, M.TimeFeedback, M.TimeFeedbackName
					, M.InventoryID, M.InventoryName, M.RequestDescription, M.FeedbackDescription
					, M.AttachFile, M.Disabled, M.IsCommon, M.CreateDate, M.LastModifyDate
			FROM #CRMT1090 M WITH (NOLOCK)
			' + ISNULL(@SearchWhere, '') + '
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
			
--PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
