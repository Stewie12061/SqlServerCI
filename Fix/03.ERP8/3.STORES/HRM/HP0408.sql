IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0408]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0408]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
 ---- 
 ---- Bao cao luong
 -- <Param>
 ---- 
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History> 
----- Created by: Trương Ngọc Phương Thảo on 26/12/2016
----- Purpose: Bao cao luong (customize Meiko) 
---- Modified by Phương Thảo on 27/04/2017: Fix lỗi lên các khoản bị sai
---- Modified on 11/08/2017 by Tấn Phú: 	+ Bổ điều kiện +T2.[Income143] (Meiko)
---- Modified on 08/09/2020	by Văn Tài: 	Move từ MEIKO qua.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

/*-- <Example>
EXEC HP0408 'MK', 12, 2016,  '%', '%', '%', '%', '%', '%'
----*/

CREATE PROCEDURE [dbo].[HP0408]
				@DivisionID as nvarchar(50),
				@TranMonth as Tinyint,
				@TranYear as Int,
				@DepartmentID as nvarchar(50),
				@TeamID as nvarchar(50),				
				@SectionID as nvarchar(50),
				@ProcessID as nvarchar(50),
				@FromEmployeeID as nvarchar(50),
				@ToEmployeeID as nvarchar(50),
				@Mode as Int = 0

AS
SET NOCOUNT ON

DECLARE @SQL NVarchar(4000) = ''

--IF (@Mode = 0) -- Bang luong tong hop
--BEGIN  
--	EXEC HP04081 @DivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @SectionID, @ProcessID, @FromEmployeeID, @ToEmployeeID, @Mode
--END
--ELSE
--IF (@Mode = 1) -- Bang luong thu viec
--BEGIN 
--	EXEC HP04082 @DivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @SectionID, @ProcessID, @FromEmployeeID, @ToEmployeeID, @Mode
--END
--ELSE
--IF (@Mode = 2) -- Payslip
--BEGIN 
--	EXEC HP04083 @DivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @SectionID, @ProcessID, @FromEmployeeID, @ToEmployeeID, @Mode
--END
--ElSE
--IF (@Mode = 3) -- Thanh toan luong
--BEGIN 
--	EXEC HP04084 @DivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @SectionID, @ProcessID, @FromEmployeeID, @ToEmployeeID, @Mode
--END

DECLARE @SQL01 Varchar(8000), @i int, @N int, @si Varchar(10),
		@TimeConvert decimal(28, 8), 
		@FirstDate datetime, @LastDate datetime,
		@sSQL001 Nvarchar(4000) ='',
		@sSQL002 Nvarchar(4000) ='',
		@sSQL003 Nvarchar(4000) ='',
		@sSQL004 Nvarchar(4000) ='',
		@sSQL005 Nvarchar(4000) ='',
		@sSQL006 Nvarchar(4000) ='',
		@sSQL007 Nvarchar(4000) ='',
		@sSQL008 Nvarchar(4000) ='',
		@sSQL009 Nvarchar(4000) ='',
		@sSQL010 Nvarchar(4000) ='',
		@sSQL011 Nvarchar(4000) ='',
		@sSQL012 Nvarchar(4000) ='',
		@sSQL013 Nvarchar(4000) ='',
		@sSQL014 Nvarchar(4000) ='',
		@TableHT2400 Varchar(50),		
		@TableHT2402 Varchar(50),	
		@sTranMonth Varchar(2),
		@sSQLWhereTV Nvarchar(4000) ='',
		@FromDepartmentID Varchar(50),
		@ToDepartmentID Varchar(50)

-- Lấy ra ngày cuối của tháng in
SET @FirstDate = CONVERT(Datetime,STR(@TranMonth)+'/'+'1'+'/'++STR(@TranYear)) 
--print @Date
SET @LastDate = DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@FirstDate)+1,0))

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear),
			@TableHT2402 = 'HT2402M'+@sTranMonth+Convert(Varchar(4),@TranYear)						
END
ELSE
BEGIN
	SELECT  @TableHT2400 = 'HT2400',
			@TableHT2402 = 'HT2402'
END

Declare @ReportCode Varchar(50)

SELECT TOP 1 @ReportCode = ReportCode
FROM HT4711
WHERE DivisionID = @DivisionID

IF(@DepartmentID = '%')
BEGIN 
	SELECT TOP 1 @FromDepartmentID = DepartmentID
	FROM AT1102 WITH (NOLOCK)
    WHERE Disabled=0 AND DivisionID = @DivisionID
    ORDER BY DepartmentID 

	SELECT TOP 1 @ToDepartmentID = DepartmentID
	FROM AT1102 WITH (NOLOCK)
    WHERE Disabled=0 AND DivisionID = @DivisionID
    ORDER BY DepartmentID desc
END
ELSE 
	SELECT	@FromDepartmentID = @DepartmentID,
			@ToDepartmentID = @DepartmentID

-- Xử lý insert bảng thiết lập báo cáo lương
EXEC HP7006 @DivisionID,@ReportCode,@FromDepartmentID,@ToDepartmentID,@TeamID,@FromEmployeeID,@ToEmployeeID,@TranMonth,@TranYear,@TranMonth,@TranYear,N'%',0,N'',N''


SET @sSQLWhereTV = N'
AND	
(
	(H03.FromApprenticeTime <= '''+Convert(Varchar(20),@FirstDate,112)+'''
	AND H03.ToApprenticeTime >= '''+Convert(Varchar(20),@LastDate,112)+''') 
OR
	(H03.FromApprenticeTime BETWEEN '''+Convert(Varchar(20),@FirstDate,112)+''' AND '''+Convert(Varchar(20),@LastDate,112)+''')
OR 
	(H03.ToApprenticeTime BETWEEN '''+Convert(Varchar(20),@FirstDate,112)+''' AND '''+Convert(Varchar(20),@LastDate,112)+''')
)
'


