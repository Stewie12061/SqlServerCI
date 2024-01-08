IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2500]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2500]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



----Created by: Vo Thanh Huong, date: 01/09/2004
----purpose: Xu ly so lieu load len man hinh cham cong ngay
----Edit by Huynh Trung Dung ,date 14/12/2010 --- Them tham so @ToDepartmentID
--- Modify on 23/01/2014 by Bảo Anh: Bỏ convert sang nvarchar khi Where AbsentDate
--- Modify on 30/03/2016 by Phương Thảo: Sửa lại cách load dữ liệu: Sử dụng pivot, bỏ vòng lặp
--- Modified on 08/11/2016 by Bảo Thy: Bổ sung xử lý tách bảng nghiệp vụ
--- Modified on 07/12/2016 by Bảo Thy: Bổ sung subsectionID, processID cho khách hàng MEIKO
--- Modified on 23/10/2020 by Đức Thông: Bổ sung store custom cho MEIKO
--- Modidied on 30/09/2022 by Nhựt Trường: [2022/09/IS/0168] - Fix lỗi truyền thiếu parameter khi gọi store custom cho MEIKO.

-- exec HP2500 @DivisionID=N'MK',@DepartmentID=N'A000000',@ToDepartmentID=N'A000000',@TeamID=N'%',@EmployeeID=N'%',@FromDate='2016-01-01 00:00:00',@Todate='2016-01-31 00:00:00',@TranMonth=1,@TranYear=2016

CREATE PROCEDURE [dbo].[HP2500]  @DivisionID nvarchar(50),
				@DepartmentID nvarchar(50),
				@ToDepartmentID nvarchar(50),
				@TeamID nvarchar(50),
				@EmployeeID nvarchar(50),
				@FromDate datetime,
				@Todate datetime, 
				@TranMonth int,
				@TranYear int,
				@SubsectionID nvarchar(50) = '',
				@ProcessID nvarchar(50) = ''
AS
Declare @sSQL varchar(max), @sSQL1 varchar(max), @sSQL2 varchar(max),
	@cur cursor,
	@Column int,
	@AbsentTypeID nvarchar(50),
	@sSQL001 Nvarchar(4000) ='',
	@TableHT2401 Varchar(50),
	@TableHT2400 Varchar(50),
	@sTranMonth Varchar(2),
	@Select NVARCHAR(MAX) = '',
	@Select1 NVARCHAR(MAX) = '',
	@Group NVARCHAR(MAX) = '',
	@Where NVARCHAR(MAX) = '',
	@CustomerIndex INT

SELECT @CustomerIndex = CustomerName FROM CustomerIndex




IF @CustomerIndex = 50 --MEIKO
	EXEC HP2500_MK @DivisionID, @DepartmentID, @ToDepartmentID, @TeamID, @EmployeeID, @FromDate, @Todate, @TranMonth, @TranYear, @SubsectionID, @ProcessID
ELSE
BEGIN
SELECT @sSQL = '', @sSQL1 = ''

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

CREATE TABLE #HP2500_1 (EmpFileID NVARCHAR(50), DivisionID VARCHAR(50),DepartmentID VARCHAR(50), TeamID VARCHAR(50), EmployeeID VARCHAR(50), FullName NVARCHAR(250),
						AbsentDate DATETIME,  Notes NVARCHAR(250), AbsentTypeID VARCHAR(50), AbsentAmount DECIMAL(28,8), SubsectionID VARCHAR(50), ProcessID VARCHAR(50))
CREATE TABLE #HP2500_2 (AbsentTypeID VARCHAR(50))

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),@TranYear),
			@TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2401 = 'HT2401',
			@TableHT2400 = 'HT2400'
END

SET @sSQL001 = '
INSERT INTO #HP2500_1 (EmpFileID, DivisionID, DepartmentID, TeamID, EmployeeID, FullName, AbsentDate, Notes, AbsentTypeID, AbsentAmount'+@Select1+')
SELECT	HT.EmpFileID, HT.DivisionID, HT.DepartmentID, isnull(HT.TeamID, '''') as TeamID, HT.EmployeeID, FullName, AbsentDate, Notes,
		HT02.AbsentTypeID,	SUM(HT02.AbsentAmount) AS AbsentAmount '+@Select+'
FROM	'+@TableHT2400+' HT 
LEFT JOIN '+@TableHT2401+' HT02 ON HT.EmployeeID=HT02.EmployeeID
		and HT.DivisionID=HT02.DivisionID and HT.DepartmentID=HT02.DepartmentID
		and IsNull(HT.TeamID,'''')=ISNull(HT02.TeamID,'''') and HT.EmployeeID=HT02.EmployeeID 
		and HT.TranMonth=HT02.TranMonth and HT.TranYear=HT02.TranYear
LEFT JOIN HV1400 HV on HT.EmployeeID = HV.EmployeeID and HT.DivisionID = HV.DivisionID
WHERE	Isnull(HT02.AbsentTypeID,'''') <> '''' and 
		HT.DivisionID =  '''+@DivisionID+'''  and
		HT.DepartmentID between  '''+@DepartmentID+'''  and '''+@ToDepartmentID+'''  and 
		isnull(HT.TeamID, '''') like isnull('''+@TeamID+''', '''')  and 
		HT.EmployeeID like  '''+@EmployeeID+''' and
		HT.TranMonth = '+STR(@TranMonth)+' and HT.TranYear = '+STR(@TranYear)+' and 
		AbsentDate between  '''+Convert(Varchar(20),@FromDate,120)+''' And '''+Convert(Varchar(20),@ToDate,120)+'''
GROUP BY  HT.EmpFileID, HT.DivisionID,HT.DepartmentID, isnull(HT.TeamID,''''), HT.EmployeeID, FullName, AbsentDate, Notes, HT02.AbsentTypeID'+@Group+'


INSERT INTO	#HP2500_2 (AbsentTypeID)
SELECT	DISTINCT AbsentTypeID
FROM	#HP2500_1

'
EXEC (@sSQL001)
--PRINT (@sSQL001)
--select * from #HP2500_1
--select * from #HP2500_2

IF EXISTS (SELECT TOP 1 1 FROM #HP2500_2)
BEGIN 
	SELECT @sSQL = @sSQL +
	'
	SELECT	*
	FROM	
	(
	SELECT	EmpFileID,			
			DivisionID,
			DepartmentID, 	
			TeamID,									
			EmployeeID,
			FullName,
			AbsentDate,					
			Notes,
			AbsentTypeID,
			AbsentAmount '+@Select1+'		
	FROM	#HP2500_1
	) P
	PIVOT
	(SUM(AbsentAmount) FOR AbsentTypeID IN ('
	SELECT	@sSQL1 = @sSQL1 + CASE WHEN @sSQL1 <> '' THEN ',' ELSE '' END +'['+''+AbsentTypeID+''+']' 
	FROM	#HP2500_2
	
	SELECT	@sSQL1 = @sSQL1 +')
	) As T
	ORDER BY	EmployeeID, AbsentDate' 
END
ELSE 
BEGIN
	SELECT @sSQL = @sSQL +
	'
	SELECT	* FROM #HP2500_1
	WHERE	1 = 0
	'
END
print @sSQL
print @sSQL1
EXEC (@sSQL + @sSQL1)

DROP TABLE #HP2500_1
DROP TABLE #HP2500_2

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO