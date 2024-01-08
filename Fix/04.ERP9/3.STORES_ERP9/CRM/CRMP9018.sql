IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP9018]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP9018]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load dữ liệu màn hình chọn Từ điển hỗ trợ
-- <Param>
-- <Return>
-- <Reference>
-- <History>
---- Created by: Vĩnh Tâm, Date 11/4/2019
---- Modified by: Vĩnh Tâm	on: 25/01/2021: Load field Sản phẩm cho màn hình Chọn Từ điển hỗ trợ
/* <Example
	EXEC CRMP9018 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'ASOFTADMIN',@PageNumber=N'1',@PageSize=N'50',@ConditionDictionarySupportID=N''
 */

CREATE PROCEDURE CRMP9018 (
	@DivisionID NVARCHAR(2000),
	@TxtSearch NVARCHAR(250),
	@UserID VARCHAR(50),
	@ConditionDictionarySupportID NVARCHAR(MAX),
	@PageNumber INT,
	@PageSize INT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
DECLARE @CustomerName INT
IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#CustomerName'))
DROP TABLE #CustomerName
CREATE Table #CustomerName (CustomerName INT, ImportExcel INT)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

SET @sWhere = 'C00.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'
SET @TotalRow = ''
SET @OrderBy = ' C00.SupportDictionaryID'

IF @PageNumber = 1
	SET @TotalRow = 'COUNT(*) OVER ()'
ELSE
	SET @TotalRow = 'NULL'

IF ISNULL(@TxtSearch,'') != '' SET @sWhere = @sWhere + '
						AND (C00.SupportDictionaryID LIKE N''%' + @TxtSearch + '%''
						OR C00.SupportDictionarySubject LIKE N''%' + @TxtSearch + '%''
						OR C00.FeedbackDescription LIKE N''%' + @TxtSearch + '%''
						OR C00.RequestDescription LIKE N''%' + @TxtSearch + '%''
						OR C00.DivisionID LIKE N''%' + @TxtSearch + '%''
						OR O01.Description LIKE N''%' + @TxtSearch + '%''
						OR C01.Description LIKE N''%' + @TxtSearch + '%''
						OR C02.Description LIKE N''%' + @TxtSearch + '%''
						OR A01.InventoryName LIKE N''%' + @TxtSearch + '%'')'

IF ISNULL(@ConditionDictionarySupportID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(C00.CreateUserID,'''') IN (''' + @ConditionDictionarySupportID + ''') '

SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, ' + @TotalRow + ' AS TotalRow
			, C00.APK, C00.DivisionID, C00.SupportDictionaryID, C00.SupportDictionarySubject
			, C00.RequestDescription, C00.FeedbackDescription, C00.RelatedToTypeID
			, C00.KindID, O01.Description AS KindName
			, C00.PriorityID, C02.Description AS PriorityName
			, C00.InventoryID, A01.InventoryName
			, C00.TimeFeedback, C01.Description AS TimeFeedbackName
		FROM CRMT1090 C00 WITH (NOLOCK)
			LEFT JOIN CRMT0099 C01 WITH (NOLOCK) ON C01.ID = C00.TimeFeedback AND C01.CodeMaster = ''CRMT00000027''
			LEFT JOIN CRMT0099 C02 WITH (NOLOCK) ON C02.ID = C00.PriorityID AND C02.CodeMaster = ''CRMT00000006''
			LEFT JOIN AT1302 A01 WITH (NOLOCK) ON C00.DivisionID IN (A01.DivisionID, ''@@@'') AND A01.InventoryID = C00.InventoryID
			LEFT JOIN OOT0099 O01 WITH (NOLOCK) ON O01.CodeMaster = ''OOF2170.TypeOfRequest'' AND O01.ID = C00.KindID
		WHERE ' + @sWhere + '
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
