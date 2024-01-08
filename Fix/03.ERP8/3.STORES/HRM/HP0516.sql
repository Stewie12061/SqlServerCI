IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0516]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0516]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra trước khi xóa sửa hàng trả về (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Khả Vi on 25/09/2017
---- Modified by on 

/*-- <Example>
	HP0516 @DivisionID='CH', @TranMonth = 1, @TranYear = 2017,  @EmployeeID='0000000002'
----*/

CREATE PROCEDURE [dbo].[HP0516]
(
	@DivisionID AS VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@EmployeeID VARCHAR(50)
)
AS

DECLARE @Status AS TINYINT = 0,
		@Message  AS NVARCHAR(250)

--Kiem tra neu du lieu khong thuoc ky ke toan hien tai thi khong cho xoa/sua
IF NOT EXISTS (SELECT TOP 1 1 FROM HT1116 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND DivisionID = @DivisionID AND TranMonth + TranYear * 100 = @TranMonth + @TranYear * 100)
BEGIN
	SET @Status = 1
	SET @Message = N'HFML000566'
	GOTO EndMess
END
--Kiem tra may da duoc lap ket qua san suat trong ky thi khong cho xoa/sua
IF EXISTS (SELECT TOP 1 1 FROM HT1116 WITH (NOLOCK)
			INNER JOIN HT11161 WITH (NOLOCK) ON HT1116.DivisionID = HT11161.DivisionID AND HT1116.APK = HT11161.APKMaster
			INNER JOIN HT1117 WITH (NOLOCK) ON HT11161.DivisionID = HT1117.DivisionID AND HT11161.MachineID = HT1117.MachineID 
			WHERE HT1116.EmployeeID = @EmployeeID AND HT1116.DivisionID = @DivisionID AND HT1116.TranMonth + HT1116.TranYear * 100 = @TranMonth + @TranYear * 100 )
BEGIN
	SET @Status = 1
	SET @Message = N'HFML000009'
	GOTO EndMess
END

--Kiem tra may da duoc tinh luong cho nhan vien trong ky thi khong cho xoa/sua
IF EXISTS (SELECT TOP 1 1 FROM HT1116 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND DivisionID = @DivisionID AND EmployeeID = @EmployeeID AND TranMonth + TranYear * 100 = @TranMonth + @TranYear * 100)
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM HT1116 WITH (NOLOCK)
				INNER JOIN HT1118 ON HT1116.DivisionID = HT1118.DivisionID AND HT1116.EmployeeID = HT1118.EmployeeID AND HT1116.TranMonth + HT1116.TranYear * 100 = HT1118.TranMonth + HT1118.TranYear * 100 
				WHERE HT1116.EmployeeID = @EmployeeID AND HT1116.DivisionID = @DivisionID AND HT1116.TranMonth + HT1116.TranYear * 100 = @TranMonth + @TranYear * 100 )
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
