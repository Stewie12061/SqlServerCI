IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0199]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0199]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xuất Excel dử liệu quét thẻ HF0197
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 24/08/2016
 --- Modified by Phương Thảo on 17/05/2017 : Sửa danh mục dùng chung
/*-- <Example>
	HP0199 @DivisionID='MK',@UserID='ASOFTADMIN',@TranMonth=6, @TranYear=2016,
	@FromDate='2016-06-01',@ToDate='2016-06-30'
----*/

CREATE PROCEDURE HP0199
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = ''
      
SET @OrderBy = 'HT14.DepartmentID,HT14.TeamID,HT28.EmployeeID,HT28.NewAbsentDate'
	
SELECT HT2408.APK,HT2408.DivisionID,HT2408.EmployeeID,HT2408.TranMonth,HT2408.TranYear,HT2408.AbsentCardNo,HT2408.AbsentDate, HT2408.AbsentDate NewAbsentdate,
HT2408.AbsentTime,HT2408.CreateUserID,HT2408.CreateDate,HT2408.LastModifyUserID,HT2408.LastModifyDate,HT2408.MachineCode,HT2408.IOCode,HT2408.InputMethod,
HT2408.APKMaster,HT2408.IsScan,Convert(Tinyint,null) AS IsNextDay,
Isnull(ShiftCode,CASE Day(AbsentDate)
				WHEN 1 THEN H25.D01 WHEN 2 THEN H25.D02 WHEN 3 THEN H25.D03 WHEN 4 THEN H25.D04 WHEN 5 THEN H25.D05 WHEN 6 THEN H25.D06 WHEN    
				7 THEN H25.D07 WHEN 8 THEN H25.D08 WHEN 9 THEN H25.D09 WHEN 10 THEN H25.D10 WHEN 11 THEN H25.D11 WHEN 12 THEN H25.D12 WHEN    
				13 THEN H25.D13 WHEN 14 THEN H25.D14 WHEN 15 THEN H25.D15 WHEN 16 THEN H25.D16 WHEN 17 THEN H25.D17 WHEN 18 THEN H25.D18 WHEN    
				19 THEN H25.D19 WHEN 20 THEN H25.D20 WHEN 21 THEN H25.D21 WHEN 22 THEN H25.D22 WHEN 23 THEN H25.D23 WHEN 24 THEN H25.D24 WHEN    
				25 THEN H25.D25 WHEN 26 THEN H25.D26 WHEN 27 THEN H25.D27 WHEN 28 THEN H25.D28 WHEN 29 THEN H25.D29 WHEN 30 THEN H25.D30 WHEN    
				31 THEN H25.D31 ELSE NULL END) as ShiftCode
INTO #HT2408
FROM HT2408
LEFT JOIN HT1025 AS H25 ON HT2408.EmployeeID = H25.EmployeeID and HT2408.DivisionID = H25.DivisionID AND H25.TranMonth = HT2408.TranMonth 
AND H25.TranYear = HT2408.TranYear
WHERE HT2408.TranMonth = @TranMonth AND HT2408.TranYear = @TranYear
AND HT2408.AbsentDate BETWEEN  @FromDate AND @ToDate
--AND HT2408.employeeid = '000265'


--SELECT * FROM #HT2408

UPDATE	T1
SET		T1.IsNextDay = T2.IsNextDay
FROM	#HT2408 T1
INNER JOIN 
(	SELECT	DivisionID, ShiftID, MAX(IsNextDay) AS IsNextDay, DateTypeID
	FROM	HT1021 
	WHERE	Isnull(IsNextDay,0) <> 0  
	GROUP BY 	DivisionID, ShiftID, DateTypeID
) T2 ON T1.DivisionID = T2.DivisionID  and T1.ShiftCode = T2.ShiftID AND LEFT(Datename(dw,T1.AbsentDate),3) = T2.DateTypeID

--UPDATE T1
--SET T1.NewAbsentdate = DATEADD(d,-1,T1.Absentdate)
--FROM #HT2408 T1
--LEFT JOIN HT1021 ON T1.ShiftCode = HT1021.ShiftID
--WHERE IsNextDay = 1 AND T1.IOCode = 1
--AND LEFT(Datename(dw,T1.AbsentDate),3) = HT1021.DateTypeID


