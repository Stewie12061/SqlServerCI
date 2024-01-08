IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2511]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2511]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-----Created by Vo Thanh Huong, date: 24/08/2004
-----purpose: X? lý s? li?u in h? so luong
---Edit by Huynh Trung Dung date 14/12/2010 --- Them tham so @ToDepartmentID
---- Modified by Bảo Thy on 23/11/2016: Bổ sung C26->C150 (MEIKO)
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung
---- Modified by Văn Minh on 27/12/2019: Lỗi bound Table
---- EXEC [HP2511] 'MK', 'A00000', 'A000000', 2016, 10,'00'

CREATE PROCEDURE [dbo].[HP2511] @DivisionID nvarchar(50),
				@DepartmentID nvarchar(50),
				@ToDepartmentID nvarchar(50),
				@TranYear int,
				@TranMonth int,
				@ConnID nvarchar(100) ='00'

AS
Declare @sSQL1 nvarchar(4000)='',
	@sSQL nvarchar(4000)='',
	@sSQL2 nvarchar(4000)='', 
	@cur cursor,	
	@FieldID nvarchar(50),
	@Description nvarchar(250),
	@Orders int,
	@i int,
	@CustomerIndex INT

SELECT @CustomerIndex = CustomerName From CustomerIndex		
	
