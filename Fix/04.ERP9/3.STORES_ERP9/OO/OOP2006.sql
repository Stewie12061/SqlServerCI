IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Kiểm tra phân ca so với thời gian vào làm, nghỉ làm, thử việc của nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> Approve Online \ Bảng phân ca \ Thêm mới,sửa: OOF2003
---- 
-- <History>
---- Create on 07/02/2017 by Trương Ngọc Phương Thảo
---- Modified on 23/12/2019 by Lương Mỹ: Đổi cách Convert Date ở Line 85 ( Vì check sai )
-- <Example>
/*
	EXEC OOP2006 'MK','ASOFTADMIN','010928',10,2017,NULL
	EXEC OOP2006 @DivisionID, @UserID, @EmployeeID, @TranMonth, @TranYear, @ShiftID
*/
CREATE PROCEDURE OOP2006
(
	@DivisionID Varchar(50),
	@UserID Varchar(50),
	@EmployeeID Varchar(50),
	@TranMonth Tinyint,
	@TranYear Int,
	@ShiftID xml
)    
AS 
--DECLARE @sTranMonth Varchar(2),
--		@BeginDate Datetime

SELECT  X.Data.query('Days').value('.', 'NVARCHAR(50)') AS Days,
		X.Data.query('ShiftID').value('.', 'NVARCHAR(50)') AS ShiftID,
		Convert(Datetime,null) AS Date
INTO #TblShiftID
FROM @ShiftID.nodes('//Data') AS X (Data)

UPDATE #TblShiftID
SET Date = CAST(LTRIM(@TranYear)+'/'+LTRIM(@TranMonth)+'/'+RIGHT(Days,2) AS  DATETIME)

--select @BeginDate = BeginDate
--from HT1414
--where EmployeeID = @EmployeeID AND EmployeeMode = 'PR'

--Select 1 AS Status, N'OOFML000053-'+Days+'-'+ShiftID AS Message
--From #TblShiftID
--Where CASE WHEN DATEPART(DAY, @BeginDate) > DATEPART(DAY,Date)
--            THEN DATEDIFF(MONTH, @BeginDate, Date) - 1
--            ELSE DATEDIFF(MONTH,@BeginDate, Date) END >= 7

DECLARE @WorkDate DATETIME,
		@LeaveDate DATETIME,
		@FromApprenticeTime DATETIME,
		@ShiftID_Cur VARCHAR(50),
		@ToApprenticeTime DATETIME,
		@Cursor CURSOR,
		@Date_Cur DATETIME,
		@Params VARCHAR(MAX) = '',
		@MessageID VARCHAR(50) = ''

CREATE TABLE #Message_OOP2006 (Status TINYINT, MessageID VARCHAR(50), Params VARCHAR(MAX), Params1 VARCHAR(MAX))

SELECT  @WorkDate = WorkDate,
		@FromApprenticeTime = ISNULL(FromApprenticeTime,''),
	    @ToApprenticeTime = ISNULL(ToApprenticeTime,'') 
FROM HT1403 WITH (NOLOCK) 
WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID

SELECT @LeaveDate = ISNULL(MAX(LeaveDate),'') FROM HT1380 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID GROUP BY EmployeeID
---- Kiểm tra WorkDate <= thời gian sắp ca < LeaveDate
IF ISNULL(@WorkDate,'') <> '' 
	--AND EXISTS (SELECT TOP 1 1 FROM #TblShiftID WHERE ISNULL(CONVERT(VARCHAR(10),#TblShiftID.Date,103),'') < CONVERT(VARCHAR(10),@WorkDate,103) AND ISNULL(ShiftID,'') <> '')
	AND EXISTS (SELECT TOP 1 1 FROM #TblShiftID WHERE CONVERT(DATE,#TblShiftID.Date) < CONVERT(DATE,@WorkDate) AND ISNULL(ShiftID,'') <> '')
BEGIN

	INSERT INTO #Message_OOP2006 (Status, MessageID, Params, Params1)
	SELECT 1 AS Status, 'OOFML000049' AS MessageID, CONVERT(VARCHAR(10),@WorkDate,103) AS Params, @EmployeeID

END

IF ISNULL(@LeaveDate,'') <> '' AND EXISTS (SELECT TOP 1 1 FROM #TblShiftID WHERE ISNULL(CONVERT(VARCHAR(10),Date,103),'') >= CONVERT(VARCHAR(10),@LeaveDate,103) AND Isnull(ShiftID,'') <> '')
BEGIN
	INSERT INTO #Message_OOP2006 (Status, MessageID, Params, Params1)
	SELECT 1 AS Status, 'OOFML000053' AS MessageID, CONVERT(VARCHAR(10),@LeaveDate,103) AS Params, @EmployeeID
END
			
---- Kiểm tra sắp ca thử việc (_TV) nếu phân ca trong thời gian thử việc
SET @Cursor = CURSOR SCROLL KEYSET FOR
SELECT Date, ShiftID
FROM #TblShiftID
WHERE ISNULL(ShiftID,'') <> ''
ORDER BY Date

OPEN @Cursor
FETCH NEXT FROM @Cursor INTO @Date_Cur, @ShiftID_Cur
WHILE @@FETCH_STATUS = 0
BEGIN
	IF EXISTS ( SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK)
				WHERE DivisionID = @DivisionID
				AND ShiftID = @ShiftID_Cur
				AND @Date_Cur BETWEEN @FromApprenticeTime AND @ToApprenticeTime 
				AND ISNULL(IsApprenticeShift,0) = 0
				)
	BEGIN
		SET @Params = @Params + CONVERT(VARCHAR(10),@Date_Cur,103) + ', '
		SET @MessageID = 'OOFML000065'
	END

FETCH NEXT FROM @Cursor INTO  @Date_Cur, @ShiftID_Cur
END
CLOSE @Cursor

INSERT INTO #Message_OOP2006 (Status, MessageID, Params, Params1)
SELECT 1 AS Status, @MessageID AS MessageID, LEFT(RTRIM(@Params),LEN(@Params)-1) AS Params, @EmployeeID AS Params1
WHERE ISNULL(@Params,'') <> ''

---Select kết quả kiểm tra
SELECT * FROM #Message_OOP2006

DROP TABLE #TblShiftID
DROP TABLE #Message_OOP2006

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