UPDATE T1
SET		T1.NewAbsentdate = T1.AbsentDate - 1
FROM #HT2408 T1
WHERE (T1.IsNextDay is null  or T1.IsNextDay = 1) AND T1.IOCode = 1
AND EXISTS (SELECT TOP 1 1 FROM #HT2408 T2             
            WHERE T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID and
														T2.AbsentDate = T1.AbsentDate - 1 and T2.IsNextDay = 1 and T2.IOCode = 0)

UPDATE T1
SET		T1.ShiftCode =  CASE Day(T1.NewAbsentDate)     
                      WHEN 1 THEN T2.D01 WHEN 2 THEN T2.D02 WHEN 3 THEN T2.D03 WHEN 4 THEN T2.D04 WHEN 5 THEN T2.D05 WHEN 6 THEN T2.D06 WHEN    
                       7 THEN T2.D07 WHEN 8 THEN T2.D08 WHEN 9 THEN T2.D09 WHEN 10 THEN T2.D10 WHEN 11 THEN T2.D11 WHEN 12 THEN T2.D12 WHEN    
                       13 THEN T2.D13 WHEN 14 THEN T2.D14 WHEN 15 THEN T2.D15 WHEN 16 THEN T2.D16 WHEN 17 THEN T2.D17 WHEN 18 THEN T2.D18 WHEN    
                       19 THEN T2.D19 WHEN 20 THEN T2.D20 WHEN 21 THEN T2.D21 WHEN 22 THEN T2.D22 WHEN 23 THEN T2.D23 WHEN 24 THEN T2.D24 WHEN    
                       25 THEN T2.D25 WHEN 26 THEN T2.D26 WHEN 27 THEN T2.D27 WHEN 28 THEN T2.D28 WHEN 29 THEN T2.D29 WHEN 30 THEN T2.D30 WHEN    
                       31 THEN T2.D31 ELSE NULL END
FROM #HT2408 T1
LEFT JOIN HT1025 AS T2 ON T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth 
AND T1.TranYear = T2.TranYear
WHERE T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear

--SELECT * FROM #ht2408 WHERE tranmonth=9 AND tranyear = 2016 AND employeeid = '000803' ORDER BY absentdate, iocode, absenttime
SET @sSQL = N'
select ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, HT28.DivisionID, HT28.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As FullName, 
	HT14.DepartmentID, A11.DepartmentName AS DepartmentName01, HT14.TeamID,  A12.TeamName AS TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
	HT28.NewAbsentDate AS AbsentDate, HT28.ShiftCode,
    CASE WHEN Min(IOCODE) = 0 THEN CONVERT(TIME(0),MIN(HT28.AbsentDate+Cast(HT28.AbsentTime as Datetime))) ELSE NULL END AS InTime,  
	 CASE WHEN MAX(IOCODE) = 1 THEN CONVERT(TIME(0),MAX(HT28.AbsentDate+Cast(HT28.AbsentTime as Datetime))) ELSE NULL END AS OutTime

FROM #HT2408 HT28 WITH (NOLOCK)
LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = HT28.DivisionID AND HT14.EmployeeID = HT28.EmployeeID 
LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HT14.DepartmentID
LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = HT28.DivisionID AND A12.TeamID=HT14.TeamID
LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
LEFT JOIN HT1025 AS H25 ON HT28.EmployeeID = H25.EmployeeID and HT28.DivisionID = H25.DivisionID AND H25.TranMonth = HT28.TranMonth
WHERE HT28.DivisionID = '''+@DivisionID+'''
AND HT28.TranMonth = '+STR(@TranMonth)+'
AND HT28.TranYear = '+STR(@TranYear)+'
AND CONVERT(VARCHAR(10),NewAbsentDate,120) BETWEEN '''+CONVERT(VARCHAR(10),CONVERT(DATE,@FromDate,120),120)+''' AND'''+ CONVERT(VARCHAR(10),CONVERT(DATE,@ToDate,120),120)+'''


GROUP BY HT28.DivisionID, HT14.DepartmentID,HT14.TeamID, HT14.Ana04ID, HT14.Ana05ID, HT28.EmployeeID, 
HT14.LastName, HT14.MiddleName, HT14.FirstName,  A11.DepartmentName, A12.TeamName,
A13.AnaName,A14.AnaName,NewAbsentDate,HT28.ShiftCode

ORDER BY '+@OrderBy+' '

EXEC (@sSQL)
--PRINT(@sSQL)


DROP TABLE #HT2408



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
