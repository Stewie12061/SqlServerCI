IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5011_AG]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP5011_AG]
GO
------ Created by Nguyen Van Nhan.  
------ Created Date 04/05/2004
----- Purpose: Kiem tra truoc khi tinh luongg  
/********************************************  
'* Edited by: [GS] [Minh Lâm] [02/08/2010]  
'* Edited by: Kim Thư 09/10/2018 - Bổ sung kiểm tra tính lương theo từng nhân viên, truyền thêm EmployeeID
'* Edited by: Xuân Nguyên 17/11/2021 - Customize Angel
'********************************************/  
  
CREATE PROCEDURE [dbo].[HP5011_AG]  
       @DivisionID AS nvarchar(50) ,  
       @TranMonth AS int ,  
       @TranYear AS int ,  
       @PayrollMethodID AS nvarchar(50) ,  
       @VoucherDate AS datetime ,  
       @DepartmentID1 AS nvarchar(50) ,  
       @TeamID1 AS nvarchar(50) ,
	   @EmployeeID AS varchar(50)  
AS  
DECLARE  
        @Status AS tinyint ,  
        @VietMess AS nvarchar(250) ,  
        @EngMess AS nvarchar(250)  
  
SET @Status = 0  
SET @VietMess = ''  
SET @EngMess = ''  
 


IF EXISTS ( SELECT TOP 1  1  
            FROM  HT3400   WITH (NOLOCK)
            WHERE  PayrollMethodID = @PayrollMethodID AND DivisionID = @DivisionID AND DepartmentID LIKE @DepartmentID1 AND IsNull(TeamID , '') LIKE IsNull(@TeamID1 , '') 
			AND TranMonth = @TranMonth AND TranYear = @TranYear  AND EmployeeID LIKE @EmployeeID)  
   BEGIN  
         SET @Status = 1  
         SET @VietMess = N'HFML000160' --'Ph­¬ng ph¸p tÝnh l­¬ng kú nµy ®· ®­îc tÝnh, b¹n kh«ng thÓ tÝnh tiÕp ®­îc'  
         SET @EngMess = N'HFML000160'--' At this period,the payroll method is calcuted,you can not calcute! '  
   END  
  
--ENDMESS:  
  
SELECT  
    @Status AS Status ,  
    @VietMess AS VieMessage ,  
    @EngMess AS EngMessage  
  
  
  
  
  