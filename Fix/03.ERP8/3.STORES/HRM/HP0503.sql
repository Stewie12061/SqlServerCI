IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0503]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0503]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra sửa/xóa danh mục máy sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 14/09/2017
---- Modified by on 

/*-- <Example>
	HP0503 @DivisionID='MK',@MachineID = ''
----*/

CREATE PROCEDURE [dbo].[HP0503]
(
	@DivisionID AS VARCHAR(50), 
	@MachineID AS VARCHAR(50)
)
AS

DECLARE @Status AS TINYINT = 0,
		@Message  AS NVARCHAR(250)


IF EXISTS (SELECT TOP 1 1 FROM HT1110 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND MachineID = @MachineID)
OR EXISTS (SELECT TOP 1 1 FROM HT1113 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND MachineID = @MachineID)
OR EXISTS (SELECT TOP 1 1 FROM HT1114 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND MachineID = @MachineID)
OR EXISTS (SELECT TOP 1 1 FROM HT1115 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND MachineID = @MachineID)
OR EXISTS (SELECT TOP 1 1 FROM HT1117 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND MachineID = @MachineID)
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
