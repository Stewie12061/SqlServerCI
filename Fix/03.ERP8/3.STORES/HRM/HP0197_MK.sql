IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0197_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0197_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


 -- <Summary>
 ---- 
 ---- Tìm kiếm lỗi khi quét thẻ - customize Meiko
 -- <Param>
 ----   
 -- <Return>
 ---- 
 -- <Reference> 
 ---- Customize Meiko: Gọi từ sp HP0197
 -- <History>
 ----Created by: Phương Thảo, Date: 14/04/2016
 --- Modified on 09/06/2016 by Bảo Anh: Where thêm TranMonth, TranYear khi join HT2408 với HT1025 do double dữ liệu
 --- Modified on 18/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
 --- Modified on 04/10/2016 by Bảo Thy: Bổ sung IsAO
 --- Modified on 17/05/2017 by Bảo Thy: Bổ sung trường HT2406.APK để thực thi kiểm tra tại màn hình Hiệu chỉnh mã thẻ lỗi (HF0413)
 --- Modified by Phương Thảo on 17/05/2017 : Sửa danh mục dùng chung
 --- Modified by Đình Định on 05/12/2023 : Bổ sung thêm biến lấy mã NV.
 /*-- <Example>
 	exec HP0197 @DivisionID=N'CTY',@DepartmentID=N'%',@TranMonth=11,@TranYear=2014,@FromDate='2014-11-01 00:00:00',@ToDate='2014-11-30 00:00:00'
 ----*/

CREATE PROCEDURE [dbo].[HP0197_MK]
				@DivisionID as nvarchar(50),
				@DepartmentID as nvarchar(50),
				@TranMonth as int,
				@TranYear as int,
				@FromDate as datetime,
				@ToDate as datetime,
				@EmployeeID AS NVARCHAR(50)
AS

DECLARE @SQL001 NVARCHAR(MAX),		
		@SQL002 NVARCHAR(MAX),		
		@SQL003 NVARCHAR(MAX),
		@TableHT2408 Varchar(50),
		@TableHT2406 Varchar(50),
		@sTranMonth Varchar(2)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SET @TableHT2408 = 'HT2408M'+@sTranMonth+Convert(Varchar(4),@TranYear)
	SET @TableHT2406 = 'HT2406M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SET	@TableHT2408 = 'HT2408'
	SET @TableHT2406 = 'HT2406'
END
SET @SQL001 = ''

