IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load thông tin detail Đơn xin làm thêm giờ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 10/12/2015
---- Modified on 07/12/2016 by Bảo Thy: Bổ sung FromWorkingDate, ToWorkingDate
---- Modified on 04/01/2019 by Bảo Anh: Lấy các thông tin duyệt theo các cấp
---- Modified on 20/05/2020 by Bảo Toàn: Bổ sung hiển thị mô tả ca
---- Modified on 06/06/2020 by Bảo Toàn: Tính lại tổng giá trị OT.
---- Modified on 19/12/2020 by Hoài Phong: lấy lại tổng giá trị OT ở OOT2030. và lấy thêm cột WorkDate
---- Modified on 04/10/2021 by Văn Tài	 : Hỗ trợ sắp xếp theo mã nhân viên.
-- <Example>
---- 
/*
   exec OOP2033 @DivisionID=N'MK',@UserID=N'000021',@APKMaster=N'17FC9084-384F-477D-9A7C-D9AD2754B874',@tranMonth=11,@TranYear=2016,@PageNumber=1,
   @PageSize=10,@DepartmentID=N'K1',@SectionID=N'%',@SubsectionID=N'%',@ProcessID=N'%'
   
exec OOP2033 @DivisionID=N'MK',@UserID=N'000110',@APKMaster=N'e84e8cd0-4936-4ec5-94a1-2dca6a1906b8',
@tranMonth=2,@TranYear=2016,@PageNumber=1,@PageSize=50,@DepartmentID=N'A000000',@SectionID=N'%',@SubsectionID=N'%',@ProcessID=N'%'
*/
CREATE PROCEDURE OOP2033
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT=1,
	@PageSize INT=50,
	@APKMaster VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@DepartmentID VARCHAR(50),
	@SectionID VARCHAR(50),
	@SubsectionID VARCHAR(50),
	@ProcessID VARCHAR(50)
)
AS
DECLARE @Cur CURSOR,
		@sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = '',
		@EmployeeID VARCHAR(50),
		@Date DATETIME
		
SET @OrderBy = 'BT.EmployeeID, BT.WorkFromDate '
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

CREATE TABLE #Shift (ShiftID VARCHAR(50),EmployeeID VARCHAR(50), [Date] DATE, IsNextDay TINYINT, FromWorkingDate DATETIME, ToWorkingDate DATETIME)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT Distinct EmployeeID,CONVERT(Date,WorkFromDate,113) FROM oot2030 WITH (NOLOCK) WHERE APKMaster=@ApkMaster

OPEN @Cur 
FETCH NEXT FROM @Cur INTO  @EmployeeID, @Date
WHILE @@FETCH_STATUS = 0
BEGIN	

	INSERT #Shift
	EXEC OOP2034 @DivisionID, @UserID, @Date, @EmployeeID

FETCH NEXT FROM @Cur INTO @EmployeeID, @Date
END 
Close @Cur

