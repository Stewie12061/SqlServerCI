IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- trả ra ca hiện tại của nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Bảo Thy, Date: 29/03/2016
----Modified by Bảo Thy on 04/01/2017: Bổ sung check IsNextDay khi xin nghỉ phép qua ngày hôm sau của ca đêm
----Modified by Bảo Thy on 08/05/2017: Bổ sung where tranyear
--- Modified on 23/07/2018 by Bảo Anh: Sửa cách lấy ca làm việc cho trường hợp kỳ kế toán không bắt đầu là ngày 1
--- Modified on 20/07/2023 by Kiều Nga: [2023/07/IS/0202] Bổ sung xử lý lấy ca cho ca đêm qua ngày (customize NEWTOYO)
--- Modified on 09/09/2023 by Đình Định: NEWTOYO - Bổ sung lấy ca ban đầu cho loại đơn làm thêm giờ DXLTG. 
/*-- <Example>
	OOP2034 @DivisionID='VF', @UserID='ADMIN', @Date='20180221', @EmployeeID='VFC0015'
----*/

CREATE PROCEDURE OOP2034
(
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @Date DATETIME, -- DXP: LeaveToDate, còn lại: FromDate
  @EmployeeID VARCHAR(MAX),
  @Type VARCHAR(50) = ''
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)='',
		@sSelect NVARCHAR(MAX)='',
		@Day INT,
		@Month INT,
		@Year INT,
		@ShiftID VARCHAR(50),
		@Customerindex INT

SET @Customerindex = (SELECT TOP 1 CustomerName FROM CustomerIndex WITH (NOLOCK))
		
IF @Type = 'DXP' AND CONVERT(TIME(0), @Date, 120) BETWEEN '00:00:00' AND '04:00:00'
BEGIN
	SET @Date = DATEADD(d, -1, @Date)
	SET @sSelect = ', 1 As IsNextDay, '''+CONVERT(NVARCHAR(10),CONVERT(DATE,@Date,120),120)+''' AS FromWorkingDate, 
	'''+CONVERT(NVARCHAR(10),CONVERT(DATE,@Date,120),120)+''' AS ToWorkingDate'
END
ELSE
IF (@Customerindex = 81 AND (ISNULL(@Type,'') <> 'DXP' AND ISNULL(@Type,'') <> 'DXLTG') AND CONVERT(TIME(0), @Date, 120) BETWEEN '00:00:00' AND '06:59:00') -- customize NEWTOYO 
BEGIN
	SET @Date = DATEADD(d, -1, @Date)
	SET @sSelect = ', 1 As IsNextDay, '''+CONVERT(NVARCHAR(10),CONVERT(DATE,@Date,120),120)+''' AS FromWorkingDate, 
	'''+CONVERT(NVARCHAR(10),CONVERT(DATE,@Date,120),120)+''' AS ToWorkingDate'
END
ELSE
BEGIN
	SET @sSelect = ', 0 As IsNextDay, '''+CONVERT(NVARCHAR(10),CONVERT(DATE,@Date,120),120)+''' AS FromWorkingDate, 
	'''+CONVERT(NVARCHAR(10),CONVERT(DATE,@Date,120),120)+''' AS ToWorkingDate'
END

--SET @Month = DATEPART(m,@Date)
--SET @Year = DATEPART(yyyy,@Date)
--SET @Day = DATEPART(d,@Date)
SELECT @Month = TranMonth, @Year = TranYear FROM HT9999 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND (CONVERT(DATE,@Date) BETWEEN BeginDate And EndDate)
SELECT @Day = DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @Month, @Year) WHERE [Date] = CONVERT(DATE,@Date)

	DECLARE  @s VARCHAR(2)
		IF @Day < 10 SET @s = '0' + CONVERT(VARCHAR, @Day)
		ELSE SET @s = CONVERT(VARCHAR, @Day)
			
	SET @sSQL=N'SELECT TOP 1 D'+@s+' ShiftID,EmployeeID, '''+CONVERT(NVARCHAR(10),CONVERT(DATE,@Date,120),120)+''' Date '+@sSelect+'
				FROM HT1025 WITH (NOLOCK)
				WHERE DivisionID='''+@DivisionID+''' 
				AND ISNULL(D'+@s+','''')<>'''' 
				AND EmployeeID = '''+@EmployeeID+'''
				AND TranMonth = '+STR(@Month)+' 
				AND TranYear = '+STR(@Year)+' 
         '
	EXEC (@sSQL)

--PRINT(@s)
--PRINT(@sSQL)
--PRINT(@ShiftID)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
