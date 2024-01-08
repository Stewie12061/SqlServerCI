IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2620]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2620]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
  
--- Created by Bao Anh Date: 15/01/2213  
--- Purpose: Load du lieu phu cap theo cong trinh  
--- Modify on 03/04/2013 by Bao Anh: Bo PeriodID  
--- Modify on 11/10/2013 by Bao Anh: Bo sung he so C14 -> C25  
---- Modified on 16/09/2013 by Le Thi Thu Hien : Chia doan SQL de khong bi cat chuoi
--- Modified on 22/10/2013 by Bao Anh : Bo sung cac muc luong
--- Modified on 19/11/2013 by Bao Anh : Bo sung cac he so luong, chuc vu, tham nien
--- Modify on 04/12/2013 by Bảo Anh: Bổ sung Order by
--- Modify on 08/01/2014 by Bảo Anh: Bổ sung phí giới thiệu (Unicare)
--- Modify on 11/04/2014 by Bảo Anh: Bỏ where điều kiện TeamID khi join HT2400 và HT2430
--- Modify on 26/01/2015 by Quốc Tuấn: bổ sung join bảng HT3400 để xem đã được tính lương chưa
--- Modified on 03/08/2016 by Bảo Thy: sửa Isnull(HT02.C03,0) as C03
--- Modified on 14/11/2017 by Bảo Thy: fix lỗi Ambiguous Notes
--- Modified on 24/11/2016 by Bảo Thy: Bổ sung C26->C150 (MEIKO)
--- EXEC HP2620 'UN','3A  HCM',11,2013  
  
CREATE PROCEDURE [dbo].[HP2620]  
	@DivisionID nvarchar(50),    
    @ProjectID  NVARCHAR(50),   
    @TranMonth int,    
    @TranYear int  
    ---@PeriodID  NVARCHAR(50) = NULL    
AS    
Declare @sSQL nvarchar(max)  
Declare @sSQL1 nvarchar(max),
		@sSelect nvarchar(max)='',
		@sSelect1 nvarchar(max)='',
		@sJoin nvarchar(max)=''
		  
Declare @AP4444 Table(CustomerName Int, Export Int)  
Insert Into @AP4444(CustomerName,Export) EXEC('AP4444')

Set @sSQL = N'SELECT * FROM (  
Select HT.DivisionID, HT.DepartmentID, HT.TeamID, HT.EmployeeID, FullName, HT.TranMonth, HT.TranYear,(Case When  HT.TranMOnth <10 then ''0''+rtrim(ltrim(str(HT.TranMonth)))+''/''+ltrim(Rtrim(str(HT.TranYear)))     
 Else rtrim(ltrim(str(HT.TranMonth)))+''/''+ltrim(Rtrim(str(HT.TranYear))) End) as MonthYear, HV.Notes, HV.Orders, HV.WorkDate, HT02.ProjectID,
 Sum(Isnull(HT02.BaseSalary,HT.BaseSalary)) as BaseSalary, Sum(Isnull(HT02.Salary01,HT.Salary01)) as Salary01, Sum(Isnull(HT02.Salary02,HT.Salary02)) as Salary02, Sum(Isnull(HT02.Salary03,HT.Salary03)) as Salary03,
 Sum(Isnull(HT02.SalaryCoefficient,HT.SalaryCoefficient)) as SalaryCoefficient,
 Sum(Isnull(HT02.DutyCoefficient,HT.DutyCoefficient)) as DutyCoefficient,
 Sum(Isnull(HT02.TimeCoefficient,HT.TimeCoefficient)) as TimeCoefficient,
 Sum(Isnull(HT02.C01,HT.C01)) as C01, Sum(Isnull(HT02.C02,HT.C02)) as C02, Sum(Isnull(HT02.C03,0)) as C03,
 '
 
IF (Select CustomerName From @AP4444) = 21 --- Unicare
	Set @sSQL = @sSQL + '(case when (Select count(EmployeeID) From HT1403 Where DivisionID = HT.DivisionID And MidEmployeeID = HT.EmployeeID
									And datediff(month,WorkDate,''' + ltrim(@TranMonth) + '/25/' + LTRIM(@TranYear) + ''') >= 1
									And datediff(month,WorkDate,''' + ltrim(@TranMonth) + '/25/' + LTRIM(@TranYear) + ''') < 2
									And EmployeeStatus not in (3,9)) > 0
						 then Isnull(Sum(HT02.C04),(Select count(*) From HT1403 Where DivisionID = HT.DivisionID And MidEmployeeID = HT.EmployeeID
												And datediff(month,WorkDate,''' + ltrim(@TranMonth) + '/25/' + LTRIM(@TranYear) + ''') >= 1 
												And datediff(month,WorkDate,''' + ltrim(@TranMonth) + '/25/' + LTRIM(@TranYear) + ''') < 2
												And EmployeeStatus not in (3,9)) * 100000)
						 else Sum(Isnull(HT02.C04,HT.C04)) end) as C04,'
