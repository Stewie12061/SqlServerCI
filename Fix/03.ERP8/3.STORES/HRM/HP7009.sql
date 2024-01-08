IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP7009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP7009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--Create Date: 20/09/2005
---Purpose: In bao cao luong theo thiet lap cua nguoi dung
/********************************************
'* Edited by: [GS] [Hoàng Phước] [29/07/2010]
'********************************************/
--- Edited by Bao Anh	Date: 24/07/2012
--- Purpose: Lay them truong Birthday, PersonalTaxID
--- Edited by Bao Anh	Date: 27/11/2012
--- Purpose: Lay truong WorkDate, LeaveDate
--- Edited by Bao Anh	Date: 19/12/2012	Bo sung truong EducationLevelID, EducationLevelName, MajorID, MajorName
--- Edited by Bao Anh	Date: 11/12/2013	Bo sung truong ShortName, Alias
----- Modified on 18/06/2014 by Le Thi Thu Hien : Bo sung them Thuế TNCN
----- Modified by Thanh Sơn on 21/01/2015: Bổ sug thêm 3 trường tài khoản kết chuyển cho SG Petro
----- Modified by Bảo Anh on 28/01/2016: Bổ sung thêm 3 trường IdentifyDate, IdentifyPlace, ArmyLevel
----- Modifyed by Kim Vu on 23/02/2016: Bổ sung in theo danh sách nhân viên được chọn
----- Modified by Bảo Thy on 16/09/2016: Thay đổi cách lấy danh sách nhân viên bằng XML để không bị tràn chuỗi
----- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
----- Modified on 15/01/2018 by Bảo Anh: Bổ sung in nhiều đơn vị
----- Modified on 13/11/2018 by Kim Thư: Bỏ create HT7110 -> đưa ra fix riêng
----- Modified on 31/12/2018 by Kim Thư: Bổ sung AbsentCardNo từ HT1407 vào HT7110

CREATE PROCEDURE [dbo].[HP7009]
				@DivisionID nvarchar(50),
				@ReportCode nvarchar(50),
				@FromDepartmentID nvarchar(50),
				@ToDepartmentID nvarchar(50),
				@TeamID nvarchar(50),
				@FromEmployeeID nvarchar(50),
				@ToEmployeeID nvarchar(50),
				@FromMonth int,
				@FromYear int,
				@ToMonth int,
				@ToYear int,
				@lstPayrollMethodID as nvarchar(4000),
				@lstEmployeeID AS XML,
				@StrDivisionID AS NVARCHAR(4000) = ''
AS
Declare @sSQL nvarchar(4000), 
	@sSQL1 nvarchar(4000), 
	@cur as cursor,
	@PayrollMethodID nvarchar(50),
	@Count as int,
	@sSQLGroup as nvarchar(4000),
	@Caption as nvarchar(250),
	@AmountType as nvarchar(50), 
	@AmountTypeFrom as nvarchar(50), 
	@AmountTypeTo as nvarchar(50),
	@Signs as nvarchar(50), 
	@OtherAmount as decimal(28,8),
	@AmountTypeFromOut as nvarchar(500),
	@AmountTypeToOut as nvarchar(500),
	@ColumnID as int,
	@IsSerie as tinyint,
	@ColumnAmount as nvarchar(500),
	@FromColumn as int,
	@ToColumn as int, 
	@sGroupBy as nvarchar(4000),
	@sCaption as nvarchar(4000),
	@sColumn as nvarchar(2000),
	@Pos as int,
	@Currency as nvarchar(50),
	@Currency1 as nvarchar(50),
	@RateExchange as decimal(28,8),
	@IsChangeCurrency as tinyint,
	@IsTotal as tinyint,
	@sSQL2 as nvarchar(4000), 	
	@FOrders as int,
	@sSQL_HT2400 nvarchar(4000),
	@sSQL_HT2401 nvarchar(4000),
	@sSQL_HT2402 nvarchar(4000),
	@sSQL_HT3400GA nvarchar(4000),
	@sSQL_HT3400 nvarchar(4000),
	@sSQL_HT0338 NVARCHAR(MAX),
	@sWHERE nvarchar(4000),
	@TableName nvarchar(4000),
	@IsHT2400 tinyint,
	@IsHT2401 tinyint,
	@IsHT2402 tinyint,
	@IsHT3400 tinyint,
	@IsOT tinyint,
	@sSQL_Where nvarchar(4000),
	@StrDivisionID_New AS NVARCHAR(4000),
	@sTable VARCHAR(4000)	

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'DivTable' AND xtype = 'U')
	DROP TABLE DivTable

