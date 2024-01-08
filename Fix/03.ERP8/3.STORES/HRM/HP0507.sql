IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0507]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0507]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- kiểm tra sửa/xóa Phân công nhân viên đứng máy (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT-HRM \ Danh mục \ Thông tin chấm công \ Phân công nhân viên đứng máy
-- <History>
----Created by Bảo Thy on 19/09/2017
---- Modified by on 

/*-- <Example>
	HP0507 @DivisionID='CH', @TranMonth=5, @TranYear=2017, @MachineID='%'
----*/

CREATE PROCEDURE [dbo].[HP0507]
(
	@DivisionID AS VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@APKMaster VARCHAR(50),
	@EmployeeList XML,
	@ScreenID VARCHAR(50)
)
AS


DECLARE @Status AS TINYINT = 0,
		@Message  AS NVARCHAR(250)

---Kiem tra nhan vien da tinh luong san pham thi khong cho sua
IF @ScreenID = 'HF0507'
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM HT1113 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND APKMaster = @APKMaster AND TranMonth+TranYear*100 = @TranMonth+@TranYear*100)
	BEGIN
		SET @Status = 1
		SET @Message = N'HFML000566'
		GOTO EndMess
	END

	IF EXISTS (SELECT TOP 1 1 FROM HT1113 T1 WITH (NOLOCK) 
			   INNER JOIN HT1118 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.TranMonth+T1.TranYear*100 = T2.TranMonth+T2.TranYear*100
			   WHERE T1.DivisionID = @DivisionID AND T1.APKMaster = @APKMaster AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100)
	BEGIN
		SET @Status = 1
		SET @Message = N'HFML000294'
		SELECT T1.EmployeeID
		INTO #HP0509_Employee_HF0507
		FROM HT1113 T1 WITH (NOLOCK) 
		INNER JOIN HT1118 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.TranMonth+T1.TranYear*100 = T2.TranMonth+T2.TranYear*100
		WHERE T1.DivisionID = @DivisionID AND T1.APKMaster = @APKMaster AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
		--SELECT * FROM #HP0509_Employee_HF0507 ORDER BY EmployeeID
		GOTO EndMess	
	END
END
ELSE
IF @ScreenID = 'HF0509'
BEGIN
	IF @EmployeeList IS NOT NULL
	BEGIN
		CREATE TABLE #HP0509_Employee_HF0509 (EmployeeID VARCHAR(50))
		
		INSERT INTO #HP0509_Employee_HF0509
		SELECT X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID
		FROM @EmployeeList.nodes('//Data') AS X (Data)
	
		IF EXISTS (SELECT TOP 1 1 FROM HT1118 T1 WITH (NOLOCK)
				   INNER JOIN #HP0509_Employee_HF0509 T2 WITH (NOLOCK) ON T1.EmployeeID = T2.EmployeeID
				   WHERE T1.DivisionID = @DivisionID AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100)
		BEGIN
			SET @Status = 1
			SET @Message = N'HFML000294'
			DELETE #HP0509_Employee_HF0509 
			FROM #HP0509_Employee_HF0509 T1
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM HT1118 T2 WITH (NOLOCK) WHERE T2.DivisionID = @DivisionID AND T2.TranMonth+T2.TranYear*100 = @TranMonth+@TranYear*100 AND T1.EmployeeID = T2.EmployeeID)
			--SELECT * FROM #HP0509_Employee_HF0509 ORDER BY EmployeeID
			GOTO EndMess	
		END
	END
END

EndMess:

SELECT @Status AS Status, @Message AS Message

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

