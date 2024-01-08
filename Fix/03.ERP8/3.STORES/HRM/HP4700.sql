IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP4700]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP4700]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created  Date 21/09/2005
----- Purpose: Tra ra gia tri
----- Edit by: Dang Le Bao Quynh; Date 29/01/2007
----- Purpose: Thiet lap them dieu kien ky luong
----- Modified on 06/01/2014 by Le Thi Thu Hien : Bo sung them I21 đến I30
----- Modified on 18/06/2014 by Le Thi Thu Hien : Bo sung them Thuế TNCN
----- Modified on 11/06/2018 by Bảo Anh: Bổ sung thêm các khoản thu nhập và giảm trừ tới 99 khoản
----- Modified on 12/11/2018 by Kim Thư: Bổ sung trường hợp hệ số lương C26 -> C31 TableName = 'HT2499'
-----									Bổ sung các khoản giảm trừ từ SubAmount21 -> SubAmount99 bảng HT3499
----- Modified on 27/11/2018 by Bảo Anh: Bổ sung các khoản bảo hiểm cty đóng
----- Modified on 03/12/2018 by Bảo Anh: Sửa lỗi lấy sai table cho các khoản thu nhập/giảm trừ thuộc HT3499
----- Modified on 17/07/2023 by Nhựt Trường: [2023/07/IS/0183] - Fix lỗi sai cú pháp ở các câu điều kiện khi lấy thu nhập và giảm trừ.
/**********************************************
** Edited by: [GS] [Cẩm Loan] [02/08/2010]
***********************************************/

CREATE PROCEDURE [dbo].[HP4700] 
		@DivisionID nvarchar(50),
		@Level1 as nvarchar(400),
		@Type as nvarchar(50),
		@lstPayrollMethodID nvarchar(2000),
		@LevelColumn1 as nvarchar(4000) OUTPUT,
		@TableName as nvarchar(4000) OUTPUT,
		@SWHERE nvarchar(4000) OUTPUT

		
AS
DECLARE @sSQL nvarchar(4000),
		@Orders int,
		@cur as cursor,
		@PeriodID nvarchar(50),
		@Level1Number int

IF @Type IN ('IO','SU')
BEGIN
	SET @Level1Number = CONVERT(INT,RIGHT(@Level1,CONVERT(NVARCHAR(50),LEN(@Level1) - 1)))
END
		
