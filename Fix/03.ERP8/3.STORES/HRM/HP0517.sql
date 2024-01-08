IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0517]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0517]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra trước khi sửa/xóa kết quả sản xuất (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT-HRM \ Danh mục \ Thông tin chấm công \ Kết quả sản xuất
-- <History>
----Created by Bảo Thy on 25/09/2017
---- Modified by on 

/*-- <Example>
	HP0517 @DivisionID='CH', @TranMonth=5, @TranYear=2017, @MachineID='%'
----*/

CREATE PROCEDURE [dbo].[HP0517]
(
	@DivisionID AS VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@MachineID VARCHAR(50)
)
AS

DECLARE @Status AS TINYINT = 0,
		@Message  AS NVARCHAR(250)

---Kiem tra máy da tinh luong san pham thi khong cho sua
IF EXISTS (SELECT TOP 1 1 FROM HT1118 T1 WITH (NOLOCK)   
		  WHERE T1.DivisionID = @DivisionID AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
		  AND (EXISTS (SELECT TOP 1 1 FROM HT1113 T2 WITH (NOLOCK) 
					  WHERE T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
					  AND T2.MachineID = @MachineID)
				OR EXISTS (SELECT TOP 1 1 FROM HT1114 T3 WITH (NOLOCK) 
					  WHERE T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID AND T1.TranMonth = T3.TranMonth AND T1.TranYear = T3.TranYear
					  AND T3.MachineID = @MachineID)
			  ))
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
