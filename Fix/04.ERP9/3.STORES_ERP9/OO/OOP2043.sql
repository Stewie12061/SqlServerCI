IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load thông tin detail Đơn xin bổ sung/hủy quẹt thẻ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 11/12/2015
---- Modified on 07/12/2016 by Bảo Thy: Bổ sung WorkingDate
---- Modified on 04/01/2019 by Bảo Anh: Lấy các thông tin duyệt theo các cấp
---- Modified on 17/07/2020 by Bảo Toàn: Bổ sung thông tin ca
-- <Example>
---- 
/*
   EXEC OOP2043 @DivisionID='MK',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@APKMaster='6377634F-31E8-404C-A29A-56B46A6FCCDD',@TranMonth=11,@TranYear=2016
   EXEC OOP2043 @DivisionID='CTY',@UserID='ASOFTADMIN',@PageNumber=NULL,@PageSize=25,@APKMaster='69A2719E-0E21-457B-A5BD-4F9A125B9127',@TranMonth=8,@TranYear=2015
*/
CREATE PROCEDURE OOP2043
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@APKMaster VARCHAR(50),
	@TranMonth INT,
	@TranYear INT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = ''

SET @OrderBy = ' BT.EmployeeID'
IF @PageNumber IS NULL 
BEGIN
	SET  @sSQL1=''
	SET @TotalRow = 'NULL'	
END
ELSE if @PageNumber = 1 
BEGIN
SET @TotalRow = 'COUNT(*) OVER ()'
SET @sSQL1 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
ELSE 
BEGIN
	SET @TotalRow = 'NULL'
	SET @sSQL1 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END

--- Trả dữ liệu duyệt theo dạng cột
----- Lấy người duyệt của từng cấp
SELECT	APKDetail, MAX([1]) AS ApprovePerson01ID, MAX([2]) AS ApprovePerson02ID, MAX([3]) AS ApprovePerson03ID,
		MAX([4]) AS ApprovePerson04ID, MAX([5]) AS ApprovePerson05ID
INTO #TAM1
FROM
(
SELECT *
FROM
(
SELECT *
FROM OOT9001 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND APKMaster = @APKMaster
) AS J
PIVOT
(
  MAX(ApprovePersonID) FOR Level IN ([1],[2],[3],[4],[5])
) AS P
) A
GROUP BY APKDetail
ORDER BY APKDetail

----- Lấy Status của từng cấp
SELECT	APKDetail, MAX([1]) AS ApprovePerson01Status, MAX([2]) AS ApprovePerson02Status, MAX([3]) AS ApprovePerson03Status,
		MAX([4]) AS ApprovePerson04Status, MAX([5]) AS ApprovePerson05Status
INTO #TAM2
FROM
(
SELECT *
FROM
(
SELECT *
FROM OOT9001 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND APKMaster = @APKMaster
) AS J
PIVOT
(
  MAX(Status) FOR Level IN ([1],[2],[3],[4],[5])
) AS P
) A
GROUP BY APKDetail
ORDER BY APKDetail

----- Lấy Ghi chú duyệt của từng cấp
SELECT	APKDetail, MAX([1]) AS ApprovePerson01Notes, MAX([2]) AS ApprovePerson02Notes, MAX([3]) AS ApprovePerson03Notes,
		MAX([4]) AS ApprovePerson04Notes, MAX([5]) AS ApprovePerson05Notes
INTO #TAM3
FROM
(
SELECT *
FROM
(
SELECT *
FROM OOT9001 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND APKMaster = @APKMaster
) AS J
PIVOT
(
  MAX(Note) FOR Level IN ([1],[2],[3],[4],[5])
) AS P
) A
GROUP BY APKDetail
ORDER BY APKDetail

--- Trả ra tất cả các thông tin duyệt theo từng nhân viên
SELECT	A.*,
		HV141.FullName AS ApprovePerson01Name, HV142.FullName AS ApprovePerson02Name, HV143.FullName AS ApprovePerson03Name, HV144.FullName AS ApprovePerson04Name, HV145.FullName AS ApprovePerson05Name,
		O991.[Description] AS ApprovePerson01StatusName, O992.[Description] AS ApprovePerson02StatusName, O993.[Description] AS ApprovePerson03StatusName, O994.[Description] AS ApprovePerson04StatusName, O995.[Description] AS ApprovePerson05StatusName
