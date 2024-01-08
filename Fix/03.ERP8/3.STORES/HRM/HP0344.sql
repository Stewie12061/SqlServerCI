IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0344]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0344]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Created by Bảo Anh	Date: 09/10/2013
--- Purpose: In danh sách thanh toán chế độ ốm đau, thai sản, dưỡng sức PHSK
--- Modify on 25/02/2014 by Bảo Anh: Bổ sung trường WorkConditionTypeID
--- Modify on 27/02/2014 by Bảo Anh: Sửa lỗi tính sai VoucherDateTo ở chế độ thai sản
--- Modify on 23/06/2015 by Bảo Anh: Dùng ltrim thay cho str để convert dữ liệu thành kiểu chuỗi
---									 Sửa cách lấy OldTotalAmounts ở phần 3, khai báo @BankName thành nvarchar
---									 Không lấy số lẻ ở field DecayRate
--- Modify on 10/08/2015 by Thanh Thịnh: Cộng thêm số Dư đầu kỳ vào lũy số kế thừa.
--- Modified by Tiểu Mai on 15/02/2017: Chỉnh sửa text báo cáo			
--- Modified by Bảo Thy on 11/05/2017: Sửa danh mục dùng chung
--- EXEC HP0344 'AS','%','%',3,2012,'01/2012',1,2,'Order by Group01ID, ConditionTypeID'

CREATE PROCEDURE [dbo].[HP0344]
				@DivisionID nvarchar(50),
				@DepartmentID nvarchar(50),
				@TeamID nvarchar(50),
				@TranMonth int,
				@TranYear int,
				@Quarter nvarchar(7),
				@IsQuarter tinyint,
				@TimesNo int,
				@Orderby nvarchar(max)
AS
	
Declare @SQL1 nvarchar(max),
		@SQL2 nvarchar(max),
		@SQL3 nvarchar(max),
		@WhereTime nvarchar(max),
		@Where nvarchar(max),
		@Where1 nvarchar(max),
		@BankAccountNo as varchar(50),
		@BankName as nvarchar(250)
	
IF @IsQuarter = 1	--- hiển thị dữ liệu quý
	SET @WhereTime = 'And HT03.TranYear = ' + ltrim(@TranYear) + '
						And	HT03.TranMonth in (Select TranMonth FROM HV9999 Where DivisionID = ''' + @DivisionID + ''' And Quarter = ''' + @Quarter + ''')'	
					
ELSE	--- hiển thị dữ liệu tháng
	SET @WhereTime = 'And HT03.TranMonth = ' + ltrim(@TranMonth) + ' AND HT03.TranYear = ' + ltrim(@TranYear)
	