Select @sSQL1 = '', @sSQL2 = '', @i = 1
Set @sSQL1 = '
	Select 		HT.DivisionID, HT.EmployeeID, FullName,  HT.DepartmentID,  AT.DepartmentName, isnull(HT.TeamID,'''') as TeamID,  HT1101.TeamName, HV.Orders as Orders, 
			isnull(DutyName,'''') as DutyName,  isnull(HT.BaseSalary,0) as BaseSalary, isnull(HT.InsuranceSalary, 0) as InsuranceSalary, 
			isnull(HT.Salary01, 0) as Salary01, isnull(HT.Salary02, 0) as Salary02, isnull(HT.Salary03,0) as Salary03, isnull(HT.SalaryCoefficient,0) as SalaryCoefficient,  
			isnull(HT.TimeCoefficient,0) as TimeCoefficient, isnull(HT.DutyCoefficient,0) as DutyCoefficient,
		 	isnull(HT.C01,0) as C01, isnull(HT.C02,0) as C02, isnull(HT.C03,0) as C03, isnull(HT.C04,0) as C04, isnull(HT.C05,0) as C05, isnull(HT.C06,0) as C06, 
			isnull(HT.C07,0) as C07, isnull(HT.C08,0) as C08, isnull(HT.C09,0) as C09, isnull(HT.C10,0) as C10, isnull(HT.C11,0) as C11, isnull(HT.C12,0) as C12,
			isnull(HT.C13,0) as C13, isnull(HT.C14,0) as C14, isnull(HT.C15,0) as C15, isnull(HT.C16,0) as C16, isnull(HT.C17,0) as C17, isnull(HT.C18,0) as C18,
			isnull(HT.C19,0) as C19, isnull(HT.C20,0) as C20, isnull(HT.C21,0) as C21, isnull(HT.C22,0) as C22, isnull(HT.C23,0) as C23, isnull(HT.C24,0) as C24, 
			isnull(HT.C25,0) as C25, isnull(HV.C26,0) as C26, isnull(HV.C27,0) as C27, isnull(HV.C28,0) as C28, isnull(HV.C29,0) as C29, isnull(HV.C30,0) as C30, 
			isnull(HV.C31,0) as C31, isnull(HV.C32,0) as C32, isnull(HV.C33,0) as C33, isnull(HV.C34,0) as C34, isnull(HV.C35,0) as C35, isnull(HV.C36,0) as C36, 
			isnull(HV.C37,0) as C37, isnull(HV.C38,0) as C38, isnull(HV.C39,0) as C39, isnull(HV.C40,0) as C40, isnull(HV.C41,0) as C41, isnull(HV.C42,0) as C42, 
			isnull(HV.C43,0) as C43, isnull(HV.C44,0) as C44, isnull(HV.C45,0) as C45, isnull(HV.C46,0) as C46, isnull(HV.C47,0) as C47, isnull(HV.C48,0) as C48, 
			isnull(HV.C49,0) as C49, isnull(HV.C50,0) as C50, isnull(HV.C51,0) as C51, isnull(HV.C52,0) as C52, isnull(HV.C53,0) as C53, isnull(HV.C54,0) as C54, 
			isnull(HV.C55,0) as C55, isnull(HV.C56,0) as C56, isnull(HV.C57,0) as C57, isnull(HV.C58,0) as C58, isnull(HV.C59,0) as C59, isnull(HV.C60,0) as C60, 
			isnull(HV.C61,0) as C61, isnull(HV.C62,0) as C62, isnull(HV.C63,0) as C63, isnull(HV.C64,0) as C64, isnull(HV.C65,0) as C65, isnull(HV.C66,0) as C66, 
			isnull(HV.C67,0) as C67, isnull(HV.C68,0) as C68, isnull(HV.C69,0) as C69, isnull(HV.C70,0) as C70, isnull(HV.C71,0) as C71, isnull(HV.C72,0) as C72, 
			isnull(HV.C73,0) as C73, isnull(HV.C74,0) as C74, isnull(HV.C75,0) as C75, isnull(HV.C76,0) as C76, isnull(HV.C77,0) as C77, isnull(HV.C78,0) as C78, 
			isnull(HV.C79,0) as C79, isnull(HV.C80,0) as C80, isnull(HV.C81,0) as C81, isnull(HV.C82,0) as C82, isnull(HV.C83,0) as C83, isnull(HV.C84,0) as C84, 
			isnull(HV.C85,0) as C85, isnull(HV.C86,0) as C86, isnull(HV.C87,0) as C87, isnull(HV.C88,0) as C88, isnull(HV.C89,0) as C89, isnull(HV.C90,0) as C90, 
			isnull(HV.C91,0) as C91, isnull(HV.C92,0) as C92, isnull(HV.C93,0) as C93, isnull(HV.C94,0) as C94, isnull(HV.C95,0) as C95, isnull(HV.C96,0) as C96, 
			isnull(HV.C97,0) as C97, isnull(HV.C98,0) as C98, isnull(HV.C99,0) as C99, isnull(HV.C100,0) as C100, isnull(HV.C101,0) as C101,
			'
SET @sSQL ='
			isnull(HV.C102,0) as C102, isnull(HV.C103,0) as C103, isnull(HV.C104,0) as C104, isnull(HV.C105,0) as C105, isnull(HV.C106,0) as C106, 
			isnull(HV.C107,0) as C107, isnull(HV.C108,0) as C108, isnull(HV.C109,0) as C109, isnull(HV.C110,0) as C110, isnull(HV.C111,0) as C111, 
			isnull(HV.C112,0) as C112, isnull(HV.C113,0) as C113, isnull(HV.C114,0) as C114, isnull(HV.C115,0) as C115, isnull(HV.C116,0) as C116, 
			isnull(HV.C117,0) as C117, isnull(HV.C118,0) as C118, isnull(HV.C119,0) as C119, isnull(HV.C120,0) as C120, isnull(HV.C121,0) as C121, 
			isnull(HV.C122,0) as C122, isnull(HV.C123,0) as C123, isnull(HV.C124,0) as C124, isnull(HV.C125,0) as C125, isnull(HV.C126,0) as C126, 
			isnull(HV.C127,0) as C127, isnull(HV.C128,0) as C128, isnull(HV.C129,0) as C129, isnull(HV.C130,0) as C130, isnull(HV.C131,0) as C131, 
			isnull(HV.C132,0) as C132, isnull(HV.C133,0) as C133, isnull(HV.C134,0) as C134, isnull(HV.C135,0) as C135, isnull(HV.C136,0) as C136, 
			isnull(HV.C137,0) as C137, isnull(HV.C138,0) as C138, isnull(HV.C139,0) as C139, isnull(HV.C140,0) as C140, isnull(HV.C141,0) as C141, 
			isnull(HV.C142,0) as C142, isnull(HV.C143,0) as C143, isnull(HV.C144,0) as C144, isnull(HV.C145,0) as C145, isnull(HV.C146,0) as C146, 
			isnull(HV.C147,0) as C147, isnull(HV.C148,0) as C148, isnull(HV.C149,0) as C149, isnull(HV.C150,0) as C150
From HT2400 HT 
Inner join HV1400 HV on  HV.EmployeeID = HT.EmployeeID and HV.DivisionID = HT.DivisionID 
Inner join AT1102 AT on AT.DepartmentID = HT.DepartmentID 
Left  JOIN HT1101 on HT1101.TeamID = HT.TeamID and HT1101.DivisionID = HT.DivisionID and 
		HT1101.DepartmentID = HT.DepartmentID 
Where HT.DivisionID = ''' + @DivisionID + ''' and
HT.DepartmentID between ''' + @DepartmentID + ''' and  ''' + @ToDepartmentID + ''' and 
HT.TranMonth = ' + str(@TranMonth) + ' and
HT.TranYear = ' + str(@TranYear)  +'
'

--print @sSQL1
--print @sSQL

if not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2406')
	exec('Create view HV2406 ---- tao boi HP2511
				as ' + @sSQL1+@sSQL)	
else
	exec('Alter view HV2406 ---- tao boi HP2511
				as ' + @sSQL1+@sSQL)
if not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2406' + @ConnID)
	exec('Create view HV2406' + @ConnID + ' ---- tao boi HP2511
				as ' + @sSQL1+@sSQL)	
else
	exec('Alter view HV2406' + @ConnID + ' ---- tao boi HP2511
				as ' + @sSQL1+@sSQL)

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[HT2407' + @ConnID + ']') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	exec ('Drop table [dbo].[HT2407' + @ConnID + ']' )

Set @cur = Cursor scroll keyset for
		Select CoefficientID as FieldID, Caption as Description
			From HV1111
		Where DivisionID = @DivisionID And CoefficientID not in('C11','C12','C13')
		Union
		Select BaseSalaryFieldID as FieldID, Description
		From HV1112
		Where DivisionID = @DivisionID And BaseSalaryFieldID In ('BaseSalary', 'InsuranceSalary')
	--	Order by Orders
Open @cur
Fetch next from @cur into @FieldID, @Description
While @@FETCH_STATUS = 0
Begin	
	SET @FieldID = ISNULL(@FieldID,'');
	SET @Description = ISNULL(@Description,'');
	
	Set @sSQL2 = ' Select DivisionID,EmployeeID, FullName, DepartmentID, DepartmentName,  TeamID, Orders, DutyName, 
	' +@FieldID + ' as Amount, N''' + @FieldID + '''  as FieldID, N''' + @Description + ''' as  Description, '+ 
		str(@i) + ' as FOrders
	  From HV2406' + @ConnID + '
	 Where DivisionID = '''+@DivisionID+''' And	' + @FieldID + ' <> 0' 
	
	if @i=1
		begin
			set @sSQL1 = 'Select A.DivisionID, cast(A.EmployeeID as nvarchar(50)) as EmployeeID,cast(A.FullName as nvarchar(150)) as FullName,cast(A.DepartmentID as nvarchar(50)) as DepartmentID,
			cast(A.DepartmentName as nvarchar(150)) as DepartmentName,cast(A.TeamID as nvarchar(50)) as TeamID,cast(A.Orders as nvarchar(50)) as Orders, cast(A.DutyName as nvarchar(150)) as DutyName,
			cast(A.Amount as money) as Amount, cast(A.FieldID as nvarchar(50)) as FieldID,cast(A.Description as nvarchar(150)) as Description,cast(A.FOrders as int) as FOrders into HT2407' + @ConnID + ' from (' + @sSQL2 +') as A'
			
			exec (@sSQL1)
		end
	else			
		exec ('Insert into HT2407' + @ConnID + @sSQL2 )
	Set @i = @i + 1
	Fetch next from @cur into @FieldID, @Description	
	
	--print @sSQL1

End
--Set @sSQL2 = left(@sSQL2, len(@sSQL2) - 5)
Set @sSQL2 ='Select * from [dbo].[HT2407' + @ConnID + ']'

If not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2407')
	exec('Create view HV2407 ---- tao boi HP2511
				as ' + @sSQL2)
else
	exec('Alter view HV2407 ---- tao boi HP2511
				as ' + @sSQL2)	
If not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2407' + @ConnID)
	exec('Create view HV2407' + @ConnID + ' ---- tao boi HP2511
				as ' + @sSQL2)
else
	exec('Alter view HV2407' + @ConnID + ' ---- tao boi HP2511
				as ' + @sSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
