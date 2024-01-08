IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0556]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0556]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------ Created by Pham Le Hoang.  
------ Created Date 24/05/2021
----- Purpose: Kiem tra truoc khi tinh luong/huy tinh luong san pham theo cong doan - HF0546, HF0547 Plugin (MAITHU)
/********************************************  
'* Edited by: [GS] [Minh Lâm] [02/08/2010]  
'********************************************/  
  
CREATE PROCEDURE [dbo].[HP0556]  
       @DivisionID AS nvarchar(50) ,  
       @TranMonth AS int ,  
       @TranYear AS int ,  
       @Date AS datetime ,  
       @DepartmentID1 AS nvarchar(50) ,  
       @TeamID1 AS nvarchar(50),
	   @Action AS int  
AS  
DECLARE  
        @Status AS tinyint ,  
        @VietMess AS nvarchar(250) ,  
        @EngMess AS nvarchar(250)  
  
SET @Status = 0  
SET @VietMess = ''  
SET @EngMess = ''  
  
IF EXISTS ( SELECT TOP 1 1 FROM HT3400 
				WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND DepartmentID LIKE @DepartmentID1
				AND IsNull(TeamID , '') LIKE IsNull(@TeamID1 , ''))  
   BEGIN  
         SET @Status = 1  
		 IF @Action = 0 --tính lương
		 BEGIN
			SET @VietMess = N'HFML000603' 
			SET @EngMess = N'HFML000603'
		 END
		 ELSE IF @Action = 1 -- hủy tính lương
		 BEGIN
			SET @VietMess = N'HFML000604' 
			SET @EngMess = N'HFML000604'
		 END
   END  
  
--ENDMESS:  
  
SELECT  
    @Status AS Status ,  
    @VietMess AS VieMessage ,  
    @EngMess AS EngMessage  
  
  
  
  
  

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
