IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP7008_GOD]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP7008_GOD]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--Created by: Kim Thư, Date: 5/6/2019
---Purpose: In bao cao luong theo thiet lap cua nguoi dung - Godrej. Bổ sung Update các cột lương đóng BHXH
---Modified on 04/07/2019 by Hoàng Trúc: sửa điều kiện lấy số công (AbsentAmount) cho mã loại công (AbsentTypeID) CNN
---Modified on 25/02/2021 by Huỳnh Thử: bổ sung điều kiện lấy số công (AbsentAmount) tính ở bảng #tam lấy thêm loại công CCN20
---Modified on 15/07/2022 by Văn Tài  : Thay đổi cách lưu trữ bảng tạm.

-- Ex: EXEC HP7008_GOD @DivisionID=N'GOD',@ReportCode=N'TONGHOP',@FromDepartmentID=N'ADMIN-O',@ToDepartmentID=N'P-WELDING',@TeamID=N'%',@FromEmployeeID=N'BD01',@ToEmployeeID=N'BD01' , 
--		@FromMonth=7,@FromYear=2018,@ToMonth=3,@ToYear=2019,@lstPayrollMethodID=N'%', @lstEmployeeID=NULL,@StrDivisionID=N'GOD'

CREATE PROCEDURE [dbo].[HP7008_GOD]
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
        @PayrollMethodID nvarchar(50) ,
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
		@sTable VARCHAR(4000)

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

SET @sSQL0 = +'	SELECT DivisionID, EmployeeID, Notes as ShiftID, COUNT(EmployeeID) as Times, SUM(AbsentAmount) AS AbsentAmount,
						SUM(Case When LEFT(DATENAME(dw, Convert(date,AbsentDateFull,112)), 3) = ''SUN'' Then 1 Else 0 End) as Times_SUN
				INTO #TAM
				FROM
				(			
					SELECT A.DivisionID, A.EmployeeID, A.AbsentDate,NULL AS AbsentDateFull, A.ShiftID, HT1020.Notes,
						SUM(CASE WHEN A.AbsentTypeID IN (''CNN'',''CCN20'') AND A.AbsentHour > 5 THEN 8 
							ELSE CASE WHEN A.AbsentTypeID  IN (''CNN'',''CCN20'') AND A.AbsentHour <= 5 AND A.AbsentHour >= 3 THEN 4
								ELSE 0 END END) AS AbsentAmount
				FROM HT2407 A
				INNER JOIN HT1020 ON HT1020.DivisionID = A.DivisionID And HT1020.ShiftID = A.ShiftID
				Where A.DivisionID = ''' + @DivisionID + '''
				AND A.TranMonth + A.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) + '
				GROUP BY A.DivisionID, A.EmployeeID, A.AbsentDate, A.ShiftID, HT1020.Notes
				) B
				GROUP BY DivisionID, EmployeeID, Notes'	

