IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5013_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP5013_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----Xoa du lieu tinh luong
---- Modified by Tiểu Mai on 15/03/2016: Bổ sung kiểm tra xóa bảng lương đã duyệt (ANGEL)
---- Modified by: Kim Thư 28/11/2018 - Bổ sung kiểm tra từng nhân viên, truyền thêm EmployeeID

CREATE PROCEDURE [dbo].[HP5013_AG]
       @DivisionID AS nvarchar(50) ,
       @TranMonth AS int ,
       @TranYear AS int ,
       @PayrollMethodID AS nvarchar(50) ,
       @DepartmentID1 AS nvarchar(50) ,
       @TeamID1 AS nvarchar(50),
	   @EmployeeID AS nvarchar(50)
AS
DECLARE
        @Status AS tinyint ,
        @Message AS nvarchar(250) ,
        @CustomerName Int

SET @Status = 0
SET @Message = ''

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)	
IF @CustomerName = 57 --- ANGEL
BEGIN

	-- Nếu tính cho 1 nhân viên cụ thể thì lấy DepartmentID và TeamID của nhân viên đó, ngược lại lấy theo dữ liệu người dùng chọn
	IF  @EmployeeID <>'%'
	BEGIN
		SELECT @DepartmentID1 = DepartmentID FROM HV3400 WHERE DivisionID=@DivisionID AND EmployeeID=@EmployeeID
		SELECT @TeamID1 = TeamID FROM HV3400 WHERE DivisionID=@DivisionID AND EmployeeID=@EmployeeID
		IF EXISTS (SELECT TOP 1 1 FROM HT3400 
	           WHERE DivisionID = @DivisionID 
					AND PayrollMethodID = @PayrollMethodID 
					AND DepartmentID LIKE @DepartmentID1 
					AND IsNull(TeamID , '') LIKE IsNull(@TeamID1 , '') 
					AND TranMonth = @TranMonth AND TranYear = @TranYear
					AND IsConfirm = 1
					AND EmployeeID=@EmployeeID)
			BEGIN
			SET @Status = 1
			SET @Message = N'HFML000523'			
			END
		ELSE
		DELETE
			HT3400
	WHERE
			PayrollMethodID = @PayrollMethodID AND DivisionID = @DivisionID AND DepartmentID LIKE @DepartmentID1 AND IsNull(TeamID , '') LIKE IsNull(@TeamID1 , '') AND TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID=@EmployeeID

	END
ELSE
	DELETE
			HT3400
	WHERE
			PayrollMethodID = @PayrollMethodID AND DivisionID = @DivisionID AND DepartmentID LIKE @DepartmentID1 AND IsNull(TeamID , '') LIKE IsNull(@TeamID1 , '') AND TranMonth = @TranMonth AND TranYear = @TranYear --AND EmployeeID=@EmployeeID

END	
SELECT  
    @Status AS Status ,  
    @Message AS Message




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