SET @Where = 'WHERE HT03.DivisionID = ''' + @DivisionID + ''' And HT03.DepartmentID like ''' + @DepartmentID + '''
			AND Isnull(HT03.TeamID,'''') like ''' + @TeamID + ''' AND HT03.TimesNo = ' + ltrim(@TimesNo) + ' AND Isnull(HT03.IsExamined,0) = 0 ' + @WhereTime

SET @Where1 = 'WHERE HT03.DivisionID = ''' + @DivisionID + ''' And HT03.DepartmentID like ''' + @DepartmentID + '''
			AND Isnull(HT03.TeamID,'''') like ''' + @TeamID + ''' AND HT03.TimesNo = ' + ltrim(@TimesNo - 1) + ' AND Isnull(HT03.IsExamined,0) = 1 AND Isnull(EndAmounts,0) <> 0 ' + @WhereTime

SELECT @BankAccountNo = BankAccountNo, @BankName = BankName FROM AT1016 
WHERE BankAccountID = (Select BankAccountID From HT0000 WHERE DivisionID = @DivisionID)
	
--- Phần 1: Danh sách hưởng chế độ mới phát sinh	
SET @SQL1 = N'SELECT * FROM (
			--- Chế độ ốm đau
			SELECT N''' + Isnull(@BankAccountNo,'') + ''' as BankAccountNo, N''' + Isnull(@BankName,'') + ''' as BankName, ''A'' as Group01ID, N''CHẾ ĐỘ ỐM ĐAU'' as Group01Name,
					HT03.EmployeeID, Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
					HT03.ConditionTypeID, HV0300.ConditionTypeName, HT00.IsMale, HT00.Birthday, HT03.SNo, HT03.InsuranceSalary, HT03.Amounts,
					
					(DATEDIFF(m,(Select Top 1 SBeginDate From HT2460 Where DivisionID = ''' + @DivisionID + ''' And EmployeeID = HT03.EmployeeID And SBeginDate <= HT03.VoucherDateFrom
								Order by SBeginDate DESC), dateadd(m,-1,HT03.VoucherDateFrom))) as InsuranceTime,
								
					HT03.WorkConditionTypeID,	
					(case HT03.WorkConditionTypeID when 0 then N''Điều kiện BT'' when 1 then N''Điều kiện NN-ĐH'' when 2 then N''KV 0,7'' end) as WorkConditionTypeName,
					HT03.ConditionNotes, (ltrim(Day(HT03.ChildBirthDate)) + ''/'' + ltrim(Month(HT03.ChildBirthDate)) + ''/'' + ltrim(Year(HT03.ChildBirthDate))) as Notes, HT03.VoucherDateFrom, HT03.VoucherDateTo, HT03.InLeaveDays,
					
					(SELECT SUM(Isnull(EndInLeaveDays,InLeaveDays)) FROM HT0308
					WHERE DivisionID = ''' + @DivisionID + ''' AND TranYear = HT03.TranYear AND VoucherDateFrom <= HT03.VoucherDateFrom AND EmployeeID = HT03.EmployeeID)
					+	ISNULL((SELECT sum(firstleaveday) FROM HT0308
						WHERE DivisionID = ''' + @DivisionID + ''' 
						and EmployeeID = HT03.EmployeeID and TranYear = HT03.TranYear AND VoucherDateFrom <= HT03.VoucherDateFrom),0) as BeginLeaveDays					
				
			FROM HT0308 HT03
			INNER JOIN HT1400 HT00 On HT03.DivisionID = HT00.DivisionID And HT03.EmployeeID = HT00.EmployeeID
			LEFT JOIN HV0300 On HT03.DivisionID = HV0300.DivisionID And HT03.ConditionTypeID = HV0300.ConditionTypeID And HV0300.TypeID = ''H04'' ' + @Where + '
					
			--- Chế độ thai sản
			UNION
			SELECT N''' + Isnull(@BankAccountNo,'') + ''' as BankAccountNo, N''' + Isnull(@BankName,'') + ''' as BankName, ''B'' as Group01ID, N''CHẾ ĐỘ THAI SẢN'' as Group01Name,
					HT03.EmployeeID, Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
					HT03.ConditionTypeID, HV0300.ConditionTypeName, HT00.IsMale, HT00.Birthday, HT03.SNo, HT03.InsuranceSalary, HT03.Amounts,
					
					(case when (DATEDIFF(m,(Select Top 1 SBeginDate From HT2460 Where DivisionID = ''' + @DivisionID + ''' And EmployeeID = HT03.EmployeeID And SBeginDate <= HT03.VoucherDate
								Order by SBeginDate DESC), HT03.VoucherDate)) > 12 then 12
								else (DATEDIFF(m,(Select Top 1 SBeginDate From HT2460 Where DivisionID = ''' + @DivisionID + ''' And EmployeeID = HT03.EmployeeID And SBeginDate <= HT03.VoucherDate
								Order by SBeginDate DESC), HT03.VoucherDate)) end) as InsuranceTime,
								
					HT03.ConditionTypeID as WorkConditionTypeID,
					HV0300.ConditionTypeName as WorkConditionTypeName,
					HT03.ConditionNotes, HT03.Notes, HT03.VoucherDate as VoucherDateFrom, dateadd(d,HT03.InLeaveDays-1,HT03.VoucherDate) as VoucherDateTo, HT03.InLeaveDays,
					
					(SELECT SUM(Isnull(EndInLeaveDays,InLeaveDays)) FROM HT0315
					WHERE DivisionID = ''' + @DivisionID + ''' AND TranYear = HT03.TranYear AND VoucherDate <= HT03.VoucherDate AND EmployeeID = HT03.EmployeeID) 
					+	ISNULL((SELECT sum(firstleaveday) FROM HT0315
						WHERE DivisionID = ''' + @DivisionID + ''' 
						and EmployeeID = HT03.EmployeeID and TranYear = HT03.TranYear AND VoucherDate <= HT03.VoucherDate),0) as BeginLeaveDays					
				
			FROM HT0315 HT03
			INNER JOIN HT1400 HT00 On HT03.DivisionID = HT00.DivisionID And HT03.EmployeeID = HT00.EmployeeID
			LEFT JOIN HV0300 On HT03.DivisionID = HV0300.DivisionID And HT03.ConditionTypeID = HV0300.ConditionTypeID And HV0300.TypeID = ''H02'' ' + @Where
			
			SET @SQL2 = N'
			--- Chế độ dưỡng sức PHSK sau ốm đau
			UNION
			SELECT N''' + Isnull(@BankAccountNo,'') + ''' as BankAccountNo, N''' + Isnull(@BankName,'') + ''' as BankName, ''C'' as Group01ID, N''Nghỉ DS sau ốm đau'' as Group01Name,
					HT03.EmployeeID, Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
					(case when Isnull(HT03.HomeDays,0) <> 0 then 0 else 1 end) as ConditionTypeID, (case when Isnull(HT03.HomeDays,0) <> 0 then N''Nghỉ tại gia đình'' else N''Nghỉ tập trung'' end) as ConditionTypeName,
					HT00.IsMale, HT00.Birthday, HT03.SNo, (case when Isnull(HT03.HomeDays,0) = 0 then 40 else 25 end) as InsuranceSalary, HT03.Amounts,
					NULL as InsuranceTime,
					
					HT03.ConditionTypeID as WorkConditionTypeID,
					HV0300.ConditionTypeName as WorkConditionTypeName,
					NULL as ConditionNotes, HT03.Notes, HT03.LeaveFromDate as VoucherDateFrom, HT03.LeaveToDate as VoucherDateTo, (Isnull(HT03.HomeDays,0) + Isnull(HT03.HealthCenterDays,0)) as InLeaveDays,
					
					(SELECT SUM(Isnull(EndInLeaveDays,Isnull(HomeDays,0) + Isnull(HealthCenterDays,0))) FROM HT0312
					WHERE DivisionID = ''' + @DivisionID + ''' AND TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate AND EmployeeID = HT03.EmployeeID) 
					+	ISNULL((SELECT sum(firstleaveday) FROM HT0312
						WHERE DivisionID = ''' + @DivisionID + ''' 
						and EmployeeID = HT03.EmployeeID and TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate),0) as BeginLeaveDays					
				
			FROM HT0312 HT03
			INNER JOIN HT1400 HT00 On HT03.DivisionID = HT00.DivisionID And HT03.EmployeeID = HT00.EmployeeID
			LEFT JOIN HV0300 On HT03.DivisionID = HV0300.DivisionID And HT03.ConditionTypeID = HV0300.ConditionTypeID And HV0300.TypeID = ''H03'' ' + @Where + '			
							
			--- Chế độ dưỡng sức PHSK sau thai sản
			UNION
			SELECT N''' + Isnull(@BankAccountNo,'') + ''' as BankAccountNo, N''' + Isnull(@BankName,'') + ''' as BankName, ''D'' as Group01ID, N''Nghỉ DS sau thai sản'' as Group01Name,
					HT03.EmployeeID, Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
					(case when Isnull(HT03.HomeDays,0) <> 0 then 0 else 1 end) as ConditionTypeID, (case when Isnull(HT03.HomeDays,0) <> 0 then N''Nghỉ tại gia đình'' else N''Nghỉ tập trung'' end) as ConditionTypeName,
					HT00.IsMale, HT00.Birthday, HT03.SNo, (case when Isnull(HT03.HomeDays,0) = 0 then 40 else 25 end) as InsuranceSalary, HT03.Amounts,
					NULL as InsuranceTime,
					
					HT03.ConditionTypeID as WorkConditionTypeID,
					HV0300.ConditionTypeName as WorkConditionTypeName,
					NULL as ConditionNotes, HT03.Notes, HT03.LeaveFromDate as VoucherDateFrom, HT03.LeaveToDate as VoucherDateTo, (Isnull(HT03.HomeDays,0) + Isnull(HT03.HealthCenterDays,0)) as InLeaveDays,
					
					(SELECT SUM(Isnull(EndInLeaveDays,Isnull(HomeDays,0) + Isnull(HealthCenterDays,0))) FROM HT0310
					WHERE DivisionID = ''' + @DivisionID + ''' AND TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate AND EmployeeID = HT03.EmployeeID) 
					+	ISNULL((SELECT sum(firstleaveday) FROM HT0310
						WHERE DivisionID = ''' + @DivisionID + ''' 
						and EmployeeID = HT03.EmployeeID and TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate),0) as BeginLeaveDays
					
			FROM HT0310 HT03
			INNER JOIN HT1400 HT00 On HT03.DivisionID = HT00.DivisionID And HT03.EmployeeID = HT00.EmployeeID
			LEFT JOIN HV0300 On HT03.DivisionID = HV0300.DivisionID And HT03.ConditionTypeID = HV0300.ConditionTypeID And HV0300.TypeID = ''H01'' ' + @Where
			
			SET @SQL3 = N'
			--- Chế độ dưỡng sức PHSK sau TNLĐ,bệnh nghề nghiệp
			UNION
			SELECT N''' + Isnull(@BankAccountNo,'') + ''' as BankAccountNo, N''' + Isnull(@BankName,'') + ''' as BankName, ''E'' as Group01ID, N''Nghỉ DS sau TNLĐ-BNN'' as Group01Name,
					HT03.EmployeeID, Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
					(case when Isnull(HT03.HomeDays,0) <> 0 then 0 else 1 end) as ConditionTypeID, (case when Isnull(HT03.HomeDays,0) <> 0 then N''Nghỉ tại gia đình'' else N''Nghỉ tập trung'' end) as ConditionTypeName,
					HT00.IsMale, HT00.Birthday, HT03.SNo, (case when Isnull(HT03.HomeDays,0) = 0 then 40 else 25 end) as InsuranceSalary, HT03.Amounts,
					NULL as InsuranceTime, '''' as WorkConditionTypeID, ltrim(cast(HT03.DecayRate as int)) + ''%'' as WorkConditionTypeName,
					NULL as ConditionNotes, HT03.Notes, HT03.LeaveFromDate as VoucherDateFrom, HT03.LeaveToDate as VoucherDateTo, (Isnull(HT03.HomeDays,0) + Isnull(HT03.HealthCenterDays,0)) as InLeaveDays,
					
					(SELECT SUM(Isnull(EndInLeaveDays,Isnull(HomeDays,0) + Isnull(HealthCenterDays,0))) FROM HT0301
					WHERE DivisionID = ''' + @DivisionID + ''' AND TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate AND EmployeeID = HT03.EmployeeID) 
					+	ISNULL((SELECT sum(firstleaveday) FROM HT0301
						WHERE DivisionID = ''' + @DivisionID + ''' 
						and EmployeeID = HT03.EmployeeID and TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate),0) as BeginLeaveDays
				
			FROM HT0301 HT03
			INNER JOIN HT1400 HT00 On HT03.DivisionID = HT00.DivisionID And HT03.EmployeeID = HT00.EmployeeID ' + @Where + '
			) A ' + @Orderby			

