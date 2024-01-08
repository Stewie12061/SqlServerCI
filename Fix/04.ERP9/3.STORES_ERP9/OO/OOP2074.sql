IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2074]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2074]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra trùng ca Đơn xin đổi ca
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 23/02/2016
--- Modify on 23/07/2018 by Bảo Anh: Sửa cách lấy ca làm việc cho trường hợp kỳ kế toán không bắt đầu là ngày 1
--- Modify on 12/06/2020 by Bảo Toàn: Điều chỉnh kiểu dữ liệu bảng tạm.
--- Modify on 28/07/2023 by Kiều Nga: Bổ sung kiểm tra trùng dữ liệu bảng OOT2070 (customerindex =50 Meiko)
-- <Example>
---- 
/* 
EXEC OOP2074 @DivisionID='MK',@UserID='ASOFTADMIN', @EmployeeID='003498',@ChangeShiftID='C',@ChangeFromDate='2016-02-01 00:25:07.827',
@ChangeToDate='2016-02-04 20:25:07.827'
*/
CREATE PROCEDURE OOP2074
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@EmployeeID VARCHAR(50),
	@ChangeShiftID VARCHAR(50),
	@ChangeFromDate DATETIME,
	@ChangeToDate DATETIME
)
AS
DECLARE @sSQL NVARCHAR(MAX)='',
		@Cur CURSOR,
		@Day INT,
		@Month INT,
		@Year INT,
		@ShiftID VARCHAR(50),
		@i INT, @n INT,
		@CustomerName INT

SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex

SELECT @DivisionID DivisionID, @EmployeeID EmployeeID, @ChangeShiftID ChangeShiftID, @ChangeFromDate ChangeFromDate, @ChangeToDate ChangeToDate
INTO #Temp

CREATE TABLE #Error (EmployeeID VARCHAR(50), [Date] VARCHAR(50), ShiftID VARCHAR(50))
CREATE TABLE #Shift (ShiftID VARCHAR(50))

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT * FROM #Temp

OPEN @Cur 
FETCH NEXT FROM @Cur INTO @DivisionID, @EmployeeID, @ChangeShiftID, @ChangeFromDate, @ChangeToDate
WHILE @@FETCH_STATUS = 0
BEGIN	
	
	WHILE Convert(Date,@ChangeFromDate,103) <= Convert(Date,@ChangeToDate,103) 
	BEGIN
		--SET @Day = DATEPART(d,@ChangeFromDate)
		--SET @Month = DATEPART(m,@ChangeFromDate)
		--SET @Year = DATEPART(yyyy,@ChangeFromDate)

		SELECT @Month = TranMonth, @Year = TranYear
		FROM HT9999 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND (@ChangeFromDate BETWEEN BeginDate And EndDate)

		SELECT @Day = DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @Month, @Year) WHERE [Date] = @ChangeFromDate
		
		--Lấy ca hiện tại trong bảng phân ca
		DECLARE  @s VARCHAR(2)
		IF @Day < 10 SET @s = '0' + CONVERT(VARCHAR, @Day)
		ELSE SET @s = CONVERT(VARCHAR, @Day)
		
		SET @sSQL=N'SELECT D'+@s+' FROM HT1025 WHERE DivisionID='''+@DivisionID+''' AND ISNULL(D'+@s+','''')<>'''' AND EmployeeID = '''+@EmployeeID+'''
														AND TranMonth = '+STR(@Month)+' AND TranYear = '+STR(@Year)+' 
         ' 
		 IF (@CustomerName = 50)
		 BEGIN
			 -- Kiểm tra trùng dữ liệu trong bảng OOT2070
			 SET @sSQL = @sSQL + N'
			 UNION ALL
			 SELECT ShiftID FROM OOT2070 WITH (NOLOCK) WHERE DivisionID='''+@DivisionID+''' AND EmployeeID = '''+@EmployeeID+''' AND [Status] =0 AND ShiftID ='''+@ChangeShiftID+'''
														AND ('''+CONVERT(VARCHAR(10), CONVERT(date, @ChangeFromDate, 105), 23)+''' BETWEEN ChangeFromDate AND ChangeToDate 
																OR '''+CONVERT(VARCHAR(10), CONVERT(date, @ChangeToDate, 105), 23)+''' BETWEEN ChangeFromDate AND ChangeToDate
																OR ChangeFromDate BETWEEN '''+CONVERT(VARCHAR(10), CONVERT(date, @ChangeFromDate, 105), 23)+''' AND '''+CONVERT(VARCHAR(10), CONVERT(date, @ChangeToDate, 105), 23)+'''
																OR ChangeToDate BETWEEN '''+CONVERT(VARCHAR(10), CONVERT(date, @ChangeFromDate, 105), 23)+''' AND '''+CONVERT(VARCHAR(10), CONVERT(date, @ChangeToDate, 105), 23)+''')'
		 END

		 INSERT INTO #Shift
		 EXEC (@sSQL)
		 --SET @ShiftID = (SELECT TOP 1 ShiftID FROM #Shift)

         --Kiểm tra với ca đã được phân
         IF  EXISTS (SELECT TOP 1 ShiftID FROM #Shift WHERE ShiftID = @ChangeShiftID)
         BEGIN
			INSERT INTO #Error
			VALUES (@EmployeeID , CONVERT(VARCHAR(10),@ChangeFromDate,103) , @ChangeShiftID) 
				
			SET @ChangeFromDate = DATEADD(d,1,@ChangeFromDate) 
			DELETE #Shift
         END
         ELSE 
         BEGIN
         	SET @ChangeFromDate = DATEADD(d,1,@ChangeFromDate)
         	DELETE #Shift
         END
			 
	END
	
--EXEC (@sSQL)


FETCH NEXT FROM @Cur INTO @DivisionID, @EmployeeID, @ChangeShiftID, @ChangeFromDate, @ChangeToDate
END 
Close @Cur

SELECT * FROM #Error


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
