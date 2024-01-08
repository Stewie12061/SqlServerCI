IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP0004]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Cập nhật ngày hiệu lực của hồ sơ lương
-- <Param>
---- TH nhân viên nghỉ việc tháng trước những đã lỡ tạo hồ sơ lương các tháng sau
-- <Return>
---- 
-- <Reference> HRM\Nghiệp vụ QĐ nghỉ việc
---- 
-- <History>
---- Create on 07/02/2017 by Trương Ngọc Phương Thảo
---- Modified on 07/01/2021 by Văn Tài: Bổ sung giải phóng bộ nhớ cho các Cursor.
---- Modified on 06/12/2021 by Văn Tài: Loại bỏ phần giải phóng cursor sai.
-- <Example>
----  
CREATE PROCEDURE HP0004
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@EmployeeID Varchar(50) = ''
)    
AS 
DECLARE @CurMonth CURSOR,
		@CurYear CURSOR,
		@MonthTableID VARCHAR(50),
		@YearTableID VARCHAR(50),
		@sSQL001 NVarchar(4000)

--set @Employeeid = '000293'

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN

SET @CurMonth = CURSOR SCROLL KEYSET FOR
SELECT  name
FROM SYSOBJECTS TAB
WHERE TAB.Name LIKE 'HT2400M%'


OPEN @CurMonth
FETCH NEXT FROM @CurMonth INTO @MonthTableID
WHILE @@FETCH_STATUS = 0
BEGIN
	
	SET @sSQL001 = N'
	UPDATE T1
	SET 
	T1.EndDate = T2.LeaveDate
	FROM '+@MonthTableID+' T1
	LEFT JOIN HT1380 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
	WHERE T1.DivisionID = '''+@DivisionID+'''
	AND
	CONVERT(DATE,T2.LeaveDate,120) <= CONVERT(DATE, GETDATE(),120) 
	'
	EXEC(@sSQL001)

	FETCH NEXT FROM @CurMonth INTO @MonthTableID
	END 
	Close @CurMonth

	SET @CurYear = CURSOR SCROLL KEYSET FOR
	SELECT  name
	FROM SYSOBJECTS TAB
	WHERE TAB.Name LIKE 'HT2400Y%'


	OPEN @CurYear
	FETCH NEXT FROM @CurYear INTO @YearTableID
	WHILE @@FETCH_STATUS = 0
	BEGIN
	SET @sSQL001 = N'
	UPDATE T1
	SET 
	T1.EndDate = T2.LeaveDate
	FROM '+@YearTableID+' T1
	LEFT JOIN HT1380 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
	WHERE T1.DivisionID = '''+@DivisionID+'''
	AND
	CONVERT(DATE,T2.LeaveDate,120) <= CONVERT(DATE, GETDATE(),120) 
	'
	EXEC(@sSQL001)
	FETCH NEXT FROM @CurYear INTO @YearTableID
	END 
Close @CurYear
END
ELSE
BEGIN
	UPDATE T1
	SET 
	T1.EndDate = T2.LeaveDate
	FROM HT2400 T1
	LEFT JOIN HT1380 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
	WHERE T1.DivisionID = @DivisionID
	AND
	CONVERT(DATE,T2.LeaveDate,120) <= CONVERT(DATE, GETDATE(),120) 
END

-------- Cập nhật dữ liệu bảng phân ca

DECLARE @CurShift CURSOR,		
		@cEmployeeID VARCHAR(50),
		@Period VARCHAR(50),
		@LeaveDate Datetime,
		@sSQL002 NVarchar(4000),
		@sSQL003 NVarchar(4000),
		@FromDay INT,
		@ToDay INT,
		@iMonth INT, @iYear INT  ,
		@DecidingNo Varchar(20), 
		@DecidingDate Datetime, 
		@Proposer Varchar(20)

