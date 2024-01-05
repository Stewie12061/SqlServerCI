IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP0010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP0010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load dữ liệu API Grid Đầu mối lâu không tương tác trên màn hình Dashboard_CRM
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoài Bảo - [09/06/2021]
----Updated by: Hoài Bảo - [12/07/2021] - Bỏ check trạng thái và kỳ Null
-- <Example>
/*
    EXEC CRMP0010 @DivisionID='DTI', @ToDay='2021-06-09 23:11:03', @ListUserID='ASOFTADMIN'',''D11001', @PeriodIDList = '04/2021', @CompareDate=10, @LeadStatus= 'TTDM01'',''TTDM02'
*/
CREATE proc [dbo].[CRMP0010]
(
	@DivisionID VARCHAR(50),
	@ToDay DATETIME,
	@ListUserID VARCHAR(MAX) = NULL,
	@PeriodIDList VARCHAR(2000),
	@CompareDate SMALLINT,  --Số ngày tối đa không tương tác: Tính từ ngày tương tác cuối cùng đến ngày hiện tại.
	@LeadStatus VARCHAR(200)
)
AS
BEGIN
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@sLeadTime VARCHAR(MAX),
		@DayCompare VARCHAR(10)
	
	SET @sLeadTime = ''
	SET @DayCompare = CONVERT(NVARCHAR(10), DATEADD(DAY,-@CompareDate, @ToDay), 111)

	SET @sWhere = ' AND ISNULL(C3.DeleteFlg, 0) = 0 AND C1.LeadStatusID NOT IN (''CANCLE'')'

	SET @sWhere = @sWhere + ' AND C1.DivisionID = ''' + @DivisionID + ''''

	SET @sWhere = @sWhere + ' AND C1.AssignedToUserID IN (''' + @ListUserID + ''')'

	SET @sWhere = @sWhere + ' AND C1.LeadStatusID IN (''' + @LeadStatus + ''')'

	--Set điều kiện thời gian cho Cơ hội
	SET @sLeadTime = ' AND (CASE WHEN MONTH(C1.CreateDate) < 10 THEN ''0'' + RTRIM(LTRIM(MONTH(C1.CreateDate))) + ''/'' + RTRIM(LTRIM(YEAR(C1.CreateDate)))
				ELSE RTRIM(LTRIM(MONTH(C1.CreateDate))) + ''/'' + RTRIM(LTRIM(YEAR(C1.CreateDate))) END) IN (''' + @PeriodIDList + ''')'

	SET @sSQL = '
	SELECT ROW_NUMBER() OVER (ORDER BY T.LeadID DESC) AS RowNum ,*
	FROM
	(
		SELECT DISTINCT C1.APK, C1.LeadID, C1.LeadName, C1.LeadMobile, C1.Email, A1.FullName AS AssignedToUserName, A2.StageName AS LeadStatusName
		FROM CRMT20301 C1 WITH (NOLOCK)
		INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = C1.AssignedToUserID
		LEFT JOIN CRMT10401 A2 WITH (NOLOCK) ON C1.LeadStatusID = A2.StageID
		LEFT JOIN CRMT90031_REL C2 ON C1.APK = C2.RelatedToID
		LEFT JOIN CRMT90031 C3 ON C2.NotesID = C3.NotesID
		WHERE CONVERT(NVARCHAR(10), C1.LastModifyDate, 111) < ''' + @DayCompare + ''' AND (CONVERT(NVARCHAR(10), C3.LastModifyDate, 111) < ''' + @DayCompare + ''' OR C3.LastModifyDate IS NULL)' 
		+ @sLeadTime + @sWhere + '
	) AS T
	ORDER BY T.LeadID DESC'

	--PRINT(@sSQL)
	EXEC (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