SET @sSQL1 = ' Select HV3400.DivisionID, HV3400.DepartmentID,  T01.DepartmentName, IsNull(HV3400.TeamID,'''') as TeamID, 
				 IsNull(T11.TeamName,'''') as TeamName,
				HV3400.EmployeeID, HV3400.FullName, HV1400.IdentifyCardNo, HV1400.BankID, HT1008.BankName, HV1400.BankAccountNo,	
				IsNull(HV3400.DutyID,'''') as DutyID,
				 IsNull(DutyName,'''')   AS DutyName, HV3400.Orders, 0 as Groups, sum(Isnull(SA01,0)) as BaseSalary,
				 HV1400.Birthday, HV1400.PersonalTaxID, HV1400.WorkDate, HV1400.LeaveDate,
				 HV1400.EducationLevelID, HV1400.EducationLevelName, HV1400.MajorID, HT1004.MajorName, HV1400.ShortName, HV1400.Alias,
				 HV1400.ExpenseAccountID, HV1400.PayableAccountID, HV1400.PerInTaxID, HV3400.TranMonth, HV3400.TranYear,
				 HV1400.IdentifyDate, HV1400.IdentifyPlace, HV1400.ArmyLevel, HV3400.IsKeepSalary, HV3400.IsReceiveSalary, HV3400.Notes, HT1407.AbsentCardNo'

SET @sSQL1 = @sSQL1+', (Select AbsentAmount From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''1'') AS ShiftID01
					, (Select AbsentAmount From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''2'') AS ShiftID02
					, (Select AbsentAmount From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''3'') AS ShiftID03
					, (Select Times_SUN From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''1'') AS ShiftID01_SUN
					, (Select Times_SUN From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''2'') AS ShiftID02_SUN
					, (Select Times_SUN From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''3'') AS ShiftID03_SUN
					, T11.Notes as TeamNotes'


SET @sGroupBy = ' Group by HV3400.DivisionID, HV3400.DepartmentID,  T01.DepartmentName,  IsNull(T11.TeamName,''''), HV3400.EmployeeID, HV3400.Fullname,
			HV1400.IdentifyCardNo, HV1400.BankID, HT1008.BankName, HV1400.BankAccountNo,	
			 IsNull(HV3400.TeamID,''''), IsNull(HV3400.DutyID,'''') , IsNull(DutyName,''''), HV3400.Orders, HV1400.Birthday, HV1400.PersonalTaxID,
			 HV1400.WorkDate, HV1400.LeaveDate, HV1400.EducationLevelID, HV1400.EducationLevelName, HV1400.MajorID, HT1004.MajorName, HV1400.ShortName, HV1400.Alias,
			  HV1400.ExpenseAccountID, HV1400.PayableAccountID, HV1400.PerInTaxID, HV3400.TranMonth, HV3400.TranYear,
			  HV1400.IdentifyDate, HV1400.IdentifyPlace, HV1400.ArmyLevel, HV3400.IsKeepSalary, HV3400.IsReceiveSalary, HV3400.Notes, HT1407.AbsentCardNo, T11.Notes'


SET @sSQL2 = ' From HV3400 HV3400 
	left join AT1102 T01 on T01.DepartmentID = HV3400.DepartmentID 
	left join HT1101 T11 on T11.DivisionID = HV3400.DivisionID and T11.DepartmentID = HV3400.DepartmentID and IsNull(HV3400.TeamID,'''')=IsNull(T11.TeamID,'''')
	left join HV1400 on HV1400.EmployeeID = HV3400.EmployeeID And HV1400.DivisionID = HV3400.DivisionID
	left join HT1008 on HV1400.BankID = HT1008.BankID AND HV1400.DivisionID = HT1008.DivisionID
	left join HT1004 on HV1400.DivisionID = HT1004.DivisionID And HV1400.MajorID = HT1004.MajorID
	left join HT1407 WITH (NOLOCK) ON HV1400.DivisionID = HT1407.DivisionID and HV1400.EmployeeID = HT1407.EmployeeID
	Where HV3400.DivisionID '+@StrDivisionID_New+' and
	HV3400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + ''' and
	isnull(HV3400.TeamID,'''') like isnull(''' + @TeamID + ''', '''') and
	HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
	HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) + ' and
	PayrollMethodID ' + @PayrollMethodID  +	@sSQL_Where


DELETE  HT7110
DBCC CHECKIDENT ( HT7110,RESEED,0 )


EXEC (@sSQL0+ '
				Insert into HT7110  ( DivisionID,DepartmentID, DepartmentName, TeamID, TeamName, EmployeeID, FullName, IdentifyCardNo, BankID, BankName, BankAccountNo, 
				DutyID, DutyName, Orders, Groups, BaseSalary, Birthday, PersonalTaxID, WorkDate, LeaveDate, EducationLevelID, EducationLevelName, MajorID, MajorName,
				ShortName, Alias, ExpenseAccountID, PayableAccountID, PerInTaxID, TranMonth, TranYear, IdentifyDate, IdentifyPlace, ArmyLevel, IsKeepSalary, IsReceiveSalary, Notes_HT3400,
				AbsentCardNo, ShiftID01, ShiftID02, ShiftID03, ShiftID01_SUN, ShiftID02_SUN, ShiftID03_SUN, TeamNotes)
				'+@sSQL1+@sSQL2+@sGroupBy)

--select @sSQL0
--select @sSQL1
--select @sSQL2
--select @sGroupBy

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
				 HV3400.TranMonth, HV3400.TranYear, HT1407.AbsentCardNo
   '

	SET @sSQL1 = @sSQL1+', (Select AbsentAmount From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''1'') AS ShiftID01
					, (Select AbsentAmount From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''2'') AS ShiftID02
					, (Select AbsentAmount From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''3'') AS ShiftID03
					, (Select Times_SUN From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''1'') AS ShiftID01_SUN
					, (Select Times_SUN From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''2'') AS ShiftID02_SUN
					, (Select Times_SUN From #TAM Where DivisionID = HV3400.DivisionID And EmployeeID = HV3400.EmployeeID And ShiftID = ''3'') AS ShiftID03_SUN
					, HT1101.Notes as TeamNotes'
	
	
	SET @sSQL2 =' FROM
					HT2400 HV3400 
					INNER JOIN HV1400 ON  HV1400.EmployeeID = HV3400.EmployeeID AND HV1400.DivisionID = HV3400.DivisionID 
					INNER JOIN AT1102 ON  AT1102.DepartmentID = HV3400.DepartmentID 
					INNER JOIN HT1101 ON  HT1101.DivisionID = HV3400.DivisionID AND HT1101.DepartmentID = HV3400.DepartmentID AND HV3400.TeamID = HT1101.TeamID 
					LEFT JOIN HT1008 ON  HV1400.BankID = HT1008.BankID AND HV1400.DivisionID = HT1008.DivisionID 
					left join HT1004 ON HV1400.DivisionID = HT1004.DivisionID And HV1400.MajorID = HT1004.MajorID
					left join HT1407 WITH (NOLOCK) ON HV1400.DivisionID = HT1407.DivisionID and HV1400.EmployeeID = HT1407.EmployeeID
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
		IdentifyDate, IdentifyPlace, ArmyLevel, TranMonth, TranYear, AbsentCardNo, ShiftID01, ShiftID02, ShiftID03, ShiftID01_SUN, ShiftID02_SUN, ShiftID03_SUN,TeamNotes) ' + @sSQL1 + @sSQL2)

--select @sSQL0 + @sSQL1 + @sSQL2
--select @sSQL0
--select @sSQL1
--select @sSQL2

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

SET @cur = CURSOR SCROLL KEYSET FOR 
	SELECT DISTINCT
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
    FROM HT4712
    WHERE ReportCode = @ReportCode AND DivisionID IN (SELECT DivisionID FROM DivTable) AND IsNull(IsTotal , 0) = 0
	ORDER BY  ColumnID

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
							PayrollMethodID ' + @PayrollMethodID + @sSQL_Where  ---+ @sWHERE	
										
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
									SUM(' + @ColumnAmount + ') AS VAT
							FROM	HT0338  HV3400
							WHERE	HV3400.DivisionID '+@StrDivisionID_New+' and
									HV3400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + ''' and
									HV3400.TranMonth + HV3400.TranYear*100 between ' + CAST(@FromMonth + @FromYear * 100 AS nvarchar(10)) + ' and ' + CAST(@ToMonth + @ToYear * 100 AS nvarchar(10)) +
										+ @sWHERE + @sSQL_Where + '
							GROUP BY DivisionID, EmployeeID, HV3400.TranMonth, HV3400.TranYear
					 		) HT0338 
					ON		HT7110.DivisionID = HT0338.DivisionID AND 
							HT7110.EmployeeID = HT0338.EmployeeID'
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
		PayrollMethodID ' + @PayrollMethodID  + @sSQL_Where
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

DELETE  HT7110
WHERE  isnull(ColumnAmount01 , 0) = 0 AND isnull(ColumnAmount02 , 0) = 0 AND isnull(ColumnAmount03 , 0) = 0 AND isnull(ColumnAmount04 , 0) = 0 
AND isnull(ColumnAmount05 , 0) = 0 AND isnull(ColumnAmount06 , 0) = 0 AND isnull(ColumnAmount07 , 0) = 0 AND isnull(ColumnAmount08 , 0) = 0 
AND isnull(ColumnAmount09 , 0) = 0 AND isnull(ColumnAmount10 , 0) = 0 AND isnull(ColumnAmount11 , 0) = 0 AND isnull(ColumnAmount12 , 0) = 0 
AND isnull(ColumnAmount13 , 0) = 0 AND isnull(ColumnAmount14 , 0) = 0 AND isnull(ColumnAmount15 , 0) = 0 AND isnull(ColumnAmount16 , 0) = 0 
AND isnull(ColumnAmount17 , 0) = 0 AND isnull(ColumnAmount18 , 0) = 0 AND isnull(ColumnAmount19 , 0) = 0 AND isnull(ColumnAmount20 , 0) = 0 
AND isnull(ColumnAmount21 , 0) = 0 AND isnull(ColumnAmount22 , 0) = 0 AND isnull(ColumnAmount23 , 0) = 0 AND isnull(ColumnAmount24 , 0) = 0 
AND isnull(ColumnAmount25 , 0) = 0 AND isnull(ColumnAmount26 , 0) = 0 AND isnull(ColumnAmount27 , 0) = 0 AND isnull(ColumnAmount28 , 0) = 0 
AND isnull(ColumnAmount29 , 0) = 0 AND isnull(ColumnAmount30 , 0) = 0 AND isnull(ColumnAmount31 , 0) = 0 AND isnull(ColumnAmount32 , 0) = 0 
AND isnull(ColumnAmount33 , 0) = 0 AND isnull(ColumnAmount34 , 0) = 0 AND isnull(ColumnAmount35 , 0) = 0 AND isnull(ColumnAmount36 , 0) = 0 
AND isnull(ColumnAmount37 , 0) = 0 AND isnull(ColumnAmount38 , 0) = 0 AND isnull(ColumnAmount39 , 0) = 0 AND isnull(ColumnAmount40 , 0) = 0 
AND isnull(ColumnAmount41 , 0) = 0 AND isnull(ColumnAmount42 , 0) = 0 AND isnull(ColumnAmount43 , 0) = 0 AND isnull(ColumnAmount44 , 0) = 0 
AND isnull(ColumnAmount45 , 0) = 0 AND isnull(ColumnAmount46 , 0) = 0 AND isnull(ColumnAmount47 , 0) = 0 AND isnull(ColumnAmount48 , 0) = 0 
AND isnull(ColumnAmount49 , 0) = 0 AND isnull(ColumnAmount50 , 0) = 0

DELETE #HP7008Emp
DROP TABLE DivTable

-- Update các cột lương đóng BHXH
DECLARE @i INT

SELECT ROW_NUMBER() OVER (ORDER BY (TranMonth + TranYear * 100)) AS OrderID, TranMonth + TranYear * 100 AS Period, MonthYear INTO #PERIOD 
FROM HV9999
WHERE DivisionID = @DivisionID AND TranMonth + TranYear * 100 BETWEEN 201807 AND 201903

SET @sSQL0='
	UPDATE HT7110
	SET InCome25_1 = (SELECT InCome25 FROM HT3400 WITH(NOLOCK) WHERE TranMonth = '+LTRIM(@FromMonth)+' AND TranYear = '+LTRIM(@FromYear)+' AND EmployeeID = HT7110.EmployeeID)
'
SET @i=2
WHILE @i<=(SELECT MAX(OrderID) FROM #PERIOD)
BEGIN
	SET @sSQL0=@sSQL0+'
		, InCome25_'+LTRIM(@i)+' = (SELECT InCome25 FROM HT3400 WITH(NOLOCK) WHERE TranMonth+TranYear*100 = (SELECT T1.Period FROM #PERIOD T1 WHERE T1.OrderID = '+ltrim(@i)+')
										AND EmployeeID = HT7110.EmployeeID)
	'
	SET @i=@i+1
END

exec (@sSQL0)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