SET @sSQL001 = N'
SELECT	HT34.DivisionID,  HT34.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As  EmployeeName, 
		CASE WHEN HT14.IsMale = 0 THEN N''Nữ'' ELSE N''Nam'' END AS Sex, H24.DepartmentID, 
		Convert(NVarchar(250),'''') AS DepartmentName,
		H24.TeamID, 
		Convert(NVarchar(250),'''') AS TeamName,
		H24.[Ana04ID] AS SectionID, 
		Convert(NVarchar(250),'''') AS SectionName,
		H24.[Ana05ID] AS ProcessID, 
		Convert(NVarchar(250),'''') AS ProcessName,				
		Convert(Varchar(50),'''') AS ContractTypeID,
		Convert(Varchar(50),'''') AS StatusID,
		Convert(NVarchar(250),'''') AS WorkingStatus,
		HT14.Birthday, 
		H24.DutyID AS TitleID, 
		Convert(NVarchar(250),'''') AS TitleName,
		H03.[Target05ID] AS WorkType, H03.WorkDate,	Convert(decimal(28, 8),0) AS  StandardAmount,	
		H24.[Notes01] AS CT, Convert(int, Right(H03.SalaryLevel,2)) AS SalaryLevel, 
		Convert(Decimal(28,8),0) AS BaseSalary, Convert(Decimal(28,8),0) AS LevelAmount, Convert(Decimal(28,8),0) AS ResponsibilityAmount, 
		Convert(Decimal(28,8),0) AS KnowledgeAmount, Convert(Decimal(28,8),0) AS ExperienceAmount, Convert(Decimal(28,8),0) AS ManagementAmount,	
		Convert(Decimal(28,8),0) AS AdjustAmount, Convert(Decimal(28,8),0) AS  LanguageAmount,	Convert(Decimal(28,8),0) AS SpecialAmount, 
		Convert(Decimal(28,8),0) AS	XRayAmount,	Convert(Decimal(28,8),0) AS SkillAmount, 
		Convert(Decimal(28,8),0) AS EnvironmentAmount, 
		Convert(Decimal(28,8),0) AS  FixAmount, 
		Convert(Decimal(28,8),0) AS NightAllowance,  Convert(Decimal(28,8),0) AS GeneralActivityAmount,
		Convert(Decimal(28,8),0) AS FlexibleAmount,	Convert(Decimal(28,8),0) AS  ActualHours, 
		Convert(Decimal(28,8),0) AS NightHours30, Convert(Decimal(28,8),0) AS  FixOTHours, Convert(Decimal(28,8),0) AS  FemaleOTHours, 
		Convert(Decimal(28,8),0) AS NightHours, Convert(Decimal(28,8),0) AS BreakfastHours, Convert(Decimal(28,8),0) AS PickUpHours,
		Convert(Decimal(28,8),0) AS OT150, Convert(Decimal(28,8),0) AS OT215, Convert(Decimal(28,8),0) AS OT200, Convert(Decimal(28,8),0) AS OT280, 
		Convert(Decimal(28,8),0) AS OT300, Convert(Decimal(28,8),0) AS OT410, Convert(Decimal(28,8),0) AS WWHours, 
		Convert(Decimal(28,8),0) AS DTVS, Convert(Decimal(28,8),0) AS NoSalaryOff, Convert(Decimal(28,8),0) AS SalaryOff,
		Convert(Decimal(28,8),0) AS EmpDeduction, Convert(Decimal(28,8),0) AS Relation, Convert(Decimal(28,8),0) AS SumDeduction,
		Convert(Decimal(28,8),0) AS OTDeduction, Convert(Decimal(28,8),0) AS TNCNDeduction, Convert(Decimal(28,8),0) AS CalculateTNCN,
		Convert(Decimal(28,8),0) AS ActualAmount, Convert(Decimal(28,8),0) AS NightAmount30, Convert(Decimal(28,8),0) AS FixSalary,
		Convert(Decimal(28,8),0) AS	NightAmount, Convert(Decimal(28,8),0) AS LaboriousAmount, Convert(Decimal(28,8),0) AS PickUpAmount,
		Convert(Decimal(28,8),0) AS OTAmount, Convert(Decimal(28,8),0) AS OtherActivityAmount, Convert(Decimal(28,8),0) AS FlexibleSalary, '

SET @sSQL002 = N'
		
		Convert(Decimal(28,8),0) AS Amount150, Convert(Decimal(28,8),0) AS Amount215, Convert(Decimal(28,8),0) AS  Amount200, 
		Convert(Decimal(28,8),0) AS Amount280, Convert(Decimal(28,8),0) AS Amount300, Convert(Decimal(28,8),0) AS Amount410,
		Convert(Decimal(28,8),0) AS TotalOTAmount, Convert(Decimal(28,8),0) AS TotalBalanceBeforeTax, Convert(Decimal(28,8),0) AS TotalBalanceAfterTax,
		Convert(Decimal(28,8),0) AS SeasonalInsurance, Convert(Decimal(28,8),0) AS SalaryBeforeTax, Convert(Decimal(28,8),0) AS NoSalaryMinus,
		Convert(Decimal(28,8),0) AS DTVSMinus,	Convert(Decimal(28,8),0) AS InsuranceMinus,	Convert(Decimal(28,8),0) AS CommitMinus,
		Convert(Decimal(28,8),0) AS OtherMinus,	Convert(Decimal(28,8),0) AS MinusBeforeTax,	Convert(Decimal(28,8),0) AS IncomeTax,
		Convert(Decimal(28,8),0) AS PersonalTax, Convert(Decimal(28,8),0) AS SalaryAfterTax, Convert(Decimal(28,8),0) AS AdvanceAmount,
		Convert(Decimal(28,8),0) AS ActualSalary, H02.BankAccountNo, 
		Convert(NVarchar(50),'''') AS BankID,
		Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) AS ReceivePerson,
		Convert(NVarchar(250),'''') AS Address, Convert(NVarchar(250),'''') AS 	BankName, Convert(NVarchar(250),'''') AS Note	,
		-------- Cac khoan chi tiet len phieu luong
		Convert(Decimal(28,8),0) AS BalanceBeforeTax, Convert(Decimal(28,8),0) AS BalanceAfterTax,
		Convert(Decimal(28,8),0) AS FQCBonus, Convert(Decimal(28,8),0) AS OPLBonus, Convert(Decimal(28,8),0) AS WWDiscount,
		Convert(Decimal(28,8),0) AS LaboriousBonus, Convert(Decimal(28,8),0) AS PCCCAmount,
		Convert(Decimal(28,8),0) AS AbsentPreYear, Convert(Decimal(28,8),0) AS AbsentYear, 
		Convert(Decimal(28,8),0) AS PhoneAmount, Convert(Decimal(28,8),0) AS ApprenticeSalary,
		Convert(Decimal(28,8),0) AS FireAmount, Convert(Decimal(28,8),0) AS BHXHAmount, Convert(Decimal(28,8),0) AS MealAmount,
		Convert(Decimal(28,8),0) AS KTXMealPayment, Convert(Decimal(28,8),0) AS BreakfastDiscount,
		Convert(Decimal(28,8),0) AS KTXPayment, Convert(Decimal(28,8),0) AS BHYTAmount, Convert(Decimal(28,8),0) AS FirePayment,
		Convert(Decimal(28,8),0) AS BenefitAmount, Convert(Decimal(28,8),0) AS TNCNPreYear, Convert(Decimal(28,8),0) AS FineAmount,
		HT2499.[C149] AS IsCT, HT2499.[C148] AS IsTV, HT2499.[C150] AS IsCTTV
INTO	#HP04081_HT3400
FROM	HT3400 HT34
LEFT JOIN HT1400 HT14 ON HT34.EmployeeID = HT14.EmployeeID and HT34.DivisionID = HT14.DivisionID
LEFT JOIN HT1403 H03 WITH (NOLOCK) ON HT34.EmployeeID = H03.EmployeeID and HT34.DivisionID = H03.DivisionID
LEFT JOIN HT1402 H02 WITH (NOLOCK) ON HT34.EmployeeID = H02.EmployeeID and HT34.DivisionID = H02.DivisionID
LEFT JOIN '+@TableHT2400+' H24 WITH (NOLOCK) ON HT34.EmployeeID = H24.EmployeeID and HT34.DivisionID = H24.DivisionID
LEFT JOIN HT2499 WITH(NOLOCK) ON H24.EmpFileID = HT2499.EmpFileID AND H24.EmpFileID = HT2499.EmpFileID
WHERE	HT34.DivisionID = '''+@DivisionID+''' and
		Isnull(HT14.DepartmentID,'''') LIKE Isnull('''+@DepartmentID+''','''')  and
		Isnull(HT14.TeamID, '''') like Isnull('''+@TeamID+''', '''') and
		HT34.TranMonth + HT34.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'
		 AND Isnull(HT14.[Ana04ID],'''') like Isnull('''+@SectionID+''','''') AND Isnull(HT14.[Ana05ID],'''') like ISnull('''+@ProcessID+''','''')	 
		 AND HT34.EmployeeID BETWEEN '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+'''
'
+ CASE WHEN @Mode = 1 THEN @sSQLWhereTV ELSE '' END


SET @sSQL003 = N'

-- Update ten Khoi: DepartmentName
Update	T1
set		T1.DepartmentName = T2.DepartmentName
from	#HP04081_HT3400 T1
inner join AT1102 T2 WITH (NOLOCK) on T1.DepartmentID = T2.DepartmentID and T1.DivisionID = T2.DivisionID

-- Update ten Phong : TeamName
Update	T1
set		T1.TeamName = T2.TeamName
from	#HP04081_HT3400 T1
inner join HT1101 T2 WITH (NOLOCK) on T1.TeamID = T2.TeamID and T1.DivisionID = T2.DivisionID

-- Update ten Ban: SectionName
Update	T1
set		T1.SectionName = T2.AnaName
from	#HP04081_HT3400 T1
inner join AT1011 T2 WITH (NOLOCK) on T1.SectionID = T2.AnaID and T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A04''

-- Update ten Cong doan: ProcessName
Update	T1
set		T1.ProcessName = T2.AnaName
from	#HP04081_HT3400 T1
inner join AT1011 T2 WITH (NOLOCK) on T1.ProcessID = T2.AnaID and T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A05''

-- Update loại hợp đồng
UPDATE	T1
SET		T1.ContractTypeID = T2.ContractTypeID
FROM #HP04081_HT3400 T1
INNER JOIN
(SELECT EmployeeID, ContractTypeID
FROM HT1360 A
WHERE EXISTS 
(Select Top 1 1
From HT1360 B
Where B.EmployeeID = A.EmployeeID
Having A.SignDate = Max(B.SignDate))
) T2 ON T1.EmployeeID = T2.EmployeeID


-- Update trạng thái/chế độ
Update	T1
set		T1.StatusID = CASE WHEN ISNULL(T2.EmployeeMode,'''') <> '''' THEN  T2.EmployeeMode ELSE T2.EmployeeStatus END
from	#HP04081_HT3400 T1
left join HT1414 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
WHERE	'''+Convert(Varchar(50),@LastDate,101)+''' BETWEEN ISNULL(T2.BeginDate,T1.WorkDate) AND Isnull(T2.EndDate,'''+Convert(Varchar(50),@LastDate,101)+''') 

Update	T1
set		T1.WorkingStatus = T2.EmployeeStatusName
from	#HP04081_HT3400 T1
inner join
(	SELECT ID AS StatusID, [Description] AS EmployeeStatusName FROM AT0099 WHERE CodeMaster = ''AT00000010''
	UNION ALL
	SELECT  ''1'', N''NV đang làm''
	UNION ALL
	SELECT  ''2'', N''NV thử việc''
	UNION ALL
	SELECT  ''3'', N''Tạm nghỉ''
	UNION ALL
	SELECT  ''4'', N''CN thời vụ''	)T2 ON T1.StatusID = T2.StatusID

--- Update ten chuc danh: TitleName
Update	T1
set		T1.TitleName = T2.TitleName,
		T1.StandardAmount = T2.StandardAbsentAmount
from	#HP04081_HT3400 T1
inner join HT1106 T2 WITH (NOLOCK) on T1.TitleID = T2.TitleID and T1.DivisionID = T2.DivisionID
'


SET @sSQL004 = N'
--- BaseSalary: Lương cơ bản
Update	T1
set		T1.BaseSalary = CASE WHEN T1.IsCT = 1 THEN T2.[Income01] ELSE
							CASE WHEN T1.IsTV = 1 THEN T2.[Income02]
								ELSE CASE WHEN T1.IsCTTV = 1 THEN 
									CASE WHEN '+STR(@Mode)+' = 1 THEN T2.[Income04] ELSE T2.[Income03] END
								END
							END END
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- LevelAmount: Trợ cấp cấp bậc
Update	T1
set		T1.LevelAmount =  CASE WHEN T1.IsCT = 1 THEN T2.[Income05] ELSE
							CASE WHEN T1.IsTV = 1 THEN T2.[Income06]
								ELSE CASE WHEN T1.IsCTTV = 1 THEN 
									CASE WHEN '+STR(@Mode)+' = 1 THEN T2.[Income08] ELSE T2.[Income07] END
								END
							END END
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- ResponsibilityAmount: Trợ cấp trách nhiệm
Update	T1
set		T1.ResponsibilityAmount = CASE WHEN T1.IsCT = 1 THEN T2.[Income09] ELSE
							CASE WHEN T1.IsTV = 1 THEN T2.[Income10]
								ELSE CASE WHEN T1.IsCTTV = 1 THEN 
									CASE WHEN '+STR(@Mode)+' = 1 THEN T2.[Income12] ELSE T2.[Income11] END
								END
							END END
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- KnowledgeAmount: Trợ cấp chuyên môn
Update	T1
set		T1.KnowledgeAmount = CASE WHEN T1.IsCT = 1 THEN T2.[Income13] ELSE
							CASE WHEN T1.IsTV = 1 THEN T2.[Income14]
								ELSE CASE WHEN T1.IsCTTV = 1 THEN 
									CASE WHEN '+STR(@Mode)+' = 1 THEN T2.[Income16] ELSE T2.[Income15] END
								END
							END END
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- ExperienceAmount: Trợ cấp thâm niên
Update	T1
set		T1.ExperienceAmount = T2.[Income18] 
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- ManagementAmount: Trợ cấp quản lý sản xuất
Update	T1
set		T1.ManagementAmount = CASE WHEN T1.IsCT = 1 THEN T2.[Income19] ELSE
							CASE WHEN T1.IsTV = 1 THEN T2.[Income20]
								ELSE CASE WHEN T1.IsCTTV = 1 THEN 
									CASE WHEN '+STR(@Mode)+' = 1 THEN T2.[Income22] ELSE T2.[Income21] END
								END 
							END END
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'	'

SET  @sSQL005 = N'

-- AdjustAmount: Trợ cấp điều chỉnh
Update	T1
set		T1.AdjustAmount = CASE WHEN T1.IsCT = 1 THEN T2.[Income23] ELSE
							CASE WHEN T1.IsTV = 1 THEN T2.[Income24]
								ELSE CASE WHEN T1.IsCTTV = 1 THEN 
									CASE WHEN '+STR(@Mode)+' = 1 THEN T2.[Income26] ELSE T2.[Income25] END
								END 
							END END
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'	

-- LanguageAmount: Trợ cấp ngoại ngữ
Update	T1
set		T1.LanguageAmount = CASE WHEN T1.IsCT = 1 THEN T2.[Income27] ELSE
							CASE WHEN T1.IsTV = 1 THEN T2.[Income28]
								ELSE CASE WHEN T1.IsCTTV = 1 THEN 
									CASE WHEN '+STR(@Mode)+' = 1 THEN T2.[Income30] ELSE T2.[Income29] END
								END 
							END END
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- SpecialAmount: Trợ cấp đặc biệt
Update	T1
set		T1.SpecialAmount = CASE WHEN T1.IsCT = 1 THEN T2.[Income136] ELSE
							CASE WHEN T1.IsTV = 1 THEN T2.[Income137]
								ELSE CASE WHEN T1.IsCTTV = 1 THEN 
									CASE WHEN '+STR(@Mode)+' = 1 THEN T2.[Income139] ELSE T2.[Income138] END
								END 
							END END
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- XRayAmount: Trợ cấp XRay: Xử lý CT và TV đều hưởng như nhau, TH vừa CT, vừa TV thì ưu tiên CT
Update	T1
set		T1.XRayAmount = CASE WHEN T1.IsCT = 1 OR T1.IsTV = 1 THEN T2.[Income35]
						 ELSE CASE WHEN '+STR(@Mode)+' = 1 THEN 0 ELSE T2.[Income35] END END
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- SkillAmount: Trợ cấp kỹ năng có chứng chỉ và do Cty xét duyệt
Update	T1
set		T1.SkillAmount = CASE WHEN T1.IsCT = 1 THEN T2.[Income31] ELSE
							CASE WHEN T1.IsTV = 1 THEN T2.[Income32]
								ELSE CASE WHEN T1.IsCTTV = 1 THEN 
									CASE WHEN '+STR(@Mode)+' = 1 THEN T2.[Income34] ELSE T2.[Income33] END
								END 
							END END + T1.XRayAmount
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- EnvironmentAmount: Trợ cấp môi trường
Update	T1
set		T1.EnvironmentAmount = CASE WHEN T1.IsCT = 1 OR T1.IsTV = 1 THEN T2.[Income37] 
						 ELSE CASE WHEN '+STR(@Mode)+' = 1 THEN 0 ELSE T2.[Income37] END END
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- FixAmount: Tổng thu nhập cố định
Update	T1
set		T1.FixAmount = T1.BaseSalary + T1.LevelAmount + T1.ResponsibilityAmount + T1.KnowledgeAmount
					+ T1.ExperienceAmount + T1.ManagementAmount + T1.AdjustAmount + T1.LanguageAmount
					+ T1.SpecialAmount + T1.SkillAmount + T1.EnvironmentAmount
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

'

SET @sSQL006 = N'
-- NightAllowance: Trợ cấp làm đêm
Update	T1
set		T1.NightAllowance = T2.[Income43] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- GeneralActivityAmount: Trợ cấp kiêm nhiệm hoạt động chung
Update	T1
set		T1.GeneralActivityAmount = T2.[Income44] + T2.[Income45] + T2.[Income46] + T2.[Income47]	
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- FlexibleAmount: Tổng trợ cấp không cố định
Update	T1
set		T1.FlexibleAmount = T2.[Income52] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- ActualHours: Gio cong thuc te
Update	T1
set		T1.ActualHours = T2.Amount
from	#HP04081_HT3400 T1
inner join 
(SELECT		HT2402.DivisionID, HT2402.EmployeeID, SUM(HT2402.AbsentAmount) AS Amount
FROM		'+@TableHT2402+' HT2402
LEFT JOIN	HT1400 ON HT1400.DivisionID = HT2402.DivisionID AND HT1400.EmployeeID = HT2402.EmployeeID
WHERE		HT2402.DivisionID = '''+@DivisionID+''' and
			Isnull(HT2402.DepartmentID,'''') LIKE Isnull('''+@DepartmentID+''','''')  and
			Isnull(HT2402.TeamID, '''') like Isnull('''+@TeamID+''', '''') and
			HT2402.TranMonth + HT2402.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'
			AND Isnull(HT1400.[Ana04ID],'''') like Isnull('''+@SectionID+''','''') AND Isnull(HT1400.[Ana05ID],'''') like ISnull('''+@ProcessID+''','''')	 
			AND HT2402.EmployeeID BETWEEN '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+'''
			'+CASE WHEN @Mode = 1 THEN 'AND HT2402.AbsentTypeID IN (						
						SELECT  TActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+''') '
			ELSE 
						'AND HT2402.AbsentTypeID IN (
						SELECT  CActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+'''
						UNION ALL
						SELECT  TActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+''') ' END +'
GROUP BY HT2402.DivisionID, HT2402.EmployeeID ) T2 ON T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID 

-- EmpDeduction: Giảm trừ cho bản thân
Update	T1
set		T1.EmpDeduction = T2.[SubAmount10]
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- Relation: Số người phụ thuộc
Update	T1
set		T1.Relation = T2.Relation
from	#HP04081_HT3400 T1 
inner join
(
SELECT DivisionID, EmployeeID, Count(1) AS Relation
FROM HT0334
where Status  = 0 -- tanphu them dieu kien loai tru cac nguoi phu thuoc het hang
GROUP BY DivisionID, EmployeeID
) T2 ON T1.EmployeeID = T2.EmployeeID AND T1.DivisionID = T2.DivisionID
WHERE	T1.DivisionID = '''+@DivisionID+''' --AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+'		

-- OTDeduction: Giảm trừ OT
Update	T1
set		T1.OTDeduction = T2.[SubAmount12]
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- CalculateTNCN: Các khoản đã nhận đưa vào để tính thuế TNCN
Update	T1
set		T1.CalculateTNCN = T2.[Income141] + T2.[Income142] + T2.[Income143]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- ActualAmount: Lương theo giờ công thực tế
Update	T1
set		T1.ActualAmount = T2.[Income57] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'
'


SET @sSQL007 = N'

--NightAmount30: Trợ cấp làm việc ban đêm (30%)
Update	T1
set		T1.NightAmount30 = T2.[Income62] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- NightAmount: Trợ cấp ca đêm
Update	T1
set		T1.NightAmount = T2.[Income63] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- LaboriousAmount: Trợ cấp chuyên cần
Update	T1
set		T1.LaboriousAmount = T2.[Income64] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- PickUpAmount: Trợ cấp đi lại
Update	T1
set		T1.PickUpAmount = T2.[Income69] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

--OTAmount: Trợ cấp OT
Update	T1
set		T1.OTAmount = T2.[Income76] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- OtherActivityAmount: Trợ cấp kiêm nhiệm hoạt động khác
Update	T1
set		T1.OtherActivityAmount = T2.[Income81] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- Amount150: Ngày (150%)
Update	T1
set		T1.Amount150 = T2.[Income86] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- Amount215: Đêm (215%)
Update	T1
set		T1.Amount215 = T2.[Income91] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- Amount200: Ngày (200%)
Update	T1
set		T1.Amount200 = T2.[Income95] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- Amount280: Đêm (280%)
Update	T1
set		T1.Amount280 = T2.[Income100] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'
'

SET @sSQL008 = N'
-- Amount300: Ngày (300%)
Update	T1
set		T1.Amount300 = T2.[Income105] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- Amount410: Đêm (410%)
Update	T1
set		T1.Amount410 = T2.[Income110] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- TotalBalanceBeforeTax: Tổng bù trừ trước thuế
Update	T1
set		T1.TotalBalanceBeforeTax =	T2.[Income111] +T2.[Income112]+T2.[Income113]+ T2.[Income114]+ T2.[Income115]+
									T2.[Income116] +T2.[Income117]+T2.[Income118]+ T2.[Income119]+ T2.[Income120] +T2.[Income121] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- TotalBalanceAfterTax: Tổng bù trừ sau thuế
Update	T1
set		T1.TotalBalanceAfterTax =	T2.[Income122] +T2.[Income123]+T2.[Income124]+ T2.[Income125]+ T2.[Income126]+
									T2.[Income127] +T2.[Income128]+T2.[Income129]+ T2.[Income130]+ T2.[Income131]+ 
									T2.[Income132] +T2.[Income133]+T2.[Income134]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- SeasonalInsurance: Bảo hiểm cho NLĐ làm hợp đồng thời vụ (22%)
Update	T1
set		T1.SeasonalInsurance =	T2.[Income135] 
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- NoSalaryMinus: Khấu trừ Nghỉ không hưởng lương
Update	T1
set		T1.NoSalaryMinus =	T2.[SubAmount05]
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- DTVSMinus: Khấu trừ Đi sớm, về muộn, bỏ làm
Update	T1
set		T1.DTVSMinus =	T2.[SubAmount06]
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- CommitMinus: Khấu trừ Công đoàn
Update	T1
set		T1.CommitMinus =	T2.[SubAmount07]
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- OtherMinus: Khấu trừ khác
Update	T1
set		T1.OtherMinus =	T2.[SubAmount08]
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- SumDeduction : Tổng giảm trừ bản thân và người phụ thuộc
Update	T1
set		T1.SumDeduction =	T2.[SubAmount10]
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- AdvanceAmount : Âm lương tháng trước/ Số tiền đã tạm ứng
Update	T1
set		T1.AdvanceAmount =	T2.[SubAmount11]
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'
'
--- Xử lý lấy dữ liệu theo thiết lập báo cáo lương
DECLARE @StrAmount34 NVARCHAR(4000) = ''
update HT4712
set @StrAmount34 = @StrAmount34 + CASE WHEN @StrAmount34 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 34

SET @sSQL009 = N'
-- NightHours30: Số giờ làm việc ca đêm (30%)
Update	T1
set		T1.NightHours30 =	'+CASE WHEN @StrAmount34 = '' THEN STR(0) ELSE @StrAmount34 END+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID

'
DECLARE @StrAmount35 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount35 = @StrAmount35 + CASE WHEN @StrAmount35 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 35

SET @sSQL009 = @sSQL009+ N'
-- FixOTHours: Số giờ trợ cấp OT cố định (0.5h/ngày)(150%)
Update	T1
set		T1.FixOTHours =	'+CASE WHEN @StrAmount35 = '' THEN STR(0) ELSE @StrAmount35 END+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'
DECLARE @StrAmount36 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount36 = @StrAmount36 + CASE WHEN @StrAmount36 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 36
--select @StrAmount36
SET @sSQL009 = @sSQL009+ N'
-- FemaleOTHours: Số giờ trợ cấp OT phụ nữ (2h/ tháng) (150%)
Update	T1
set		T1.FemaleOTHours =	'+@StrAmount36+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'
DECLARE @StrAmount37 NVARCHAR(4000) = '0'

update HT4712
set @StrAmount37 = @StrAmount37 + CASE WHEN @StrAmount37 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 37

SET @sSQL009 = @sSQL009+ N'
-- NightHours: Số giờ trợ cấp ca đêm (12h/ngày)
Update	T1
set		T1.NightHours =	'+@StrAmount37+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount38 NVARCHAR(4000) = '0'

update HT4712
set @StrAmount38 = @StrAmount38 + CASE WHEN @StrAmount38 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 38

SET @sSQL009 = @sSQL009+ N'
-- BreakfastHours: Số ngày trừ tiền ăn sáng
Update	T1
set		T1.BreakfastHours =	'+@StrAmount38+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount39 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount39 = @StrAmount39 + CASE WHEN @StrAmount39 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 39

SET @sSQL009 = @sSQL009+ N'
-- PickUpHours: Số ngày hưởng trợ cấp đi lại
Update	T1
set		T1.PickUpHours =	'+@StrAmount39+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
INNER JOIN HT1403 T3 ON T1.EmployeeID = T3.EmployeeID AND T1.DivisionID = T3.DivisionID
WHERE T3.Target01ID = ''1''

'

DECLARE @StrAmount40 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount40 = @StrAmount40 + CASE WHEN @StrAmount40 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 40

SET @sSQL009 = @sSQL009+ N'
-- OT150: Ngày (150%)
Update	T1
set		T1.OT150 =	'+@StrAmount40+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID'


DECLARE @StrAmount41 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount41 = @StrAmount41 + CASE WHEN @StrAmount41 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 41

SET @sSQL010 = @sSQL010+ N'
-- OT215: Đêm (215%)
Update	T1
set		T1.OT215 =	'+@StrAmount41+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount42 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount42 = @StrAmount42 + CASE WHEN @StrAmount42 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 42

SET @sSQL010 = @sSQL010+ N'
-- OT200: Ngày(200%)
Update	T1
set		T1.OT200 =	'+@StrAmount42+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount43 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount43 = @StrAmount43 + CASE WHEN @StrAmount43 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 43

SET @sSQL010 = @sSQL010+ N'
-- OT280: Đêm (280%)
Update	T1
set		T1.OT280 =	'+@StrAmount43+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'
DECLARE @StrAmount44 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount44 = @StrAmount44 + CASE WHEN @StrAmount44 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 44

SET @sSQL010 = @sSQL010+ N'
-- OT300: Ngày (300%)
Update	T1
set		T1.OT300 =	'+@StrAmount44+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount45 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount45 = @StrAmount45 + CASE WHEN @StrAmount45 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 45

SET @sSQL010 = @sSQL010+ N'
-- OT410: Đêm (410%)
Update	T1
set		T1.OT410 =	'+@StrAmount45+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'
--print @sSQL010
DECLARE @StrAmount46 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount46 = @StrAmount46 + CASE WHEN @StrAmount46 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 46

SET @sSQL010 = @sSQL010+ N'
-- WWHours: Số giờ nghỉ chờ việc (70%)
Update	T1
set		T1.WWHours =	'+@StrAmount46+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount47 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount47 = @StrAmount47 + CASE WHEN @StrAmount47 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 47

SET @sSQL010 = @sSQL010+ N'
-- DTVS: Đi muộn, về sớm, bỏ làm
Update	T1
set		T1.DTVS =	'+@StrAmount47+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount48 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount48 = @StrAmount48 + CASE WHEN @StrAmount48 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 48

SET @sSQL010 = @sSQL010+ N'
-- NoSalaryOff: Nghỉ không hưởng lương
Update	T1
set		T1.NoSalaryOff =	'+@StrAmount48+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount49 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount49 = @StrAmount49 + CASE WHEN @StrAmount49 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 49

SET @sSQL010 = @sSQL010+ N'
-- SalaryOff: Số giờ nghỉ có hưởng lương (phép, TNLĐ, cưới, ma chay,…)
Update	T1
set		T1.SalaryOff =	ABS('+@StrAmount49+')
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount52 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount52 = @StrAmount52 + CASE WHEN @StrAmount52 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 52

SET @sSQL010 = @sSQL010+ N'
-- SumDeduction: Tổng giảm trừ bản thân và người phụ thuộc
Update	T1
set		T1.SumDeduction =	SumDeduction + '+@StrAmount52+' 
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount82 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount82 = @StrAmount82 + CASE WHEN @StrAmount82 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 82

SET @sSQL010 = @sSQL010+ N'
-- IncomeTax: Thu nhập chịu thuế
Update	T1
set		T1.IncomeTax =	'+@StrAmount82+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

DECLARE @StrAmount83 NVARCHAR(4000) = '0'
update HT4712
set @StrAmount83 = @StrAmount83 + CASE WHEN @StrAmount83 <> '' THEN ' + ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders))) END +' ,0)' 
																ELSE 'ISNULL(ColumnAmount'+CASE WHEN FOrders <10 THEN Convert(Varchar(2),'0'+Convert(Varchar(1),FOrders)) ELSE LTRIM(RTRIM(Convert(Varchar(5),FOrders)))END +' ,0)' END 
from HT4712 where OtherAmount = 83

SET @sSQL010 = @sSQL010+ N'
-- PersonalTax: Thuế TNCN
Update	T1
set		T1.PersonalTax =	'+@StrAmount83+'
from	#HP04081_HT3400 T1
inner join HT7110 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
'

--- Trường chi tiết để lên phiếu lương: V. Tổng bù trừ trước thuế
SET @sSQL011 = N'
-- FQCBonus: Thưởng FQC or Ribbon
Update	T1
set		T1.FQCBonus =	T2.[Income121]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- OPLBonus: Thưởng OPL & chứng chỉ ISO
Update	T1
set		T1.OPLBonus =	T2.[Income111]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- WWDiscount: Khấu trừ nghỉ chờ việc
Update	T1
set		T1.WWDiscount =	T2.[Income112]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- LaboriousBonus: Thưởng chuyên cần quý, năm
Update	T1
set		T1.LaboriousBonus =	T2.[Income113]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- BalanceBeforeTax : Bù/ trừ lương trước thuế
Update	T1
set		T1.BalanceBeforeTax =	T2.[Income114]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- PCCCAmount: Hỗ trợ tập huấn PCCC
Update	T1
set		T1.PCCCAmount =	T2.[Income120]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- AbsentPreYear: Thanh toán phép năm & NB 2015
Update	T1
set		T1.AbsentPreYear =	T2.[Income116]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- AbsentYear: Thanh toán phép năm (nghi việc)
Update	T1
set		T1.AbsentYear =	T2.[Income115]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- PhoneAmount: TC điện thoại
Update	T1
set		T1.PhoneAmount =	T2.[Income118]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- ApprenticeSalary: Lương thử việc
Update	T1
set		T1.ApprenticeSalary =	T2.[Income119]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'
'

--- Trường chi tiết để lên phiếu lương: VI. Tổng bù trừ sau thuế
SET @sSQL012 = N'
-- FireAmount: Trợ cấp thôi việc
Update	T1
set		T1.FireAmount =	T2.[Income129]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- BHXHAmount: Thanh toán chế độ BHXH 
Update	T1
set		T1.BHXHAmount =	T2.[SubAmount01]
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'
-- MealAmount: Tiền ăn ra ngoài, đi học
Update	T1
set		T1.MealAmount =	T2.[Income125]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

	
-- BalanceAfterTax : Bù/ trừ lương sau thuế
Update	T1
set		T1.BalanceBeforeTax =	T2.[Income127]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- KTXMealPayment: Truy thu suất ăn KTX
Update	T1
set		T1.KTXMealPayment =	T2.[Income124]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- BreakfastDiscount: Khấu trừ 1/2 giá trị bữa ăn sáng
Update	T1
set		T1.BreakfastDiscount =	T2.[Income132]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- KTXPayment: Truy thu KTX
Update	T1
set		T1.KTXPayment =	T2.[Income128]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- BHYTAmount: Truy thu/ truy lĩnh BHYT
Update	T1
set		T1.BHYTAmount =	T2.[SubAmount02]
from	#HP04081_HT3400 T1
inner join HT3400 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- FirePayment: Truy thu thiếu thủ tục thôi việc (Hoàn trả đồng phục)
Update	T1
set		T1.FirePayment =	T2.[Income131]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- BenefitAmount: Phúc lợi ma chay/cưới hỏi
Update	T1
set		T1.BHYTAmount =	T2.[Income134]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

--TNCNPreYear: Hoàn thuế TNCN 
Update	T1
set		T1.BHYTAmount =	T2.[Income133]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- FineAmount: Phạt vi phạm báo trước
Update	T1
set		T1.BHYTAmount =	T2.[Income123]
from	#HP04081_HT3400 T1
inner join HT3499 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'
'


SET @sSQL013 = N'
-- InsuranceMinus : Bảo hiểm
Update	T1
set		T1.InsuranceMinus =	SAmount + HAmount + TAmount
from	#HP04081_HT3400 T1
inner join HT2461 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID
where	T2.TranMonth + T2.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'

-- BankName: Tên chi nhánh ngân hàng
Update	T1
set		T1.BankID =	T2.BankID
from	#HP04081_HT3400 T1
inner join HT1402 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID =T2.DivisionID

Update	T1
set		T1.BankName =	T2.ObjectName,
		T1.Address = T2.Address
from	#HP04081_HT3400 T1
inner join AT1202 T2 WITH (NOLOCK) on T2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T1.BankID = T2.ObjectID and T1.DivisionID =T2.DivisionID
where T2.ObjectTypeID = ''BA''

'

---- Xử lý tính các cột công thức
SET @sSQL014 = N'
--- Tổng khấu trừ lương trước thuế : MinusBeforeTax = NoSalaryMinus + DTVSMinus + InsuranceMinus + OtherMinus
UPDATE	#HP04081_HT3400
SET		MinusBeforeTax = ISNULL(NoSalaryMinus,0) + Isnull(DTVSMinus,0) + Isnull(InsuranceMinus,0) + Isnull(OtherMinus,0)

--- Tổng giảm trừ thuế TNCN : TNCNDeduction = SumDeduction + OTDeduction
UPDATE	#HP04081_HT3400
SET		TNCNDeduction = ISNULL(SumDeduction,0) + ISNULL(OTDeduction,0)

--- Tổng lương cố định : FixSalary = ActualAmount + NightAmount30
UPDATE	#HP04081_HT3400
SET		FixSalary = ISNULL(ActualAmount,0) + ISNULL(NightAmount30,0)

--- Tổng lương không cố định: FlexibleSalary = NightAmount + LaboriousAmount + PickUpAmount + OTAmount + OtherActivityAmount
UPDATE	#HP04081_HT3400
SET		FlexibleSalary = ISNULL(NightAmount,0) + ISNULL(LaboriousAmount,0) + ISNULL(PickUpAmount,0) + ISNULL(OTAmount,0) + ISNULL(OtherActivityAmount,0)

--- Tổng lương làm thêm: TotalOTAmount = Amount150 + Amount215 + Amount200 + Amount280 + Amount300 + Amount410
UPDATE	#HP04081_HT3400
SET		TotalOTAmount = ISNULL(Amount150,0) + ISNULL(Amount215,0) + ISNULL(Amount200,0) + ISNULL(Amount280,0) + ISNULL(Amount300,0) + ISNULL(Amount410,0)

--- Tổng lương trước thuế: SalaryBeforeTax = FixSalary + FlexibleSalary + TotalOTAmount + TotalBalanceBeforeTax - MinusBeforeTax + CalculateTNCN + SeasonalInsurance
UPDATE	#HP04081_HT3400
SET		SalaryBeforeTax = Round((ISNULL(FixSalary,0) + ISNULL(FlexibleSalary,0) + ISNULL(TotalOTAmount,0) + ISNULL(TotalBalanceBeforeTax,0) 
						- ISNULL(MinusBeforeTax,0) + ISNULL(CalculateTNCN,0) + ISNULL(SeasonalInsurance,0)),0)

--- Tổng khấu trừ lương trước thuế: MinusBeforeTax = NoSalaryMinus + DTVSMinus + InsuranceMinus + OtherMinus
UPDATE	#HP04081_HT3400
SET		MinusBeforeTax = ISNULL(NoSalaryMinus,0) + ISNULL(DTVSMinus,0) + ISNULL(InsuranceMinus,0) + ISNULL(OtherMinus,0)

--- Tổng lương sau thuế: SalaryAfterTax = SalaryBeforeTax - PersonalTax + BalanceAfterTax - CalculateTNCN - CommitMinus
UPDATE	#HP04081_HT3400
SET		SalaryAfterTax = Round((ISNULL(SalaryBeforeTax,0) - ISNULL(PersonalTax,0) + ISNULL(BalanceAfterTax,0) - ISNULL(CalculateTNCN,0) - ISNULL(CommitMinus,0)),0)

--- Tổng lương thực nhận: ActualSalary = SalaryAfterTax - AdvanceAmount 
UPDATE	#HP04081_HT3400
SET		ActualSalary = CASE WHEN Round(ISNULL(SalaryAfterTax,0) - ISNULL(AdvanceAmount,0),0) < 0 THEN 0 ELSE Round(ISNULL(SalaryAfterTax,0) - ISNULL(AdvanceAmount,0),0)  END

SELECT * FROM #HP04081_HT3400 order by EmployeeID
DROP TABLE #HP04081_HT3400
'

--Print @sSQL001
--Print @sSQL002
--Print @sSQL003
--Print @sSQL004
--Print @sSQL005
--Print @sSQL006
--Print @sSQL007
--Print @sSQL008
--Print @sSQL009
--Print @sSQL010
--Print @sSQL011
--Print @sSQL012
--Print @sSQL013
--Print @sSQL014
EXEC(@sSQL001+@sSQL002+@sSQL003+@sSQL004+@sSQL005+@sSQL006+@sSQL007+@sSQL008+@sSQL009+@sSQL010+@sSQL011+@sSQL012+@sSQL013+@sSQL014)





SET NOCOUNT OFF



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
