IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2501_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2501_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

  
----Created by: Vo Thanh Huong, date: 03/09/2004  
----purpose: Luu cham cong ngay khi them moi, hieu chinh  
  
/********************************************  
'* Edited by: [GS] [Vi?t Kh�nh] [02/08/2010]  
'********************************************/  
---- Modify by Phương Thảo by 
  
CREATE PROCEDURE [dbo].[HP2501_MK]   
    @DivisionID NVARCHAR(50),   
    @DepartmentID NVARCHAR(50),   
    @TeamID NVARCHAR(50),   
    @EmployeeID NVARCHAR(50),   
    @TranMonth INT,   
    @TranYear INT,   
    @AbsentDate DATETIME,   
    @AbsentTypeID NVARCHAR(50),   
    @AbsentAmount DECIMAL(28,8),   
    @CreateUserID NVARCHAR(50)  
AS  

Declare @TableHT2401 Varchar(50),
		@sSQL nvarchar(4000),
		@sTranMonth Varchar(2)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2401 = 'HT2401'
END

SET @sSQL = '
IF (NOT EXISTS(SELECT TOP 1 1   
                FROM '+@TableHT2401+'   
                WHERE DivisionID = '''+@DivisionID+'''   
                    AND DepartmentID = '''+@DepartmentID+'''   
                    AND ISNULL(TeamID,'''') = '''+ISNULL(@TeamID,'')+'''
                    AND EmployeeID = '''+@EmployeeID+'''   
                    AND TranMonth = '+STR(@TranMonth)+'   
                    AND TranYear = '+STR(@TranYear)+'
                    AND AbsentTypeID = '''+@AbsentTypeID+'''   
                    AND AbsentDate = '''+Convert(Varchar(20),@AbsentDate,120)+''') )  
    INSERT '+@TableHT2401+' (	DivisionID, DepartmentID, TeamID, EmployeeID, TranMonth, TranYear, AbsentDate, 
					AbsentTypeID, AbsentAmount, CreateUserID, CreateDate, 
					LastModifyUserID, LastModifydate )   
    VALUES ('''+@DivisionID+''', '''+@DepartmentID+''', '''+ISNULL(@TeamID,'')+''', '''+@EmployeeID+''', '+STR(@TranMonth)+', '+STR(@TranYear)+', 
			'''+Convert(Varchar(20),@AbsentDate,120)+''', 
			'''+@AbsentTypeID+''', '+Convert(Varchar(50),ISNULL(@AbsentAmount,0))+', '''+@CreateUserID+''', GETDATE(), 
			'''+@CreateUserID+''', GETDATE()) 

'
--PRINT @sSQL
EXEC(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