EXEC(@SQL1 + @SQL2 + @SQL3)

--- Phần 2: Danh sách điều chỉnh số đã được thanh toán trong đợt xét duyệt trước
SET @SQL1 = N'SELECT * FROM (
			--- Chế độ ốm đau
			SELECT ''A'' as Group01ID, N''CHẾ ĐỘ ỐM ĐAU'' as Group01Name,
					HT03.EmployeeID, Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
					HT03.ConditionTypeID, HV0300.ConditionTypeName, HT00.IsMale, HT00.Birthday, HT03.SNo, HT03.Reason,
					(''0'' + ltrim(HT03.TimesNo) + ''/'' + (case when HT03.TranMonth < 10 then ''0'' else '''' end) + ltrim(HT03.TranMonth) + ''/'' + (case when ' + LTRIM(@IsQuarter) + '=1 then ''' + LEFT(@Quarter,2) + ''' else (Select left(Quarter,2) From HV9999 Where DivisionID = ''' + @DivisionID + ''' And TranMonth = HT03.TranMonth And TranYear = HT03.TranYear) end) + ''/'' + ltrim(HT03.TranYear)) as TimesNo,
					HT03.EndAmounts,(case when Isnull(HT03.EndAmounts,0) = 0 then 0 else HT03.EndAmounts - HT03.Amounts end) as DiffAmounts,
					(case when Isnull(HT03.EndInLeaveDays,0) = 0 then 0 else HT03.EndInLeaveDays - HT03.InLeaveDays end) as DiffLeaveDays,
					
					(SELECT SUM(Isnull(EndInLeaveDays,0)) FROM HT0308
					WHERE DivisionID = ''' + @DivisionID + ''' AND TranYear = HT03.TranYear AND VoucherDateFrom <= HT03.VoucherDateFrom AND EmployeeID = HT03.EmployeeID) 
					+	ISNULL((SELECT sum(firstleaveday) FROM HT0308
						WHERE DivisionID = ''' + @DivisionID + ''' 
						and EmployeeID = HT03.EmployeeID and TranYear = HT03.TranYear AND VoucherDateFrom <= HT03.VoucherDateFrom),0) as BeginLeaveDays
					
			FROM HT0308 HT03
			INNER JOIN HT1400 HT00 On HT03.DivisionID = HT00.DivisionID And HT03.EmployeeID = HT00.EmployeeID
			LEFT JOIN HV0300 On HT03.DivisionID = HV0300.DivisionID And HT03.ConditionTypeID = HV0300.ConditionTypeID And HV0300.TypeID = ''H04'' ' + @Where1 + '
			
			UNION
			--- Chế độ thai sản
			SELECT ''B'' as Group01ID, N''CHẾ ĐỘ THAI SẢN'' as Group01Name,
					HT03.EmployeeID, Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
					HT03.ConditionTypeID, HV0300.ConditionTypeName, HT00.IsMale, HT00.Birthday, HT03.SNo, HT03.Reason,
					(''0'' + ltrim(HT03.TimesNo) + ''/'' + (case when HT03.TranMonth < 10 then ''0'' else '''' end) + ltrim(HT03.TranMonth) + ''/'' + (case when ' + LTRIM(@IsQuarter) + '=1 then ''' + LEFT(@Quarter,2) + ''' else (Select left(Quarter,2) From HV9999 Where DivisionID = ''' + @DivisionID + ''' And TranMonth = HT03.TranMonth And TranYear = HT03.TranYear) end) + ''/'' + ltrim(HT03.TranYear)) as TimesNo,
					HT03.EndAmounts,(case when Isnull(HT03.EndAmounts,0) = 0 then 0 else HT03.EndAmounts - HT03.Amounts end) as DiffAmounts,
					(case when Isnull(HT03.EndInLeaveDays,0) = 0 then 0 else HT03.EndInLeaveDays - HT03.InLeaveDays end) as DiffLeaveDays,
					
					(SELECT SUM(Isnull(EndInLeaveDays,0)) FROM HT0315
					WHERE DivisionID = ''' + @DivisionID + ''' AND TranYear = HT03.TranYear AND VoucherDate <= HT03.VoucherDate AND EmployeeID = HT03.EmployeeID) 
					+	ISNULL((SELECT sum(firstleaveday) FROM HT0315
						WHERE DivisionID = ''' + @DivisionID + ''' 
						and EmployeeID = HT03.EmployeeID and TranYear = HT03.TranYear AND VoucherDate <= HT03.VoucherDate),0) as BeginLeaveDays
					
			FROM HT0315 HT03
			INNER JOIN HT1400 HT00 On HT03.DivisionID = HT00.DivisionID And HT03.EmployeeID = HT00.EmployeeID
			LEFT JOIN HV0300 On HT03.DivisionID = HV0300.DivisionID And HT03.ConditionTypeID = HV0300.ConditionTypeID And HV0300.TypeID = ''H02'' ' + @Where1
			
SET @SQL2 = N'--- Chế độ dưỡng sức PHSK sau ốm đau
			UNION
			SELECT ''C'' as Group01ID, N''DƯỠNG SỨC PHỤC HỒI SỨC KHỎE SAU ỐM ĐAU'' as Group01Name,
					HT03.EmployeeID, Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
					(case when Isnull(HT03.HomeDays,0) <> 0 then 0 else 1 end) as ConditionTypeID, (case when Isnull(HT03.HomeDays,0) <> 0 then N''Nghỉ tại gia đình'' else N''Nghỉ tập trung'' end) as ConditionTypeName,
					HT00.IsMale, HT00.Birthday, HT03.SNo, HT03.Reason,
					(''0'' + ltrim(HT03.TimesNo) + ''/'' + (case when HT03.TranMonth < 10 then ''0'' else '''' end) + ltrim(HT03.TranMonth) + ''/'' + (case when ' + LTRIM(@IsQuarter) + '=1 then ''' + LEFT(@Quarter,2) + ''' else (Select left(Quarter,2) From HV9999 Where DivisionID = ''' + @DivisionID + ''' And TranMonth = HT03.TranMonth And TranYear = HT03.TranYear) end) + ''/'' + ltrim(HT03.TranYear)) as TimesNo,
					HT03.EndAmounts,(case when Isnull(HT03.EndAmounts,0) = 0 then 0 else HT03.EndAmounts - HT03.Amounts end) as DiffAmounts,
					(case when Isnull(HT03.EndInLeaveDays,0) = 0 then 0 else HT03.EndInLeaveDays - (Isnull(HT03.HomeDays,0) + Isnull(HT03.HealthCenterDays,0)) end) as DiffLeaveDays,
					
					(SELECT SUM(Isnull(EndInLeaveDays,0)) FROM HT0312
					WHERE DivisionID = ''' + @DivisionID + ''' AND TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate AND EmployeeID = HT03.EmployeeID) 
					+ ISNULL((SELECT sum(firstleaveday) FROM HT0312
						WHERE DivisionID = ''' + @DivisionID + ''' 
						and EmployeeID = HT03.EmployeeID and TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate),0) as BeginLeaveDays
					
			FROM HT0312 HT03
			INNER JOIN HT1400 HT00 On HT03.DivisionID = HT00.DivisionID And HT03.EmployeeID = HT00.EmployeeID
			LEFT JOIN HV0300 On HT03.DivisionID = HV0300.DivisionID And HT03.ConditionTypeID = HV0300.ConditionTypeID And HV0300.TypeID = ''H03'' ' + @Where1 + '			
			
			--- Chế độ dưỡng sức PHSK sau thai sản
			UNION
			SELECT ''D'' as Group01ID, N''DƯỠNG SỨC PHỤC HỒI SỨC KHỎE SAU THAI SẢN'' as Group01Name,
					HT03.EmployeeID, Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
					(case when Isnull(HT03.HomeDays,0) <> 0 then 0 else 1 end) as ConditionTypeID, (case when Isnull(HT03.HomeDays,0) <> 0 then N''Nghỉ tại gia đình'' else N''Nghỉ tập trung'' end) as ConditionTypeName,
					HT00.IsMale, HT00.Birthday, HT03.SNo, HT03.Reason,
					(''0'' + ltrim(HT03.TimesNo) + ''/'' + (case when HT03.TranMonth < 10 then ''0'' else '''' end) + ltrim(HT03.TranMonth) + ''/'' + (case when ' + LTRIM(@IsQuarter) + '=1 then ''' + LEFT(@Quarter,2) + ''' else (Select left(Quarter,2) From HV9999 Where DivisionID = ''' + @DivisionID + ''' And TranMonth = HT03.TranMonth And TranYear = HT03.TranYear) end) + ''/'' + ltrim(HT03.TranYear)) as TimesNo,
					HT03.EndAmounts,(case when Isnull(HT03.EndAmounts,0) = 0 then 0 else HT03.EndAmounts - HT03.Amounts end) as DiffAmounts,
					(case when Isnull(HT03.EndInLeaveDays,0) = 0 then 0 else HT03.EndInLeaveDays - (Isnull(HT03.HomeDays,0) + Isnull(HT03.HealthCenterDays,0)) end) as DiffLeaveDays,
					
					(SELECT SUM(Isnull(EndInLeaveDays,0)) FROM HT0310
					WHERE DivisionID = ''' + @DivisionID + ''' AND TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate AND EmployeeID = HT03.EmployeeID)
					+	ISNULL((SELECT sum(firstleaveday) FROM HT0310
						WHERE DivisionID = ''' + @DivisionID + ''' 
						and EmployeeID = HT03.EmployeeID and TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate),0) as BeginLeaveDays
					
			FROM HT0310 HT03
			INNER JOIN HT1400 HT00 On HT03.DivisionID = HT00.DivisionID And HT03.EmployeeID = HT00.EmployeeID
			LEFT JOIN HV0300 On HT03.DivisionID = HV0300.DivisionID And HT03.ConditionTypeID = HV0300.ConditionTypeID And HV0300.TypeID = ''H01'' ' + @Where1
			
			SET @SQL3 = N'
			--- Chế độ dưỡng sức PHSK sau TNLĐ,bệnh nghề nghiệp
			UNION
			SELECT ''E'' as Group01ID, N''DƯỠNG SỨC PHỤC HỒI SỨC KHỎE SAU TNLĐ-BNN'' as Group01Name,
					HT03.EmployeeID, Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
					(case when Isnull(HT03.HomeDays,0) <> 0 then 0 else 1 end) as ConditionTypeID, (case when Isnull(HT03.HomeDays,0) <> 0 then N''Nghỉ tại gia đình'' else N''Nghỉ tập trung'' end) as ConditionTypeName,
					HT00.IsMale, HT00.Birthday, HT03.SNo, HT03.Reason,
					(''0'' + ltrim(HT03.TimesNo) + ''/'' + (case when HT03.TranMonth < 10 then ''0'' else '''' end) + ltrim(HT03.TranMonth) + ''/'' + (case when ' + LTRIM(@IsQuarter) + '=1 then ''' + LEFT(@Quarter,2) + ''' else (Select left(Quarter,2) From HV9999 Where DivisionID = ''' + @DivisionID + ''' And TranMonth = HT03.TranMonth And TranYear = HT03.TranYear) end) + ''/'' + ltrim(HT03.TranYear)) as TimesNo,
					HT03.EndAmounts,(case when Isnull(HT03.EndAmounts,0) = 0 then 0 else HT03.EndAmounts - HT03.Amounts end) as DiffAmounts,
					(case when Isnull(HT03.EndInLeaveDays,0) = 0 then 0 else HT03.EndInLeaveDays - (Isnull(HT03.HomeDays,0) + Isnull(HT03.HealthCenterDays,0)) end) as DiffLeaveDays,
					
					(SELECT SUM(Isnull(EndInLeaveDays,0)) FROM HT0301
					WHERE DivisionID = ''' + @DivisionID + ''' AND TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate AND EmployeeID = HT03.EmployeeID) 
					+	ISNULL((SELECT sum(firstleaveday) FROM HT0301
						WHERE DivisionID = ''' + @DivisionID + ''' 
						and EmployeeID = HT03.EmployeeID and TranYear = HT03.TranYear AND LeaveFromDate <= HT03.LeaveFromDate),0) as BeginLeaveDays					
			FROM HT0301 HT03
			INNER JOIN HT1400 HT00 On HT03.DivisionID = HT00.DivisionID And HT03.EmployeeID = HT00.EmployeeID ' + @Where1 + '
			) A ' + @Orderby

EXEC(@SQL1 + @SQL2 + @SQL3)

--- Phần 3: Tổng hợp chi phí thanh toán			
SET @SQL1 = N'SELECT * FROM (
			--- Số tiền duyệt mới
			SELECT
			(Isnull((SELECT Sum(HT03.Amounts) From HT0308 HT03 ' + @Where + '),0) + Isnull((SELECT Sum(HT03.Amounts) From HT0315 HT03 ' + @Where + '),0) +
			Isnull((SELECT Sum(HT03.Amounts) From HT0312 HT03 ' + @Where + '),0) + Isnull((SELECT Sum(HT03.Amounts) From HT0310 HT03 ' + @Where + '),0) +
			Isnull((SELECT Sum(HT03.Amounts) From HT0301 HT03 ' + @Where + '),0)) as NewTotalAmounts,			
			
			(Isnull((SELECT Sum(Isnull(HT03.EndAmounts,0)) - Sum(Isnull(HT03.Amounts,0)) From HT0308 HT03 ' + @Where1 + '),0) + Isnull((SELECT Sum(Isnull(HT03.EndAmounts,0)) - Sum(Isnull(HT03.Amounts,0)) From HT0315 HT03 ' + @Where1 + '),0) +
			Isnull((SELECT Sum(Isnull(HT03.EndAmounts,0)) - Sum(Isnull(HT03.Amounts,0)) From HT0312 HT03 ' + @Where1 + '),0) + Isnull((SELECT Sum(Isnull(HT03.EndAmounts,0)) - Sum(Isnull(HT03.Amounts,0)) From HT0310 HT03 ' + @Where1 + '),0) +
			Isnull((SELECT Sum(Isnull(HT03.EndAmounts,0)) - Sum(Isnull(HT03.Amounts,0)) From HT0301 HT03 ' + @Where1 + '),0)) as OldTotalAmounts
			
			) A'
EXEC(@SQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
