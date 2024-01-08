IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP7008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP7008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created by: Pham Thi Phuong Loan, Date: 20/09/2005
---Purpose: In bao cao luong theo thiet lap cua nguoi dung
--Code written by : Luong Bao Anh
/********************************************
'* Edited by: [GS] [Minh Lâm] [02/08/2010]
'********************************************/
--- Edited by Bao Anh	Date: 24/07/2012
--- Purpose: Lay truong PersonalTaxID, Birthday
--- Edited by Bao Anh	Date: 27/11/2012
--- Purpose: Lay truong WorkDate, LeaveDate
--- Edited by Bao Anh	Date: 19/12/2012	Bo sung truong EducationLevelID, EducationLevelName, MajorID, MajorName
--- Edited by Bao Anh	Date: 24/02/2013	Bo @sWHERE trong cau @sSQL_HT3400GA (truong hop @TableName = 'HT3400' va @AmountType = 'GA')
--- Edited by Bao Anh	Date: 11/12/2013	Bo sung truong ShortName, Alias
----- Modified on 18/06/2014 by Le Thi Thu Hien : Bo sung them Thuế TNCN
----- Modified on 08/08/2014 by Bảo Anh : Bổ sung cột thực lãnh và thuế TNCN vào HT7110
--- HP7008 'ltv','BLCHITIET','A01','C08','%','A0101','A0101',6,2014,6,2014,'%'
----- Modified by Thanh Sơn on 21/01/2015: Bổ sug thêm 3 trường tài khoản kết chuyển cho SG Petro
----- Modified by Bảo Anh on 28/01/2016: Bổ sung thêm 3 trường IdentifyDate, IdentifyPlace, ArmyLevel
----- Modifyed by Kim Vu on 23/02/2016: Bổ sung in theo danh sách nhân viên được chọn
----- Modified by Kim Vu on 15/04/2016: Group by them TranMonth, TranYear
----- Modified by Quốc Tuấn on 03/06/2016: Bỏ điều kiện join TranMonth and TranYear ở column25
----- Modified by Bảo Thy on 16/09/2016: Thay đổi cách lấy danh sách nhân viên bằng XML để không bị tràn chuỗi
----- Modified by Hải Long on 27/12/2016: Bổ sung 3 cột IsKeepSalary, IsReceiveSalary, Notes_HT3400
----- Modified by Tiểu Mai on 29/12/2016: Bố sung Isnull
----- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
----- Modified on 15/01/2018 by Bảo Anh: Bổ sung in nhiều đơn vị
----- Modified by Bảo Anh on 01/03/2018: Bổ sung thêm 3 trường ShiftID01, ShiftID02, ShiftID03 cho GodRej
----- Modified by Bảo Anh on 11/05/2018: Bổ sung thêm 3 trường ShiftID01_SUN, ShiftID02_SUN, ShiftID03_SUN cho GodRej
----- Modified by Bảo Anh on 04/07/2018: Bổ sung JOIN HT3499 để lấy được các khoản thu nhập từ 31 -> 200
----- Modified by Bảo Anh on 06/07/2018: Thay HT2407 cho HT1025 khi lấy các trường ShiftID01, ShiftID02, ShiftID03, ... cho GODREJ
----- Modified on 12/11/2018 by Kim Thư: Bổ sung trường hợp hệ số lương từ C26->C31 @TableName = 'HT2499', bỏ create HT7110 -> đưa ra fix riêng
----- Modified on 27/11/2018 by Bảo Anh: Sửa lỗi không lên số liệu các khoản bảo hiểm cty đóng
----- Modified on 31/12/2018 by Kim Thư: Bổ sung AbsentCardNo từ HT1407 vào HT7110
----- Modified on 21/03/2019 by Kim Thư: Bổ sung Notes từ HT1101 vào HT7110 (Ghi chú của tổ nhóm). Bổ sung cho cả Godrej
----- Modified on 5/6/2019 by Kim Thư: Tách store cho Godrej
----- Modified on 29/06/2021 by Nhựt Trường: Thay đổi cách lấy trường AbsentCardNo.
----- Modified on 15/07/2022 by Văn Tài	   : Thay đổi cách lưu trữ bảng tạm.
----- Modified on 15/09/2022 by Văn Tài	   : Xử lý lấy InLateCount, OutEarlyCount: đếm số lần đi trễ về sớm.
----- Modified on 10/03/2023 by Nhựt Trường: Bổ sung insert trường PayrollMethodID vào bảng HT7110.
----- Modified on 17/03/2023 by Kiều Nga: [2023/03/IS/0113] Tính tiền chuyên cần bị sai do xin nghỉ phép nhưng phần mềm vẫn tính là đi trễ
----- Modified on 12/07/2023 by Đình Định: Tăng kích thước cho biến @PayrollMethodID.
----- Modified on 13/12/2023 by Xuân Nguyên: [2023/12/IS/0060]- Điều chỉnh bỏ group TranMonth/TranYear để sum dữ liệu 
----- Modified on 18/12/2023 by Xuân Nguyên: [2023/12/IS/0199]- Bổ sung điều kiện TranMonth/TranYear khi lấy dữ liệu từ HT0338
CREATE PROCEDURE [dbo].[HP7008]
       @DivisionID nvarchar(50) ,
       @ReportCode nvarchar(50) ,
       @FromDepartmentID nvarchar(50) ,
       @ToDepartmentID nvarchar(50) ,
       @TeamID nvarchar(50) ,
       @FromEmployeeID nvarchar(50) ,
       @ToEmployeeID nvarchar(50) ,
       @FromMonth int ,
       @FromYear int ,
       @ToMonth int ,
       @ToYear int ,
       @lstPayrollMethodID AS nvarchar(4000),
	   @lstEmployeeID as XML = NULL,
	   @StrDivisionID AS NVARCHAR(4000) = ''
AS
DECLARE
        @sSQL varchar(8000) ,
		@sSQL0 varchar(8000),
        @sSQL1 varchar(8000) ,
        @cur AS cursor ,
        @PayrollMethodID NVARCHAR(MAX) ,
        @Count AS int ,
        @sSQLGroup AS nvarchar(4000) ,
        @Caption AS nvarchar(250) ,
        @AmountType AS nvarchar(50) ,
        @AmountTypeFrom AS nvarchar(50) ,
        @AmountTypeTo AS nvarchar(50) ,
        @Signs AS nvarchar(50) ,
        @OtherAmount AS money ,
        @AmountTypeFromOut AS nvarchar(4000) ,
        @AmountTypeToOut AS nvarchar(4000) ,
        @ColumnID AS int ,
        @IsSerie AS tinyint ,
        @ColumnAmount AS nvarchar(4000) ,
        @FromColumn AS int ,
        @ToColumn AS int ,
        @sGroupBy AS nvarchar(4000) ,
        @sCaption AS nvarchar(4000) ,
        @sColumn AS nvarchar(2000) ,
        @Pos AS int ,
        @Currency AS nvarchar(50) ,
        @Currency1 AS nvarchar(50) ,
        @RateExchange AS money ,
        @IsChangeCurrency AS tinyint ,
        @IsTotal AS tinyint ,
        @sSQL2 AS varchar(8000) ,
		@sSQL3 AS varchar(8000) ,
        @FOrders AS int ,
        @sSQL_HT2400 nvarchar(4000) ,
        @sSQL_HT2460 nvarchar(4000) ,
        @sSQL_HT2401 nvarchar(4000) ,
        @sSQL_HT2402 nvarchar(4000) ,
        @sSQL_HT3400 nvarchar(4000) ,
        @sSQL_HT3400GA nvarchar(4000) ,
        @sSQL_HT0338 NVARCHAR(MAX),
		@sSQL_HT2499 NVARCHAR(MAX),
		@sSQL_HT2461 varchar(MAX),
        @TableName nvarchar(4000) ,
        @IsHT2400 tinyint ,
        @IsHT2401 tinyint ,
        @IsHT2402 tinyint ,
        @IsHT3400 tinyint ,
        @IsOT tinyint ,
        @sWHERE nvarchar(4000),
        @NetIncomeMethod int,
        @sSQL_Total nvarchar(4000),
        @sSQL_Tax nvarchar(4000),
		@sSQL_Where nvarchar(4000),
		@StrDivisionID_New AS NVARCHAR(4000),
		@sTable VARCHAR(4000),
		@CustomerName INT
	
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF 	@CustomerName = 74--GODREJ
	EXEC HP7008_GOD @DivisionID,@ReportCode,@FromDepartmentID,@ToDepartmentID,@TeamID,@FromEmployeeID,@ToEmployeeID,@FromMonth,@FromYear,@ToMonth,@ToYear,@lstPayrollMethodID,@lstEmployeeID,@StrDivisionID