SET @CurShift = CURSOR SCROLL KEYSET FOR
SELECT T1.EmployeeID, Month(LeaveDate)+Year(LeaveDate)*100 As Period, LeaveDate, DecidingNo, DecidingDate, Proposer
FROM	HT1380 T1
INNER JOIN HT1400 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.DivisionID = T2.DivisionID
WHERE LeaveDate <= GetDate()
AND EXISTS (SELECT TOP 1 1 
			FROM HT1025 T2 
			WHERE T1.EmployeeID = T2.EmployeeID 
			AND T1.DivisionID = T2.DivisionID  
			AND T2.TranYear*100+T2.TranMonth >= Month(LeaveDate)+Year(LeaveDate)*100 )
and T2.EmployeeStatus not in (3,9)
and T1.EmployeeID LIKE @EmployeeID
OPEN @CurShift
FETCH NEXT FROM @CurShift INTO @cEmployeeID, @Period, @LeaveDate, @DecidingNo, @DecidingDate, @Proposer
WHILE @@FETCH_STATUS = 0
BEGIN
	SET  @FromDay=DAY(@LeaveDate)
	SET  @ToDay=DAY(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@LeaveDate)+1,0)))
	
	DECLARE @i INT =@FromDay, @s VARCHAR(2)
	WHILE @i <= @ToDay
	BEGIN		
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)		
	
		SET @sSQL002='UPDATE  T1 
					SET D'+@s+'= NULL
					FROM OOT2000 T1
					LEFT JOIN OOT9000 T2 ON T1.DivisionID = T2.DivisionID AND T2.APK = T1.APKMaster
					WHERE T1.DivisionID='''+@DivisionID+''' 
					AND T1.EmployeeID='''+@cEmployeeID +'''
					AND T2.TranMonth + T2.TranYear*100 = '+STR(@Period)+' '		
			
		SET @sSQL003='UPDATE  HT1025 
					SET D'+@s+'= NULL,
					Notes = N''SQĐ: N'+@DecidingNo+N' - Ngày nghỉ việc: N'+CONVERT(VARCHAR(10),@LeaveDate,120)+N' - Người QĐ: '+@Proposer+'''
			        WHERE HT1025.DivisionID='''+@DivisionID+''' 
					AND EmployeeID='''+@cEmployeeID +'''
					AND HT1025.TranMonth + HT1025.TranYear*100 = '+STR(@Period)+' '
		
		EXEC(@sSQL002+@sSQL003)
		--Print @sSQL002
		--Print @sSQL003
		SET @i=@i+1
	END
	SELECT @i = 1, @ToDay = 31

	WHILE @i <= @ToDay
	BEGIN
	IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @s = CONVERT(VARCHAR, @i)		

	SET @sSQL002='UPDATE  T1 
					SET D'+@s+'= NULL
					FROM OOT2000 T1
					LEFT JOIN OOT9000 T2 ON T1.DivisionID = T2.DivisionID AND T2.APK = T1.APKMaster
					WHERE T1.DivisionID='''+@DivisionID+''' 
					AND T1.EmployeeID='''+@cEmployeeID +'''
					AND T2.TranMonth + T2.TranYear*100 > '+STR(@Period)+' '		
			
	SET @sSQL003='UPDATE  HT1025 SET D'+@s+'= NULL,
				Notes = N''SQĐ: N'+@DecidingNo+N' - Ngày nghỉ việc: N'+CONVERT(VARCHAR(10),@LeaveDate,120)+N' - Người QĐ: '+@Proposer+'''
			    WHERE HT1025.DivisionID='''+@DivisionID+''' 
				AND EmployeeID='''+@cEmployeeID +'''
				AND HT1025.TranMonth + HT1025.TranYear*100 > '+STR(@Period)+' '

	EXEC(@sSQL002+@sSQL003)
	--PRINT(@sSQL002)
	--PRINT(@sSQL003)
	SET @i=@i+1

	END

FETCH NEXT FROM @CurShift INTO @cEmployeeID, @Period, @LeaveDate, @DecidingNo, @DecidingDate, @Proposer
END 
Close @CurShift
--DEALLOCATE @CurShift;  
--DEALLOCATE @CurMonth;
--DEALLOCATE @CurYear;

--Print @sSQL002
--Print @sSQL003


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

