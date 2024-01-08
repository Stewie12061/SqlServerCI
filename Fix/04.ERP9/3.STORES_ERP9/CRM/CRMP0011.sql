IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP0011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP0011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load dữ liệu API Grid Cơ hội lâu không tương tác trên màn hình Dashboard_CRM
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoài Bảo - [09/06/2021]
----Updated by: Hoài Bảo - [12/07/2021] - Lọc theo kỳ dựa trên ngày dự kiến kết thúc, bỏ check trạng thái và kỳ Null
-- <Example>
/*
    EXEC CRMP0011 @DivisionID='DTI', @ToDay='2021-06-09 23:11:03', @ListUserID='D31003'',''USER03', @PeriodIDList = '06/2021',@CompareDate=10, @OpportunityStatus = '01'',''02'
*/
CREATE proc [dbo].[CRMP0011]
(
	@DivisionID VARCHAR(50),
	@ToDay DATETIME,
	@ListUserID VARCHAR(MAX) = NULL,
	@PeriodIDList VARCHAR(2000),
	@CompareDate INT,  --Số ngày tối đa không tương tác: Tính từ ngày tương tác cuối cùng đến ngày hiện tại.
	@OpportunityStatus VARCHAR(200)
)
AS
BEGIN
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@sOpportunityTime VARCHAR(MAX),
		@DayCompare VARCHAR(10)
	
	SET @sOpportunityTime = ''
	SET @DayCompare = CONVERT(NVARCHAR(10), DATEADD(DAY,-@CompareDate, @ToDay), 111)
	
	SET @sWhere = ' AND ISNULL(C3.DeleteFlg, 0) = 0 AND A2.StageID NOT IN (''WIN'',''LOST'')'

	SET @sWhere = @sWhere + ' AND C1.DivisionID = ''' + @DivisionID + ''''

	SET @sWhere = @sWhere + ' AND C1.AssignedToUserID IN (''' + @ListUserID + ''')'

	SET @sWhere = @sWhere + ' AND C1.StageID IN (''' + @OpportunityStatus + ''')'

	--Set điều kiện thời gian cho Cơ hội
	SET @sOpportunityTime = ' AND (CASE WHEN MONTH(C1.ExpectedCloseDate) < 10 THEN ''0'' + RTRIM(LTRIM(MONTH(C1.ExpectedCloseDate))) + ''/'' + RTRIM(LTRIM(YEAR(C1.ExpectedCloseDate)))
				ELSE RTRIM(LTRIM(MONTH(C1.ExpectedCloseDate))) + ''/'' + RTRIM(LTRIM(YEAR(C1.ExpectedCloseDate))) END) IN (''' + @PeriodIDList + ''')'

	SET @sSQL = '
	SELECT ROW_NUMBER() OVER (ORDER BY T.OpportunityID DESC) AS RowNum , *
	FROM
	(
		SELECT DISTINCT C1.APK, C1.OpportunityID, C1.OpportunityName, A2.StageName, A1.FullName AS AssignedToUserName, C1.StartDate, C1.ExpectedCloseDate
		FROM CRMT20501 C1 WITH (NOLOCK)
		INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = C1.AssignedToUserID
		LEFT JOIN CRMT10401 A2 WITH (NOLOCK) ON C1.StageID = A2.StageID
		LEFT JOIN CRMT90031_REL C2 WITH (NOLOCK) ON C1.APK = C2.RelatedToID
		LEFT JOIN CRMT90031 C3 WITH (NOLOCK) ON C2.NotesID = C3.NotesID
		WHERE CONVERT(NVARCHAR(10), C1.LastModifyDate, 111) < ''' + @DayCompare + ''' AND (CONVERT(NVARCHAR(10), C3.LastModifyDate, 111) < ''' + @DayCompare + ''' OR C3.LastModifyDate IS NULL)' 
		+ @sOpportunityTime + @sWhere + '
	) AS T
	ORDER BY T.OpportunityID DESC'

	--PRINT(@sSQL)
	EXEC (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