ELSE
BEGIN
	SET @StrDivisionID_New = ''
	SET @sTable = ''

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

	CREATE TABLE #HP7008Emp (EmployeeID VARCHAR(50))
	INSERT INTO #HP7008Emp
	SELECT X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID
	FROM @lstEmployeeID.nodes('//Data') AS X (Data)

	-----BUOC 1: XAC DINH LOAI TIEN TE MA PHUONG PHAP TINH LUONG SU DUNG			

	SET @PayrollMethodID = CASE
								WHEN @lstPayrollMethodID = '%' THEN ' like ''' + @lstPayrollMethodID + ''''
								ELSE ' in (''' + replace(@lstPayrollMethodID , ',' , ''',''') + ''')'
						   END
	SET @Pos = PATINDEX('%,%' , @PayrollMethodID)

	IF @Pos <> 0 OR @lstPayrollMethodID = '%'
	   BEGIN-----neu in theo nhieu PP tinh luong 
			 SELECT
				 @RateExchange = 1 ,
				 @Currency = 'VND' ,
				 @Currency1 = 'USD'
	   END
	ELSE
	   BEGIN
			 SELECT TOP 1
				 @RateExchange = IsNull(RateExchange , 1)
			 FROM
				 HT0000
			 WHERE
				 DivisionID IN (Select DivisionID From DivTable)
			 SELECT TOP 1
				 @Currency = CurrencyID
			 FROM
				 HT5000
			 WHERE
				 PayrollMethodID = @lstPayrollMethodID And DivisionID IN (Select DivisionID From DivTable)
			 IF @Currency = 'VND'
				BEGIN
					  SET @Currency1 = 'USD'
				END
			 ELSE
				BEGIN
					  SET @Currency1 = 'VND'
				END

	   END

	SET @sSQL = ''
	SET @sSQL0 = ''
	SET @sColumn = ''
	SET @sSQL1 = ''
	SET @sSQL2 = ''

	SELECT @Count = Max(ColumnID)
	FROM HT4712
	WHERE ReportCode = @ReportCode And DivisionID IN (Select DivisionID From DivTable)

	----------BUOC 2: XAC DINH CO NHOM THEO PHONG BAN, TO NHOM HAY KHONG
	IF NOT EXISTS (SELECT TOP 1 1 FROM #HP7008Emp)
	BEGIN 
		SET @sSQL_Where =''
	END
	ELSE
	BEGIN
		SET @sSQL_Where = ' AND HV3400.EmployeeID  in (SELECT EmployeeID FROM #HP7008Emp) '
	END

	SET @sSQL1 = ' Select HV3400.DivisionID, HV3400.DepartmentID,  T01.DepartmentName, IsNull(HV3400.TeamID,'''') as TeamID, 
					 IsNull(T11.TeamName,'''') as TeamName,
					HV3400.EmployeeID, HV3400.FullName, HV1400.IdentifyCardNo, HV1400.BankID, HT1008.BankName, HV1400.BankAccountNo,	
					IsNull(HV3400.DutyID,'''') as DutyID,
					 IsNull(DutyName,'''')   AS DutyName, HV3400.Orders, 0 as Groups, sum(Isnull(SA01,0)) as BaseSalary,
					 HV1400.Birthday, HV1400.PersonalTaxID, HV1400.WorkDate, HV1400.LeaveDate,
					 HV1400.EducationLevelID, HV1400.EducationLevelName, HV1400.MajorID, HT1004.MajorName, HV1400.ShortName, HV1400.Alias,
					 HV1400.ExpenseAccountID, HV1400.PayableAccountID, HV1400.PerInTaxID, HV3400.TranMonth, HV3400.TranYear,
					 HV1400.IdentifyDate, HV1400.IdentifyPlace, HV1400.ArmyLevel, HV3400.IsKeepSalary, HV3400.IsReceiveSalary, HV3400.Notes,
					 (SELECT TOP 1 AbsentCardNo FROM HT1407 WHERE   HT1407.DivisionID = HV3400.DivisionID and HT1407.EmployeeID = HV3400.DivisionID )  AS AbsentCardNo,
					 (SELECT COUNT(*) FROM (SELECT DISTINCT HT07.AbsentDate FROM HT2407 HT07 WITH (NOLOCK) 
											LEFT JOIN HT1020 TT WITH (NOLOCK) ON  TT.DivisionID = HT07.DivisionID AND TT.ShiftID = HT07.ShiftID
											LEFT JOIN OOT2010 OT20 WITH (NOLOCK) ON HT07.DivisionID = OT20.DivisionID 
																				AND OT20.Status = 1 
																				AND OT20.EmployeeID = HT07.EmployeeID
																				AND CONVERT(DATE, HT07.AbsentDate)  -- Dữ liệu ngày trong thời gian xin phép
																					between CONVERT(DATE, OT20.LeaveFromDate) and CONVERT(DATE, OT20.LeaveToDate)
																				 AND -- Dữ liệu ngày chấm công <so sánh> Thời gian xin phép
																				 (
																					CONVERT(DATETIME, HT07.AbsentDate +'' ''+ TT.BeginTime )
																						between OT20.LeaveFromDate and OT20.LeaveToDate
																					)
											WHERE HT07.DivisionID = HV3400.DivisionID 
													AND HT07.EmployeeID = HV3400.EmployeeID 
													AND HT07.TranMonth = HV3400.TranMonth 
													AND HT07.TranYear = HV3400.TranYear
													AND ISNULL(HT07.InLateMinutes, 0) > 0
													AND OT20.EmployeeID IS NULL 
											) HT07) AS InLateCount,
					 (SELECT COUNT(*) FROM (SELECT DISTINCT HT08.AbsentDate FROM HT2407 HT08 WITH (NOLOCK) 
											WHERE HT08.DivisionID = HV3400.DivisionID 
													AND HT08.EmployeeID = HV3400.EmployeeID 
													AND HT08.TranMonth = HV3400.TranMonth 
													AND HT08.TranYear = HV3400.TranYear  
													AND ISNULL(HT08.OutEarlyMinutes, 0) > 0
											) HT08) AS OutEarlyCount 
					'

	SET @sSQL1 = @sSQL1+', NULL as ShiftID01, NULL as ShiftID02, NULL as ShiftID03, NULL as ShiftID01_SUN, NULL as ShiftID02_SUN, NULL as ShiftID03_SUN, T11.Notes as TeamNotes, PayrollMethodID'
	

	SET @sGroupBy = ' Group by HV3400.DivisionID, HV3400.DepartmentID,  T01.DepartmentName,  IsNull(T11.TeamName,''''), HV3400.EmployeeID, HV3400.Fullname,
				HV1400.IdentifyCardNo, HV1400.BankID, HT1008.BankName, HV1400.BankAccountNo,	
				 IsNull(HV3400.TeamID,''''), IsNull(HV3400.DutyID,'''') , IsNull(DutyName,''''), HV3400.Orders, HV1400.Birthday, HV1400.PersonalTaxID,
				 HV1400.WorkDate, HV1400.LeaveDate, HV1400.EducationLevelID, HV1400.EducationLevelName, HV1400.MajorID, HT1004.MajorName, HV1400.ShortName, HV1400.Alias,
				  HV1400.ExpenseAccountID, HV1400.PayableAccountID, HV1400.PerInTaxID, HV3400.TranMonth, HV3400.TranYear,
				  HV1400.IdentifyDate, HV1400.IdentifyPlace, HV1400.ArmyLevel, HV3400.IsKeepSalary, HV3400.IsReceiveSalary, HV3400.Notes, T11.Notes, PayrollMethodID'


	SET @sSQL2 = ' From HV3400 HV3400 
		left join AT1102 T01 on T01.DepartmentID = HV3400.DepartmentID 
		left join HT1101 T11 on T11.DivisionID = HV3400.DivisionID and T11.DepartmentID = HV3400.DepartmentID and IsNull(HV3400.TeamID,'''')=IsNull(T11.TeamID,'''')
		left join HV1400 on HV1400.EmployeeID = HV3400.EmployeeID And HV1400.DivisionID = HV3400.DivisionID
		left join HT1008 on HV1400.BankID = HT1008.BankID AND HV1400.DivisionID = HT1008.DivisionID
		left join HT1004 on HV1400.DivisionID = HT1004.DivisionID And HV1400.MajorID = HT1004.MajorID
		--left join HT1407 WITH (NOLOCK) ON HV1400.DivisionID = HT1407.DivisionID and HV1400.EmployeeID = HT1407.EmployeeID
		Where HV3400.DivisionID '+@StrDivisionID_New+' and
		HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
		isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
		HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
		HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) + ' and
		HV3400.PayrollMethodID ' + @PayrollMethodID  +	@sSQL_Where

	--IF EXISTS ( SELECT *  FROM sysobjects WHERE  name = 'HT7110' AND xtype = 'U' )
	--   BEGIN
	--         IF NOT EXISTS ( SELECT  * FROM  syscolumns col INNER JOIN sysobjects tab  ON  col.id = tab.id
	--                         WHERE tab.name = 'HT7110' AND col.name = 'ColumnAmount50' )
	--            BEGIN
	--                  DROP TABLE HT7110
	--            END
	--   END

	--IF NOT EXISTS ( SELECT TOP 1 1 FROM SysObjects WHERE Name = 'HT7110' AND Xtype = 'U' )
	--   BEGIN
	--         CREATE TABLE [dbo].[HT7110]
	--         (
	--           [ID] [int] IDENTITY(1,1)
	--                      PRIMARY KEY ,
	--           [STT] [int] NULL ,
	--           [DivisionID] [nvarchar](50) NULL ,
	--           [DepartmentID] [nvarchar](50) NULL ,
	--           [DepartmentName] [nvarchar](250) NULL ,
	--           [TeamID] [nvarchar](50) NULL ,
	--           [TeamName] [nvarchar](250) NULL ,
	--           [EmployeeID] [nvarchar](50) NOT NULL ,
	--           [FullName] [nvarchar](250) NULL ,
	--           [IdentifyCardNo] [nvarchar](50) NULL ,
	--           [BankID] [nvarchar](50) NULL ,
	--           [BankName] [nvarchar](250) NULL ,
	--           [BankAccountNo] [nvarchar](50) NULL ,
	--           [DutyID] [nvarchar](50) NULL ,
	--           [DutyName] [nvarchar](250) NULL ,
	--           [Orders] [int] NULL ,
	--           [Groups] [tinyint] NULL ,
	--           [BaseSalary] decimal(28,8) NULL ,
	--           [ColumnAmount01] decimal(28,8) NULL ,
	--           [ColumnAmount02] decimal(28,8) NULL ,
	--           [ColumnAmount03] decimal(28,8) NULL ,
	--           [ColumnAmount04] decimal(28,8) NULL ,
	--           [ColumnAmount05] decimal(28,8) NULL ,
	--           [ColumnAmount06] decimal(28,8) NULL ,
	--           [ColumnAmount07] decimal(28,8) NULL ,
	--           [ColumnAmount08] decimal(28,8) NULL ,
	--           [ColumnAmount09] decimal(28,8) NULL ,
	--           [ColumnAmount10] decimal(28,8) NULL ,
	--           [ColumnAmount11] decimal(28,8) NULL ,
	--           [ColumnAmount12] decimal(28,8) NULL ,
	--           [ColumnAmount13] decimal(28,8) NULL ,
	--           [ColumnAmount14] decimal(28,8) NULL ,
	--           [ColumnAmount15] decimal(28,8) NULL ,
	--           [ColumnAmount16] decimal(28,8) NULL ,
	--           [ColumnAmount17] decimal(28,8) NULL ,
	--           [ColumnAmount18] decimal(28,8) NULL ,
	--           [ColumnAmount19] decimal(28,8) NULL ,
	--           [ColumnAmount20] decimal(28,8) NULL ,
	--           [ColumnAmount21] decimal(28,8) NULL ,
	--           [ColumnAmount22] decimal(28,8) NULL ,
	--           [ColumnAmount23] decimal(28,8) NULL ,
	--           [ColumnAmount24] decimal(28,8) NULL ,
	--           [ColumnAmount25] decimal(28,8) NULL ,
	--           [ColumnAmount26] decimal(28,8) NULL ,
	--           [ColumnAmount27] decimal(28,8) NULL ,
	--           [ColumnAmount28] decimal(28,8) NULL ,
	--           [ColumnAmount29] decimal(28,8) NULL ,
	--           [ColumnAmount30] decimal(28,8) NULL ,
	--           [ColumnAmount31] decimal(28,8) NULL ,
	--           [ColumnAmount32] decimal(28,8) NULL ,
	--           [ColumnAmount33] decimal(28,8) NULL ,
	--           [ColumnAmount34] decimal(28,8) NULL ,
	--           [ColumnAmount35] decimal(28,8) NULL ,
	--           [ColumnAmount36] decimal(28,8) NULL ,
	--           [ColumnAmount37] decimal(28,8) NULL ,
	--           [ColumnAmount38] decimal(28,8) NULL ,
	--           [ColumnAmount39] decimal(28,8) NULL ,
	--           [ColumnAmount40] decimal(28,8) NULL ,
	--           [ColumnAmount41] decimal(28,8) NULL ,
	--           [ColumnAmount42] decimal(28,8) NULL ,
	--           [ColumnAmount43] decimal(28,8) NULL ,
	--           [ColumnAmount44] decimal(28,8) NULL ,
	--           [ColumnAmount45] decimal(28,8) NULL ,
	--           [ColumnAmount46] decimal(28,8) NULL ,
	--           [ColumnAmount47] decimal(28,8) NULL ,
	--           [ColumnAmount48] decimal(28,8) NULL ,
	--           [ColumnAmount49] decimal(28,8) NULL ,
	--           [ColumnAmount50] decimal(28,8) NULL ,
	--           [Birthday] DATETIME NULL,	
	--           [PersonalTaxID] NVARCHAR(50) NULL,
	--           [WorkDate] datetime NULL,
	--           [LeaveDate] datetime NULL,
	--           [EducationLevelID] nvarchar(50) NULL,
	--		   [EducationLevelName] nvarchar(250) NULL,
	--		   [MajorID] NVARCHAR(50) NULL,
	--		   [MajorName] NVARCHAR(250) NULL,
	--		   [ShortName] NVARCHAR(50) NULL,
	--		   [Alias] NVARCHAR(50) NULL,
	--		   [Total] decimal(28,8),
	--		   [TaxAmount] decimal(28,8),
	--		   [ExpenseAccountID] VARCHAR(50),
	--		   [PayableAccountID] VARCHAR(50),
	--		   [PerInTaxID] VARCHAR(50),
	--		   [TranMonth] INT,
	--		   [TranYear] INT,
	--		   [IdentifyDate] datetime NULL,
	--		   [IdentifyPlace] NVARCHAR(250) NULL,
	--		   [ArmyLevel] NVARCHAR(100) NULL,
	--		   IsKeepSalary TINYINT,
	--		   IsReceiveSalary TINYINT,
	--		   Notes_HT3400 NVARCHAR(250) NULL,
	--		   ShiftID01 NVARCHAR(250) NULL,
	--		   ShiftID02 NVARCHAR(250) NULL,
	--		   ShiftID03 NVARCHAR(250) NULL,
	--		   ShiftID01_SUN NVARCHAR(250) NULL,
	--		   ShiftID02_SUN NVARCHAR(250) NULL,
	--		   ShiftID03_SUN NVARCHAR(250) NULL
	--         )
	--         ON     [PRIMARY]
	--   END
	--ELSE
	--   BEGIN
			 DELETE  HT7110
			 DBCC CHECKIDENT ( HT7110,RESEED,0 )
	-- END

	
	EXEC (@sSQL0+ '
					Insert into HT7110  ( DivisionID,DepartmentID, DepartmentName, TeamID, TeamName, EmployeeID, FullName, IdentifyCardNo, BankID, BankName, BankAccountNo, 
					DutyID, DutyName, Orders, Groups, BaseSalary, Birthday, PersonalTaxID, WorkDate, LeaveDate, EducationLevelID, EducationLevelName, MajorID, MajorName,
					ShortName, Alias, ExpenseAccountID, PayableAccountID, PerInTaxID, TranMonth, TranYear, IdentifyDate, IdentifyPlace, ArmyLevel, IsKeepSalary, IsReceiveSalary, Notes_HT3400,
					AbsentCardNo,
					InLateCount,
					OutEarlyCount,
					ShiftID01, ShiftID02, ShiftID03, ShiftID01_SUN, ShiftID02_SUN, ShiftID03_SUN, TeamNotes, PayrollMethodID)
					'+@sSQL1+@sSQL2+@sGroupBy)
	--select @sSQL0+@sSQL1+@sSQL2+@sGroupBy
	IF NOT EXISTS ( SELECT TOP 1
						1
					FROM
						HT7110 Where DivisionID IN (SELECT DivisionID FROM DivTable))
	   BEGIN
	   SET @sSQL1 = 'SELECT
					 HV3400.DivisionID ,
					 HV3400.DepartmentID ,
					 AT1102.DepartmentName ,
					 HV3400.TeamID ,
					 HT1101.TeamName ,
					 HV3400.EmployeeID ,
					 HV1400.FullName ,
					 HV1400.IdentifyCardNo ,
					 HV1400.BankID ,
					 HT1008.BankName ,
					 HV1400.BankAccountNo ,
					 HV1400.DutyID ,
					 HV1400.DutyName ,
					 HV1400.Orders ,
					 0 AS Groups ,
					 HV3400.BaseSalary,
					 HV1400.Birthday,
					 HV1400.PersonalTaxID,
					 HV1400.WorkDate,
					 HV1400.LeaveDate,
					 HV1400.EducationLevelID,
					 HV1400.EducationLevelName,
					 HV1400.MajorID,
					 HT1004.MajorName,
					 HV1400.ShortName,
					 HV1400.Alias, HV1400.IdentifyDate, HV1400.IdentifyPlace, HV1400.ArmyLevel,
					 HV3400.TranMonth, HV3400.TranYear,
					 (SELECT TOP 1 AbsentCardNo FROM HT1407 WHERE   HT1407.DivisionID = HV3400.DivisionID and HT1407.EmployeeID = HV3400.DivisionID )  AS AbsentCardNo,
					 (SELECT COUNT(*) FROM (SELECT DISTINCT HT07.AbsentDate FROM HT2407 HT07 WITH (NOLOCK) 
											LEFT JOIN HT1020 TT WITH (NOLOCK) ON  TT.DivisionID = HT07.DivisionID AND TT.ShiftID = HT07.ShiftID
											LEFT JOIN OOT2010 OT20 WITH (NOLOCK) ON HT07.DivisionID = OT20.DivisionID 
																				AND OT20.Status = 1 
																				AND OT20.EmployeeID = HT07.EmployeeID
																				AND CONVERT(DATE, HT07.AbsentDate)  -- Dữ liệu ngày trong thời gian xin phép
																					between CONVERT(DATE, OT20.LeaveFromDate) and CONVERT(DATE, OT20.LeaveToDate)
																				 AND -- Dữ liệu ngày chấm công <so sánh> Thời gian xin phép
																				 (
																					CONVERT(DATETIME, HT07.AbsentDate +'' ''+ TT.BeginTime )
																						between OT20.LeaveFromDate and OT20.LeaveToDate
																					)
											WHERE HT07.DivisionID = HV3400.DivisionID 
													AND HT07.EmployeeID = HV3400.EmployeeID 
													AND HT07.TranMonth = HV3400.TranMonth 
													AND HT07.TranYear = HV3400.TranYear
													AND ISNULL(HT07.InLateMinutes, 0) > 0
													AND OT20.EmployeeID IS NULL 
											) HT07) AS InLateCount,
					 (SELECT COUNT(*) FROM (SELECT DISTINCT HT08.AbsentDate FROM HT2407 HT08 WITH (NOLOCK) 
											WHERE HT08.DivisionID = HV3400.DivisionID 
													AND HT08.EmployeeID = HV3400.EmployeeID 
													AND HT08.TranMonth = HV3400.TranMonth 
													AND HT08.TranYear = HV3400.TranYear  
													AND ISNULL(HT08.OutEarlyMinutes, 0) > 0
											) HT08) AS OutEarlyCount
	   '
	   
		SET @sSQL1 = @sSQL1+', NULL as ShiftID01, NULL as ShiftID02, NULL as ShiftID03, NULL as ShiftID01_SUN, NULL as ShiftID02_SUN, NULL as ShiftID03_SUN, HT1101.Notes as TeamNotes, PayrollMethodID'
	
	   SET @sSQL2 =' FROM
					 HT2400 HV3400 
					 INNER JOIN HV1400 ON  HV1400.EmployeeID = HV3400.EmployeeID AND HV1400.DivisionID = HV3400.DivisionID 
					 INNER JOIN AT1102 ON  AT1102.DepartmentID = HV3400.DepartmentID 
					 INNER JOIN HT1101 ON  HT1101.DivisionID = HV3400.DivisionID AND HT1101.DepartmentID = HV3400.DepartmentID AND HV3400.TeamID = HT1101.TeamID 
					 LEFT JOIN HT1008 ON  HV1400.BankID = HT1008.BankID AND HV1400.DivisionID = HT1008.DivisionID 
					 left join HT1004 ON HV1400.DivisionID = HT1004.DivisionID And HV1400.MajorID = HT1004.MajorID
					 --left join HT1407 WITH (NOLOCK) ON HV1400.DivisionID = HT1407.DivisionID and HV1400.EmployeeID = HT1407.EmployeeID
				 WHERE
					 HV3400.DivisionID '+@StrDivisionID_New+' AND HV3400.DepartmentID BETWEEN ''' +@FromDepartmentID + ''' AND ''' + @ToDepartmentID + '''
					 AND isnull(HV3400.TeamID , '''') LIKE isnull('''+@TeamID+''' , '''') 
					 AND HV3400.EmployeeID BETWEEN  ''' + @FromEmployeeID + ''' AND ''' + @ToEmployeeID + '''
					 AND HV3400.TranMonth + HV3400.TranYear * 100 BETWEEN ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) +'
					 AND ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) + @sSQL_Where

			Exec(@sSQL0+'
				INSERT INTO HT7110
				 (
				   DivisionID ,
				   DepartmentID ,
				   DepartmentName ,
				   TeamID ,
				   TeamName ,
				   EmployeeID ,
				   FullName ,
				   IdentifyCardNo ,
				   BankID ,
				   BankName ,
				   BankAccountNo ,
				   DutyID ,
				   DutyName ,
				   Orders ,
				   Groups ,
				   BaseSalary,
				   Birthday,
				   PersonalTaxID,
				   WorkDate,
				   LeaveDate,
				   EducationLevelID,
				   EducationLevelName,
				   MajorID,
				   MajorName,
				   ShortName,
				   Alias,
				   IdentifyDate, IdentifyPlace, ArmyLevel, TranMonth, TranYear, 
				   AbsentCardNo, 
				   InLateCount,
				   OutEarlyCount,
				   ShiftID01, ShiftID02, ShiftID03, ShiftID01_SUN, ShiftID02_SUN, ShiftID03_SUN,TeamNotes, PayrollMethodID) ' + @sSQL1 + @sSQL2)

	--select @sSQL0 + @sSQL1 + @sSQL2
				 --SELECT
				 --    HT2400.DivisionID ,
				 --    HT2400.DepartmentID ,
				 --    AT1102.DepartmentName ,
				 --    HT2400.TeamID ,
				 --    HT1101.TeamName ,
				 --    HT2400.EmployeeID ,
				 --    HV1400.FullName ,
				 --    HV1400.IdentifyCardNo ,
				 --    HV1400.BankID ,
				 --    HT1008.BankName ,
				 --    HV1400.BankAccountNo ,
				 --    HV1400.DutyID ,
				 --    HV1400.DutyName ,
				 --    HV1400.Orders ,
				 --    0 AS Groups ,
				 --    HT2400.BaseSalary,
				 --    HV1400.Birthday,
				 --    HV1400.PersonalTaxID,
				 --    HV1400.WorkDate,
				 --    HV1400.LeaveDate,
				 --    HV1400.EducationLevelID,
				 --    HV1400.EducationLevelName,
				 --    HV1400.MajorID,
				 --    HT1004.MajorName,
				 --    HV1400.ShortName,
				 --    HV1400.Alias, HV1400.IdentifyDate, HV1400.IdentifyPlace, HV1400.ArmyLevel
				 --FROM
				 --    HT2400 INNER JOIN HV1400
				 --ON  HV1400.EmployeeID = HT2400.EmployeeID AND HV1400.DivisionID = HT2400.DivisionID INNER JOIN AT1102
				 --ON  AT1102.DivisionID = HT2400.DivisionID AND AT1102.DepartmentID = HT2400.DepartmentID INNER JOIN HT1101
				 --ON  HT1101.DivisionID = HT2400.DivisionID AND HT1101.DepartmentID = HT2400.DepartmentID AND HT2400.TeamID = HT1101.TeamID LEFT JOIN HT1008
				 --ON  HV1400.BankID = HT1008.BankID AND HV1400.DivisionID = HT1008.DivisionID left join HT1004
				 --ON HV1400.DivisionID = HT1004.DivisionID And HV1400.MajorID = HT1004.MajorID
				 --WHERE
				 --    HT2400.DivisionID = @DivisionID AND HT2400.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID AND isnull(HT2400.TeamID , '') LIKE isnull(@TeamID , '') AND HT2400.EmployeeID BETWEEN @FromEmployeeID AND @ToEmployeeID AND HT2400.TranMonth + HT2400.TranYear * 100 BETWEEN CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) AND CAST(@ToMonth + @ToYear * 100 AS nvarchar(10))
	   END 
	
	----------------------BUOC 3: FETCH TUNG COT TRONG HT4712 DE TINH TOAN

	SELECT
		@sCaption = '' ,
		@IsHT2400 = 0 ,
		@IsHT2401 = 0 ,
		@IsHT2402 = 0 ,
		@IsHT3400 = 0 ,
		@IsOT = 0 ,
		@sSQL_HT3400 = '' ,
		@sSQL_HT3400GA = ''

	SET @cur = CURSOR SCROLL KEYSET FOR SELECT DISTINCT
											ColumnID ,
											FOrders ,
											Caption ,
											isnull(AmountType , '') AS AmountType ,
											isnull(AmountTypeFrom , '') AS AmountTypeFrom ,
											isnull(AmountTypeTo , '') AS AmountTypeTo ,
											Signs ,
											IsNull(IsSerie , 0) AS IsSerie ,
											isnull(OtherAmount , 0) ,
											IsNull(IsChangeCurrency , 0) AS IsChangeCurrency,
											Isnull(NetIncomeMethod, 0) as NetIncomeMethod
										FROM
											HT4712
										WHERE
											ReportCode = @ReportCode AND DivisionID IN (SELECT DivisionID FROM DivTable) AND IsNull(IsTotal , 0) = 0
	ORDER BY
											ColumnID


	OPEN @cur
	FETCH NEXT FROM @cur INTO @ColumnID,@FOrders,@Caption,@AmountType,@AmountTypeFrom,@AmountTypeTo,@Signs,@IsSerie,@OtherAmount,@IsChangeCurrency, @NetIncomeMethod
	WHILE @@Fetch_Status = 0
		  BEGIN
				IF @AmountType <> 'OT'  ----so lieu khong phai la Khac							

				BEGIN               
						EXEC HP4700 @DivisionID ,@AmountTypeFrom , @AmountType , @lstPayrollMethodID , @AmountTypeFromOut  OUTPUT, @TableName OUTPUT , @sWHERE OUTPUT
						EXEC HP4700 @DivisionID ,@AmountTypeTo , @AmountType , @lstPayrollMethodID , @AmountTypeToOut OUTPUT , @TableName OUTPUT , @sWHERE OUTPUT                 
						EXEC HP4701 @DivisionID ,@AmountTypeFromOut , @AmountTypeToOut , @Signs , @IsSerie , @IsChangeCurrency , @Currency , @Currency1 , @RateExchange , @ColumnAmount OUTPUT

						--select @TableName, @AmountTypeFromOut, @AmountTypeToOut, @sWHERE, @ColumnAmount, @FOrders, @sSQL_Where

					IF @TableName = 'HT2400'
					BEGIN
							SET @sSQL_HT2400 = '
							Update HT7110 
							Set ColumnAmount' + ( CASE WHEN @FOrders < 10 THEN '0' ELSE ''END ) + ltrim(rtrim(str(@FOrders))) + '=  A
							From HT7110 
							left  join (Select DivisionID, DepartmentID, isnull(TeamID, '''') as TeamID,  EmployeeID,TranMonth, TranYear,
										sum(' + @ColumnAmount + ') as A 
										From HT2400  HV3400
										Where HV3400.DivisionID '+@StrDivisionID_New+' and
										HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
										isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
										HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and 
										HV3400.TranMonth + HV3400.TranYear*100 between '
											+ CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) 
											+ @sSQL_Where + '
										Group by DivisionID, DepartmentID, isnull(TeamID, ''''), EmployeeID, TranMonth, TranYear
										)	HV3400 on HT7110.DivisionID=HV3400.DivisionID and 
							HT7110.DepartmentID=HV3400.DepartmentID and 
							isnull(HT7110.TeamID,'''')=isnull(HV3400.TeamID,'''') and 
							HT7110.EmployeeID = HV3400.EmployeeID
							AND HT7110.TranMonth = HV3400.TranMonth
							AND HT7110.TranYear = HV3400.TranYear
							'				
							EXEC ( @sSQL_HT2400 )
							--Print(@sSQL_HT2400)
					END
					ELSE
					BEGIN
						IF @TableName = 'HT2460'
						BEGIN
							SET @sSQL_HT2460 = '
							Update HT7110 Set ColumnAmount' + ( CASE WHEN @FOrders < 10 THEN '0' ELSE '' END ) + ltrim(rtrim(str(@FOrders))) + '=  A
							From HT7110 left  join (Select DivisionID, DepartmentID, isnull(TeamID, '''') as TeamID,  EmployeeID,TranMonth, TranYear,
													sum(' + @ColumnAmount + ') as A 
													From HT2460  HV3400
													Where HV3400.DivisionID '+@StrDivisionID_New+' and
													HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
													isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
													HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
													HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + 
													CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) 
													+ @sSQL_Where + '
													Group by DivisionID, DepartmentID, isnull(TeamID, ''''), EmployeeID, TranMonth, TranYear
													)	HV3400 on HT7110.DivisionID=HV3400.DivisionID and 
							HT7110.DepartmentID=HV3400.DepartmentID and 
							isnull(HT7110.TeamID,'''')=isnull(HV3400.TeamID,'''') and 
							HT7110.EmployeeID = HV3400.EmployeeID
							AND HT7110.TranMonth = HV3400.TranMonth
							AND HT7110.TranYear = HV3400.TranYear'
				
							EXEC ( @sSQL_HT2460 )
							--PRINT(@sSQL_HT2460)                
						END
						ELSE
						BEGIN
							IF @TableName = 'HT2401'
							BEGIN
								SET @sSQL_HT2401 = 
								'Update HT7110 Set ColumnAmount' + ( CASE WHEN @FOrders < 10 THEN '0' ELSE '' END ) + ltrim(rtrim(str(@FOrders))) + '=' + @ColumnAmount + ' 
								From HT7110 left  join (Select EmployeeID, DivisionID, DepartmentID, isnull(TeamID,'''') as TeamID,TranMonth, TranYear,
														sum(isnull(AbsentAmount, 0)) as AbsentAmount
														From HT2401 HV3400
														Where AbsentTypeID between ''' + @AmountTypeFrom + ''' and ''' + @AmountTypeTo + ''' and 
														HV3400.DivisionID '+@StrDivisionID_New+' and
														HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
														isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
														HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
														HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + 
														CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) 
														+  @sSQL_Where + '
														Group by HV3400.DivisionID, HV3400.DepartmentID, isnull(HV3400.TeamID, ''''), HV3400.EmployeeID, HV3400.TranMonth, HV3400.TranYear
														) HV3400 on HT7110.DivisionID=HV3400.DivisionID and 
								HT7110.DepartmentID=HV3400.DepartmentID
								and IsNull(HT7110.TeamID,'''')=IsNull(HV3400.TeamID,'''') and 
								IsNull(HT7110.EmployeeID,'''')=IsNull(HV3400.EmployeeID,'''')
								AND HT7110.TranMonth = HV3400.TranMonth
								AND HT7110.TranYear = HV3400.TranYear'
						
								EXEC ( @sSQL_HT2401 )
								--PRINT(@sSQL_HT2401)
                                                
							END
							ELSE
							BEGIN
								IF @TableName = 'HT2402'
								BEGIN
								SET @sSQL_HT2402 = 
								'Update HT7110 Set ColumnAmount' + ( CASE  WHEN @FOrders < 10 THEN '0' ELSE '' END ) + ltrim(rtrim(str(@FOrders))) + '=' + @ColumnAmount + ' 
									From HT7110 left  join (Select EmployeeID, DivisionID, DepartmentID, isnull(TeamID,'''') as TeamID,TranMonth, TranYear,
														sum(isnull(AbsentAmount, 0)) as AbsentAmount
														From HT2402 HV3400
														Where AbsentTypeID between ''' + @AmountTypeFrom + ''' and ''' + @AmountTypeTo + ''' and 
														HV3400.DivisionID '+@StrDivisionID_New+' and
														HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
														isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
														HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
														HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + 
														CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) 
														+ @sSQL_Where + '
														Group by HV3400.DivisionID, HV3400.DepartmentID, isnull(HV3400.TeamID, ''''), HV3400.EmployeeID, HV3400.TranMonth, HV3400.TranYear
														) HV3400 on HT7110.DivisionID=HV3400.DivisionID and 
								HT7110.DepartmentID=HV3400.DepartmentID
								and IsNull(HT7110.TeamID,'''')=IsNull(HV3400.TeamID,'''') and 
								IsNull(HT7110.EmployeeID,'''')=IsNull(HV3400.EmployeeID,'''')
								AND HT7110.TranMonth = HV3400.TranMonth
								AND HT7110.TranYear = HV3400.TranYear'
								EXEC ( @sSQL_HT2402 )
								--PRINT(@sSQL_HT2402)
								END
								ELSE
								BEGIN
									IF @TableName = 'HT3400' AND @AmountType = 'GA'
									BEGIN
										SET @sSQL_HT3400GA = 
										'Update HT7110 Set ColumnAmount' + ( CASE WHEN @FOrders < 10 THEN '0' ELSE '' END ) + ltrim(rtrim(str(@FOrders))) + '=' + @ColumnAmount + '
					 					From HT7110 left  join HT3400 HV3400 on HT7110.DivisionID=HV3400.DivisionID and 
										HT7110.DepartmentID=HV3400.DepartmentID
										and IsNull(HT7110.TeamID,'''')=IsNull(HV3400.TeamID,'''') and 
										IsNull(HT7110.EmployeeID,'''')=IsNull(HV3400.EmployeeID,'''')
										Where HV3400.DivisionID '+@StrDivisionID_New+' and
										HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
										isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
										HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
										HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) 
										+ '  and
										HV3400.PayrollMethodID ' + @PayrollMethodID + @sSQL_Where  ---+ @sWHERE	
										
										EXEC ( @sSQL_HT3400GA )
										--PRINT(@sSQL_HT3400GA)
									END
									ELSE
									BEGIN
										IF @TableName = 'HT3400'
										BEGIN
											SET @sSQL_HT3400 = 
											'Update HT7110 Set ColumnAmount' + ( CASE WHEN @FOrders < 10 THEN '0' ELSE '' END ) + ltrim(rtrim(str(@FOrders))) + '=  A
					 						From HT7110 left  join (Select HV3400.DivisionID, HV3400.DepartmentID, isnull(HV3400.TeamID, '''') as TeamID, HV3400.EmployeeID, HV3400.TRanMonth, HV3400.TranYear,
																	sum(' + @ColumnAmount + ') as A 
																	From HT3400  HV3400
																	LEFT JOIN HT3499 ON HV3400.DivisionID = HT3499.DivisionID AND HV3400.TransactionID = HT3499.TransactionID 
																	Where HV3400.DivisionID '+@StrDivisionID_New+' and
																	HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
																	isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
																	HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
																	HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) 
																	+ '  and
																	HV3400.PayrollMethodID ' + @PayrollMethodID + @sWHERE + @sSQL_Where + '
																	Group by HV3400.DivisionID, HV3400.DepartmentID, isnull(HV3400.TeamID, ''''), HV3400.EmployeeID, HV3400.TranMonth, HV3400.TranYear
																	)	HV3400 on HT7110.DivisionID=HV3400.DivisionID and 
											HT7110.DepartmentID=HV3400.DepartmentID and 
											isnull(HT7110.TeamID,'''')=isnull(HV3400.TeamID,'''') and 
											HT7110.EmployeeID = HV3400.EmployeeID
											AND HT7110.TranMonth = HV3400.TranMonth
											AND HT7110.TranYear = HV3400.TranYear'
											EXEC ( @sSQL_HT3400 )
											--PRINT(@sSQL_HT3400)
										END
									END
								END
							END
						END
						IF @TableName = 'HT0338' --- Thuế TNCN                            
						BEGIN
							SET @sSQL_HT0338 = '
							UPDATE HT7110 
							SET ColumnAmount' + ( CASE WHEN @FOrders < 10 THEN '0' ELSE '' END ) + ltrim(rtrim(str(@FOrders))) + '=  VAT
					 		FROM HT7110 
					 		LEFT  JOIN (SELECT	DivisionID, EmployeeID,
												SUM(' + @ColumnAmount + ') AS VAT, HV3400.TranMonth, HV3400.TranYear
										FROM	HT0338  HV3400
										WHERE	HV3400.DivisionID '+@StrDivisionID_New+' and
												HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
												HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) +
													+ @sWHERE + @sSQL_Where + '
										GROUP BY DivisionID, EmployeeID, HV3400.TranMonth, HV3400.TranYear
					 					) HT0338 
					 			ON		HT7110.DivisionID = HT0338.DivisionID AND 
										HT7110.EmployeeID = HT0338.EmployeeID AND
										HT7110.TranMonth = HT0338.TranMonth and
										HT7110.TranYear = HT0338.TranYear'
							EXEC ( @sSQL_HT0338 )
							--PRINT(@sSQL_HT0338)
						END
						ELSE
						BEGIN
							IF @TableName = 'HT2499'
							BEGIN
							SET @sSQL_HT2499 = '
							Update HT7110 
							Set ColumnAmount' + ( CASE WHEN @FOrders < 10 THEN '0' ELSE ''END ) + ltrim(rtrim(str(@FOrders))) + '=  A
							From HT7110 
							left  join (Select HV3400.DivisionID, HV3400.DepartmentID, isnull(HV3400.TeamID, '''') as TeamID,  HV3400.EmployeeID, HV3400.TranMonth, HV3400.TranYear,
										sum(' + @ColumnAmount + ') as A 
										From HT2400  HV3400 INNER JOIN HT2499 ON HV3400.EmpFileID = HT2499.EmpFileID
										Where HV3400.DivisionID '+@StrDivisionID_New+' and
										HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
										isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
										HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and 
										HV3400.TranMonth + HV3400.TranYear*100 between '
											+ CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) 
											+ @sSQL_Where + '
										Group by HV3400.DivisionID, HV3400.DepartmentID, isnull(HV3400.TeamID, ''''), HV3400.EmployeeID, HV3400.TranMonth, HV3400.TranYear
										)	HV3400 on HT7110.DivisionID=HV3400.DivisionID and 
							HT7110.DepartmentID=HV3400.DepartmentID and 
							isnull(HT7110.TeamID,'''')=isnull(HV3400.TeamID,'''') and 
							HT7110.EmployeeID = HV3400.EmployeeID
							AND HT7110.TranMonth = HV3400.TranMonth
							AND HT7110.TranYear = HV3400.TranYear
							'				
							EXEC ( @sSQL_HT2499 )
							--select(@sSQL_HT2499)
							END
						END
					END

					IF @TableName = 'HT2461'
					BEGIN
						SET @sSQL_HT2461 = '
							Update HT7110 Set ColumnAmount' + ( CASE WHEN @FOrders < 10 THEN '0' ELSE '' END ) + ltrim(rtrim(str(@FOrders))) + '=  A
							From HT7110 left  join (Select DivisionID, DepartmentID, isnull(TeamID, '''') as TeamID,  EmployeeID,TranMonth, TranYear,
													sum(' + @ColumnAmount + ') as A 
													From HT2461  HV3400
													Where HV3400.DivisionID '+@StrDivisionID_New+' and
													HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
													isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
													HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
													HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + 
													CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) 
													+ @sSQL_Where + '
													Group by DivisionID, DepartmentID, isnull(TeamID, ''''), EmployeeID, TranMonth, TranYear
													)	HV3400 on HT7110.DivisionID=HV3400.DivisionID and 
							HT7110.DepartmentID=HV3400.DepartmentID and 
							isnull(HT7110.TeamID,'''')=isnull(HV3400.TeamID,'''') and 
							HT7110.EmployeeID = HV3400.EmployeeID
							AND HT7110.TranMonth = HV3400.TranMonth
							AND HT7110.TranYear = HV3400.TranYear'
				
							EXEC (@sSQL_HT2461)
					END
				END
				ELSE	----- @AmountType = 'OT'  , so lieu la khac thi lay hang so la so lieu cua mot cot
				BEGIN
						IF @IsOT = 0
						BEGIN
							SELECT @IsOT = 1 ,
								   @sSQL = 'Update HT7110 Set '
						END
						SET @sSQL = @sSQL + 'ColumnAmount' + ( CASE
																	WHEN @FOrders < 10 THEN '0'
																	ELSE ''
															END ) + ltrim(rtrim(str(@FOrders))) + '=' + ' IsNull(' + str(@OtherAmount) + ',0) ' + ','
				END
			
				--- Update thực lãnh
				IF Isnull(@NetIncomeMethod,0) = 1
					SET @sSQL_Total = 'UPDATE HT7110 Set Total = Isnull(Total,0) + Isnull(ColumnAmount' + ( CASE
																	 WHEN @FOrders < 10 THEN '0'
																	 ELSE ''
																END ) + ltrim(rtrim(str(@FOrders))) + ',0) '
				ELSE IF Isnull(@NetIncomeMethod,0) = 2
					SET @sSQL_Total = 'UPDATE HT7110 Set Total = Isnull(Total,0) - Isnull(ColumnAmount' + ( CASE
																	 WHEN @FOrders < 10 THEN '0'
																	 ELSE ''
																END ) + ltrim(rtrim(str(@FOrders))) + ',0) '
				ELSE
					SET @sSQL_Total = ''
            
				EXEC(@sSQL_Total)
			   --PRINT @sSQL_Total
           
				--- Update thuế TNCN
				IF @AmountType = 'TA'
				BEGIN
					SET @sSQL_Tax = 'UPDATE HT7110 Set TaxAmount = ColumnAmount' + ( CASE WHEN @FOrders < 10 THEN '0' ELSE '' END ) + ltrim(rtrim(str(@FOrders)))
					EXEC(@sSQL_Tax)
				END
		
				FETCH NEXT FROM @cur INTO @ColumnID,@FOrders,@Caption,@AmountType,@AmountTypeFrom,@AmountTypeTo,@Signs,@IsSerie,@OtherAmount,@IsChangeCurrency, @NetIncomeMethod

		  END
	CLOSE @cur

	IF @IsOT = 1
	   BEGIN

			 SET @sSQL = LEFT(@sSQL , len(@sSQL) - 1)
			 SET @sSQL = @sSQL + ' From HT7110 left  join HV3400 on HT7110.DivisionID=HV3400.DivisionID and HT7110.DepartmentID=HV3400.DepartmentID
				and IsNull(HT7110.TeamID,'''')=IsNull(HV3400.TeamID,'''') and IsNull(HT7110.EmployeeID,'''')=IsNull(HV3400.EmployeeID,'''')
				Where HV3400.DivisionID '+@StrDivisionID_New+' and
				HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
				isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and

				HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
				HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) + ' and
				HV3400.PayrollMethodID ' + @PayrollMethodID  + @sSQL_Where
			 --select @sSQL
			 EXEC ( @sSQL )
	   END


	---------Neu co tinh tong 

	IF EXISTS ( SELECT TOP 1 1 FROM HT4712 WHERE IsNull(IsTotal , 0) = 1 AND ReportCode = @ReportCode And DivisionID IN (SELECT DivisionID FROM DivTable))
	   BEGIN

			 SET @sSQL = 'Update HT7110 Set '

			 SET @cur = CURSOR SCROLL KEYSET FOR SELECT DISTINCT ColumnID, FOrders, Caption, Signs, IsNull(IsSerie, 0) AS IsSerie, FromColumn, ToColumn
												 FROM  HT4712
												 WHERE DivisionID IN (SELECT DivisionID FROM DivTable) and ReportCode = @ReportCode AND IsNull(IsTotal , 0) = 1
												ORDER BY ColumnID
			 OPEN @cur
			 FETCH NEXT FROM @cur INTO @ColumnID,@FOrders,@Caption,@Signs,@IsSerie,@FromColumn,@ToColumn
			 WHILE @@Fetch_Status = 0
				   BEGIN               
						 EXEC HP4702 @Signs , @IsSerie , @FromColumn , @ToColumn , @ColumnAmount OUTPUT , @ColumnID              
						 SET @sSQL = @sSQL + 'ColumnAmount' + ( CASE
																	 WHEN @FOrders < 10 THEN '0'
																	 ELSE ''
																END ) + ltrim(rtrim(str(@FOrders))) + '=' + @ColumnAmount -- + ','
           
						EXEC ( @sSQL )
						 SET @sSQL = 'Update HT7110 Set '
						 FETCH NEXT FROM @cur INTO @ColumnID,@FOrders,@Caption,@Signs,@IsSerie,@FromColumn,@ToColumn
                    
				   END
			 CLOSE @cur
	   END

	DELETE
			HT7110
	WHERE
			isnull(ColumnAmount01 , 0) = 0 AND isnull(ColumnAmount02 , 0) = 0 AND isnull(ColumnAmount03 , 0) = 0 AND isnull(ColumnAmount04 , 0) = 0 AND isnull(ColumnAmount05 , 0) = 0 AND isnull(ColumnAmount06 , 0) = 0 AND isnull(ColumnAmount07 , 0) = 0 AND isnull(ColumnAmount08 , 0) = 0 AND isnull(ColumnAmount09 , 0) = 0 AND isnull(ColumnAmount10 , 0) = 0 AND isnull(ColumnAmount11 , 0) = 0 AND isnull(ColumnAmount12 , 0) = 0 AND isnull(ColumnAmount13 , 0) = 0 AND isnull(ColumnAmount14 , 0) = 0 AND isnull(ColumnAmount15 , 0) = 0 AND isnull(ColumnAmount16 , 0) = 0 AND isnull(ColumnAmount17 , 0) = 0 AND isnull(ColumnAmount18 , 0) = 0 AND isnull(ColumnAmount19 , 0) = 0 AND isnull(ColumnAmount20 , 0) = 0 AND isnull(ColumnAmount21 , 0) = 0 AND isnull(ColumnAmount22 , 0) = 0 AND isnull(ColumnAmount23 , 0) = 0 AND isnull(ColumnAmount24 , 0) = 0 AND isnull(ColumnAmount25 , 0) = 0 AND isnull(ColumnAmount26 , 0) = 0 AND isnull(ColumnAmount27 , 0) = 0 AND isnull(ColumnAmount28 , 0) = 0 AND isnull(ColumnAmount29 , 0) = 0 AND isnull(ColumnAmount30 , 0) = 0 AND isnull(ColumnAmount31 , 0) = 0 AND isnull(ColumnAmount32 , 0) = 0 AND isnull(ColumnAmount33 , 0) = 0 AND isnull(ColumnAmount34 , 0) = 0 AND isnull(ColumnAmount35 , 0) = 0 AND isnull(ColumnAmount36 , 0) = 0 AND isnull(ColumnAmount37 , 0) = 0 AND isnull(ColumnAmount38 , 0) = 0 AND isnull(ColumnAmount39 , 0) = 0 AND isnull(ColumnAmount40 , 0) = 0 AND isnull(ColumnAmount41 , 0) = 0 AND isnull(ColumnAmount42 , 0) = 0 AND isnull(ColumnAmount43 , 0) = 0 AND isnull(ColumnAmount44 , 0) = 0 AND isnull(ColumnAmount45 , 0) = 0 AND isnull(ColumnAmount46 , 0) = 0 AND isnull(ColumnAmount47 , 0) = 0 AND isnull(ColumnAmount48 , 0) = 0 AND isnull(ColumnAmount49 , 0) = 0 AND isnull(ColumnAmount50 , 0) = 0

	DELETE #HP7008Emp
	DROP TABLE DivTable
END


 Select * INTO #HT7110 from HT7110 
 Delete HT7110
 SET @sSQL = '
 INSERT INTO HT7110 (
DivisionID	,DepartmentID,DepartmentName,TeamID	,TeamName,EmployeeID,FullName,IdentifyCardNo,BankID	,BankName,BankAccountNo	,DutyID	,DutyName,
Orders	,Groups	,BaseSalary,
ColumnAmount01,ColumnAmount02,ColumnAmount03,ColumnAmount04	,ColumnAmount05	,ColumnAmount06	,ColumnAmount07	,ColumnAmount08	,ColumnAmount09	,ColumnAmount10	,
ColumnAmount11,ColumnAmount12,ColumnAmount13,ColumnAmount14	,ColumnAmount15	,ColumnAmount16	,ColumnAmount17	,ColumnAmount18	,ColumnAmount19	,ColumnAmount20	,
ColumnAmount21,ColumnAmount22,ColumnAmount23,ColumnAmount24	,ColumnAmount25	,ColumnAmount26	,ColumnAmount27	,ColumnAmount28	,ColumnAmount29	,ColumnAmount30	,
ColumnAmount31,ColumnAmount32,ColumnAmount33,ColumnAmount34	,ColumnAmount35	,ColumnAmount36	,ColumnAmount37	,ColumnAmount38	,ColumnAmount39	,ColumnAmount40	,
ColumnAmount41,ColumnAmount42,ColumnAmount43,ColumnAmount44	,ColumnAmount45	,ColumnAmount46	,ColumnAmount47	,ColumnAmount48	,ColumnAmount49	,ColumnAmount50	,
Birthday,PersonalTaxID,WorkDate	,LeaveDate,EducationLevelID,EducationLevelName,MajorID	,MajorName,ShortName,Alias	,
Total	,TaxAmount,ExpenseAccountID,PayableAccountID,PerInTaxID	,
IdentifyDate,IdentifyPlace,ArmyLevel,IsKeepSalary,IsReceiveSalary,Notes_HT3400,ShiftID01,ShiftID02,ShiftID03,ShiftID01_SUN,ShiftID02_SUN,ShiftID03_SUN,
CountryName	,Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,AbsentCardNo,TeamNotes	,
InCome25_1,InCome25_2,InCome25_3,InCome25_4,InCome25_5,InCome25_6,InCome25_7,InCome25_8,InCome25_9,InCome25_10,InCome25_11,InCome25_12,
ColumnAmount51,ColumnAmount52,ColumnAmount53,ColumnAmount54,ColumnAmount55,ColumnAmount56,ColumnAmount57,ColumnAmount58,ColumnAmount59,ColumnAmount60,
ColumnAmount61,ColumnAmount62,ColumnAmount63,ColumnAmount64,ColumnAmount65,ColumnAmount66,ColumnAmount67,ColumnAmount68,ColumnAmount69,ColumnAmount70,
ColumnAmount71,ColumnAmount72,ColumnAmount73,ColumnAmount74,ColumnAmount75,ColumnAmount76,ColumnAmount77,ColumnAmount78,ColumnAmount79,ColumnAmount80,
ColumnAmount81,ColumnAmount82,ColumnAmount83,ColumnAmount84,ColumnAmount85,ColumnAmount86,ColumnAmount87,ColumnAmount88,ColumnAmount89,ColumnAmount90,
ColumnAmount91,ColumnAmount92,ColumnAmount93,ColumnAmount94,ColumnAmount95,ColumnAmount96,ColumnAmount97,ColumnAmount98,ColumnAmount99,ColumnAmount100,
TitleID	,TitleName,
ColumnAmount101,ColumnAmount102,ColumnAmount103,ColumnAmount104,ColumnAmount105,ColumnAmount106,ColumnAmount107,ColumnAmount108,ColumnAmount109,ColumnAmount110,
ColumnAmount111,ColumnAmount112,ColumnAmount113,ColumnAmount114,ColumnAmount115,ColumnAmount116,ColumnAmount117,ColumnAmount118,ColumnAmount119,ColumnAmount120,
ColumnAmount121,ColumnAmount122,ColumnAmount123,ColumnAmount124,ColumnAmount125,ColumnAmount126,ColumnAmount127,ColumnAmount128,ColumnAmount129,ColumnAmount130,
ColumnAmount131,ColumnAmount132,ColumnAmount133,ColumnAmount134,ColumnAmount135,ColumnAmount136,ColumnAmount137,ColumnAmount138,ColumnAmount139,ColumnAmount140,
ColumnAmount141,ColumnAmount142,ColumnAmount143,ColumnAmount144,ColumnAmount145,ColumnAmount146,ColumnAmount147,ColumnAmount148,ColumnAmount149,ColumnAmount150,
ColumnAmount151,ColumnAmount152,ColumnAmount153,ColumnAmount154,ColumnAmount155,ColumnAmount156,ColumnAmount157,ColumnAmount158,ColumnAmount159,ColumnAmount160,
ColumnAmount161,ColumnAmount162,ColumnAmount163,ColumnAmount164,ColumnAmount165,ColumnAmount166,ColumnAmount167,ColumnAmount168,ColumnAmount169,ColumnAmount170,
ColumnAmount171,ColumnAmount172,ColumnAmount173,ColumnAmount174,ColumnAmount175,ColumnAmount176,ColumnAmount177,ColumnAmount178,ColumnAmount179,ColumnAmount180,
ColumnAmount181,ColumnAmount182,ColumnAmount183,ColumnAmount184,ColumnAmount185,ColumnAmount186,ColumnAmount187,ColumnAmount188,ColumnAmount189,ColumnAmount190,
ColumnAmount191,ColumnAmount192,ColumnAmount193,ColumnAmount194,ColumnAmount195,ColumnAmount196,ColumnAmount197,ColumnAmount198,ColumnAmount199,ColumnAmount200,
InLateCount	,OutEarlyCount)
 '
 SET @sSQL1 = N' Select DivisionID,DepartmentID,DepartmentName,TeamID,TeamName,EmployeeID,FullName,IdentifyCardNo,BankID,
BankName,BankAccountNo,DutyID,DutyName,Orders,Groups,
SUM(ISNULL(BaseSalary	 ,0)) as BaseSalary	  ,
SUM(ISNULL(ColumnAmount01,0)) as ColumnAmount01,
SUM(ISNULL(ColumnAmount02,0)) as ColumnAmount02,
SUM(ISNULL(ColumnAmount03,0)) as ColumnAmount03,
SUM(ISNULL(ColumnAmount04,0)) as ColumnAmount04,
SUM(ISNULL(ColumnAmount05,0)) as ColumnAmount05,
SUM(ISNULL(ColumnAmount06,0)) as ColumnAmount06,
SUM(ISNULL(ColumnAmount07,0)) as ColumnAmount07,
SUM(ISNULL(ColumnAmount08,0)) as ColumnAmount08,
SUM(ISNULL(ColumnAmount09,0)) as ColumnAmount09,
SUM(ISNULL(ColumnAmount10,0)) as ColumnAmount10,
SUM(ISNULL(ColumnAmount11,0)) as ColumnAmount11,
SUM(ISNULL(ColumnAmount12,0)) as ColumnAmount12,
SUM(ISNULL(ColumnAmount13,0)) as ColumnAmount13,
SUM(ISNULL(ColumnAmount14,0)) as ColumnAmount14,
SUM(ISNULL(ColumnAmount15,0)) as ColumnAmount15,
SUM(ISNULL(ColumnAmount16,0)) as ColumnAmount16,
SUM(ISNULL(ColumnAmount17,0)) as ColumnAmount17,
SUM(ISNULL(ColumnAmount18,0)) as ColumnAmount18,
SUM(ISNULL(ColumnAmount19,0)) as ColumnAmount19,
SUM(ISNULL(ColumnAmount20,0)) as ColumnAmount20,
SUM(ISNULL(ColumnAmount21,0)) as ColumnAmount21,
SUM(ISNULL(ColumnAmount22,0)) as ColumnAmount22,
SUM(ISNULL(ColumnAmount23,0)) as ColumnAmount23,
SUM(ISNULL(ColumnAmount24,0)) as ColumnAmount24,
SUM(ISNULL(ColumnAmount25,0)) as ColumnAmount25,
SUM(ISNULL(ColumnAmount26,0)) as ColumnAmount26,
SUM(ISNULL(ColumnAmount27,0)) as ColumnAmount27,
SUM(ISNULL(ColumnAmount28,0)) as ColumnAmount28,
SUM(ISNULL(ColumnAmount29,0)) as ColumnAmount29,
SUM(ISNULL(ColumnAmount30,0)) as ColumnAmount30,
SUM(ISNULL(ColumnAmount31,0)) as ColumnAmount31,
SUM(ISNULL(ColumnAmount32,0)) as ColumnAmount32,
SUM(ISNULL(ColumnAmount33,0)) as ColumnAmount33,
SUM(ISNULL(ColumnAmount34,0)) as ColumnAmount34,
SUM(ISNULL(ColumnAmount35,0)) as ColumnAmount35,
SUM(ISNULL(ColumnAmount36,0)) as ColumnAmount36,
SUM(ISNULL(ColumnAmount37,0)) as ColumnAmount37,
SUM(ISNULL(ColumnAmount38,0)) as ColumnAmount38,
SUM(ISNULL(ColumnAmount39,0)) as ColumnAmount39,
SUM(ISNULL(ColumnAmount40,0)) as ColumnAmount40,
SUM(ISNULL(ColumnAmount41,0)) as ColumnAmount41,
SUM(ISNULL(ColumnAmount42,0)) as ColumnAmount42,
SUM(ISNULL(ColumnAmount43,0)) as ColumnAmount43,
SUM(ISNULL(ColumnAmount44,0)) as ColumnAmount44,
SUM(ISNULL(ColumnAmount45,0)) as ColumnAmount45,
SUM(ISNULL(ColumnAmount46,0)) as ColumnAmount46,
SUM(ISNULL(ColumnAmount47,0)) as ColumnAmount47,
SUM(ISNULL(ColumnAmount48,0)) as ColumnAmount48,
SUM(ISNULL(ColumnAmount49,0)) as ColumnAmount49,
SUM(ISNULL(ColumnAmount50,0)) as ColumnAmount50,
Birthday,PersonalTaxID,WorkDate,
LeaveDate,EducationLevelID,EducationLevelName,MajorID,
MajorName,ShortName,Alias,
SUM(ISNULL(Total,0)) as Total,
SUM(ISNULL(TaxAmount,0)) as TaxAmount,
ExpenseAccountID,PayableAccountID,PerInTaxID,
IdentifyDate,IdentifyPlace,ArmyLevel,IsKeepSalary,IsReceiveSalary,
Notes_HT3400,ShiftID01,ShiftID02,ShiftID03,ShiftID01_SUN,ShiftID02_SUN,ShiftID03_SUN,
CountryName	,Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,AbsentCardNo,TeamNotes	,
SUM(ISNULL(InCome25_1 ,0))	as InCome25_1 ,
SUM(ISNULL(InCome25_2 ,0))	as InCome25_2 ,
SUM(ISNULL(InCome25_3 ,0))	as InCome25_3 ,
SUM(ISNULL(InCome25_4 ,0))	as InCome25_4 ,
SUM(ISNULL(InCome25_5 ,0))	as InCome25_5 ,
SUM(ISNULL(InCome25_6 ,0))	as InCome25_6 ,
SUM(ISNULL(InCome25_7 ,0))	as InCome25_7 ,
SUM(ISNULL(InCome25_8 ,0))	as InCome25_8 ,
SUM(ISNULL(InCome25_9 ,0))	as InCome25_9 ,
SUM(ISNULL(InCome25_10,0))	as InCome25_10,
SUM(ISNULL(InCome25_11,0))	as InCome25_11,
SUM(ISNULL(InCome25_12,0))	as InCome25_12,
SUM(ISNULL(ColumnAmount51,0))	as ColumnAmount51,
SUM(ISNULL(ColumnAmount52,0))	as ColumnAmount52,
SUM(ISNULL(ColumnAmount53,0))	as ColumnAmount53,
SUM(ISNULL(ColumnAmount54,0))	as ColumnAmount54,
SUM(ISNULL(ColumnAmount55,0))	as ColumnAmount55,
SUM(ISNULL(ColumnAmount56,0))	as ColumnAmount56,
SUM(ISNULL(ColumnAmount57,0))	as ColumnAmount57,
SUM(ISNULL(ColumnAmount58,0))	as ColumnAmount58,
SUM(ISNULL(ColumnAmount59,0))	as ColumnAmount59,
SUM(ISNULL(ColumnAmount60,0))	as ColumnAmount60,
SUM(ISNULL(ColumnAmount61,0))	as ColumnAmount61,
SUM(ISNULL(ColumnAmount62,0))	as ColumnAmount62,
SUM(ISNULL(ColumnAmount63,0))	as ColumnAmount63,
SUM(ISNULL(ColumnAmount64,0))	as ColumnAmount64,
SUM(ISNULL(ColumnAmount65,0))	as ColumnAmount65,
SUM(ISNULL(ColumnAmount66,0))	as ColumnAmount66,
SUM(ISNULL(ColumnAmount67,0))	as ColumnAmount67,
SUM(ISNULL(ColumnAmount68,0))	as ColumnAmount68,
SUM(ISNULL(ColumnAmount69,0))	as ColumnAmount69,
SUM(ISNULL(ColumnAmount70,0))	as ColumnAmount70,
SUM(ISNULL(ColumnAmount71,0))	as ColumnAmount71,
SUM(ISNULL(ColumnAmount72,0))	as ColumnAmount72,
SUM(ISNULL(ColumnAmount73,0))	as ColumnAmount73,
SUM(ISNULL(ColumnAmount74,0))	as ColumnAmount74,
SUM(ISNULL(ColumnAmount75,0))	as ColumnAmount75,
SUM(ISNULL(ColumnAmount76,0))	as ColumnAmount76,
SUM(ISNULL(ColumnAmount77,0))	as ColumnAmount77,
SUM(ISNULL(ColumnAmount78,0))	as ColumnAmount78,
SUM(ISNULL(ColumnAmount79,0))	as ColumnAmount79,
SUM(ISNULL(ColumnAmount80,0))	as ColumnAmount80,
SUM(ISNULL(ColumnAmount81,0))	as ColumnAmount81,
SUM(ISNULL(ColumnAmount82,0))	as ColumnAmount82,
SUM(ISNULL(ColumnAmount83,0))	as ColumnAmount83,
SUM(ISNULL(ColumnAmount84,0))	as ColumnAmount84,
SUM(ISNULL(ColumnAmount85,0))	as ColumnAmount85,
SUM(ISNULL(ColumnAmount86,0))	as ColumnAmount86,
SUM(ISNULL(ColumnAmount87,0))	as ColumnAmount87,
SUM(ISNULL(ColumnAmount88,0))	as ColumnAmount88,
SUM(ISNULL(ColumnAmount89,0))	as ColumnAmount89,
SUM(ISNULL(ColumnAmount90,0))	as ColumnAmount90,
SUM(ISNULL(ColumnAmount91,0))	as ColumnAmount91,
SUM(ISNULL(ColumnAmount92,0))	as ColumnAmount92,
SUM(ISNULL(ColumnAmount93,0))	as ColumnAmount93,
SUM(ISNULL(ColumnAmount94,0))	as ColumnAmount94,
SUM(ISNULL(ColumnAmount95,0))	as ColumnAmount95,
SUM(ISNULL(ColumnAmount96,0))	as ColumnAmount96,
SUM(ISNULL(ColumnAmount97,0))	as ColumnAmount97,
SUM(ISNULL(ColumnAmount98,0))	as ColumnAmount98,
SUM(ISNULL(ColumnAmount99,0))	as ColumnAmount99,
SUM(ISNULL(ColumnAmount100,0))	as ColumnAmount100,
TitleID	,TitleName,'
SET @sSQL2 = N'SUM(ISNULL(ColumnAmount101,0))	as ColumnAmount101,
SUM(ISNULL(ColumnAmount102,0))	as ColumnAmount102,
SUM(ISNULL(ColumnAmount103,0))	as ColumnAmount103,
SUM(ISNULL(ColumnAmount104,0))	as ColumnAmount104,
SUM(ISNULL(ColumnAmount105,0))	as ColumnAmount105,
SUM(ISNULL(ColumnAmount106,0))	as ColumnAmount106,
SUM(ISNULL(ColumnAmount107,0))	as ColumnAmount107,
SUM(ISNULL(ColumnAmount108,0))	as ColumnAmount108,
SUM(ISNULL(ColumnAmount109,0))	as ColumnAmount109,
SUM(ISNULL(ColumnAmount110,0))	as ColumnAmount110,
SUM(ISNULL(ColumnAmount111,0))	as ColumnAmount111,
SUM(ISNULL(ColumnAmount112,0))	as ColumnAmount112,
SUM(ISNULL(ColumnAmount113,0))	as ColumnAmount113,
SUM(ISNULL(ColumnAmount114,0))	as ColumnAmount114,
SUM(ISNULL(ColumnAmount115,0))	as ColumnAmount115,
SUM(ISNULL(ColumnAmount116,0))	as ColumnAmount116,
SUM(ISNULL(ColumnAmount117,0))	as ColumnAmount117,
SUM(ISNULL(ColumnAmount118,0))	as ColumnAmount118,
SUM(ISNULL(ColumnAmount119,0))	as ColumnAmount119,
SUM(ISNULL(ColumnAmount120,0))	as ColumnAmount120,
SUM(ISNULL(ColumnAmount121,0))	as ColumnAmount121,
SUM(ISNULL(ColumnAmount122,0))	as ColumnAmount122,
SUM(ISNULL(ColumnAmount123,0))	as ColumnAmount123,
SUM(ISNULL(ColumnAmount124,0))	as ColumnAmount124,
SUM(ISNULL(ColumnAmount125,0))	as ColumnAmount125,
SUM(ISNULL(ColumnAmount126,0))	as ColumnAmount126,
SUM(ISNULL(ColumnAmount127,0))	as ColumnAmount127,
SUM(ISNULL(ColumnAmount128,0))	as ColumnAmount128,
SUM(ISNULL(ColumnAmount129,0))	as ColumnAmount129,
SUM(ISNULL(ColumnAmount130,0))	as ColumnAmount130,
SUM(ISNULL(ColumnAmount131,0))	as ColumnAmount131,
SUM(ISNULL(ColumnAmount132,0))	as ColumnAmount132,
SUM(ISNULL(ColumnAmount133,0))	as ColumnAmount133,
SUM(ISNULL(ColumnAmount134,0))	as ColumnAmount134,
SUM(ISNULL(ColumnAmount135,0))	as ColumnAmount135,
SUM(ISNULL(ColumnAmount136,0))	as ColumnAmount136,
SUM(ISNULL(ColumnAmount137,0))	as ColumnAmount137,
SUM(ISNULL(ColumnAmount138,0))	as ColumnAmount138,
SUM(ISNULL(ColumnAmount139,0))	as ColumnAmount139,
SUM(ISNULL(ColumnAmount140,0))	as ColumnAmount140,
SUM(ISNULL(ColumnAmount141,0))	as ColumnAmount141,
SUM(ISNULL(ColumnAmount142,0))	as ColumnAmount142,
SUM(ISNULL(ColumnAmount143,0))	as ColumnAmount143,
SUM(ISNULL(ColumnAmount144,0))	as ColumnAmount144,
SUM(ISNULL(ColumnAmount145,0))	as ColumnAmount145,
SUM(ISNULL(ColumnAmount146,0))	as ColumnAmount146,
SUM(ISNULL(ColumnAmount147,0))	as ColumnAmount147,
SUM(ISNULL(ColumnAmount148,0))	as ColumnAmount148,
SUM(ISNULL(ColumnAmount149,0))	as ColumnAmount149,
SUM(ISNULL(ColumnAmount150,0))	as ColumnAmount150,
SUM(ISNULL(ColumnAmount151,0))	as ColumnAmount151,
SUM(ISNULL(ColumnAmount152,0))	as ColumnAmount152,
SUM(ISNULL(ColumnAmount153,0))	as ColumnAmount153,
SUM(ISNULL(ColumnAmount154,0))	as ColumnAmount154,
SUM(ISNULL(ColumnAmount155,0))	as ColumnAmount155,
SUM(ISNULL(ColumnAmount156,0))	as ColumnAmount156,
SUM(ISNULL(ColumnAmount157,0))	as ColumnAmount157,
SUM(ISNULL(ColumnAmount158,0))	as ColumnAmount158,
SUM(ISNULL(ColumnAmount159,0))	as ColumnAmount159,
SUM(ISNULL(ColumnAmount160,0))	as ColumnAmount160,
SUM(ISNULL(ColumnAmount161,0))	as ColumnAmount161,
SUM(ISNULL(ColumnAmount162,0))	as ColumnAmount162,
SUM(ISNULL(ColumnAmount163,0))	as ColumnAmount163,
SUM(ISNULL(ColumnAmount164,0))	as ColumnAmount164,
SUM(ISNULL(ColumnAmount165,0))	as ColumnAmount165,
SUM(ISNULL(ColumnAmount166,0))	as ColumnAmount166,
SUM(ISNULL(ColumnAmount167,0))	as ColumnAmount167,
SUM(ISNULL(ColumnAmount168,0))	as ColumnAmount168,
SUM(ISNULL(ColumnAmount169,0))	as ColumnAmount169,
SUM(ISNULL(ColumnAmount170,0))	as ColumnAmount170,
SUM(ISNULL(ColumnAmount171,0))	as ColumnAmount171,
SUM(ISNULL(ColumnAmount172,0))	as ColumnAmount172,
SUM(ISNULL(ColumnAmount173,0))	as ColumnAmount173,
SUM(ISNULL(ColumnAmount174,0))	as ColumnAmount174,
SUM(ISNULL(ColumnAmount175,0))	as ColumnAmount175,
SUM(ISNULL(ColumnAmount176,0))	as ColumnAmount176,
SUM(ISNULL(ColumnAmount177,0))	as ColumnAmount177,
SUM(ISNULL(ColumnAmount178,0))	as ColumnAmount178,
SUM(ISNULL(ColumnAmount179,0))	as ColumnAmount179,
SUM(ISNULL(ColumnAmount180,0))	as ColumnAmount180,
SUM(ISNULL(ColumnAmount181,0))	as ColumnAmount181,
SUM(ISNULL(ColumnAmount182,0))	as ColumnAmount182,
SUM(ISNULL(ColumnAmount183,0))	as ColumnAmount183,
SUM(ISNULL(ColumnAmount184,0))	as ColumnAmount184,
SUM(ISNULL(ColumnAmount185,0))	as ColumnAmount185,
SUM(ISNULL(ColumnAmount186,0))	as ColumnAmount186,
SUM(ISNULL(ColumnAmount187,0))	as ColumnAmount187,
SUM(ISNULL(ColumnAmount188,0))	as ColumnAmount188,
SUM(ISNULL(ColumnAmount189,0))	as ColumnAmount189,
SUM(ISNULL(ColumnAmount190,0))	as ColumnAmount190,
SUM(ISNULL(ColumnAmount191,0))	as ColumnAmount191,
SUM(ISNULL(ColumnAmount192,0))	as ColumnAmount192,
SUM(ISNULL(ColumnAmount193,0))	as ColumnAmount193,
SUM(ISNULL(ColumnAmount194,0))	as ColumnAmount194,
SUM(ISNULL(ColumnAmount195,0))	as ColumnAmount195,
SUM(ISNULL(ColumnAmount196,0))	as ColumnAmount196,
SUM(ISNULL(ColumnAmount197,0))	as ColumnAmount197,
SUM(ISNULL(ColumnAmount198,0))	as ColumnAmount198,
SUM(ISNULL(ColumnAmount199,0))	as ColumnAmount199,
SUM(ISNULL(ColumnAmount200,0))	as ColumnAmount200,
SUM(ISNULL(InLateCount,0)) as InLateCount,SUM(ISNULL(OutEarlyCount,0)) as OutEarlyCount 
From #HT7110 '
set @sSQL3 = N' Where
DivisionID '+@StrDivisionID_New+'
Group by DivisionID,DepartmentID,DepartmentName,TeamID,TeamName,EmployeeID,FullName,IdentifyCardNo,BankID,
BankName,BankAccountNo,DutyID,DutyName,Orders,Groups,
Birthday,PersonalTaxID,WorkDate,
LeaveDate,EducationLevelID,EducationLevelName,MajorID,
MajorName,ShortName,Alias,
ExpenseAccountID,PayableAccountID,PerInTaxID,
IdentifyDate,IdentifyPlace,ArmyLevel,IsKeepSalary,IsReceiveSalary,
Notes_HT3400,ShiftID01,ShiftID02,ShiftID03,ShiftID01_SUN,ShiftID02_SUN,ShiftID03_SUN,
CountryName	,Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,AbsentCardNo,TeamNotes	,
TitleID	,TitleName	'

print @sSQL
print @sSQL1 
print @sSQL2 
print @sSQL3
EXEC ( @sSQL+@sSQL1+@sSQL2+@sSQL3 )
						


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
