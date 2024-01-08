IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra thời gian vào làm, nghỉ làm, thử việc của nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> Approve Online \ Đơn xin phép \ Thêm mới,sửa: OOF2011
----		   Approve Online \ Đơn xin đổi ca \ Thêm mới,sửa: OOF2071
-- <History>
---- Create on 07/02/2017 by Trương Ngọc Phương Thảo
---- Updated on 08/06/2020 by Văn Tài: Fix kiểm tra điều kiện: không tồn tại Ca làm việc.
---- Updated on 17/07/2020 by Huỳnh Thanh Minh: Fix kiểm tra điều kiện nhân viên đã có quyết định nghỉ việc, nhưng sau đó quay trở lại làm việc thì không cho xin nghỉ phép
---- Modified on 
-- <Example>
/*
	EXEC OOP2008 'MK','ASOFTADMIN','010966',10,2017,'2017-10-11 00:00:00.000','2017-11-11 00:00:00.000','C'
*/
CREATE PROCEDURE OOP2008
(
	@DivisionID Varchar(50),
	@UserID Varchar(50),
	@EmployeeID Varchar(50),
	@TranMonth Tinyint,
	@TranYear Int,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@ShiftID VARCHAR(50)
)    
AS 

DECLARE @WorkDate DATETIME,
		@LeaveDate DATETIME,
		@FromApprenticeTime DATETIME,
		@ToApprenticeTime DATETIME,
		@ActFromApprenticeTime DATETIME,
		@ActToApprenticeTime DATETIME,
		@EmployeeStatus INT

CREATE TABLE #Message_OOP2008 (Status TINYINT, MessageID VARCHAR(50), Params VARCHAR(MAX), Params1 VARCHAR(MAX), Params2 VARCHAR(MAX))

SELECT  @WorkDate = WorkDate,
		@FromApprenticeTime = ISNULL(FromApprenticeTime,''),
	    @ToApprenticeTime = ISNULL(ToApprenticeTime,''),
		@EmployeeStatus = ISNULL(EmployeeStatus,1)
FROM HT1403 WITH (NOLOCK) 
WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID

SELECT @LeaveDate = ISNULL(MAX(LeaveDate),'') FROM HT1380 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID GROUP BY EmployeeID

---- Kiểm tra WorkDate <= thời gian sắp ca < LeaveDate
IF @WorkDate > @FromDate
BEGIN
	INSERT INTO #Message_OOP2008 (Status, MessageID, Params, Params1)
	SELECT 1 AS Status, 'OOFML000066' AS MessageID, CONVERT(VARCHAR(10),@WorkDate,103) AS Params, @EmployeeID
END

IF @LeaveDate <= @ToDate and @EmployeeStatus = 2 -- Đã tồn tại quyết định nghỉ việc và trạng thái hồ sơ là đang nghỉ việc
BEGIN
	INSERT INTO #Message_OOP2008 (Status, MessageID, Params, Params1)
	SELECT 1 AS Status, 'OOFML000067' AS MessageID, CONVERT(VARCHAR(10),@LeaveDate,103) AS Params, @EmployeeID
END

IF ISNULL(@ShiftID,'') <> ''
BEGIN
---- Kiểm tra sắp ca thử việc (_TV) nếu phân ca trong thời gian thử việc
	SELECT @ActFromApprenticeTime = CASE 
									WHEN CONVERT(DATE,@FromApprenticeTime,120) BETWEEN CONVERT(DATE,@FromDate,120) AND CONVERT(DATE,@ToDate,120) 
										THEN CONVERT(DATE,@FromApprenticeTime,120)
									WHEN CONVERT(DATE,@FromApprenticeTime,120) <= CONVERT(DATE,@FromDate,120) AND CONVERT(DATE,@ToApprenticeTime,120) >= CONVERT(DATE,@FromDate,120) 
									THEN CONVERT(DATE,@FromDate,120) END,
	@ActToApprenticeTime = CASE 
							WHEN CONVERT(DATE,@ToApprenticeTime,120) BETWEEN CONVERT(DATE,@FromDate,120) AND CONVERT(DATE,@ToDate,120) 
								THEN CONVERT(DATE,@ToApprenticeTime,120)
							WHEN CONVERT(DATE,@ToApprenticeTime,120) >= CONVERT(DATE,@ToDate,120) AND CONVERT(DATE,@FromApprenticeTime,120) <= CONVERT(DATE,@ToDate,120) 
								THEN CONVERT(DATE,@ToDate,120) END
	
	IF (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ShiftID = Isnull(@ShiftID,'') AND ISNULL(IsApprenticeShift,0) = 0) = 0
	AND
	(CONVERT(DATE,@ActFromApprenticeTime,120) BETWEEN CONVERT(DATE,@FromDate,120) AND CONVERT(DATE,@ToDate,120)
	OR		
	CONVERT(DATE,@ActToApprenticeTime,120) BETWEEN CONVERT(DATE,@FromDate,120) AND CONVERT(DATE,@ToDate,120)
	OR
	CONVERT(DATE,@FromDate,120) BETWEEN CONVERT(DATE,@ActFromApprenticeTime,120) AND CONVERT(DATE,@ToApprenticeTime,120)
	OR
	CONVERT(DATE,@ToDate,120) BETWEEN CONVERT(DATE,@ActFromApprenticeTime,120) AND CONVERT(DATE,@ToApprenticeTime,120)
	)
	BEGIN
		INSERT INTO #Message_OOP2008 (Status, MessageID, Params, Params1, Params2)
		SELECT 1 AS Status, 'OOFML000064' AS MessageID, @EmployeeID, CONVERT(VARCHAR(10),@ActFromApprenticeTime,103) AS Params1, CONVERT(VARCHAR(10),@ActToApprenticeTime,103) AS Params2
	END
END
---Select kết quả kiểm tra
SELECT * FROM #Message_OOP2008

DROP TABLE #Message_OOP2008

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
