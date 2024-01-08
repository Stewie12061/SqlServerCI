IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2057]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2057]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xét duyệt đơn Đơn xin đổi ca đẩy xuống HRM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 24/02/2016
--- Modify on 23/07/2018 by Bảo Anh: Sửa cách lấy ca làm việc cho trường hợp kỳ kế toán không bắt đầu là ngày 1
--- Modify on 03/01/2019 by Bảo Anh: Bổ sung biến @APKDetail do thay đổi màn hình thiết lập xét duyệt
--- Modify on 14/01/2021 by Nhựt Trường: Sửa lại điều kiện where theo kỳ khi Update xuống OOT2000 và HT1025
--- Modify on 07/06/2023 by Nhựt Trường: Fix lại cách lấy kỳ khi Update xuống OOT2000 và HT1025.
/*-- <Example>
exec OOP2057 @APKMaster='8F5FB58F-79D3-4A62-BB76-9E8617D1BEAD',@TranMonth=2,@TranYear=2016,
@DivisionID=N'MK',@UserID=N'000021', @Status=1
----*/

CREATE PROCEDURE OOP2057
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @TranMonth INT,
  @TranYear INT,
  @APKMaster VARCHAR(50),
  @Status TINYINT,
  @APKDetail VARCHAR(50)
) 
AS 
DECLARE @sSQL1 NVARCHAR(MAX)='',
		@sSQL2 NVARCHAR(MAX)='',
		@Cur CURSOR,
		@APK VARCHAR(50),
		@EmployeeID VARCHAR(50),
		@ChangeFromDate DATETIME,
		@ChangeToDate DATETIME,
		@ShiftID VARCHAR(50),
		@FromDay INT,
		@ToDay INT,
		@iMonth INT,
		@iYear INT 		
		
		
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT APK,EmployeeID,ChangeFromDate,ChangeToDate,ShiftID
FROM OOT2070 WITH (NOLOCK)
WHERE DivisionID=@DivisionID 
AND APKMaster=@APKMaster
AND APK = @APKDetail
AND ISNULL([Status],0)=1

OPEN @Cur
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@ChangeFromDate,@ChangeToDate,@ShiftID
WHILE @@FETCH_STATUS = 0
BEGIN	
	--SET  @FromDay=DAY(@ChangeFromDate)
	--SET  @ToDay=DAY(@ChangeToDate)

	SET @iMonth = MONTH(@ChangeFromDate)
	SET @iYear = YEAR(@ChangeFromDate)

	SELECT @FromDay = DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @iMonth, @iYear) WHERE [Date] = @ChangeFromDate
	SELECT @ToDay = DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @iMonth, @iYear) WHERE [Date] = @ChangeToDate

	DECLARE @i INT =@FromDay, @s VARCHAR(2)
	WHILE @i <= @ToDay
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		
		IF EXISTS (SELECT TOP 1 1 FROM OOT2000 WITH (NOLOCK)
		           LEFT JOIN OOT9000 WITH (NOLOCK) ON OOT2000.APKMaster=OOT9000.APK
		           WHERE OOT2000.DivisionID=@DivisionID AND EmployeeID=@EmployeeID AND TranMonth=@iMonth AND TranYear=@iYear)
		BEGIN
			IF @Status=1
			SET @sSQL1='UPDATE  T1 
						SET D'+@s+'='''+@ShiftID+''' 
						FROM OOT2000 T1
						LEFT JOIN OOT9000 T2 ON T1.DivisionID = T2.DivisionID AND T2.APK = T1.APKMaster
					    WHERE T1.DivisionID='''+@DivisionID+''' 
						AND T1.EmployeeID='''+@EmployeeID +'''
						AND T2.TranMonth='+STR(@iMonth)+'
						AND T2.TranYear='+STR(@iYear)+''
		END
		
		IF EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK)
		           WHERE DivisionID=@DivisionID AND EmployeeID=@EmployeeID AND TranMonth=@iMonth AND TranYear=@iYear)
		BEGIN
			IF @Status=1
			SET @sSQL2='UPDATE  HT1025 SET D'+@s+'='''+@ShiftID+''' 
			          	WHERE HT1025.DivisionID='''+@DivisionID+''' 
						AND EmployeeID='''+@EmployeeID +'''
						AND TranMonth='+STR(@iMonth)+'
						AND TranYear='+STR(@iYear)+''
		END
		EXEC(@sSQL1+@sSQL2)
		SET @i=@i+1
	END
	
	FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@ChangeFromDate,@ChangeToDate,@ShiftID
END 
Close @Cur



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
