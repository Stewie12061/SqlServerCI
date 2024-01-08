IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2534]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2534]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-----Created by Vo Thanh Huong, date: 27/04/2005
-----purpose: Xu ly so lieu in ngay cong thang + luong cong thang 

/********************************************
'* Edited by: [GS] [Ngọc Nhựt] [29/07/2010]
'********************************************/
---- Modifyed by Kim Vu on 23/02/2016: Bổ sung in theo danh sách nhân viên được chọn
---- Modified by Bảo Thy on 16/09/2016: Thay đổi cách lấy danh sách nhân viên bằng XML để không bị tràn chuỗi
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Thy on 17/01/2017: BỔ sung I151 -> I200 (MEIKO)

CREATE PROCEDURE [dbo].[HP2534] 
				@DivisionID NVARCHAR(50),
				@FromDepartmentID NVARCHAR(50),
				@ToDepartmentID NVARCHAR(50),
				@TeamID NVARCHAR(50),
				@FromEmployeeID NVARCHAR(50), 
				@ToEmployeeID NVARCHAR(50), 
				@FromYear int,
				@FromMonth int,				
				@ToYear int,
				@ToMonth int,				
				@PayrollMethodID1 nvarchar(4000),
				@GrossPay NVARCHAR(50),
				@Deduction NVARCHAR(50),
				@IncomeTax NVARCHAR(50),
				@WorkingTime NVARCHAR(50),
				@Salary NVARCHAR(50),
				@BasicSalary NVARCHAR(50),
				@InsurSalary NVARCHAR(50),
				@NetPay NVARCHAR(50),
				@Allowance NVARCHAR(50), -- Phụ cấp
				@gnLang int,
				@IsChangeCurrency int,
				@lstEmployeeID as XML --- Danh sach nhân viên được chọn
				-- ,	@ProductPayrollMethodID as nvarchar(500)
AS
Declare @sSQL nvarchar(MAX), 
	@cur cursor,
	@FieldID NVARCHAR(50),
	@Caption nvarchar(100),
	@Signs  decimal (28, 8),
	@Notes  nvarchar(50), 
	@Orders int,
	@IncomeID NVARCHAR(50),
	@lstPayrollMethodID nvarchar(4000),
	@PayrollMethodID NVARCHAR(50),
	@Displayed decimal (28, 8),
	@Note1 as nvarchar(50),
	@sDepartment nvarchar(4000), 
	@Type as decimal (28, 8),
	@Pos int,
	@RateExchange decimal (28, 8),
	@Currency NVARCHAR(50),
	@Currency1 NVARCHAR(50),
	@sSQL_Where nvarchar(4000),
	@CustomerIndex INT,
	@sSelect1 nvarchar(MAX)='', 
	@sSelect2 nvarchar(MAX)='', 
	@sSelect3 nvarchar(MAX)='', 
	@sSelect4 nvarchar(MAX)='', 
	@sSelect5 nvarchar(MAX)='', 
	@sJoin nvarchar(MAX)=''	


SELECT X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID

INTO #Data
FROM @lstEmployeeID.nodes('//Data') AS X (Data)

--- kiem tra dieu kien where 
--if(ISNULL(@lstEmployeeID,'') = '')
--begin
--	SET @sSQL_Where =''
--end
--else
--begin
--	SET @sSQL_Where = ' AND T00.EmployeeID  in (''' + @lstEmployeeID + ''') '
--end

IF NOT EXISTS (SELECT TOP 1 1 FROM #Data)
BEGIN 
	SET @sSQL_Where =''
END
ELSE
BEGIN
	SET @sSQL_Where = ' AND T01.EmployeeID  in (SELECT EmployeeID FROM #Data) '
END

-----------------------------------------------PHONG BAN, TO NHOM CAN IN LUONG---------------------------------------------------------------------

Set @sDepartment='SELECT AT1101.DivisionID, AT1102.DepartmentID, AT1102.DepartmentName, HT1101.TeamID, HT1101.TeamName
	FROM AT1101 
	LEFT JOIN AT1102 ON AT1102.DivisionID in (AT1101.DivisionID,''@@@'') 
	LEFT JOIN HT1101 ON AT1102.DepartmentID = HT1101.DepartmentID
	Where AT1101.DivisionID = '''+@DivisionID+''' And AT1102.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
	isnull(HT1101.TeamID,'''') like isnull(''' + @TeamID + ''', '''')' 
--print @sDepartment

