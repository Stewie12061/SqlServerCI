IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2073]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2073]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin detail Đơn xin đổi ca
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 23/02/2016
--- Modified on 04/01/2019 by Bảo Anh: Lấy các thông tin duyệt theo các cấp
--- Modified on 06/08/2020 by Trọng Kiên: Fix lỗi trùng dữ liệu trả về
-- <Example>
---- 
/*
   EXEC OOP2073 @DivisionID='CTY',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@APKMaster='27718131-DF2A-4278-9729-19811653C909',@TranMonth=12,@TranYear=2015
   EXEC OOP2073 @DivisionID='MK',@UserID='000715',@PageNumber=NULL,@PageSize=25,@APKMaster='DF0F7A2A-9B2B-4387-AF72-1407FBD92CBE',@TranMonth=6,@TranYear=2016
*/
CREATE PROCEDURE OOP2073
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
GROUP BY A.APKDetail, A.ApprovePerson01Status, A.ApprovePerson02Status, A.ApprovePerson03Status, A.ApprovePerson04Status, A.ApprovePerson05Status,
		A.ApprovePerson01Notes, A.ApprovePerson02Notes, A.ApprovePerson03Notes, A.ApprovePerson04Notes, A.ApprovePerson05Notes, HV141.FullName, HV142.FullName, HV143.FullName, HV144.FullName, HV145.FullName,
		O991.[Description], O992.[Description], O993.[Description], O994.[Description], O995.[Description], A.ApprovePerson01ID, A.ApprovePerson02ID, A.ApprovePerson03ID, A.ApprovePerson04ID, A.ApprovePerson05ID

SET @sSQL = '
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM
	(
SELECT 
		OOT27.APK, OOT27.APKMaster, OOT27.DivisionID,
		HT14.EmployeeID,HT14.FullName EmployeeName, OOT27.ShiftID,
		CONVERT(VARCHAR(10), OOT27.ChangeFromDate, 103) AS ChangeFromDate, CONVERT(VARCHAR(10), OOT27.ChangeToDate, 103) AS ChangeToDate,
		OOT27.Note, OOT27.DeleteFlag, 0 AS FormStatus,
		OOT27.ApproveLevel, OOT27.ApprovingLevel, O99.Description AS StatusName,
		OOT91.ApprovePerson01ID, OOT91.ApprovePerson02ID, OOT91.ApprovePerson03ID, OOT91.ApprovePerson04ID, OOT91.ApprovePerson05ID,
		OOT91.ApprovePerson01Name, OOT91.ApprovePerson02Name, OOT91.ApprovePerson03Name, OOT91.ApprovePerson04Name, OOT91.ApprovePerson05Name,
		OOT91.ApprovePerson01Status, OOT91.ApprovePerson02Status, OOT91.ApprovePerson03Status, OOT91.ApprovePerson04Status, OOT91.ApprovePerson05Status,
		OOT91.ApprovePerson01StatusName, OOT91.ApprovePerson02StatusName, OOT91.ApprovePerson03StatusName, OOT91.ApprovePerson04StatusName, OOT91.ApprovePerson05StatusName,
		OOT91.ApprovePerson01Notes, OOT91.ApprovePerson02Notes, OOT91.ApprovePerson03Notes, OOT91.ApprovePerson04Notes, OOT91.ApprovePerson05Notes
FROM OOT2070 OOT27 WITH (NOLOCK)
	INNER JOIN HV1400 HT14 ON HT14.DivisionID = OOT27.DivisionID AND HT14.EmployeeID = OOT27.EmployeeID
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT27.Status,0) AND O99.CodeMaster=''Status''
	LEFT JOIN #OOT9001 OOT91 ON OOT27.APK = OOT91.APKDetail
		WHERE OOT27.DivisionID = '''+@DivisionID+'''
		AND OOT27.APKMaster = '''+@APKMaster+'''
	)BT
		
ORDER BY '+@OrderBy+' '+@sSQL1
	
EXEC (@sSQL)
--PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