ELSE
	Set @sSQL = @sSQL + 'Sum(Isnull(HT02.C04,HT.C04)) as C04,'
	
 Set @sSQL = @sSQL + 'Sum(Isnull(HT02.C05,HT.C05)) as C05,  
 Sum(Isnull(HT02.C06,HT.C06)) as C06, Sum(Isnull(HT02.C07,HT.C07)) as C07, Sum(Isnull(HT02.C08,HT.C08)) as C08, Sum(Isnull(HT02.C09,HT.C09)) as C09, Sum(Isnull(HT02.C10,HT.C10)) as C10,  
 Sum(Isnull(HT02.C11,HT.C11)) as C11, Sum(Isnull(HT02.C12,HT.C12)) as C12, Sum(Isnull(HT02.C13,HT.C13)) as C13, Sum(Isnull(HT02.C14,HT.C14)) as C14, Sum(Isnull(HT02.C15,HT.C15)) as C15,  
 Sum(Isnull(HT02.C16,HT.C16)) as C16, Sum(Isnull(HT02.C17,HT.C17)) as C17, Sum(Isnull(HT02.C18,HT.C18)) as C18, Sum(Isnull(HT02.C19,HT.C19)) as C19, Sum(Isnull(HT02.C20,HT.C20)) as C20,  
 Sum(Isnull(HT02.C21,HT.C21)) as C21, Sum(Isnull(HT02.C22,HT.C22)) as C22, Sum(Isnull(HT02.C23,HT.C23)) as C23, Sum(Isnull(HT02.C24,HT.C24)) as C24, Sum(Isnull(HT02.C25,HT.C25)) as C25,
 (CASE WHEN ISNULL(HT3400.EmployeeID,'''')<>'''' THEN 1 ELSE 0 END) IsEdit
 '  
SET @sSelect = '
,SUM(isnull(HT03.C26,HT1.C26)) as C26, SUM(isnull(HT03.C27,HT1.C27)) as C27, SUM(isnull(HT03.C28,HT1.C28)) as C28, SUM(isnull(HT03.C29,HT1.C29)) as C29, SUM(isnull(HT03.C30,HT1.C30)) as C30, 
	SUM(isnull(HT03.C31,HT1.C31)) as C31, SUM(isnull(HT03.C32,HT1.C32)) as C32, SUM(isnull(HT03.C33,HT1.C33)) as C33, SUM(isnull(HT03.C34,HT1.C34)) as C34, SUM(isnull(HT03.C35,HT1.C35)) as C35, SUM(isnull(HT03.C36,HT1.C36)) as C36, 
	SUM(isnull(HT03.C37,HT1.C37)) as C37, SUM(isnull(HT03.C38,HT1.C38)) as C38, SUM(isnull(HT03.C39,HT1.C39)) as C39, SUM(isnull(HT03.C40,HT1.C40)) as C40, SUM(isnull(HT03.C41,HT1.C41)) as C41, SUM(isnull(HT03.C42,HT1.C42)) as C42, 
	SUM(isnull(HT03.C43,HT1.C43)) as C43, SUM(isnull(HT03.C44,HT1.C44)) as C44, SUM(isnull(HT03.C45,HT1.C45)) as C45, SUM(isnull(HT03.C46,HT1.C46)) as C46, SUM(isnull(HT03.C47,HT1.C47)) as C47, SUM(isnull(HT03.C48,HT1.C48)) as C48, 
	SUM(isnull(HT03.C49,HT1.C49)) as C49, SUM(isnull(HT03.C50,HT1.C50)) as C50, SUM(isnull(HT03.C51,HT1.C51)) as C51, SUM(isnull(HT03.C52,HT1.C52)) as C52, SUM(isnull(HT03.C53,HT1.C53)) as C53, SUM(isnull(HT03.C54,HT1.C54)) as C54, 
	SUM(isnull(HT03.C55,HT1.C55)) as C55, SUM(isnull(HT03.C56,HT1.C56)) as C56, SUM(isnull(HT03.C57,HT1.C57)) as C57, SUM(isnull(HT03.C58,HT1.C58)) as C58, SUM(isnull(HT03.C59,HT1.C59)) as C59, SUM(isnull(HT03.C60,HT1.C60)) as C60, 
	SUM(isnull(HT03.C61,HT1.C61)) as C61, SUM(isnull(HT03.C62,HT1.C62)) as C62, SUM(isnull(HT03.C63,HT1.C63)) as C63, SUM(isnull(HT03.C64,HT1.C64)) as C64, SUM(isnull(HT03.C65,HT1.C65)) as C65, SUM(isnull(HT03.C66,HT1.C66)) as C66, 
	SUM(isnull(HT03.C67,HT1.C67)) as C67, SUM(isnull(HT03.C68,HT1.C68)) as C68, SUM(isnull(HT03.C69,HT1.C69)) as C69, SUM(isnull(HT03.C70,HT1.C70)) as C70, SUM(isnull(HT03.C71,HT1.C71)) as C71, SUM(isnull(HT03.C72,HT1.C72)) as C72, 
	SUM(isnull(HT03.C73,HT1.C73)) as C73, SUM(isnull(HT03.C74,HT1.C74)) as C74, SUM(isnull(HT03.C75,HT1.C75)) as C75, SUM(isnull(HT03.C76,HT1.C76)) as C76, SUM(isnull(HT03.C77,HT1.C77)) as C77, SUM(isnull(HT03.C78,HT1.C78)) as C78, 
	SUM(isnull(HT03.C79,HT1.C79)) as C79, SUM(isnull(HT03.C80,HT1.C80)) as C80, SUM(isnull(HT03.C81,HT1.C81)) as C81, SUM(isnull(HT03.C82,HT1.C82)) as C82, SUM(isnull(HT03.C83,HT1.C83)) as C83, SUM(isnull(HT03.C84,HT1.C84)) as C84, 
	SUM(isnull(HT03.C85,HT1.C85)) as C85, SUM(isnull(HT03.C86,HT1.C86)) as C86, SUM(isnull(HT03.C87,HT1.C87)) as C87, SUM(isnull(HT03.C88,HT1.C88)) as C88, SUM(isnull(HT03.C89,HT1.C89)) as C89, SUM(isnull(HT03.C90,HT1.C90)) as C90, 
	SUM(isnull(HT03.C91,HT1.C91)) as C91, SUM(isnull(HT03.C92,HT1.C92)) as C92, SUM(isnull(HT03.C93,HT1.C93)) as C93, SUM(isnull(HT03.C94,HT1.C94)) as C94, SUM(isnull(HT03.C95,HT1.C95)) as C95, SUM(isnull(HT03.C96,HT1.C96)) as C96, 
	SUM(isnull(HT03.C97,HT1.C97)) as C97, SUM(isnull(HT03.C98,HT1.C98)) as C98, SUM(isnull(HT03.C99,HT1.C99)) as C99, SUM(isnull(HT03.C100,HT1.C100)) as C100, SUM(isnull(HT03.C101,HT1.C101)) as C101,
	'
	SET @sSelect1 = '
	SUM(isnull(HT03.C102,HT1.C102)) as C102, SUM(isnull(HT03.C103,HT1.C103)) as C103, SUM(isnull(HT03.C104,HT1.C104)) as C104, SUM(isnull(HT03.C105,HT1.C105)) as C105, SUM(isnull(HT03.C106,HT1.C106)) as C106, 
	SUM(isnull(HT03.C107,HT1.C107)) as C107, SUM(isnull(HT03.C108,HT1.C108)) as C108, SUM(isnull(HT03.C109,HT1.C109)) as C109, SUM(isnull(HT03.C110,HT1.C110)) as C110, SUM(isnull(HT03.C111,HT1.C111)) as C111, 
	SUM(isnull(HT03.C112,HT1.C112)) as C112, SUM(isnull(HT03.C113,HT1.C113)) as C113, SUM(isnull(HT03.C114,HT1.C114)) as C114, SUM(isnull(HT03.C115,HT1.C115)) as C115, SUM(isnull(HT03.C116,HT1.C116)) as C116, 
	SUM(isnull(HT03.C117,HT1.C117)) as C117, SUM(isnull(HT03.C118,HT1.C118)) as C118, SUM(isnull(HT03.C119,HT1.C119)) as C119, SUM(isnull(HT03.C120,HT1.C120)) as C120, SUM(isnull(HT03.C121,HT1.C121)) as C121, 
	SUM(isnull(HT03.C122,HT1.C122)) as C122, SUM(isnull(HT03.C123,HT1.C123)) as C123, SUM(isnull(HT03.C124,HT1.C124)) as C124, SUM(isnull(HT03.C125,HT1.C125)) as C125, SUM(isnull(HT03.C126,HT1.C126)) as C126, 
	SUM(isnull(HT03.C127,HT1.C127)) as C127, SUM(isnull(HT03.C128,HT1.C128)) as C128, SUM(isnull(HT03.C129,HT1.C129)) as C129, SUM(isnull(HT03.C130,HT1.C130)) as C130, SUM(isnull(HT03.C131,HT1.C131)) as C131, 
	SUM(isnull(HT03.C132,HT1.C132)) as C132, SUM(isnull(HT03.C133,HT1.C133)) as C133, SUM(isnull(HT03.C134,HT1.C134)) as C134, SUM(isnull(HT03.C135,HT1.C135)) as C135, SUM(isnull(HT03.C136,HT1.C136)) as C136, 
	SUM(isnull(HT03.C137,HT1.C137)) as C137, SUM(isnull(HT03.C138,HT1.C138)) as C138, SUM(isnull(HT03.C139,HT1.C139)) as C139, SUM(isnull(HT03.C140,HT1.C140)) as C140, SUM(isnull(HT03.C141,HT1.C141)) as C141, 
	SUM(isnull(HT03.C142,HT1.C142)) as C142, SUM(isnull(HT03.C143,HT1.C143)) as C143, SUM(isnull(HT03.C144,HT1.C144)) as C144, SUM(isnull(HT03.C145,HT1.C145)) as C145, SUM(isnull(HT03.C146,HT1.C146)) as C146, 
	SUM(isnull(HT03.C147,HT1.C147)) as C147, SUM(isnull(HT03.C148,HT1.C148)) as C148, SUM(isnull(HT03.C149,HT1.C149)) as C149, SUM(isnull(HT03.C150,HT1.C150)) as C150
'

SET @sJOIN = '
LEFT JOIN HT2499 HT1 WITH (NOLOCK) ON HT.EmpFileID = HT1.EmpFileID AND HT.TranMonth = HT1.TranMonth AND HT.TranYear = HT1.TranYear AND HT.DivisionID = HT1.DivisionID
LEFT JOIN HT2430_1 HT03 WITH (NOLOCK) ON HT03.EmployeeID = HT02.EmployeeID AND HT03.ProjectID = HT02.ProjectID AND HT03.TranMonth = HT02.TranMonth AND HT03.TranYear = HT02.TranYear AND HT03.DivisionID = HT02.DivisionID
'
  
Set @sSQL1 =  N' 
FROM HT2400 HT  
LEFT JOIN HT2430 HT02 ON HT.DivisionID=HT02.DivisionID and HT.DepartmentID=HT02.DepartmentID    
---   and IsNull(HT.TeamID,'''')=ISNull(HT02.TeamID,'''')
   and HT.EmployeeID=HT02.EmployeeID and    
   HT.TranMonth=HT02.TranMonth and HT.TranYear=HT02.TranYear and  
   Isnull(HT02.ProjectID,'''') = Isnull(''' + @ProjectID + ''','''')        
    LEFT JOIN HV1400 HV on HT.EmployeeID = HV.EmployeeID and HT.DivisionID=HV.DivisionID 
    LEFT JOIN HT3400 ON HT3400.DivisionID=HT.DivisionID and HT3400.EmployeeID=HT.EmployeeID
      and HT3400.DepartmentID=HT.DepartmentID and IsNull(HT3400.TeamID,'''')=IsNull(HT.TeamID,'''')
      and HT3400.TranMonth=HT.TranMonth and HT3400.TranYear=HT.TranYear  
 WHERE HT.DivisionID = ''' + @DivisionID + ''' and    
  HT.EmployeeID in (Select EmployeeID from HT2421 Where DivisionID = ''' + @DivisionID + ''' And ProjectID = ''' + @ProjectID + '''  and  
  TranMonth = ' + cast(@TranMonth as nvarchar(2)) + ' and TranYear = ' + cast(@TranYear as nvarchar(4)) + ') and  
  HT.TranMonth = ' + cast(@TranMonth as nvarchar(2)) + ' and    
  HT.TranYear = ' + cast(@TranYear as nvarchar(4)) + '      
 GROUP BY  HT.DivisionID, HT.DepartmentID, HT.TeamID, HT.EmployeeID, FullName, HT.TranMonth, HT.TranYear, HV.Notes, HV.Orders, HV.WorkDate, HT02.ProjectID,HT3400.EmployeeID) A
 Order by EmployeeID'   
  
--PRINT @sSQL 
--PRINT @sSelect  
--PRINT @sSelect1
--PRINT @sSQL1 
EXEC(@sSQl+@sSelect+@sSelect1+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