If not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2575')
	exec('Create view HV2575 ---- tao boi HP2534
				as ' +@sDepartment)
else
	exec('Alter view HV2575 ---- tao boi HP2534
				as ' + @sDepartment)
---BUOC 1		
----------------------------------------------------------------------------------------------------------------------TINH LUONG THANG-------------------------------------------------------------------------------------------
	
Set @lstPayrollMethodID = case when @PayrollMethodID1 = '%' then  ' like ''' + @PayrollMethodID1 + ''''  else ' in (''' + replace(@PayrollMethodID1, ',',''',''') + ''')' end 

Set @Pos=PATINDEX('%,%', @lstPayrollMethodID)

If @Pos <>0 Or  @PayrollMethodID1 = '%'-----neu in theo nhieu PP tinh luong 
	Begin
	Set @RateExchange=1
	Set @Currency='VND'
	Set @Currency1='USD'
	End
	
Else
	Begin
		Select @RateExchange= RateExchange From HT0000 Where DivisionID=@DivisionID
		Select @Currency= CurrencyID From HT5000 Where DivisionID = @DivisionID And PayrollMethodID=@PayrollMethodID1 
		If  @Currency='VND' 
			Set @Currency1='USD' 
		else 
			Set @Currency1='VND'

	End

Select @sSQL = '',  @Orders = 1

Set @sSQL = 'Select T00.DivisionID, T00.EmployeeID, FullName, T00.DepartmentID, V00.DepartmentName, PayrollMethodID, 
		V00.Orders as Orders, isnull(DutyName,'''') as DutyName, isnull(T00.TeamID,'''') as TeamID, isnull(T01.TeamName,'''') as TeamName, V00.WorkDate,
		avg(isnull(T02.InsuranceSalary, 0)) as InsuranceSalary, avg(isnull(T02.BaseSalary, 0)) as BaseSalary, 
		avg(isnull(T02.Salary01, 0)) as Salary01, avg(isnull(T02.Salary02, 0)) as Salary02, avg(isnull(T02.Salary03, 0)) as Salary03,
		
		avg(isnull(Income01,0)) as Income01,  avg(isnull(Income02, 0)) as Income02, avg(isnull(Income03, 0)) as Income03, 
		avg(isnull(Income04, 0)) as Income04, 
		avg(isnull(Income05, 0)) as Income05, avg(isnull(Income06, 0)) as Income06, avg(isnull(Income07, 0)) as Income07,
		avg(isnull(Income08, 0)) as Income08, avg(isnull(Income09, 0)) as Income09, avg(isnull(Income10, 0)) as Income10,
		avg(isnull(Income11,0)) as Income11,  avg(isnull(Income12, 0)) as Income12, avg(isnull(Income13, 0)) as Income13, 
		avg(isnull(Income14, 0)) as Income14, 
		avg(isnull(Income15, 0)) as Income15, avg(isnull(Income16, 0)) as Income16, avg(isnull(Income17, 0)) as Income17,
		avg(isnull(Income18, 0)) as Income18, avg(isnull(Income19, 0)) as Income19, avg(isnull(Income20, 0)) as Income20, '


SET @sSelect1 = '
		AVG(ISNULL(Income21,0)) AS Income21, AVG(ISNULL(Income22,0)) AS Income22, AVG(ISNULL(Income23,0)) AS Income23, AVG(ISNULL(Income24,0)) AS Income24,
		AVG(ISNULL(Income25,0)) AS Income25, AVG(ISNULL(Income26,0)) AS Income26, AVG(ISNULL(Income27,0)) AS Income27, AVG(ISNULL(Income28,0)) AS Income28,
		AVG(ISNULL(Income29,0)) AS Income29, AVG(ISNULL(Income30,0)) AS Income30,AVG(ISNULL(Income31,0)) AS Income31, AVG(ISNULL(Income32,0)) AS Income32,
		AVG(ISNULL(Income33,0)) AS Income33, AVG(ISNULL(Income34,0)) AS Income34, AVG(ISNULL(Income35,0)) AS Income35, AVG(ISNULL(Income36,0)) AS Income36, 
		AVG(ISNULL(Income37,0)) AS Income37, AVG(ISNULL(Income38,0)) AS Income38, AVG(ISNULL(Income39,0)) AS Income39, AVG(ISNULL(Income40,0)) AS Income40, 
		AVG(ISNULL(Income41,0)) AS Income41, AVG(ISNULL(Income42,0)) AS Income42, AVG(ISNULL(Income43,0)) AS Income43, AVG(ISNULL(Income44,0)) AS Income44, 
		AVG(ISNULL(Income45,0)) AS Income45, AVG(ISNULL(Income46,0)) AS Income46, AVG(ISNULL(Income47,0)) AS Income47, AVG(ISNULL(Income48,0)) AS Income48, 
		AVG(ISNULL(Income49,0)) AS Income49, AVG(ISNULL(Income50,0)) AS Income50, AVG(ISNULL(Income51,0)) AS Income51, AVG(ISNULL(Income52,0)) AS Income52, 
		AVG(ISNULL(Income53,0)) AS Income53, AVG(ISNULL(Income54,0)) AS Income54, AVG(ISNULL(Income55,0)) AS Income55, AVG(ISNULL(Income56,0)) AS Income56, 
		AVG(ISNULL(Income57,0)) AS Income57, AVG(ISNULL(Income58,0)) AS Income58, AVG(ISNULL(Income59,0)) AS Income59, AVG(ISNULL(Income60,0)) AS Income60, 
		AVG(ISNULL(Income61,0)) AS Income61, AVG(ISNULL(Income62,0)) AS Income62, AVG(ISNULL(Income63,0)) AS Income63, AVG(ISNULL(Income64,0)) AS Income64, 
		AVG(ISNULL(Income65,0)) AS Income65, AVG(ISNULL(Income66,0)) AS Income66, AVG(ISNULL(Income67,0)) AS Income67, AVG(ISNULL(Income68,0)) AS Income68, 
		AVG(ISNULL(Income69,0)) AS Income69, AVG(ISNULL(Income70,0)) AS Income70, AVG(ISNULL(Income71,0)) AS Income71, AVG(ISNULL(Income72,0)) AS Income72, 
		AVG(ISNULL(Income73,0)) AS Income73, AVG(ISNULL(Income74,0)) AS Income74, AVG(ISNULL(Income75,0)) AS Income75, AVG(ISNULL(Income76,0)) AS Income76, 
		AVG(ISNULL(Income77,0)) AS Income77, AVG(ISNULL(Income78,0)) AS Income78, AVG(ISNULL(Income79,0)) AS Income79, AVG(ISNULL(Income80,0)) AS Income80, 
		AVG(ISNULL(Income81,0)) AS Income81, AVG(ISNULL(Income82,0)) AS Income82, AVG(ISNULL(Income83,0)) AS Income83, AVG(ISNULL(Income84,0)) AS Income84, 
		AVG(ISNULL(Income85,0)) AS Income85, AVG(ISNULL(Income86,0)) AS Income86, AVG(ISNULL(Income87,0)) AS Income87, AVG(ISNULL(Income88,0)) AS Income88, 
		AVG(ISNULL(Income89,0)) AS Income89, AVG(ISNULL(Income90,0)) AS Income90, AVG(ISNULL(Income91,0)) AS Income91, AVG(ISNULL(Income92,0)) AS Income92, 
		AVG(ISNULL(Income93,0)) AS Income93, AVG(ISNULL(Income94,0)) AS Income94, AVG(ISNULL(Income95,0)) AS Income95, AVG(ISNULL(Income96,0)) AS Income96, 
		AVG(ISNULL(Income97,0)) AS Income97, AVG(ISNULL(Income98,0)) AS Income98, AVG(ISNULL(Income99,0)) AS Income99, AVG(ISNULL(Income100,0)) AS Income100, '
	SET @sSelect2 = '
		AVG(ISNULL(Income101,0)) AS Income101, AVG(ISNULL(Income102,0)) AS Income102, AVG(ISNULL(Income103,0)) AS Income103, AVG(ISNULL(Income104,0)) AS Income104, 
		AVG(ISNULL(Income105,0)) AS Income105, AVG(ISNULL(Income106,0)) AS Income106, AVG(ISNULL(Income107,0)) AS Income107, AVG(ISNULL(Income108,0)) AS Income108, 
		AVG(ISNULL(Income109,0)) AS Income109, AVG(ISNULL(Income110,0)) AS Income110, AVG(ISNULL(Income111,0)) AS Income111, AVG(ISNULL(Income112,0)) AS Income112, 
		AVG(ISNULL(Income113,0)) AS Income113, AVG(ISNULL(Income114,0)) AS Income114, AVG(ISNULL(Income115,0)) AS Income115, AVG(ISNULL(Income116,0)) AS Income116, 
		AVG(ISNULL(Income117,0)) AS Income117, AVG(ISNULL(Income118,0)) AS Income118, AVG(ISNULL(Income119,0)) AS Income119, AVG(ISNULL(Income120,0)) AS Income120, 
		AVG(ISNULL(Income121,0)) AS Income121, AVG(ISNULL(Income122,0)) AS Income122, AVG(ISNULL(Income123,0)) AS Income123, AVG(ISNULL(Income124,0)) AS Income124, 
		AVG(ISNULL(Income125,0)) AS Income125, AVG(ISNULL(Income126,0)) AS Income126, AVG(ISNULL(Income127,0)) AS Income127, AVG(ISNULL(Income128,0)) AS Income128, 
		AVG(ISNULL(Income129,0)) AS Income129, AVG(ISNULL(Income130,0)) AS Income130, AVG(ISNULL(Income131,0)) AS Income131, AVG(ISNULL(Income132,0)) AS Income132, 
		AVG(ISNULL(Income133,0)) AS Income133, AVG(ISNULL(Income134,0)) AS Income134, AVG(ISNULL(Income135,0)) AS Income135, AVG(ISNULL(Income136,0)) AS Income136, 
		AVG(ISNULL(Income137,0)) AS Income137, AVG(ISNULL(Income138,0)) AS Income138, AVG(ISNULL(Income139,0)) AS Income139, AVG(ISNULL(Income140,0)) AS Income140, 
		AVG(ISNULL(Income141,0)) AS Income141, AVG(ISNULL(Income142,0)) AS Income142, AVG(ISNULL(Income143,0)) AS Income143, AVG(ISNULL(Income144,0)) AS Income144, 
		AVG(ISNULL(Income145,0)) AS Income145, AVG(ISNULL(Income146,0)) AS Income146, AVG(ISNULL(Income147,0)) AS Income147, AVG(ISNULL(Income148,0)) AS Income148, 
		AVG(ISNULL(Income149,0)) AS Income149, AVG(ISNULL(Income150,0)) AS Income150,
		AVG(ISNULL(Income151,0)) AS Income151, AVG(ISNULL(Income152,0)) AS Income152, AVG(ISNULL(Income153,0)) AS Income153, AVG(ISNULL(Income154,0)) AS Income154, 
		AVG(ISNULL(Income155,0)) AS Income155, AVG(ISNULL(Income156,0)) AS Income156, AVG(ISNULL(Income157,0)) AS Income157, AVG(ISNULL(Income158,0)) AS Income158, 
		AVG(ISNULL(Income159,0)) AS Income159, AVG(ISNULL(Income160,0)) AS Income160, AVG(ISNULL(Income161,0)) AS Income161, AVG(ISNULL(Income162,0)) AS Income162,'
	SET @sSelect5 = ' 
		AVG(ISNULL(Income163,0)) AS Income163, AVG(ISNULL(Income164,0)) AS Income164, AVG(ISNULL(Income165,0)) AS Income165, AVG(ISNULL(Income166,0)) AS Income166, 
		AVG(ISNULL(Income167,0)) AS Income167, AVG(ISNULL(Income168,0)) AS Income168, AVG(ISNULL(Income169,0)) AS Income169, AVG(ISNULL(Income170,0)) AS Income170,
		AVG(ISNULL(Income171,0)) AS Income171, AVG(ISNULL(Income172,0)) AS Income172, AVG(ISNULL(Income173,0)) AS Income173, AVG(ISNULL(Income174,0)) AS Income174, 
		AVG(ISNULL(Income175,0)) AS Income175, AVG(ISNULL(Income176,0)) AS Income176, AVG(ISNULL(Income177,0)) AS Income177, AVG(ISNULL(Income178,0)) AS Income178, 
		AVG(ISNULL(Income179,0)) AS Income179, AVG(ISNULL(Income180,0)) AS Income180, AVG(ISNULL(Income181,0)) AS Income181, AVG(ISNULL(Income182,0)) AS Income182, 
		AVG(ISNULL(Income183,0)) AS Income183, AVG(ISNULL(Income184,0)) AS Income184, AVG(ISNULL(Income185,0)) AS Income185, AVG(ISNULL(Income186,0)) AS Income186, 
		AVG(ISNULL(Income187,0)) AS Income187, AVG(ISNULL(Income188,0)) AS Income188, AVG(ISNULL(Income189,0)) AS Income189, AVG(ISNULL(Income190,0)) AS Income190, 
		AVG(ISNULL(Income191,0)) AS Income191, AVG(ISNULL(Income192,0)) AS Income192, AVG(ISNULL(Income193,0)) AS Income193, AVG(ISNULL(Income194,0)) AS Income194, 
		AVG(ISNULL(Income195,0)) AS Income195, AVG(ISNULL(Income196,0)) AS Income196, AVG(ISNULL(Income197,0)) AS Income197, AVG(ISNULL(Income198,0)) AS Income198, 
		AVG(ISNULL(Income199,0)) AS Income199, AVG(ISNULL(Income200,0)) AS Income200,
		AVG(ISNULL(SubAmount21,0)) AS SubAmount21, AVG(ISNULL(SubAmount22,0)) AS SubAmount22, AVG(ISNULL(SubAmount23,0)) AS SubAmount23, AVG(ISNULL(SubAmount24,0)) AS SubAmount24,
		AVG(ISNULL(SubAmount25,0)) AS SubAmount25, AVG(ISNULL(SubAmount26,0)) AS SubAmount26, AVG(ISNULL(SubAmount27,0)) AS SubAmount27, AVG(ISNULL(SubAmount28,0)) AS SubAmount28,
		AVG(ISNULL(SubAmount29,0)) AS SubAmount29, AVG(ISNULL(SubAmount30,0)) AS SubAmount30,AVG(ISNULL(SubAmount31,0)) AS SubAmount31, AVG(ISNULL(SubAmount32,0)) AS SubAmount32,
		AVG(ISNULL(SubAmount33,0)) AS SubAmount33, AVG(ISNULL(SubAmount34,0)) AS SubAmount34, AVG(ISNULL(SubAmount35,0)) AS SubAmount35, AVG(ISNULL(SubAmount36,0)) AS SubAmount36, '
	SET @sSelect4 = '
		AVG(ISNULL(SubAmount37,0)) AS SubAmount37, AVG(ISNULL(SubAmount38,0)) AS SubAmount38, AVG(ISNULL(SubAmount39,0)) AS SubAmount39, AVG(ISNULL(SubAmount40,0)) AS SubAmount40, 
		AVG(ISNULL(SubAmount41,0)) AS SubAmount41, AVG(ISNULL(SubAmount42,0)) AS SubAmount42, AVG(ISNULL(SubAmount43,0)) AS SubAmount43, AVG(ISNULL(SubAmount44,0)) AS SubAmount44, 
		AVG(ISNULL(SubAmount45,0)) AS SubAmount45, AVG(ISNULL(SubAmount46,0)) AS SubAmount46, AVG(ISNULL(SubAmount47,0)) AS SubAmount47, AVG(ISNULL(SubAmount48,0)) AS SubAmount48, 
		AVG(ISNULL(SubAmount49,0)) AS SubAmount49, AVG(ISNULL(SubAmount50,0)) AS SubAmount50, AVG(ISNULL(SubAmount51,0)) AS SubAmount51, AVG(ISNULL(SubAmount52,0)) AS SubAmount52, 
		AVG(ISNULL(SubAmount53,0)) AS SubAmount53, AVG(ISNULL(SubAmount54,0)) AS SubAmount54, AVG(ISNULL(SubAmount55,0)) AS SubAmount55, AVG(ISNULL(SubAmount56,0)) AS SubAmount56, 
		AVG(ISNULL(SubAmount57,0)) AS SubAmount57, AVG(ISNULL(SubAmount58,0)) AS SubAmount58, AVG(ISNULL(SubAmount59,0)) AS SubAmount59, AVG(ISNULL(SubAmount60,0)) AS SubAmount60, 
		AVG(ISNULL(SubAmount61,0)) AS SubAmount61, AVG(ISNULL(SubAmount62,0)) AS SubAmount62, AVG(ISNULL(SubAmount63,0)) AS SubAmount63, AVG(ISNULL(SubAmount64,0)) AS SubAmount64, 
		AVG(ISNULL(SubAmount65,0)) AS SubAmount65, AVG(ISNULL(SubAmount66,0)) AS SubAmount66, AVG(ISNULL(SubAmount67,0)) AS SubAmount67, AVG(ISNULL(SubAmount68,0)) AS SubAmount68, 
		AVG(ISNULL(SubAmount69,0)) AS SubAmount69, AVG(ISNULL(SubAmount70,0)) AS SubAmount70, AVG(ISNULL(SubAmount71,0)) AS SubAmount71, AVG(ISNULL(SubAmount72,0)) AS SubAmount72, 
		AVG(ISNULL(SubAmount73,0)) AS SubAmount73, AVG(ISNULL(SubAmount74,0)) AS SubAmount74, AVG(ISNULL(SubAmount75,0)) AS SubAmount75, AVG(ISNULL(SubAmount76,0)) AS SubAmount76, 
		AVG(ISNULL(SubAmount77,0)) AS SubAmount77, AVG(ISNULL(SubAmount78,0)) AS SubAmount78, AVG(ISNULL(SubAmount79,0)) AS SubAmount79, AVG(ISNULL(SubAmount80,0)) AS SubAmount80, 
		AVG(ISNULL(SubAmount81,0)) AS SubAmount81, AVG(ISNULL(SubAmount82,0)) AS SubAmount82, AVG(ISNULL(SubAmount83,0)) AS SubAmount83, AVG(ISNULL(SubAmount84,0)) AS SubAmount84, 
		AVG(ISNULL(SubAmount85,0)) AS SubAmount85, AVG(ISNULL(SubAmount86,0)) AS SubAmount86, AVG(ISNULL(SubAmount87,0)) AS SubAmount87, AVG(ISNULL(SubAmount88,0)) AS SubAmount88, 
		AVG(ISNULL(SubAmount89,0)) AS SubAmount89, AVG(ISNULL(SubAmount90,0)) AS SubAmount90, AVG(ISNULL(SubAmount91,0)) AS SubAmount91, AVG(ISNULL(SubAmount92,0)) AS SubAmount92, 
		AVG(ISNULL(SubAmount93,0)) AS SubAmount93, AVG(ISNULL(SubAmount94,0)) AS SubAmount94, AVG(ISNULL(SubAmount95,0)) AS SubAmount95, AVG(ISNULL(SubAmount96,0)) AS SubAmount96, 
		AVG(ISNULL(SubAmount97,0)) AS SubAmount97, AVG(ISNULL(SubAmount98,0)) AS SubAmount98, AVG(ISNULL(SubAmount99,0)) AS SubAmount99, AVG(ISNULL(SubAmount100,0)) AS SubAmount100,
	'
	--PRINT @sSelect1
	--PRINT @sSelect2

	SET @sJoin = 'LEFT JOIN HT3499 T03 ON T00.DivisionID = T03.DivisionID AND T00.TransactionID = T03.TransactionID'

SET @sSelect3 = '
		avg(isnull(SubAmount01, 0)) as SubAmount01,  avg(isnull(SubAmount02, 0)) as SubAmount02,  avg(isnull(SubAmount03, 0)) as SubAmount03, 
		avg(isnull(SubAmount04, 0)) as SubAmount04, avg(isnull(SubAmount05, 0)) as SubAmount05,  avg(isnull(SubAmount06, 0)) as SubAmount06, 
		avg(isnull(SubAmount07, 0)) as SubAmount07, avg(isnull(SubAmount08, 0)) as SubAmount08,  avg(isnull(SubAmount09, 0)) as SubAmount09, 
		avg(isnull(SubAmount10, 0)) as SubAmount10 , 
		avg(isnull(SubAmount11, 0)) as SubAmount11,  avg(isnull(SubAmount12, 0)) as SubAmount12,  avg(isnull(SubAmount13, 0)) as SubAmount13, 
		avg(isnull(SubAmount14, 0)) as SubAmount14, avg(isnull(SubAmount15, 0)) as SubAmount15,  avg(isnull(SubAmount16, 0)) as SubAmount16, 
		avg(isnull(SubAmount17, 0)) as SubAmount17, avg(isnull(SubAmount18, 0)) as SubAmount18,  avg(isnull(SubAmount19, 0)) as SubAmount19, 
		avg(isnull(SubAmount20, 0)) as SubAmount20 ,avg(isnull(TaxAmount, 0)) as SubAmount00

		
	From HT3400 T00  inner join HV1400 V00 on  V00.EmployeeID = T00.EmployeeID and T00.DivisionID=V00.DivisionID
	LEFT join HV2575 T01 on T01.DivisionID = T00.DivisionID and T01.DepartmentID = T00.DepartmentID and isnull(T00.TeamID,'''') = isnull(T01.TeamID,'''')
	inner join HT2400 T02 on T02.DivisionID = T00.DivisionID  And T02.EmployeeID = T00.EmployeeID and T02.TranMonth = T00.TranMonth and T02.TranYear = T00.TranYear 
	Where T00.DivisionID = ''' + @DivisionID + ''' and
		T00.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
		isnull(T00.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
		T00.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
		T00.TranMonth + T00.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(10)) + ' and ' +  
		cast(@ToMonth + @ToYear*100 as nvarchar(10)) + ' and
		PayrollMethodID ' + @lstPayrollMethodID + @sSQL_Where +' 
	Group by T00.DivisionID, T00.EmployeeID, FullName, T00.DepartmentID, V00.DepartmentName, PayrollMethodID, 
		V00.Orders, isnull(DutyName,''''), isnull(T00.TeamID,''''), isnull(T01.TeamName,'''') , V00.WorkDate'
--print @sSQL

If  exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2576')
	Drop view HV2576
exec('Create view HV2576 ---- tao boi HP2534
			as ' + @sSQL+@sSelect1+@sSelect2+@sSelect5+@sSelect4+@sSelect3)

Set @sSQL = ''
Set @cur = Cursor scroll keyset for
	Select T00.PayrollMethodID, T00.IncomeID , right(T00.IncomeID,2) as Orders , 1 as Signs, 1 as Displayed,
		--Case @gnLang When 0 Then 'Tieàn löông' Else 'Gross Pay' End as Notes,
		--Case @gnLang When 0 Then  'Tieàn löông' Else 'Gross Pay' End as Note1, T01.Caption
		@GrossPay as Notes,
		--Case @gnLang When 0 Then  'Tieàn löông' Else 'Gross Pay' End as Note1, T01.Caption
		@GrossPay as Note1, T01.Caption
	From HT5005  T00 inner join HT0002 T01 on T00.IncomeID = T01.IncomeID and T00.DivisionID = T01.DivisionID
	Where T00.DivisionID = @DivisionID And T00.PayrollMethodID in (Select Distinct PayrollMethodID From HV2576) 
	Union 	
	Select  T00.PayrollMethodID, T00.SubID as IncomeID, right(T00.SubID,2) as Orders , 1 as Signs,  2 as Displayed,
		--Case @gnLang When 0 Then 'Tieàn löông' Else 'Gross Pay' End as Notes,
		--Case @gnLang When 0 Then  'Giaûm tröø' Else 'Deduction' End as Note1, T01.Caption
		@GrossPay as Notes,
		@Deduction as Note1, T01.Caption
	From HT5006  T00 inner join HT0005 T01 on T00.SubID = T01.SubID and T00.DivisionID = T01.DivisionID
	Where T00.DivisionID = @DivisionID And T00.PayrollMethodID in (Select Distinct PayrollMethodID From HV2576) 	
	Union 
	Select Distinct T00.PayrollMethodID, 'S00' as IncomeID, 0 as Orders, 1 as Signs, 2 as Displayed,
		--Case @gnLang When 0 Then 'Tieàn löông' Else 'Gross Pay' End as Notes,
		--Case @gnLang When 0 Then  'Giaûm tröø' Else 'Deduction' End as Note1,
		--Case @gnLang When 0 Then 'Thueá TN' Else 'Income Tax' End as Caption
		@GrossPay as Notes,
		@Deduction as Note1,
		@IncomeTax as Caption
	From HT5006  T00 
	Where T00.DivisionID = @DivisionID And T00.PayrollMethodID in (Select Distinct PayrollMethodID From HV2576) 

Open @cur
Fetch next from @cur into @PayrollMethodID, @IncomeID, @Orders, @Signs, @Displayed, @Notes,  @Note1, @Caption

While @@FETCH_STATUS = 0 
Begin
	Set @sSQL = @sSQL + ' Select DivisionID, EmployeeID, FullName, DepartmentID, DepartmentName,   InsuranceSalary, 
				BaseSalary, Salary01, Salary02, Salary03,
				Orders, DutyName, TeamID, TeamName, WorkDate, N''' + @Notes + ''' as Notes,  N'''  + @Note1 + ''' as Note1, ''' + @IncomeID + ''' as IncomeID,' + 
			cast(@Signs as nvarchar(50)) + ' as Signs, '  +
			cast(@Displayed as nvarchar(50)) + ' as Displayed, ' +
			+ case when @Displayed  = 1 then 'Income'  else '-SubAmount' end + 
			case when @Orders < 10 then '0' else '' end + cast(@Orders as NVARCHAR(50)) + '  as Amount,  N'''+  @Caption + ''' as  Caption, '
			+ cast(@Orders as nvarchar(2)) + ' as FOrders  , ''' +  @PayrollMethodID + ''' as a
		From HV2576   Where PayrollMethodID =''' + @PayrollMethodID + '''
		Union all' 		

	Fetch next from @cur into @PayrollMethodID, @IncomeID,  @Orders,@Signs ,@Displayed, @Notes,  @Note1, @Caption
End

--print @sSQL
--print 'a'
Set @sSQL = left(@sSQL, len(@sSQL) - 9)

set nocount off

If not Exists (Select top 1 1  From SysObjects Where Name ='HT2539' and Xtype ='U')

CREATE TABLE [dbo].[HT2539]  (
	[APK] [uniqueidentifier] NOT NULL,
	[DivisionID] [nvarchar](3) NOT NULL,
	[EmployeeID] [nvarchar] (50) NOT NULL,
	[FullName] [nvarchar] (250) NULL, 
	[DepartmentID] [nvarchar] (50)  NULL,
	[DepartmentName] [nvarchar] (100)  NULL, 
	[InsuranceSalary] [decimal] (28, 8)  NULL,	
	[BaseSalary] [decimal] (28, 8)  NULL,
	[Salary01] [decimal] (28, 8)  NULL,
	[Salary02]  [decimal] (28, 8) NULL ,
	[Salary03] [decimal] (28, 8) NULL ,
	[Orders] [int] NULL,
	[DutyName] [nvarchar] (250) NULL,
	[TeamID] [nvarchar] (20) NULL,
	[TeamName] [nvarchar] (200) NULL,
	[WorkDate] [datetime] NULL,
	[Notes] [nvarchar] (250) NULL,
	[Note1] [nvarchar] (250) NULL,
	[IncomeID] [nvarchar] (50) NULL,
	[Signs]  [int] NULL,
	[Displayed] [int] NULL,
	[Amount] [decimal] (28, 8) NULL,
	[Caption] [nvarchar] (250) NULL,
	[FOrders]  [int] NULL,
	[a] [nvarchar] (50) NULL
		
	
) ON [PRIMARY]
Else
  Delete  HT2539


Exec ( 'Insert into HT2539  ( DivisionID, EmployeeID, FullName, DepartmentID, DepartmentName,  InsuranceSalary, 
				BaseSalary, Salary01, Salary02, Salary03,
				Orders, DutyName, TeamID, TeamName, WorkDate, Notes,  Note1, IncomeID, Signs,  Displayed,  Amount,  Caption,  FOrders , a)' + @sSQL)


/*

If  exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2595')
	Drop view HV2595
exec('Create view HV2595 ---- tao boi HP2534
			as ' + @sSQL)*/


--BUOC 2 
------------------------------------------------------------------------------------------------------TINH NGAY CONG THANG-----------------------------------------------------------------------------------------

Declare @sSQL6 as nvarchar(4000)
Set @sSQL6='SELECT HT5003.DivisionID, HT5003.GeneralAbsentID, HT5003.AbsentTypeID, Caption,  HT1013.Orders
	FROM ht5003 INNER JOIN ht5005 ON ht5005.GeneralAbsentID = ht5003.GeneralAbsentID and ht5005.DivisionID = ht5003.DivisionID 
	AND ht5005.PayrollMethodID ' + @lstPayrollMethodID + ' 
	 INNER JOIN HT1013 ON HT1013.AbsentTypeID = HT5003.AbsentTypeID and HT1013.DivisionID = HT5003.DivisionID
	
	UNION
	SELECT HT5003.DivisionID, HT5003.GeneralAbsentID, HT5003.AbsentTypeID, Caption, 
    	HT1013.Orders
	FROM ht5003 INNER JOIN ht5006 ON  ht5006.DivisionID = ht5003.DivisionID and ht5006.GeneralAbsentID = ht5003.GeneralAbsentID AND 
    	ht5006.PayrollMethodID ' + @lstPayrollMethodID + '  
    	INNER JOIN HT1013 ON HT1013.DivisionID = HT5003.DivisionID '

If  exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2577')
	Drop view HV2577
exec('Create view HV2577 ---- tao boi HP2534
			as ' + @sSQL6)


Set @sSQL=''
Set @sSQL='SELECT HT02.EmployeeID, HT02.DivisionID, v.FullName, v.DepartmentID,  v.DepartmentName, 
		avg(isnull(V.InsuranceSalary, 0)) as InsuranceSalary, avg(isnull(V.BaseSalary, 0)) as BaseSalary, 
		avg(isnull(V.Salary01, 0)) as Salary01, avg(isnull(V.Salary02, 0)) as Salary02, avg(isnull(V.Salary03, 0)) as Salary03,

		3 AS Orders, v.DutyName, v.TeamID, v.TeamName, v.WorkDate, N''' + @WorkingTime+ ''''
		--+ Case @gnLang When 0 Then '''Soá coâng'''  Else '''Working Time'''  End  
		+' AS Notes, N''' + @WorkingTime+ ''''
		--+ Case @gnLang  When 0 Then  '''Soá coâng'''   Else   '''Working Time'''   End 
		+' AS Note1, HT02.AbsentTypeID AS IncomeID, 
    		0 AS Signs, -1 AS Displayed, H2.Caption, 
    		21 AS FOrders, V.A AS PayrollMethodID , avg(HT02.AbsentAmount) as Amount

	FROM HT2402 HT02 INNER JOIN HT2539 V ON HT02.DivisionID = v.DivisionID AND HT02.DepartmentID = v.DepartmentID AND 
    	ISNULL (HT02.TeamID, '''') = ISNULL (V.TeamID, '''') AND HT02.EmployeeID = v.EmployeeID
	INNER JOIN HV2577  H2 ON HT02.DivisionID = H2.DivisionID  And HT02.AbsentTypeID = H2.AbsentTypeID 
	
	
	WHERE HT02.DivisionID = ''' + @DivisionID + ''' and
		HT02.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
		isnull(HT02.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
		HT02.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
		HT02.TranMonth + ht02.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(10)) + ' and ' +  
		cast(@ToMonth + @ToYear*100 as nvarchar(10)) + @sSQL_Where + '
	
	GROUP BY HT02.EmployeeID, HT02.DivisionID, v.FullName, v.DepartmentID, 
    	v.DepartmentName, v.DutyName, v.TeamID, 
   	 v.TeamName, v.WorkDate,HT02.AbsentTypeID, H2.Caption, H2.Orders, v.a   
	Having avg(HT02.AbsentAmount)<100            
	
	

	Union SELECT distinct HV.EmployeeID, HV.DivisionID, HV.FullName, HV.DepartmentID,  HV.DepartmentName, 
		avg(isnull(HV.InsuranceSalary, 0)) as InsuranceSalary, avg(isnull(HV.BaseSalary, 0)) as BaseSalary, 
		avg(isnull(HV.Salary01, 0)) as Salary01, avg(isnull(HV.Salary02, 0)) as Salary02, avg(isnull(HV.Salary03, 0)) as Salary03,
		
		3 AS Orders, Hv.DutyName, Hv.TeamID, Hv.TeamName, hv.WorkDate, N''' + @Salary+ '''' 
		--+Case   @gnLang When 0 Then  '''Möùc löông'''    Else  '''Basic Salary'''   End
		+ ' AS Notes, N''' + @Salary+ '''' 
		--+Case   @gnLang  When 0 Then   '''Möùc löông'''    Else  '''Basic Salary'''   End
		+ '  AS Note1, N''' + @BasicSalary+ '''' 
		--+Case   @gnLang  When 0 Then   '''LCB'''   Else  '''Basic Salary'''   End 
		+ '  AS IncomeID, 
    		-1 AS Signs, -2 AS Displayed, N''' + @BasicSalary+ '''' 
    	--+Case   @gnLang  When 0 Then   '''LCB'''   Else  '''Basic Salary'''   End 
		+ ' as Caption, 
    		22 AS FOrders, ''Basic Salary'' AS PayrollMethodID , avg(isnull(HV.BaseSalary, 0)) as Amount
		
	From HV2576 HV
		GROUP BY HV.EmployeeID, Hv.DivisionID, Hv.FullName, Hv.DepartmentID, 
    	Hv.DepartmentName,  Hv.DutyName, Hv.TeamID, 
   	 Hv.TeamName, Hv.WorkDate 

	Union SELECT distinct HV.EmployeeID, HV.DivisionID, HV.FullName, HV.DepartmentID,  HV.DepartmentName, 
		avg(isnull(HV.InsuranceSalary, 0)) as InsuranceSalary, avg(isnull(HV.BaseSalary, 0)) as BaseSalary, 
		avg(isnull(HV.Salary01, 0)) as Salary01, avg(isnull(HV.Salary02, 0)) as Salary02, avg(isnull(HV.Salary03, 0)) as Salary03,
		
		3 AS Orders, Hv.DutyName, Hv.TeamID, Hv.TeamName, hv.WorkDate,N''' + @Salary+ '''' 
		--+Case   @gnLang When 0 Then  '''Möùc löông'''    Else  ''' Salary'''   End
		+ ' AS Notes, N''' + @Salary+ '''' 
		--+Case   @gnLang  When 0 Then   '''Möùc löông'''    Else  '''Insur Salary'''   End
		+ '  AS Note1, N''' + @Allowance+ '''' 
		--+Case   @gnLang  When 0 Then   '''LBHXH'''   Else  '''Insur Salary'''   End 
		+ '  AS IncomeID, 
    		-1 AS Signs, -1 AS Displayed, N''' + @Allowance+ '''' 
		--+Case   @gnLang  When 0 Then   '''LBHXH'''   Else  '''Insur Salary'''   End 
		+ ' as Caption, 
		22 AS FOrders, ''Basic Salary'' AS PayrollMethodID , avg(isnull(HV.Salary01, 0)) as Amount
	From HV2576 HV
	GROUP BY HV.EmployeeID, Hv.DivisionID, Hv.FullName, Hv.DepartmentID, 
    	Hv.DepartmentName,  Hv.DutyName, Hv.TeamID, 
   	 Hv.TeamName, Hv.WorkDate
	 '

	
--print @sSQL


If not Exists (Select top 1 1  From SysObjects Where Name ='HT2540' and Xtype ='U')

CREATE TABLE [dbo].[HT2540]  (
	[APK] [uniqueidentifier] NOT NULL,
	[DivisionID] [nvarchar](3) NOT NULL,
	[EmployeeID] [nvarchar] (50) NOT NULL,
	[FullName] [nvarchar] (250) NULL, 
	[DepartmentID] [nvarchar] (50)  NULL,
	[DepartmentName] [nvarchar] (250)  NULL, 
	[InsuranceSalary] [decimal] (28, 8)  NULL,	
	[BaseSalary] [decimal] (28, 8)  NULL,
	[Salary01] [decimal] (28, 8)  NULL,
	[Salary02]  [decimal] (28, 8) NULL ,
	[Salary03] [decimal] (28, 8) NULL ,
	[Orders] [int] NULL,
	[DutyName] [nvarchar] (250) NULL,
	[TeamID] [nvarchar] (50) NULL,
	[TeamName] [nvarchar] (250) NULL,
	[WorkDate] [datetime] NULL,
	[Notes] [nvarchar] (250) NULL,
	[Note1] [nvarchar] (250) NULL,
	[IncomeID] [nvarchar] (50) NULL,
	[Signs]  [int] NULL,
	[Displayed] [int] NULL,
	[Caption] [nvarchar] (250) NULL,
	[FOrders]  [int] NULL,
	[PayrollMethodID] [nvarchar] (50) NULL,
	[Amount] [decimal] (28, 8) NULL
		
	
) ON [PRIMARY]
Else
  Delete  HT2540


Exec ( 'Insert into HT2540  ( EmployeeID, DivisionID, FullName, DepartmentID, DepartmentName, InsuranceSalary, 
				BaseSalary, Salary01, Salary02, Salary03,
				Orders, DutyName, TeamID, TeamName, WorkDate, Notes, Note1,IncomeID, Signs,  Displayed,  Caption,  FOrders , PayrollMethodID, Amount)' + @sSQL)




----BUOC 4
----------------------------------------------------------------------------- KET HOP LUONG THANG VA NGAY CONG THANG--------------------------------------------
Declare @sSQL1 nvarchar(4000),
	@sSQL2 nvarchar(4000)
	
	
set @sSQL2='SELECT DivisionID, EmployeeID  , FullName ,DepartmentID ,DepartmentName ,  InsuranceSalary , 
	BaseSalary,Salary01,  Salary02 , Salary03   ,  Orders ,  DutyName  , TeamID , TeamName, WorkDate,
 	Notes , Note1, IncomeID ,Signs , Displayed,
 	Caption  , FOrders , A AS PayrollMethodID , Amount      
	FROM HT2539 Where DivisionID = '''+@DivisionID+'''
	
	UNION Select DivisionID, EmployeeID  , FullName ,DepartmentID ,DepartmentName ,  InsuranceSalary , 
		 BaseSalary,Salary01,  Salary02 , Salary03   ,  Orders ,  DutyName  , TeamID ,TeamName, WorkDate, N''' + @NetPay+ ' '+ @Currency + ''' '		 
		 + ' as Notes , N''' + @NetPay+ ' '
		 + @Currency + ''' '
		+ ' as Note1, ''I21'' as IncomeID , 2 as Signs , 0 as Displayed, N''' + @NetPay+ ' '
		+ @Currency + ''' '
		+' as Caption  , 15 as FOrders , A as PayrollMethodID  ,  sum(Amount) as Amount   
	
	FROM HT2539 Where DivisionID = '''+@DivisionID+'''

	GROUP BY DivisionID, EmployeeID  , FullName ,DepartmentID ,DepartmentName  ,InsuranceSalary , 
 		BaseSalary,Salary01,  Salary02 , Salary03   ,  Orders ,  DutyName  , TeamID , TeamName, WorkDate, A
	


	UNION 
		SELECT DivisionID, EmployeeID  , FullName ,DepartmentID ,DepartmentName ,  InsuranceSalary , 
	BaseSalary,Salary01,  Salary02 , Salary03   ,  Orders ,  DutyName  , TeamID ,TeamName,   WorkDate, Notes , Note1,
	IncomeID ,Signs , Displayed, Caption  , FOrders , PayrollMethodID  ,  Amount   
	FROM HT2540 Where DivisionID = '''+@DivisionID+''''

--print @sSQL2

If @IsChangeCurrency = 0----Neu khong doi ra loai tien khac

	Begin 
		If not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2578')
			exec('Create view HV2578 ---- tao boi HP2534
				as ' + @sSQL2)
		else
			exec('Alter view HV2578 ---- tao boi HP2534
				as ' + @sSQL2)
	End
Else --doi ra loai tien khac

	Begin
	
		If not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2579')
			exec('Create view HV2579 ---- tao boi HP2534
				as ' + @sSQL2)
		else
			exec('Alter view HV2579 ---- tao boi HP2534
				as ' + @sSQL2)

		Set @sSQL1='SELECT DivisionID, EmployeeID  , FullName ,DepartmentID ,DepartmentName ,   InsuranceSalary , 
				 BaseSalary,Salary01,  Salary02 , Salary03   ,  Orders ,  DutyName  , TeamID ,TeamName,  WorkDate, Notes , Note1,
 				IncomeID ,Signs , Displayed, Caption  , FOrders , PayrollMethodID  ,  Amount   
				FROM HV2579
				
				UNION 
				SELECT DivisionID, EmployeeID  , FullName ,DepartmentID ,DepartmentName ,   InsuranceSalary , 
				 BaseSalary,Salary01,  Salary02 , Salary03   ,  Orders ,  DutyName  , TeamID ,
				 TeamName, WorkDate, N''' + @NetPay+ ''' ''' + @Currency + ''' '
				--+ Case  @gnLang  When 0 Then '''Thöïc laõnh'''   Else '''Net Pay ' +  @Currency + ''' '  End 
				+ '   as Notes , N''' + @NetPay+ '''' 
				+  ' ''' + @Currency + ''' '
				--+Case  @gnLang  When 0 Then '''Thöïc laõnh'''  Else '''Net Pay ' +  @Currency + ''' '  End  
				+ ' as Note1, ''I22'' as IncomeID , 3 as Signs , 0 as Displayed, N''' + @NetPay+ ''''
				+  ' ''' + @Currency + ''' '
				--+Case  @gnLang  When 0 Then '''Thöïc laõnh'''  Else '''Net Pay ' +  @Currency + ''' ' End  
				+ ' as Caption  , 16 as FOrders ,  PayrollMethodID  , ' 
				+ Case @Currency When 'USD' Then  + Str(@RateExchange)+ '* sum(Amount)  ' 
				Else 'sum(Amount) /' + Str(@RateExchange)  End +' As Amount
				From
				
 				HV2579
				Where IncomeID=''I21'' 
				GROUP BY DivisionID, EmployeeID  , FullName ,DepartmentID ,DepartmentName  ,InsuranceSalary , 
 				BaseSalary,Salary01,  Salary02 , Salary03   ,  Orders ,  DutyName  , TeamID , TeamName,  WorkDate, PayrollMethodID' 

	--Print @sSQL1
		If not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2578')
			exec('Create view HV2578 ---- tao boi HP2534
				as ' + @sSQL1)
		else
			exec('Alter view HV2578 ---- tao boi HP2534
				as ' + @sSQL1)

	END

DROP TABLE #Data	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