CREATE TABLE DivTable (DivisionID NVARCHAR(50))

IF ISNULL(@StrDivisionID,'') <> ''
BEGIN
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
	
	SET @sTable = 'INSERT INTO DivTable SELECT ''' + REPLACE(@StrDivisionID,',',''' UNION ALL Select ''') + ''''
END
ELSE
BEGIN
	SELECT @StrDivisionID_New = ' = ''' + @DivisionID + ''''
	SET @sTable = 'INSERT INTO DivTable SELECT ''' + @DivisionID + ''''
END				

EXEC (@sTable)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[TBL_HP7009]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE TBL_HP7009 (EmployeeID VARCHAR(50))
END

INSERT INTO TBL_HP7009
SELECT X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID
FROM @lstEmployeeID.nodes('//Data') AS X (Data)

-----BUOC 1: XAC DINH LOAI TIEN TE MA PHUONG PHAP TINH LUONG SU DUNG			

Set @PayrollMethodID = case when @lstPayrollMethodID = '%' then  ' like ''' + @lstPayrollMethodID + ''''  else ' in (''' + replace(@lstPayrollMethodID, ',',''',''') + ''')' end 
Set @Pos=PATINDEX('%,%', @PayrollMethodID)

If @Pos <>0 Or  @lstPayrollMethodID = '%'-----neu in theo nhieu PP tinh luong 
	Begin
	Set @RateExchange=1
	Set @Currency='VND'
	Set @Currency1='USD'
	End
	
Else
	Begin
		Select TOP 1 @RateExchange= IsNull(RateExchange,1)  From HT0000 Where DivisionID IN (Select DivisionID From DivTable)
		Select TOP 1 @Currency= CurrencyID From HT5000 Where PayrollMethodID=@lstPayrollMethodID And DivisionID IN (Select DivisionID From DivTable)
		If  @Currency='VND' 
			Set @Currency1='USD' 
		else 
			Set @Currency1='VND'
	End

Select @sSQL = ''
Set @sColumn=''
Select @Count = Max(ColumnID) From HT4712 Where ReportCode = @ReportCode And DivisionID IN (Select DivisionID From DivTable)

--------BUOC 2:, TO NHOM CAN IN LUONG 
IF NOT EXISTS (SELECT TOP 1 1 FROM TBL_HP7009)
BEGIN 
	SET @sSQL_Where =''
END
ELSE
BEGIN
	SET @sSQL_Where = ' AND HV3400.EmployeeID  in (SELECT EmployeeID FROM TBL_HP7009) '
END

Set @sSQL1=' Select HV3400.DivisionID, HV3400.DepartmentID,  T01.DepartmentName, IsNull(HV3400.TeamID,'''') as TeamID,
					 IsNull(T11.TeamName,'''') as TeamName,
					'''' as EmployeeID,'''' as FullName, '''' as DutyID,
					 ''''  AS DutyName,  0 as Orders , 1 as Groups, sum(Isnull(SA01,0)) as BaseSalary, HV1400.Birthday, HV1400.PersonalTaxID,
					 HV1400.WorkDate, HV1400.LeaveDate, HV1400.EducationLevelID, HV1400.EducationLevelName, HV1400.MajorID, HT1004.MajorName, HV1400.ShortName, HV1400.Alias,
					 HV1400.ExpenseAccountID, HV1400.PayableAccountID, HV1400.PerInTaxID,
					 HV1400.IdentifyDate, HV1400.IdentifyPlace, HV1400.ArmyLevel, HT1407.AbsentCardNo'
			
Set @sGroupBy=' Group by HV3400.DivisionID, HV3400.DepartmentID,  T01.DepartmentName, IsNull(HV3400.TeamID,''''), IsNull(T11.TeamName,''''), HV1400.Birthday, HV1400.PersonalTaxID,
				HV1400.WorkDate, HV1400.LeaveDate, HV1400.EducationLevelID, HV1400.EducationLevelName, HV1400.MajorID, HT1004.MajorName, HV1400.ShortName, HV1400.Alias,
				HV1400.ExpenseAccountID, HV1400.PayableAccountID, HV1400.PerInTaxID,
				HV1400.IdentifyDate, HV1400.IdentifyPlace, HV1400.ArmyLevel, HT1407.AbsentCardNo'

Set @sSQL2=  ' From HV3400 left join AT1102 T01 on T01.DepartmentID = HV3400.DepartmentID 
			left join HT1101 T11 on T11.DivisionID = HV3400.DivisionID and T11.DepartmentID = HV3400.DepartmentID and IsNull(HV3400.TeamID,'''')=IsNull(T11.TeamID,'''')
			left join HT1102 T12 on IsNull(HV3400.DutyID,'''')=IsNull(T12.DutyID,'''')
			left join HV1400 on HV1400.EmployeeID = HV3400.EmployeeID And HV1400.DivisionID = HV3400.DivisionID
			left join HT1004 on HV1400.DivisionID = HT1004.DivisionID And HV1400.MajorID = HT1004.MajorID			
			left join HT1407 WITH (NOLOCK) ON HV1400.DivisionID = HT1407.DivisionID and HV1400.EmployeeID = HT1407.EmployeeID
			Where HV3400.DivisionID '+@StrDivisionID_New+' and
			HV3400.DepartmentID between N''' + @FromDepartmentID + ''' and N''' + @ToDepartmentID + ''' and
			isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
			HV3400.EmployeeID between N''' + @FromEmployeeID + ''' and N''' + @ToEmployeeID + ''' and
			HV3400.TranMonth + HV3400.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(10)) + ' and ' +  
			cast(@ToMonth + @ToYear*100 as nvarchar(10)) + ' and
			PayrollMethodID ' + @PayrollMethodID +  @sSQL_Where


--If Exists (Select * From sysobjects Where name = 'HT7110' and xtype ='U') 
--           If not exists (select * from syscolumns col inner join sysobjects tab 
--           On col.id = tab.id where tab.name =   'HT7110'  and col.name = 'ColumnAmount50') 
--	DROP TABLE HT7110

--If not Exists (Select top 1 1  From SysObjects Where Name ='HT7110' and Xtype ='U')
--Begin
--CREATE TABLE [dbo].[HT7110](
--	[APK] [uniqueidentifier] NULL,
--	[DivisionID] [nvarchar](3) NOT NULL,
--	[ID] [int] IDENTITY(1,1) NOT NULL,
--	[STT] [int] NULL,
--	[DepartmentID] [nvarchar](50) NULL,
--	[DepartmentName] [nvarchar](250) NULL,
--	[TeamID] [nvarchar](50) NULL,
--	[TeamName] [nvarchar](250) NULL,
--	[EmployeeID] [nvarchar](50) NOT NULL,
--	[FullName] [nvarchar](250) NULL,
--	[IdentifyCardNo] [nvarchar](50) NULL,
--	[BankID] [nvarchar](50) NULL,
--	[BankName] [nvarchar](250) NULL,
--	[BankAccountNo] [nvarchar](50) NULL,
--	[DutyID] [nvarchar](50) NULL,
--	[DutyName] [nvarchar](250) NULL,
--	[Orders] [int] NULL,
--	[Groups] [tinyint] NULL,
--	[BaseSalary] [decimal](28, 8) NULL,
--	[ColumnAmount01] [decimal](28, 8) NULL,
--	[ColumnAmount02] [decimal](28, 8) NULL,
--	[ColumnAmount03] [decimal](28, 8) NULL,
--	[ColumnAmount04] [decimal](28, 8) NULL,
--	[ColumnAmount05] [decimal](28, 8) NULL,
--	[ColumnAmount06] [decimal](28, 8) NULL,
--	[ColumnAmount07] [decimal](28, 8) NULL,
--	[ColumnAmount08] [decimal](28, 8) NULL,
--	[ColumnAmount09] [decimal](28, 8) NULL,
--	[ColumnAmount10] [decimal](28, 8) NULL,
--	[ColumnAmount11] [decimal](28, 8) NULL,
--	[ColumnAmount12] [decimal](28, 8) NULL,
--	[ColumnAmount13] [decimal](28, 8) NULL,
--	[ColumnAmount14] [decimal](28, 8) NULL,
--	[ColumnAmount15] [decimal](28, 8) NULL,
--	[ColumnAmount16] [decimal](28, 8) NULL,
--	[ColumnAmount17] [decimal](28, 8) NULL,
--	[ColumnAmount18] [decimal](28, 8) NULL,
--	[ColumnAmount19] [decimal](28, 8) NULL,
--	[ColumnAmount20] [decimal](28, 8) NULL,
--	[ColumnAmount21] [decimal](28, 8) NULL,
--	[ColumnAmount22] [decimal](28, 8) NULL,
--	[ColumnAmount23] [decimal](28, 8) NULL,
--	[ColumnAmount24] [decimal](28, 8) NULL,
--	[ColumnAmount25] [decimal](28, 8) NULL,
--	[ColumnAmount26] [decimal](28, 8) NULL,
--	[ColumnAmount27] [decimal](28, 8) NULL,
--	[ColumnAmount28] [decimal](28, 8) NULL,
--	[ColumnAmount29] [decimal](28, 8) NULL,
--	[ColumnAmount30] [decimal](28, 8) NULL,
--	[ColumnAmount31] [decimal](28, 8) NULL,
--	[ColumnAmount32] [decimal](28, 8) NULL,
--	[ColumnAmount33] [decimal](28, 8) NULL,
--	[ColumnAmount34] [decimal](28, 8) NULL,
--	[ColumnAmount35] [decimal](28, 8) NULL,
--	[ColumnAmount36] [decimal](28, 8) NULL,
--	[ColumnAmount37] [decimal](28, 8) NULL,
--	[ColumnAmount38] [decimal](28, 8) NULL,
--	[ColumnAmount39] [decimal](28, 8) NULL,
--	[ColumnAmount40] [decimal](28, 8) NULL,
--	[ColumnAmount41] [decimal](28, 8) NULL,
--	[ColumnAmount42] [decimal](28, 8) NULL,
--	[ColumnAmount43] [decimal](28, 8) NULL,
--	[ColumnAmount44] [decimal](28, 8) NULL,
--	[ColumnAmount45] [decimal](28, 8) NULL,
--	[ColumnAmount46] [decimal](28, 8) NULL,
--	[ColumnAmount47] [decimal](28, 8) NULL,
--	[ColumnAmount48] [decimal](28, 8) NULL,
--	[ColumnAmount49] [decimal](28, 8) NULL,
--	[ColumnAmount50] [decimal](28, 8) NULL,
--	[Birthday] DATETIME NULL,	
--    [PersonalTaxID] NVARCHAR(50) NULL,
--    [WorkDate] datetime NULL,
--    [LeaveDate] datetime NULL,
--    [EducationLevelID] nvarchar(50) NULL,
--    [EducationLevelName] nvarchar(250) NULL,
--    [MajorID] NVARCHAR(50) NULL,
--    [MajorName] NVARCHAR(250) NULL,
--    [ShortName] NVARCHAR(50) NULL,
--	[Alias] NVARCHAR(50) NULL,
--	[ExpenseAccountID] VARCHAR(50),
--	[PayableAccountID] VARCHAR(50),
--	[PerInTaxID] VARCHAR(50),
--	[IdentifyDate] datetime NULL,
--	[IdentifyPlace] NVARCHAR(250) NULL,
--	[ArmyLevel] NVARCHAR(100) NULL,
-- CONSTRAINT [PK__HT7110__47ED27BF] PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--) ON [PRIMARY]

--ALTER TABLE [dbo].[HT7110] ADD  DEFAULT (newid()) FOR [APK]

--End
--Else
--  BEGIN
  	Delete  HT7110
	DBCC CHECKIDENT (HT7110,RESEED,0)
--	END

Exec ( 'Insert into HT7110  ( DivisionID,DepartmentID, DepartmentName, TeamID, TeamName, EmployeeID, FullName, DutyID, DutyName,
			Orders, Groups, BaseSalary, Birthday, PersonalTaxID, WorkDate, LeaveDate, EducationLevelID, EducationLevelName, MajorID, MajorName, ShortName, Alias,
			ExpenseAccountID, PayableAccountID, PerInTaxID, IdentifyDate, IdentifyPlace, ArmyLevel, AbsentCardNo)
		' + @sSQL1+@sSQL2+@sGroupBy)


IF not exists (Select Top 1 1 From HT7110 Where DivisionID IN (SELECT DivisionID FROM DivTable)) 
BEGIN
SET @sSQL1 = 'Select Distinct  HV3400.DivisionID, HV3400.DepartmentID, AT1102.DepartmentName, isnulL(HV3400.TeamID, '') , HT1101.TeamName, 1 as Groups, 
		HV1400.Birthday, HV1400.PersonalTaxID, HV1400.WorkDate, HV1400.LeaveDate, HV1400.EducationLevelID, HV1400.EducationLevelName, HV1400.MajorID, HT1004.MajorName, HV1400.ShortName, HV1400.Alias,
		HV1400.IdentifyDate, HV1400.IdentifyPlace, HV1400.ArmyLevel, HT1407.AbsentCardNo
		'
SET @sSQL2=' From HT2400 HV3400	 
		inner join AT1102 on AT1102.DepartmentID = HV3400.DepartmentID 
		inner join HT1101 on HT1101.DivisionID = HV3400.DivisionID and HT1101.DepartmentID = HV3400.DepartmentID  and HV3400.TeamID = HT1101.TeamID
		INNER JOIN HV1400 ON  HV1400.EmployeeID = HV3400.EmployeeID AND HV1400.DivisionID = HV3400.DivisionID
		left join HT1004 on HV1400.DivisionID = HT1004.DivisionID And HV1400.MajorID = HT1004.MajorID
		left join HT1407 WITH (NOLOCK) ON HV1400.DivisionID = HT1407.DivisionID and HV1400.EmployeeID = HT1407.EmployeeID
Where HV3400.DivisionID '+@StrDivisionID_New+' and
		HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
		isnull(HV3400.TeamID,'') like isnull(''' + @TeamID + ''' , '') and
		HV3400.EmployeeID between ''' +@FromEmployeeID+ '''  and ''' + @ToEmployeeID + ''' and
		HV3400.TranMonth + HV3400.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(10)) + 'and ' +   
		cast(@ToMonth + @ToYear*100 as nvarchar(10)) + @sSQL_Where

EXEC('Insert into HT7110  ( DivisionID, DepartmentID, DepartmentName, TeamID, TeamName, Groups, Birthday, PersonalTaxID, WorkDate, LeaveDate, EducationLevelID, EducationLevelName, MajorID, MajorName, ShortName, Alias,
					IdentifyDate, IdentifyPlace, ArmyLevel, AbsentCardNo)' + @sSQL1+@sSQL2)
--Select Distinct  HT2400.DivisionID, HT2400.DepartmentID, AT1102.DepartmentName, isnulL(HT2400.TeamID, '') , HT1101.TeamName, 1 as Groups, 
--		HV1400.Birthday, HV1400.PersonalTaxID, HV1400.WorkDate, HV1400.LeaveDate, HV1400.EducationLevelID, HV1400.EducationLevelName, HV1400.MajorID, HT1004.MajorName, HV1400.ShortName, HV1400.Alias,
--		HV1400.IdentifyDate, HV1400.IdentifyPlace, HV1400.ArmyLevel
--From HT2400 	 inner join AT1102 on  AT1102.DivisionID = HT2400.DivisionID and AT1102.DepartmentID = HT2400.DepartmentID 
--		inner join HT1101 on HT1101.DivisionID = HT2400.DivisionID and HT1101.DepartmentID = HT2400.DepartmentID  and 
--			HT2400.TeamID = HT1101.TeamID
--		INNER JOIN HV1400 ON  HV1400.EmployeeID = HT2400.EmployeeID AND HV1400.DivisionID = HT2400.DivisionID
--		left join HT1004 on HV1400.DivisionID = HT1004.DivisionID And HV1400.MajorID = HT1004.MajorID
--Where HT2400.DivisionID =  @DivisionID and
--		HT2400.DepartmentID between N''' + @FromDepartmentID + ''' and N''' + @ToDepartmentID + ''' and
--		isnull(HT2400.TeamID,'') like isnull(@TeamID , '') and
--		HT2400.EmployeeID between @FromEmployeeID  and  @ToEmployeeID and
--		HT2400.TranMonth + HT2400.TranYear*100 between  cast(@FromMonth + @FromYear*100 as nvarchar(10)) and   
--		cast(@ToMonth + @ToYear*100 as nvarchar(10))

END

------------------BUOC 3: FETCH TUNG COT TRONG HT4712 DE TINH TOAN

Select @sCaption='',		@IsHT2400 = 0, @IsHT2401 = 0, @IsHT2402 = 0,  @IsHT3400 = 0, @IsOT = 0, 
	@sSQL_HT3400 = '',  @sSQL_HT3400GA = ''


SET @cur = Cursor Scroll KeySet FOR 
	Select DISTINCT ColumnID, FOrders, Caption,  isnull(AmountType,'') as AmountType , isnull(AmountTypeFrom, '') as AmountTypeFrom , isnull(AmountTypeTo,'') as AmountTypeTo , 
		Signs, IsNull(IsSerie,0) as IsSerie, 
		isnull( OtherAmount,0), IsNull(IsChangeCurrency,0) as IsChangeCurrency
	FROM HT4712 Where ReportCode =@ReportCode AND DivisionID IN (SELECT DivisionID FROM DivTable) and IsNull(IsTotal,0)=0  Order by ColumnID
OPEN	@cur
FETCH NEXT FROM @cur INTO  @ColumnID,  @FOrders, @Caption, @AmountType, @AmountTypeFrom, @AmountTypeTo,
						@Signs, @IsSerie, @OtherAmount, @IsChangeCurrency

WHILE @@Fetch_Status = 0
Begin
IF @AmountType <> 'OT'  ----so lieu khong phai la Khac
Begin				
	Exec HP4700	@DivisionID, @AmountTypeFrom, @AmountType, @lstPayrollMethodID, @AmountTypeFromOut, @TableName output, @sWHERE output
	Exec HP4700 @DivisionID, @AmountTypeTo, @AmountType, @lstPayrollMethodID, @AmountTypeToOut,  @TableName output, @sWHERE output
	Exec HP4701 @DivisionID, @AmountTypeFromOut, @AmountTypeToOut, @Signs,  @IsSerie, @IsChangeCurrency, @Currency, @Currency1, @RateExchange, @ColumnAmount						
	
IF @TableName = 'HT2400'
		BEGIN
		Set @sSQL_HT2400 ='Update HT7110 Set 
							ColumnAmount' +(Case when @FOrders <10 then '0' else '' End)+ltrim(rtrim(str(@FOrders)))	+ '=  A
					 From HT7110 left  join (Select DivisionID, DepartmentID, isnull(TeamID, '''') as TeamID, 
						sum(' +  @ColumnAmount + ') as A 
						From HT2400  HV3400
						Where HV3400.DivisionID '+@StrDivisionID_New+' and
						HV3400.DepartmentID between N''' + @FromDepartmentID + ''' and N''' + @ToDepartmentID + ''' and
						isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
						HV3400.EmployeeID between N''' + @FromEmployeeID + ''' and N''' + @ToEmployeeID + ''' and
						HV3400.TranMonth + HV3400.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(10)) + ' and ' +  
						cast(@ToMonth + @ToYear*100 as nvarchar(10)) +  @sSQL_Where + ' 
						Group by DivisionID, DepartmentID, isnull(TeamID, ''''))	
						HV3400 on HT7110.DivisionID=HV3400.DivisionID and 
						HT7110.DepartmentID=HV3400.DepartmentID and 
						isnull(HT7110.TeamID, '''') =isnull(HV3400.TeamID,'''')'

		EXEC(@sSQL_HT2400)
		END
	ELSE 
		IF @TableName = 'HT2401'
			BEGIN	
			Set @sSQL_HT2401='Update HT7110 Set ColumnAmount' +(Case when @FOrders <10 then '0' else '' End)+ltrim(rtrim(str(@FOrders)))	
						+ '=' + @ColumnAmount +' 
					 From HT7110 left  join (Select  DivisionID, DepartmentID, isnull(TeamID, '''') as TeamID, 
						sum(isnull(AbsentAmount, 0)) as AbsentAmount
					From HT2401 HV3400
					Where AbsentTypeID between N''' + @AmountTypeFrom + ''' and N''' + @AmountTypeTo  + ''' and 
						HV3400.DivisionID '+@StrDivisionID_New+' and
						HV3400.DepartmentID between N''' + @FromDepartmentID + ''' and N''' + @ToDepartmentID + ''' and
						isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
						HV3400.EmployeeID between N''' + @FromEmployeeID + ''' and N''' + @ToEmployeeID + ''' and
						HV3400.TranMonth + HV3400.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(10)) + ' and ' +  
						cast(@ToMonth + @ToYear*100 as nvarchar(10)) +  @sSQL_Where +'
					Group by HV3400.DivisionID, HV3400.DepartmentID, isnull(HV3400.TeamID, '''')) HV3400 on 
						HT7110.DivisionID=HV3400.DivisionID and 
						HT7110.DepartmentID=HV3400.DepartmentID and 
						isnull(HT7110.TeamID,'''')=isnull(HV3400.TeamID,'''')'

			EXEC(@sSQL_HT2401)
			END
		ELSE
			IF @TableName = 'HT2402'
				BEGIN				
				Set @sSQL_HT2402='Update HT7110 Set ColumnAmount' +(Case when @FOrders <10 then '0' else '' End)+ltrim(rtrim(str(@FOrders)))	
						+ '=' + @ColumnAmount +' 
					From HT7110 left  join (Select DivisionID, DepartmentID, isnull(TeamID, '''') as TeamID, 
						sum(isnull(AbsentAmount, 0)) as AbsentAmount
					From HT2402 HV3400
					Where AbsentTypeID between N''' + @AmountTypeFrom + ''' and N''' + @AmountTypeTo  + ''' and 
						HV3400.DivisionID '+@StrDivisionID_New+' and
						HV3400.DepartmentID between N''' + @FromDepartmentID + ''' and N''' + @ToDepartmentID + ''' and
						isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
						HV3400.EmployeeID between N''' + @FromEmployeeID + ''' and N''' + @ToEmployeeID + ''' and
						HV3400.TranMonth + HV3400.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(10)) + ' and ' +  
						cast(@ToMonth + @ToYear*100 as nvarchar(10)) +  @sSQL_Where +'
					Group by HV3400.DivisionID, HV3400.DepartmentID, isnull(TeamID, '''')) HV3400 on 

						HT7110.DivisionID=HV3400.DivisionID and 
						HT7110.DepartmentID=HV3400.DepartmentID and
						isnull(HT7110.TeamID,'''')=isnull(HV3400.TeamID,'''')'

				EXEC(@sSQL_HT2402)					 
				END
			ELSE
				IF @TableName = 'HT3400' 
					BEGIN
					Set @sSQL_HT3400 ='Update HT7110 Set 
							ColumnAmount' +(Case when @FOrders <10 then '0' else '' End)+ltrim(rtrim(str(@FOrders)))	+ '=  A
					 From HT7110 left  join (Select DivisionID, DepartmentID, isnull(TeamID, '''') as TeamID, 
						sum(' +  @ColumnAmount + ') as A 
						From HT3400  HV3400
						Where HV3400.DivisionID '+@StrDivisionID_New+' and
						HV3400.DepartmentID between N''' + @FromDepartmentID + ''' and N''' + @ToDepartmentID + ''' and
						isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
						HV3400.EmployeeID between N''' + @FromEmployeeID + ''' and N''' + @ToEmployeeID + ''' and
						HV3400.TranMonth + HV3400.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(10)) + ' and ' +  
						cast(@ToMonth + @ToYear*100 as nvarchar(10)) + '  and
						PayrollMethodID ' + @PayrollMethodID  + @sWHERE + @sSQL_Where +'
						Group by DivisionID, DepartmentID, isnull(TeamID, ''''))	HV3400 on HT7110.DivisionID=HV3400.DivisionID and 
						HT7110.DepartmentID=HV3400.DepartmentID and 
						isnull(HT7110.TeamID,'''')=isnull(HV3400.TeamID,'''')'

					EXEC (@sSQL_HT3400)
					END
				  IF @TableName = 'HT0338' --- Thuế TNCN                            
					 BEGIN
                 		SET @sSQL_HT0338 = '
                 		UPDATE HT7110 
                 		SET ColumnAmount' + ( CASE WHEN @FOrders < 10 THEN '0' ELSE '' END ) + ltrim(rtrim(str(@FOrders))) + '=  VAT
	 					FROM HT7110 
	 					LEFT  JOIN (SELECT	DivisionID, EmployeeID,
											SUM(' + @ColumnAmount + ') AS VAT
									FROM	HT0338  HV3400
									WHERE	HV3400.DivisionID '+@StrDivisionID_New+' and
											HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
											HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) + ' 
											' + @sWHERE +  @sSQL_Where +'
									GROUP BY DivisionID, EmployeeID
	 								) HV3400 
	 						ON		HT7110.DivisionID = HV3400.DivisionID AND 
									HT7110.EmployeeID = HV3400.EmployeeID '
															   EXEC ( @sSQL_HT0338 )
					 END
							 
End
	
Else	----- @AmountType = 'OT'  , so lieu la khac thi lay hang so la so lieu cua mot cot
BEGIN
IF @IsOT = 0
	Select  @IsOT = 1,	 @sSQL='Update HT7110 Set '		
	Set @sSQL = @sSQL+ 'ColumnAmount' +(Case when @FOrders <10 then '0' else '' End)+ltrim(rtrim(str(@FOrders)))	
			+'=' +  ' IsNull('+str(@OtherAmount)+ ',0) ' + ','						
END	
				
FETCH NEXT FROM @cur INTO  @ColumnID,  @FOrders, @Caption, @AmountType, @AmountTypeFrom, @AmountTypeTo,
						@Signs, @IsSerie,  @OtherAmount, @IsChangeCurrency
End
Close @cur


IF @IsOT = 1 
BEGIN
Set @sSQL=Left(@sSQL,len(@sSQL)-1)
Set @sSQL=@sSQL+ ' From HT7110 left  join HV3400 on HT7110.DivisionID=HV3400.DivisionID and HT7110.DepartmentID=HV3400.DepartmentID
	and IsNull(HT7110.TeamID,'''')=IsNull(HV3400.TeamID,'''') 
	Where HV3400.DivisionID '+@StrDivisionID_New+' and
			HV3400.DepartmentID between N''' + @FromDepartmentID + ''' and N''' + @ToDepartmentID + ''' and
			isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
			HV3400.EmployeeID between N''' + @FromEmployeeID + ''' and N''' + @ToEmployeeID + ''' and
			HV3400.TranMonth + HV3400.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(10)) + ' and ' +  
			cast(@ToMonth + @ToYear*100 as nvarchar(10)) + ' and
			PayrollMethodID ' + @PayrollMethodID + @sSQL_Where

Exec (@sSQL)
END


---------Neu co tinh tong 
If exists (select top 1 1 From HT4712 Where IsNull(IsTotal,0)=1 and ReportCode = @ReportCode And DivisionID IN (SELECT DivisionID FROM DivTable))
Begin
Set @sSQL='Update HT7110 Set '
SET @cur = Cursor Scroll KeySet FOR 
		Select DISTINCT ColumnID, FOrders, Caption,  Signs, IsNull(IsSerie,0) as IsSerie,   FromColumn, ToColumn 

FROM HT4712 Where DivisionID IN (SELECT DivisionID FROM DivTable) And ReportCode =@ReportCode and IsNull(IsTotal,0)=1  Order by ColumnID
OPEN	@cur
FETCH NEXT FROM @cur INTO  @ColumnID, @FOrders, @Caption, @Signs, @IsSerie, @FromColumn, @ToColumn

WHILE @@Fetch_Status = 0
Begin	
	Exec	HP4702 @Signs , @IsSerie , @FromColumn, @ToColumn ,  @ColumnAmount  OutPut, @ColumnID
	Set @sSQL = @sSQL+ 'ColumnAmount' +(Case when @FOrders <10 then '0' else '' End)+ltrim(rtrim(str(@FOrders)))	
				+ '=' + @ColumnAmount --+ ','
	Exec (@sSQL)
	Set @sSQL='Update HT7110 Set '
	FETCH NEXT FROM @cur INTO  @ColumnID, @FOrders,  @Caption, @Signs, @IsSerie, @FromColumn, @ToColumn					
End
Close @cur	
End
DELETE HT7110 WHERE  
isnull(ColumnAmount01,0)=0 AND  isnull(ColumnAmount02,0)=0 AND isnull(ColumnAmount03,0)=0  AND  isnull(ColumnAmount04,0)=0 AND isnull(ColumnAmount05,0)=0 AND  
isnull(ColumnAmount06,0)=0 AND  isnull(ColumnAmount07,0)=0 AND isnull(ColumnAmount08,0)=0  AND  isnull(ColumnAmount09,0)=0 AND isnull(ColumnAmount10,0)=0 AND  
isnull(ColumnAmount11,0)=0 AND  isnull(ColumnAmount12,0)=0 AND isnull(ColumnAmount13,0)=0  AND  isnull(ColumnAmount14,0)=0 AND isnull(ColumnAmount15,0)=0 AND  
isnull(ColumnAmount16,0)=0 AND  isnull(ColumnAmount17,0)=0 AND isnull(ColumnAmount18,0)=0  AND  isnull(ColumnAmount19,0)=0 AND isnull(ColumnAmount20,0)=0 AND  
isnull(ColumnAmount21,0)=0 AND  isnull(ColumnAmount22,0)=0 AND isnull(ColumnAmount23,0)=0  AND  isnull(ColumnAmount24,0)=0 AND isnull(ColumnAmount25,0)=0 AND  
isnull(ColumnAmount26,0)=0 AND  isnull(ColumnAmount27,0)=0 AND isnull(ColumnAmount28,0)=0  AND  isnull(ColumnAmount29,0)=0 AND isnull(ColumnAmount30,0)=0 AND  
isnull(ColumnAmount31,0)=0 AND  isnull(ColumnAmount32,0)=0 AND isnull(ColumnAmount33,0)=0  AND  isnull(ColumnAmount34,0)=0 AND isnull(ColumnAmount35,0)=0 AND  
isnull(ColumnAmount36,0)=0 AND  isnull(ColumnAmount37,0)=0 AND isnull(ColumnAmount38,0)=0  AND  isnull(ColumnAmount39,0)=0 AND isnull(ColumnAmount40,0) =0 AND
isnull(ColumnAmount41,0)=0 AND  isnull(ColumnAmount42,0)=0 AND isnull(ColumnAmount43,0)=0  AND  isnull(ColumnAmount44,0)=0 AND isnull(ColumnAmount45,0)=0 AND  
isnull(ColumnAmount46,0)=0 AND  isnull(ColumnAmount47,0)=0 AND isnull(ColumnAmount48,0)=0  AND  isnull(ColumnAmount49,0)=0 AND isnull(ColumnAmount50,0) =0

DELETE TBL_HP7009
DROP TABLE DivTable


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
