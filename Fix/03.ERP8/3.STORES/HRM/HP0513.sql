IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0513]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0513]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra trước khi xóa sửa thời gian dừng máy (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Khả Vi on 21/09/2017
---- Modified by on 

/*-- <Example>
	HP0513 @DivisionID='CH', @TranMonth = 1, @TranYear = 2017,  @MachineID = 'CONE_2'
----*/

CREATE PROCEDURE [dbo].[HP0513]
(
	@DivisionID AS VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@MachineID VARCHAR(50)
)
AS

DECLARE @Status AS TINYINT = 0,
		@Message  AS NVARCHAR(250)
--Kiem tra neu du lieu khong thuoc ky ke toan hien tai thi khong cho xoa/sua
IF NOT EXISTS (SELECT TOP 1 1 FROM HT1115 WITH (NOLOCK) WHERE MachineID = @MachineID AND DivisionID = @DivisionID AND  TranMonth + TranYear * 100 = @TranMonth + @TranYear * 100)
BEGIN
	SET @Status = 1
	SET @Message = N'HFML000566'
	GOTO EndMess
END
--Kiem tra may da duoc lap ket qua san suat trong ky thi khong cho xoa/sua
IF EXISTS (SELECT TOP 1 1 FROM HT1117 WITH (NOLOCK) WHERE MachineID = @MachineID AND DivisionID = @DivisionID AND  TranMonth + TranYear * 100 = @TranMonth + @TranYear * 100)
BEGIN
	SET @Status = 1
	SET @Message = N'HFML000571'
	GOTO EndMess
END
--Kiem tra may da duoc tinh luong cho nhan vien trong ky thi khong cho xoa/sua
IF EXISTS (SELECT TOP 1 1 FROM HT1115 WITH (NOLOCK) WHERE MachineID = @MachineID AND DivisionID = @DivisionID AND TranMonth+TranYear*100 = @TranMonth+@TranYear*100)
BEGIN
	-- Nhan vien giam sat
	IF EXISTS (SELECT TOP 1 1 FROM HT1115 WITH (NOLOCK) 
				INNER JOIN HT1114  WITH (NOLOCK)  ON HT1115.DivisionID = HT1114.DivisionID AND HT1115.MachineID = HT1114.MachineID AND HT1115.TranMonth + HT1115.TranYear * 100 = HT1114.TranMonth + HT1114.TranYear * 100
				INNER JOIN HT1118  WITH (NOLOCK)  ON HT1114.DivisionID = HT1118.DivisionID AND HT1114.EmployeeID = HT1118.EmployeeID AND HT1114.TranMonth + HT1114.TranYear * 100 = HT1118.TranMonth + HT1118.TranYear * 100
				WHERE HT1115.MachineID = @MachineID AND HT1115.DivisionID = @DivisionID AND HT1115.TranMonth + HT1115.TranYear * 100 = @TranMonth + @TranYear * 100)
	BEGIN
		SET @Status = 1
		SET @Message = N'HFML000009'
		GOTO EndMess
	END 

	-- Nhan vien dung may
	IF EXISTS (SELECT TOP 1 1 FROM HT1115 WITH (NOLOCK) 
				INNER JOIN HT1113  WITH (NOLOCK)  ON HT1115.DivisionID = HT1113.DivisionID AND HT1115.MachineID = HT1113.MachineID AND HT1115.TranMonth + HT1115.TranYear * 100 = HT1113.TranMonth + HT1113.TranYear * 100
				INNER JOIN HT1118  WITH (NOLOCK)  ON HT1113.DivisionID = HT1118.DivisionID AND HT1113.EmployeeID = HT1118.EmployeeID AND HT1113.TranMonth + HT1113.TranYear * 100 = HT1118.TranMonth + HT1118.TranYear * 100
				WHERE HT1115.MachineID = @MachineID AND HT1115.DivisionID = @DivisionID AND  HT1115.TranMonth + HT1115.TranYear * 100 = @TranMonth + @TranYear * 100)
	BEGIN
		SET @Status = 1
		SET @Message = N'HFML000009'
		GOTO EndMess
	END 
END

EndMess:

SELECT @Status AS Status, @Message AS Message

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
