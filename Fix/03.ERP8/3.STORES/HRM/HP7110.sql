IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP7110]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP7110]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

  
CREATE PROCEDURE [dbo].[HP7110] @DivisionID nvarchar(50) ,  @PrintType int  
  
AS  

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

--IF @CustomerName = 50 ---- Customize Meiko
--BEGIN
--	EXEC HP7010_MK @DivisionID,
--	@ReportCode,
--	@FromDepartmentID,
--	@ToDepartmentID,
--	@TeamID,
--	@FromEmployeeID,
--	@ToEmployeeID,
--	@FromMonth,
--	@FromYear,
--	@ToMonth,
--	@ToYear,
--	@lstPayrollMethodID 
--END
--ELSE

  
DECLARE  
 @i int,  
 @DepID varchar(20),  
 @EmpID varchar(20),  
 @curDep cursor,  
 @curEmp cursor  
  
SET NOCOUNT ON  
  
SET @curDep = Cursor For  
 SELECT DepartmentID FROM HT7110 WHERE DivisionID = @DivisionID
 GROUP BY DivisionID,DepartmentID ORDER BY DivisionID,DepartmentID  
   
 open @curDep  
  
 FETCH NEXT FROM @curDep INTO @DepID  
 WHILE @@FETCH_STATUS=0  
 BEGIN  
  SET @i=1  
  If @PrintType = 0  
  Begin    
    SET @curEmp = Cursor  static For   
   SELECT EmployeeID FROM HT7110 WHERE DepartmentID= @DepID AND DivisionID = @DivisionID ORDER BY EmployeeID  
  End  
  If @PrintType = 1  
  Begin    
    SET @curEmp = Cursor  static For   
   SELECT EmployeeID FROM HT7110 WHERE DepartmentID= @DepID  AND DivisionID = @DivisionID And (Len(BankAccountNo)>0 Or BankAccountNo Is Not Null) ORDER BY EmployeeID  
  End  
  If @PrintType = 2  
  Begin    
    SET @curEmp = Cursor  static For   
   SELECT EmployeeID FROM HT7110 WHERE DepartmentID= @DepID  AND DivisionID = @DivisionID And (Len(BankAccountNo)<=0 Or BankAccountNo Is Null) ORDER BY EmployeeID  
  End  
  
  SET @curEmp = Cursor  static For   
  SELECT EmployeeID FROM HT7110 WHERE DepartmentID= @DepID  AND DivisionID = @DivisionID And (Len(BankAccountNo)<=0 Or BankAccountNo Is Null) ORDER BY EmployeeID  
  --For Update OF STT  
    
  Open @curEmp  
    
  FETCH NEXT FROM @curEmp INTO @EmpID  
    
  WHILE @@FETCH_STATUS=0  
  BEGIN  
     
   UPDATE HT7110 SET STT=@i WHERE EmployeeID=@EmpID  AND DivisionID = @DivisionID 
   FETCH NEXT FROM @curEmp INTO @EmpID  
   SET @i=@i+1  
  END  
    
  Close @curEmp  
  DEALLOCATE @curEmp  
  
  FETCH NEXT FROM @curDep INTO @DepID  
 END  
 close @curDep  
SET NOCOUNT OFF  
  
  
DEALLOCATE @curDep


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
