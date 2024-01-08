IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0505]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0505]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra sửa/xóa kế hoạch sản xuất theo máy
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 18/09/2017
---- Modified by on 

/*-- <Example>
	HP0505 @DivisionID='MK',@MachineID = '', @TranMonth=9, @TranYear=2017
----*/

CREATE PROCEDURE [dbo].[HP0505]
(
	@DivisionID AS VARCHAR(50), 
	@APK AS VARCHAR(50),
	@MachineID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT
)
AS

DECLARE @Status AS TINYINT = 0,
		@Message  AS NVARCHAR(250)

IF EXISTS (SELECT TOP 1 1 FROM HT1110 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND APK = @APK AND TranMonth+TranYear*100 <> @TranMonth+@TranYear*100)
BEGIN
	SET @Status = 1
	SET @Message = N'HFML000566'
	GOTO EndMess
END

IF EXISTS (SELECT TOP 1 1 FROM HT1113 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND MachineID = @MachineID AND TranMonth+TranYear*100 = @TranMonth+@TranYear*100)
OR EXISTS (SELECT TOP 1 1 FROM HT1114 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND MachineID = @MachineID AND TranMonth+TranYear*100 = @TranMonth+@TranYear*100)
OR EXISTS (SELECT TOP 1 1 FROM HT1115 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND MachineID = @MachineID AND TranMonth+TranYear*100 = @TranMonth+@TranYear*100)
BEGIN
	SET @Status = 1
	SET @Message = N'HFML000210'
	GOTO EndMess	
END


EndMess:

SELECT @Status AS Status, @Message AS Message

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