INTO #OOT9001
FROM
(
SELECT	T1.*, T2.ApprovePerson01Status, T2.ApprovePerson02Status, T2.ApprovePerson03Status, T2.ApprovePerson04Status, T2.ApprovePerson05Status,
		T3.ApprovePerson01Notes, T3.ApprovePerson02Notes, T3.ApprovePerson03Notes, T3.ApprovePerson04Notes, T3.ApprovePerson05Notes
FROM #TAM1 T1
LEFT JOIN #TAM2 T2 ON T1.APKDetail = T2.APKDetail
LEFT JOIN #TAM3 T3 ON T1.APKDetail = T3.APKDetail
) A
LEFT JOIN HV1400 HV141 ON HV141.DivisionID=@DivisionID AND HV141.EmployeeID=A.ApprovePerson01ID
LEFT JOIN HV1400 HV142 ON HV142.DivisionID=@DivisionID AND HV142.EmployeeID=A.ApprovePerson02ID
LEFT JOIN HV1400 HV143 ON HV143.DivisionID=@DivisionID AND HV143.EmployeeID=A.ApprovePerson03ID
LEFT JOIN HV1400 HV144 ON HV144.DivisionID=@DivisionID AND HV144.EmployeeID=A.ApprovePerson04ID
LEFT JOIN HV1400 HV145 ON HV145.DivisionID=@DivisionID AND HV145.EmployeeID=A.ApprovePerson05ID
LEFT JOIN OOT0099 O991 WITH (NOLOCK) ON O991.ID1=ISNULL(A.ApprovePerson01Status,0) AND O991.CodeMaster='Status'
LEFT JOIN OOT0099 O992 WITH (NOLOCK) ON O992.ID1=ISNULL(A.ApprovePerson02Status,0) AND O992.CodeMaster='Status'
LEFT JOIN OOT0099 O993 WITH (NOLOCK) ON O993.ID1=ISNULL(A.ApprovePerson03Status,0) AND O993.CodeMaster='Status'
LEFT JOIN OOT0099 O994 WITH (NOLOCK) ON O994.ID1=ISNULL(A.ApprovePerson04Status,0) AND O994.CodeMaster='Status'
LEFT JOIN OOT0099 O995 WITH (NOLOCK) ON O995.ID1=ISNULL(A.ApprovePerson05Status,0) AND O995.CodeMaster='Status'

SET @sSQL = '
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM
	(
	SELECT
		OOT24.APK, OOT24.APKMaster, OOT90.DivisionID,
		HT14.EmployeeID, HT14.FullName EmployeeName,
		OOT24.Reason, OOT24.Date, OOT24.Status, OOT24.Note, OOT24.InOut AS InOutID, O99.Description InOutName, OOT24.EditType, O991.Description EditTypeName,OOT24.DeleteFlag,
		0 AS FormStatus, OOT24.WorkingDate,
		OOT24.ApproveLevel, OOT24.ApprovingLevel, O999.Description AS StatusName,
		OOT91.ApprovePerson01ID, OOT91.ApprovePerson02ID, OOT91.ApprovePerson03ID, OOT91.ApprovePerson04ID, OOT91.ApprovePerson05ID,
		OOT91.ApprovePerson01Name, OOT91.ApprovePerson02Name, OOT91.ApprovePerson03Name, OOT91.ApprovePerson04Name, OOT91.ApprovePerson05Name,
		OOT91.ApprovePerson01Status, OOT91.ApprovePerson02Status, OOT91.ApprovePerson03Status, OOT91.ApprovePerson04Status, OOT91.ApprovePerson05Status,
		OOT91.ApprovePerson01StatusName, OOT91.ApprovePerson02StatusName, OOT91.ApprovePerson03StatusName, OOT91.ApprovePerson04StatusName, OOT91.ApprovePerson05StatusName,
		OOT91.ApprovePerson01Notes, OOT91.ApprovePerson02Notes, OOT91.ApprovePerson03Notes, OOT91.ApprovePerson04Notes, OOT91.ApprovePerson05Notes	
		,OOT24.ShiftID, HT1020.ShiftName
	FROM OOT9000 OOT90 WITH (NOLOCK)
	INNER JOIN OOT2040 OOT24 WITH (NOLOCK) ON OOT24.DivisionID = OOT90.DivisionID AND OOT90.APK = OOT24.APKMaster
	LEFT JOIN #OOT9001 OOT91 ON OOT24.APK = OOT91.APKDetail
	LEFT JOIN OOT0099 O999 WITH (NOLOCK) ON O999.ID1=ISNULL(OOT24.Status,0) AND O999.CodeMaster=''Status''
	LEFT JOIN HV1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT90.DivisionID AND HT14.EmployeeID = OOT24.EmployeeID
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT24.InOut,0) AND O99.CodeMaster=''InOut''
	LEFT JOIN OOT0099 O991 WITH (NOLOCK) ON O991.ID1=ISNULL(OOT24.EditType,0) AND O991.CodeMaster=''EditType''
	LEFT JOIN HT1020 WITH(NOLOCK) ON OOT90.DivisionID = HT1020.DivisionID AND OOT24.ShiftID = HT1020.ShiftID
		WHERE OOT90.Type=''DXBSQT''
		--AND OOT90.TranMonth = '+STR(@TranMonth)+'
		--AND OOT90.TranYear = '+STR(@TranYear)+'
		AND OOT90.DivisionID = '''+@DivisionID+'''
		AND OOT90.APK = '''+@APKMaster+'''
	)BT
		
ORDER BY '+@OrderBy+'
'+@sSQL1
	
	
EXEC (@sSQL)
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
