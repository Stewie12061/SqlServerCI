IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2064]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2064]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- tại Form OOF2060: cập nhật Thực tế hàng loạt
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by: Trần Quốc Tuấn, Date: 07/12/2015
-- <Example>
---- 
/*
exec OOP2064 @DivisionID=N'MK',@UserID=N'000054',@TranMonth=9,@TranYear=2016,@PageNumber=1,@PageSize=10000,@IsSearch=1,@EmployeeID=NULL,@UnusualTypeID=NULL,
@DepartmentID=NULL,@SectionID=NULL,@SubsectionID=NULL,@ProcessID=NULL,@FromDate='2016-09-01 00:00:00',@ToDate='2016-09-10 00:00:00',@EmployeeName=NULL,
@Fact = 'BT0002', @APKList = 'F18ABB2F-79D4-442C-A74F-0003E749D84C', @IsCheckALL = 0
*/
CREATE PROCEDURE OOP2064
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@IsSearch TINYINT,
	@TranMonth INT,
	@TranYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@EmployeeID VARCHAR(50),
	@EmployeeName NVARCHAR(250),
	@DepartmentID VARCHAR(50),
	@SectionID VARCHAR(50),
	@SubsectionID VARCHAR(50),
	@ProcessID VARCHAR(50),
	@UnusualTypeID VARCHAR(50),
	@Fact VARCHAR(50),
	@APKList VARCHAR(MAX), 
	@IsCheckALL TINYINT,
	@IsApproved TINYINT = 0
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @sWhere1 NVARCHAR(MAX) = ''

--IF @IsSearch = 1
--BEGIN
	IF @EmployeeID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT26.EmployeeID,'''') LIKE ''%'+@EmployeeID+'%'' '
	IF @EmployeeName IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(HV14.FullName,'''') LIKE N''%'+@EmployeeName+'%'' '
	IF @DepartmentID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(HV14.DepartmentID,'''') LIKE ''%'+@DepartmentID+'%'' '
	IF @SectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(HV14.TeamID,'''') LIKE ''%'+@SectionID+'%'' '
	IF @SubsectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(HV14.Ana04ID,'''') LIKE ''%'+@SubsectionID+'%'' '
	IF @ProcessID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(HV14.Ana05ID,'''') LIKE ''%'+@ProcessID+'%'' '
	IF @UnusualTypeID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT26.JugdeUnusualType,'''') LIKE ''%'+@UnusualTypeID+'%'' '	
	IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND ISNULL(CONVERT(VARCHAR, OOT26.WorkingDate, 112),'''') BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromDate, 112),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToDate, 112),'')+''' '
--END
IF @IsCheckALL=0 SET @sWhere1='AND OOT26.APK IN ('''+@APKList+''')'

SET @sSQL ='
UPDATE  OOT26
SET Fact= '''+@Fact+''',
HandleMethodID= (SELECT HandleMethodID FROM OOT1010 WHERE OOT1010.DivisionID  = '''+@DivisionID+''' AND OOT1010.UnusualTypeID = '''+@Fact+'''),
LastModifyDate = GETDATE(),
LastModifyUserID = '''+@UserID+'''
 --SELECT *
FROM OOT2060 OOT26
LEFT JOIN HV1400 HV14 ON HV14.DivisionID = OOT26.DivisionID AND HV14.EmployeeID = OOT26.EmployeeID
WHERE OOT26.DivisionID = '''+@DivisionID+'''
AND ISNULL(OOT26.Status,0) <> 1 AND Isnull(OOT26.HandleMethodID,'''') <> ''''
AND OOT26.TranMonth = '+STR(@TranMonth)+'
AND OOT26.TranYear = '+STR(@TranYear)+
CASE WHEN @IsApproved = 1 THEN '
AND EXISTS (SELECT TOP 1 1 FROM OOT2010 T2 INNER JOIN OOT9000 T3 ON T2.APKMaster = T3.APK 
					WHERE OOT26.EmployeeID = T2.EmployeeID AND T3.Status = 1 AND T2.Status = 1
					AND  (OOT26.[Date]+Cast(Convert(Time,BeginTime) as Datetime)) Between LeaveFromDate and LeaveToDate
					AND  (OOT26.[Date]+Cast(Convert(Time,EndTime) as Datetime)) Between LeaveFromDate and LeaveToDate )
'
ELSE '
AND NOT EXISTS (SELECT TOP 1 1 FROM OOT2010 T2 INNER JOIN OOT9000 T3 ON T2.APKMaster = T3.APK 
					WHERE OOT26.EmployeeID = T2.EmployeeID AND T3.Status = 1 AND T2.Status = 1
					AND  (OOT26.[Date]+Cast(Convert(Time,BeginTime) as Datetime)) Between LeaveFromDate and LeaveToDate
					AND  (OOT26.[Date]+Cast(Convert(Time,EndTime) as Datetime)) Between LeaveFromDate and LeaveToDate )
'
END+'
'+@sWhere+'
'+@sWhere1+'	
'

EXEC (@sSQL)
--PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