SET @sSQL='
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, BT.*,0.0 OffsetTime, 0.0 AS TimeAllowance,
CONVERT(DECIMAL(28,2),(ISNULL(BT.OvertTime,0)- ISNULL(BT.TimeLaw,0))) OvertTimeNN,
CONVERT(DECIMAL(28,2),(ISNULL(BT.OvertTime,0)- ISNULL(BT.TimeCompany,0))) OvertTimeCompany
	FROM
	(
	SELECT 
		OOT2030.APK, OOT2030.APKMaster, OOT90.DivisionID,
		HT14.EmployeeID, HT14.FullName EmployeeName,
		OOT2030.Reason, 
		--cast(DATEDIFF(mi,OOT2030.WorkFromDate,OOT2030.WorkToDate) AS DECIMAL(28,2))/ 60 AS TotalOT,
		--dbo.GetTotalOTWithShift(OOT90.DivisionID, HT14.EmployeeID,OOT2030.WorkFromDate,OOT2030.WorkToDate, OOT2030.ShiftID) AS TotalOT,
		OOT2030.TotalOT,OOT2030.WorkDate,
		OOT2030.WorkFromDate, OOT2030.WorkToDate, OOT2030.Status, OOT2030.ShiftID, H20.ShiftName, OOT2030.Note, OOT2030.DeleteFlag,
		CONVERT(DECIMAL(28,2),ISNULL(C.OvertTime,0)) OvertTime, CONVERT(DECIMAL(28,2),OT20.TimeLaw) TimeLaw,CONVERT(DECIMAL(28,2),OT20.TimeCompany) TimeCompany, 
		0 AS FormStatus, #Shift.ShiftID ShiftNow, OOT2030.FromWorkingDate, OOT2030.ToWorkingDate,
		OOT2030.ApproveLevel, OOT2030.ApprovingLevel, O99.Description AS StatusName,
		OOT91.ApprovePerson01ID, OOT91.ApprovePerson02ID, OOT91.ApprovePerson03ID, OOT91.ApprovePerson04ID, OOT91.ApprovePerson05ID,
		OOT91.ApprovePerson01Name, OOT91.ApprovePerson02Name, OOT91.ApprovePerson03Name, OOT91.ApprovePerson04Name, OOT91.ApprovePerson05Name,
		OOT91.ApprovePerson01Status, OOT91.ApprovePerson02Status, OOT91.ApprovePerson03Status, OOT91.ApprovePerson04Status, OOT91.ApprovePerson05Status,
		OOT91.ApprovePerson01StatusName, OOT91.ApprovePerson02StatusName, OOT91.ApprovePerson03StatusName, OOT91.ApprovePerson04StatusName, OOT91.ApprovePerson05StatusName,
		OOT91.ApprovePerson01Notes, OOT91.ApprovePerson02Notes, OOT91.ApprovePerson03Notes, OOT91.ApprovePerson04Notes, OOT91.ApprovePerson05Notes
	FROM OOT9000 OOT90 WITH (NOLOCK)
	LEFT JOIN OOT0020 OT20 WITH (NOLOCK) ON OT20.DivisionID = OOT90.DivisionID AND OT20.TranMonth='+STR(@TranMonth)+' AND OT20.TranYear='+STR(@TranYear)+'
	LEFT JOIN OOT2030 WITH (NOLOCK) ON OOT2030.DivisionID = OOT90.DivisionID AND OOT2030.APKMaster = OOT90.APK
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT2030.Status,0) AND O99.CodeMaster=''Status''
	LEFT JOIN HV1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT90.DivisionID AND HT14.EmployeeID = OOT2030.EmployeeID
	LEFT JOIN #OOT9001 OOT91 ON OOT2030.APK = OOT91.APKDetail
	LEFT JOIN #Shift ON #Shift.EmployeeID = OOT2030.EmployeeID AND #Shift.Date = CONVERT(DATE, OOT2030.WorkFromDate)
	LEFT JOIN HT1020 H20 WITH (NOLOCK) ON OOT2030.ShiftID = H20.ShiftID AND OOT90.DivisionID = H20.DivisionID
	LEFT JOIN (	
	SELECT  ISNULL(SUM(CASE UnitID WHEN ''H'' THEN AbsentAmount
				WHEN ''D'' THEN (AbsentAmount*8) END),0) OvertTime,EmployeeID,A.DivisionID
	FROM HT2401 A WITH (NOLOCK)
	LEFT JOIN HT1013 B WITH (NOLOCK) ON A.DivisionID=B.DivisionID AND A.AbsentTypeID=B.AbsentTypeID
	LEFT JOIN OOT0020 OOT20 WITH (NOLOCK) ON A.DivisionID=OOT20.DivisionID AND A.TranMonth=OOT20.TranMonth AND A.TranYear=OOT20.TranYear
	WHERE TypeID =''OT'' AND ISNULL(B.IsMonth,0)=0
	AND A.TranMonth='+STR(@TranMonth)+' AND A.TranYear='+STR(@TranYear)+'
	GROUP BY A.EmployeeID,A.DivisionID
	)C ON C.DivisionID = HT14.DivisionID AND C.EmployeeID =HT14.EmployeeID

	WHERE OOT90.Type=''DXLTG''
		--AND OOT90.TranMonth = '+STR(@TranMonth)+'
		--AND OOT90.TranYear = '+STR(@TranYear)+'
		AND OOT90.DivisionID = '''+@DivisionID+'''
		AND OOT90.APK = '''+@APKMaster+''' 
	)BT

ORDER BY '+@OrderBy+'
'+@sSQL1

PRINT(@sSQL)
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