Select @lstPayrollMethodID = case when @lstPayrollMethodID = '%' then  ' like ''' + @lstPayrollMethodID + ''''  else ' in (''' + replace(@lstPayrollMethodID, ',',''',''') + ''')' end , @sWHERE = ''
IF ltrim(rtrim(@Level1)) = '' OR @Level1 IS NULL
    BEGIN
	SELECT @LevelColumn1 = NULL
	RETURN
    END

--------------------thu nhap
IF @Level1Number >= '01' AND @Level1Number <= '99' and @Type = 'IO'		
    BEGIN
		SELECT @LevelColumn1 = 'Income'+ right(@Level1,2), @TableName = 'HT3400'
		RETURN
    END

IF @Level1Number >= '100' and @Type = 'IO'		
    BEGIN
		SELECT @LevelColumn1 = 'Income'+ right(@Level1,3), @TableName = 'HT3400'
		RETURN
    END

--------------------giam tru
IF @Level1Number >= '00' AND @Level1Number <= '99' and @Type =	'SU'	
	BEGIN
		SELECT @LevelColumn1 = 'SubAmount'+ right(@Level1,2),  @TableName = 'HT3400'
		RETURN
	END

IF @Level1Number >= '100' and @Type =	'SU'	
	BEGIN
		SELECT @LevelColumn1 = 'SubAmount'+ right(@Level1,3),  @TableName = 'HT3400'
		RETURN
	END

--------------------HE SO

IF (@Level1 in (Select CoefficientID From HV1111 Where CoefficientID Between 'C01' and 'C25' or CoefficientID in ('DutyCoefficient','SalaryCoefficient','TimeCoefficient')))  and @Type = 'CO'		
	BEGIN
		SELECT @LevelColumn1 = @Level1, @TableName = 'HT2400'
		RETURN
	END

IF (@Level1 in (Select CoefficientID From HV1111 Where CoefficientID Between 'C26' and 'C31'))  and @Type = 'CO'		
	BEGIN
		SELECT @LevelColumn1 = @Level1, @TableName = 'HT2499'
		RETURN
	END

--------------------HE SO CHUNG

/*IF (@Level1 in (Select GeneralAbsentID From HT5002))  and @Type = 'GC'		
    BEGIN
	SET @sSQL = '
		Select  HT5005.PayrollMethodID, Max(Right(IncomeID, 2)) as Orders, count(DepartmentID) as DepartmentAmount 
			From HT5005  inner join HT5004 on HT5005.PayrollMethodID = HT5004.PayrollMethodID			
		WHERE HT5005.PayrollMethodID ' + @lstPayrollMethodID + ' and GeneralCoID = ''' + @Level1 + '''
		GROUP BY HT5005.PayrollMethodID
		UNION
		Select  HT5006.PayrollMethodID,  20 + Max(Right(IncomeID, 2)) as Orders, count(DepartmentID) as DepartmentAmount 
			From HT5006  inner join HT5004 on HT5006.PayrollMethodID = HT5004.PayrollMethodID
		WHERE HT5006.PayrollMethodID ' + @lstPayrollMethodID + ' and GeneralCoID = ''' + @Level1 + '''
		GROUP BY HT5006.PayrollMethodID'

	IF exists (Select Top 1 1 From SysObjects Where XType = 'V' and Name = 'HV4700')
		DROP VIEW HV4700
	EXEC('CREATE  VIEW HV4700 --Tao boi HP4700
			as ' + @sSQL)
	IF exists (Select Top 1 1 From HV4700)
	SELECT @LevelColumn1 = 'IGAbsentAmount'  + cast((Select Top 1 Orders From HV4700 Order by DepartmentAmount desc) as varchar(2)),
			@TableName = 'HT3400'
	ELSE 
		Set @LevelColumn1 = 0 
	RETURN
    END

*/

-------------------MUC LUONG
IF @Level1 in (Select FieldID from HV1112 WHERE DivisionID = @DivisionID) and @Type = 'SA'	 and @Level1 <> 'SA02'
    BEGIN
	SELECT @LevelColumn1 = BaseSalaryFieldID, @TableName = 'HT2400'
	From HV1112 Where 	@Level1 = FieldID AND DivisionID = @DivisionID
	RETURN
    END
IF @Level1 in (Select FieldID from HV1112 WHERE DivisionID = @DivisionID) and @Type = 'SA'	 and @Level1 = 'SA02'
    BEGIN
	SELECT @LevelColumn1 = BaseSalaryFieldID, @TableName = 'HT2460'
	From HV1112 Where 	@Level1 = FieldID AND DivisionID = @DivisionID
	RETURN
    END



-------------------NGAY CONG TONG HOP
IF  @Type = 'GA'
       BEGIN
	SET @sSQL = '
		Select  HT5005.DivisionID, HT5005.PayrollMethodID, Min(Right(IncomeID, 2)) as Orders, count(DepartmentID) as DepartmentAmount 
		From HT5005  
		inner join HT5004 on HT5005.PayrollMethodID = HT5004.PayrollMethodID And 	HT5005.DivisionID = HT5004.DivisionID	
		WHERE HT5005.PayrollMethodID ' + @lstPayrollMethodID + ' 
				and GeneralAbsentID = ''' + @Level1 + ''' 
				AND HT5005.DivisionID = '''+@DivisionID+'''
		GROUP BY HT5005.DivisionID, HT5005.PayrollMethodID
		UNION
		Select  HT5006.DivisionID, HT5006.PayrollMethodID,  20 + Min(Right(SubID, 2)) as Orders, count(DepartmentID) as DepartmentAmount 
			From HT5006  inner join HT5004 on HT5006.PayrollMethodID = HT5004.PayrollMethodID and HT5006.DivisionID = HT5004.DivisionID
		WHERE HT5006.PayrollMethodID ' + @lstPayrollMethodID + ' and GeneralAbsentID = ''' + @Level1 + ''' 
		AND HT5006.DivisionID = '''+@DivisionID+'''
		GROUP BY HT5006.DivisionID, HT5006.PayrollMethodID'


	IF exists (Select Top 1 1 From SysObjects Where XType = 'V' and Name = 'HV4700')
		DROP VIEW HV4700

	EXEC('CREATE  VIEW HV4700 --Tao boi HP4700
			as ' + @sSQL)

	IF exists (Select Top 1 1 From HV4700 WHERE DivisionID = @DivisionID)
		BEGIN
		Select  @sWHERE =' and  PayrollMethodID=''' + PayrollMethodID + '''', @Orders = Orders  From HV4700 
		WHERE DivisionID = @DivisionID
		Order by DepartmentAmount desc

		SELECT @LevelColumn1 = 'IGAbsentAmount'  + 
			case when @Orders< 10 then '0' else '' end  + cast(@Orders  as varchar(10)) ,
				@TableName = 'HT3400'
		END
	ELSE 
		Set @LevelColumn1 = '0'

	RETURN


    END

-------------------NGAY CONG THANG
IF @Type = 'MA' 
    BEGIN
	SELECT @LevelColumn1 ='AbsentAmount', @TableName = 'HT2402'
	If exists (Select Top 1 1 From HT6666)
	Begin
		SET  @sWHERE = ''
		SET @sSQL = 'Select distinct PeriodID, DivisionID From HT5002 Where GeneralAbsentID In (' + 
		'Select distinct GeneralAbsentID from ht5005
		Where GeneralAbsentID is not null and GeneralAbsentID <> '''' 
		AND DivisionID = '''+@DivisionID+''' 
		and  PayrollMethodID ' + @lstPayrollMethodID + 		
		' Union All 
		Select distinct GeneralAbsentID from ht5006
		Where GeneralAbsentID is not null and GeneralAbsentID <> '''' 
		AND DivisionID = '''+@DivisionID+'''
		and  PayrollMethodID ' + @lstPayrollMethodID + ') And PeriodID Is Not Null And PeriodID <> '''' '

		
		IF exists (Select Top 1 1 From SysObjects Where XType = 'V' and Name = 'HV4701')
		DROP VIEW HV4701
		EXEC('CREATE  VIEW HV4701 --Tao boi HP4700
			as ' + @sSQL)
		
		Set @cur = Cursor Static For
		Select PeriodID From HV4701 WHERE DivisionID = @DivisionID
		Open @cur
		Fetch Next From @cur Into @PeriodID
		While @@Fetch_Status = 0
		Begin
			SET  @sWHERE = @sWHERE + '''' + @PeriodID + ''','
			Fetch Next From @cur Into @PeriodID
		End
		SET  @sWHERE = ' And PeriodID IN(' + Left(@sWHERE,len(@sWHERE) - 1) + ') '  
	End

	RETURN
    END

-------------------NGAY CONG NGAY
IF @Type = 'DA'
    BEGIN
	SELECT @LevelColumn1 = 'AbsentAmount', @TableName = 'HT2401'
	RETURN
    END


------------------- Thuế TNCN
IF @Type = 'TA'
BEGIN
	IF @Level1 = 'T01' -- Tổng thu nhập
	BEGIN
		SELECT @LevelColumn1 = 'TotalAmount', @TableName = 'HT0338'
		RETURN		
	END
	IF @Level1 = 'T02' -- Thu nhập chịu thuế
	BEGIN
		SELECT @LevelColumn1 = 'IncomeAmount', @TableName = 'HT0338'
		RETURN		
	END
	IF @Level1 = 'T03' -- Giảm trừ gia cảnh
	BEGIN
		SELECT @LevelColumn1 = 'TaxReducedAmount', @TableName = 'HT0338'
		RETURN		
	END
	IF @Level1 = 'T04' -- Số tiền phải đóng
	BEGIN
		SELECT @LevelColumn1 = 'IncomeTax', @TableName = 'HT0338'
		RETURN		
	END
END

------------------- Các khoản bảo hiểm cty đóng
IF @Type = 'SC'
BEGIN
	IF @Level1 = 'C01' --- BHXH (công ty đóng)
	BEGIN
		SELECT @LevelColumn1 = 'SAmount2', @TableName = 'HT2461'
		RETURN		
	END

	IF @Level1 = 'C02' --- BHYT (công ty đóng)
	BEGIN
		SELECT @LevelColumn1 = 'HAmount2', @TableName = 'HT2461'
		RETURN		
	END

	IF @Level1 = 'C03' --- BHTN (công ty đóng)
	BEGIN
		SELECT @LevelColumn1 = 'TAmount2', @TableName = 'HT2461'
		RETURN		
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
