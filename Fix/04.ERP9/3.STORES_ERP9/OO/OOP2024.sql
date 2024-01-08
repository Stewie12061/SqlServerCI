IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----In Đơn xin phép ra ngoài
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 17/05/2016
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối từ danh mục phòng ban
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
-- <Example>
---- 
/*
   EXEC OOP2024 @DivisionID='MK',@UserID='000110',@APKMaster='8935B73C-D0BA-49D4-99E2-C8CB8E2B3526',@TranMonth=5,@TranYear=2016
   
*/
CREATE PROCEDURE OOP2024
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APKMaster VARCHAR(50),
	@TranMonth INT,
	@TranYear INT
)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@Level INT,
		@i INT = 1, @s VARCHAR(2),
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = ''

SET @OrderBy = ' BT.EmployeeID'
CREATE TABLE #Approve (ID varchar(50), TitleName NVARCHAR(250), [Level] VARCHAR(2),ApprovePerson NVARCHAR(250),[Status] NVARCHAR(250))

SET @Level = ISNULL((SELECT TOP 1 level FROM OOT0010 WHERE DivisionID = @DivisionID AND AbsentType = 'DXRN'AND TranMonth=@TranMonth AND TranYear=@TranYear), 0) 	
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+', ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, ApprovePerson'+@s+'Status'
		SET @sSQLJon =@sSQLJon+ '
						INSERT INTO #Approve (ID, TitleName, [Level],  ApprovePerson, Status)
						SELECT ApprovePersonID ApprovePerson'+@s+'ID,TitleName, '+@s+', 
						Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) 
						+ '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As ApprovePerson'+@s+'Name, O99.Description ApprovePerson'+@s+'Status
						FROM OOT9001 OOT1
						INNER JOIN HT1400 HT14 ON HT14.DivisionID=OOT1.DivisionID AND HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN HT1403 HT13 ON HT13.DivisionID=OOT1.DivisionID AND HT13.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN HT1106 HT16 ON HT16.DivisionID=OOT1.DivisionID AND HT13.TitleID=HT16.TitleID
						LEFT JOIN OOT0099 O99 ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						LEFT JOIN OOT9000 OOT90 ON OOT1.DivisionID= OOT90.DivisionID  AND OOT1.APKMaster=OOT90.APK
						WHERE OOT1.DivisionID = '''+@DivisionID+''' AND OOT1.Level='+STR(@i)+' AND OOT1.APKMaster = '''+@APKMaster+'''
						AND OOT90.Type=''DXRN'' '	
		SET @i = @i + 1		
	END	
	
SET @sSQL = N'
SELECT   *
	FROM
	(
	SELECT HT14.EmployeeID,HT14.FullName EmployeeName,
		OOT22.Place+'': ''+ OOT22.Reason PlaceAndReason , OOT22.GoFromDate, OOT22.GoStraight, 
		OOT22.GoToDate, OOT22.ComeStraight, N''Đi thẳng'' GoName, N''Về thẳng'' ComeName
	FROM OOT9000 OOT90 
	INNER JOIN OOT2020 OOT22 ON OOT22.DivisionID = OOT90.DivisionID AND OOT90.APK = OOT22.APKMaster
	INNER JOIN HV1400 HT14 ON HT14.DivisionID = OOT22.DivisionID AND HT14.EmployeeID = OOT22.EmployeeID
		WHERE OOT90.Type=''DXRN''
		--AND OOT90.TranMonth = '+STR(@TranMonth)+'
		--AND OOT90.TranYear = '+STR(@TranYear)+'
		AND OOT90.DivisionID = '''+@DivisionID+'''
		AND OOT90.APK = '''+@APKMaster+'''
	)BT	
ORDER BY '+@OrderBy+' '

----Trả datasheet---
EXEC (@sSQLJon)
SELECT *  FROM #Approve
ORDER BY [Level] DESC

SELECT OOT90.DivisionID, A11.DepartmentName, OOT90.AskForVehicle,OOT90.UseVehicle,
		OOT90.HaveLunch,O99.[Description] StatusName, OOT90.CreateDate
FROM OOT9000 OOT90
LEFT JOIN OOT0099 O99 ON O99.ID1=ISNULL(OOT90.Status,0) AND O99.CodeMaster='Status'
LEFT JOIN AT1102 A11 ON A11.DepartmentID=OOT90.DepartmentID 
WHERE OOT90.DivisionID = @DivisionID AND OOT90.APK= @APKMaster
AND OOT90.Type='DXRN'

EXEC (@sSQL)

--PRINT(@sSQL)
--PRINT(@sSQLJon)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