SELECT @SQL001 = '
SELECT				HT2406.APK, H06.DivisionID, H06.TranMonth, H06.Tranyear, H06.AbsentCardNo, H06.AbsentDate AS LoadAbsentDate, H06.MachineCode, H06.IOCode,     
                      H06.InputMethod, H07.EmployeeID, Null as Notes,
					  Ltrim(RTrim(isnull(H14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(H14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(H14.FirstName,''''))) As FullName,
					  H12.DepartmentName,
                      Isnull(H06.ShiftCode,CASE Day(H06.AbsentDate)     
                      WHEN 1 THEN H25.D01 WHEN 2 THEN H25.D02 WHEN 3 THEN H25.D03 WHEN 4 THEN H25.D04 WHEN 5 THEN H25.D05 WHEN 6 THEN H25.D06 WHEN    
                       7 THEN H25.D07 WHEN 8 THEN H25.D08 WHEN 9 THEN H25.D09 WHEN 10 THEN H25.D10 WHEN 11 THEN H25.D11 WHEN 12 THEN H25.D12 WHEN    
                       13 THEN H25.D13 WHEN 14 THEN H25.D14 WHEN 15 THEN H25.D15 WHEN 16 THEN H25.D16 WHEN 17 THEN H25.D17 WHEN 18 THEN H25.D18 WHEN    
                       19 THEN H25.D19 WHEN 20 THEN H25.D20 WHEN 21 THEN H25.D21 WHEN 22 THEN H25.D22 WHEN 23 THEN H25.D23 WHEN 24 THEN H25.D24 WHEN    
                       25 THEN H25.D25 WHEN 26 THEN H25.D26 WHEN 27 THEN H25.D27 WHEN 28 THEN H25.D28 WHEN 29 THEN H25.D29 WHEN 30 THEN H25.D30 WHEN    
                       31 THEN H25.D31 ELSE NULL END) as ShiftCode,
					   Convert(Tinyint,null) AS IsNightShift,  
					   H06.AbsentTime,
					   --AbsentDate+ CAST(Convert(Time,H06.AbsentTime) AS datetime) AS AbsentDate,
					   H06.AbsentDate,
					   Convert(Int,0) AS IsError,
					   IDENTITY(int, 0, 1) As orderNo, H06.IsAO
INTO	#HP0197_HT2408
FROM    '+@TableHT2408+ ' AS H06 WITH (NOLOCK)   
LEFT OUTER JOIN HT1407 AS H07 WITH (NOLOCK) ON H07.AbsentCardNo = H06.AbsentCardNo and H07.DivisionID = H06.DivisionID  
LEFT OUTER JOIN HT1025 AS H25 WITH (NOLOCK) ON H07.EmployeeID = H25.EmployeeID and H07.DivisionID = H25.DivisionID and H25.TranMonth = H06.TranMonth and H25.TranYear = H06.TranYear    
LEFT JOIN HT1400 H14 WITH (NOLOCK) ON H06.EmployeeID = H14.EmployeeID AND H06.DivisionID = H14.DivisionID
LEFT JOIN AT1102 H12 WITH (NOLOCK) ON H12.DepartmentID = H14.DepartmentID
LEFT JOIN '+@TableHT2406+' AS HT2406 WITH (NOLOCK) ON H06.AbsentCardNo = HT2406.AbsentCardNo AND H06.AbsentDate = HT2406.AbsentDate AND H06.AbsentTime = HT2406.AbsentTime AND H06.DivisionID = HT2406.DivisionID  
WHERE  H06.DivisionID = ''' + @DivisionID + ''' 
AND   H06.TranMonth = '+ str(@TranMonth) + ' AND H06.TranYear = ' +  str(@TranYear) + '
AND (H06.AbsentDate Between '''	+convert(nvarchar(10),@FromDate,101)+ ''' and  '''+convert(nvarchar(10),@ToDate,101)+ ''') 
AND H14.DepartmentID LIKE '''+@DepartmentID+'''
AND H06.EmployeeID LIKE '''+@EmployeeID+''' 
ORDER BY H06.EmployeeID, H06.AbsentDate	'

SET @SQL002 = N'
UPDATE	T1
SET		T1.IsNightShift = IsNextDay
FROM	#HP0197_HT2408 T1
INNER JOIN 
(	SELECT	DivisionID, ShiftID, MAX(IsNextDay) AS IsNextDay, DateTypeID
	FROM	HT1021 WITH (NOLOCK)
	WHERE	Isnull(IsNextDay,0) <> 0  
	GROUP BY 	DivisionID, ShiftID, DateTypeID
) T2 ON T1.DivisionID = T2.DivisionID  and T1.ShiftCode = T2.ShiftID AND LEFT(Datename(dw,T1.AbsentDate),3) = T2.DateTypeID

UPDATE T1
SET		T1.AbsentDate = T1.AbsentDate - 1
FROM #HP0197_HT2408 T1
WHERE (T1.IsNightShift is null  or T1.IsNightShift = 1) AND T1.IOCode = 1
AND EXISTS (SELECT TOP 1 1 FROM #HP0197_HT2408 T2 WHERE T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID and
														T2.AbsentDate = T1.AbsentDate - 1 and T2.IsNightShift = 1 and T2.IOCode = 0)

UPDATE T1
SET		T1.ShiftCode =  CASE Day(T1.AbsentDate)     
                      WHEN 1 THEN T2.D01 WHEN 2 THEN T2.D02 WHEN 3 THEN T2.D03 WHEN 4 THEN T2.D04 WHEN 5 THEN T2.D05 WHEN 6 THEN T2.D06 WHEN    
                       7 THEN T2.D07 WHEN 8 THEN T2.D08 WHEN 9 THEN T2.D09 WHEN 10 THEN T2.D10 WHEN 11 THEN T2.D11 WHEN 12 THEN T2.D12 WHEN    
                       13 THEN T2.D13 WHEN 14 THEN T2.D14 WHEN 15 THEN T2.D15 WHEN 16 THEN T2.D16 WHEN 17 THEN T2.D17 WHEN 18 THEN T2.D18 WHEN    
                       19 THEN T2.D19 WHEN 20 THEN T2.D20 WHEN 21 THEN T2.D21 WHEN 22 THEN T2.D22 WHEN 23 THEN T2.D23 WHEN 24 THEN T2.D24 WHEN    
                       25 THEN T2.D25 WHEN 26 THEN T2.D26 WHEN 27 THEN T2.D27 WHEN 28 THEN T2.D28 WHEN 29 THEN T2.D29 WHEN 30 THEN T2.D30 WHEN    
                       31 THEN T2.D31 ELSE NULL END
FROM #HP0197_HT2408 T1
LEFT JOIN HT1025 AS T2 WITH (NOLOCK) ON T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear  '

SET @SQL003 = N'
UPDATE T1
SET	T1.IsError = 1
FROM #HP0197_HT2408 T1
WHERE NOT EXISTS (SELECT TOP 1 1 FROM HT1025 T2 WITH (NOLOCK) WHERE T1.EmployeeID = T2.EmployeeID AND T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear)


UPDATE T1
SET	T1.IsError = 1
FROM #HP0197_HT2408 T1 
INNER JOIN 
(	SELECT  DivisionID, AbsentDate,  ISNULL(ShiftCode,'''') AS ShiftCode, EmployeeID, Count(AbsentTime) AS Times
	FROM	#HP0197_HT2408
	GROUP BY DivisionID, AbsentDate, ShiftCode, EmployeeID
	HAVING	Count(AbsentTime) <> 2
) T2 ON T1.DivisionID = T2.DivisionID and T1.AbsentDate = T2.AbsentDate and ISNULL(T1.ShiftCode,'''') = T2.ShiftCode and T1.EmployeeID = T2.EmployeeID

SELECT APK, DivisionID, TranMonth, Tranyear, AbsentCardNo, LoadAbsentDate AS AbsentDate, MachineCode, IOCode,     
       InputMethod, EmployeeID, Null as Notes, FullName, DepartmentName, ShiftCode,	IsNightShift, AbsentTime, IsError
	   , CASE WHEN ISNULL(IsAO,0) = 0 THEN ''HRM'' WHEN ISNULL(IsAO,0) = 1 THEN ''AO'' END AS IsAO
FROM #HP0197_HT2408 
Order by EmployeeID, LoadAbsentDate, AbsentTime '

--Print @SQL001
--Print @SQL002
--Print @SQL003
EXEC (@SQL001+@SQL002+@SQL003)

SET NOCOUNT OFF



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

