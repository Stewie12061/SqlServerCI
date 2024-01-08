IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5000_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP5000_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








----- Created by Nguyen Van Nhan, Date 26/04/2004.
----- Purpose: Tinh Luong thang

-----Edited by: Vo Thanh Huong
-----Edited date: 19/08/2004
-----purpose: T�nh c�c kho?n gi?m tr? luong

-----Edited by: Dang Le Bao Quynh
-----Purpose: Thay doi sap xep theo truong MethodID tu bang HT5005,HT5006 phuc vu cho tinh khoan thu nhap tong hop
-----Edit by: Dang Le Bao Quynh; Date:17/07/2006
-----Purpose: Bo sung tinh luong san pham theo phuong phap phan bo
-----Dang Le Bao Quynh; Date: 08/12/2006
-----Purpose: Loc danh sach tinh luong theo chi dinh chi tiet cua phuong phap tinh luong.
--Edit by: Dang Le Bao Quynh; 27/03/2013: Toi uu lai cau lenh, sinh TransactionID bang NewID()	
--Edit by: Dang Le Bao Quynh; 28/03/2013: Xoa tinh luong cong trinh	
---- Modified on 13/11/2013 by Le Thi Thu Hien : Bo sung HP5014
----- Modified on 25/03/2015 by Le Thi Hanh: update Salary02: Doanh so binh quan thang, tinh ngay cong nghi viec [CustomizeIndex: 36 - SGPT]
----- Modified by Bao Thy on 30/11/2016: Bo sung 150 khoan thu nhap cho MEIKO
---- Modified by Phương Thảo on 05/12/2016: Bổ sung lưu S21->S100 (MEIKO)
---- Modified by Phương Thảo on 27/04/2017: Chỉnh sửa kết chuyển các khoản thu nhập, hệ số, giảm trừ đặc biệt của Meiko
---- Modified by Phương Thảo on 01/06/2017: Chuyển phần tính thuế thu nhập ra sau phần customize Meiko
-- <Example>
---- 

CREATE PROCEDURE 	[dbo].[HP5000_MK] 	
					@DivisionID as nvarchar(50),   		---- Don vi tinh luong
					@TranMonth as int, 			---- Ky tinh luong
					@TranYear as int,			---- Nam tinh luong
					@PayrollMethodID as nvarchar(50),	---- PP tinh luong	
					@VoucherDate as Datetime,		---- ngay tinh luong
					@UserID as nvarchar(50),			---- Nguoi tinh luong
					@DepartmentID1 as nvarchar(50),
					@TeamID1 as nvarchar(50),
					@SalaryAmount as decimal(28,8) = 0
						
AS
	Declare @sSQL as nvarchar(4000),
		@sSQl1 as nvarchar(4000),
		@IncomeID as nvarchar(50), 
		@SubID as nvarchar(50), 
		@MethodID as nvarchar(50),  
		@BaseSalaryField as nvarchar(50),  
		@BaseSalary as decimal(28,8),
		@GeneralCoID as nvarchar(50),  
		@GeneralAbsentID as nvarchar(50),  
		@SalaryTotal as decimal(28,8),  
		@AbsentAmount decimal(28,8),
		@Orders as Int,
		@HT5005_cur as cursor,
		@HT5006_cur1 as cursor,
		@HT5006_cur2 as cursor,
		@TransactionID as nvarchar(50),
		@HT3400_cur as cursor,
		@EmployeeID as nvarchar(50), 
		@DepartmentID  as nvarchar(50),  
		@TeamID as nvarchar(50) ,
		@CYear as nvarchar(50),
		@IsIncome tinyint, ----1: thu nh?p, 0: c�c kho?n gi?m tr?
		@SourceFieldName nvarchar(100),
		@IsOtherDayPerMonth as tinyint,
		@SourceTableName nvarchar(50),
		@CurrencyID as nvarchar(50),
		@ExchangeRate decimal(28,8),
		@TableHT2400 Varchar(50),
		@TableHT2402 Varchar(50),
		@sTranMonth Varchar(2)

----------->>>> Kiem tra customize
Declare @AP4444 Table(CustomerName Int, Export Int)
Declare @CustomerName AS Int
Insert Into @AP4444(CustomerName,Export) EXEC('AP4444')
Select @CustomerName=CustomerName From @AP4444
-----------<<<< Kiem tra customize

Set Nocount on
Set  @CYear = LTRIM(str(@TranYear))

--- Tách bảng nghiệp vụ
SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear),
	 	   @TableHT2402 = 'HT2402M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT @TableHT2400 = 'HT2400'
	SELECT @TableHT2402 = 'HT2402'
END

IF @CustomerName = 50 --MEIKO
BEGIN

	Delete HT340001_1 Where TransactionID In 
	(Select APK From HT3400 
	Where 	DivisionID = @DivisionID and
			TranMonth =@TranMonth and 
			TranYear = @TranYear and
			DepartmentID like @DepartmentID1 and
			IsNull(TeamID,'') like IsNull(@TeamID1,'') and
			PayrollMethodID =@PayrollMethodID)	
		
	Delete HT3499 Where TransactionID in 
	(SELECT TransactionID FROM HT3400 
	 WHERE DivisionID = @DivisionID and
		   TranMonth = @TranMonth and 
		   TranYear = @TranYear and
		   DepartmentID like @DepartmentID1 and
		   IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		   PayrollMethodID =@PayrollMethodID )
END 
--Xoa tinh luong cong trinh
Delete HT340001 Where TransactionID In 
(Select APK From HT3400 
Where 	DivisionID = @DivisionID and
		TranMonth =@TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID)
		
Delete HT3400 Where DivisionID = @DivisionID and
		TranMonth =@TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID

DELETE HT3404 Where DivisionID = @DivisionID and
		TranMonth =@TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID	

		
--------->>>>>Edit by: Dang Le Bao Quynh; 27/02/2013: Toi uu lai cau lenh, sinh TransactionID bang NewID()	
----------->>>>>> Customize C?ng s�i g�n
IF @CustomerName = 19 AND (@PayrollMethodID LIKE 'PPLKH%' OR @PayrollMethodID LIKE 'PPLSP%')		--- C?ng s�i g�n
	BEGIN
	IF @PayrollMethodID LIKE 'PPLKH%' --- N?u l� l??ng kho�n ch? hi?n th? nh?ng ng??i ???c check l??ng kho�n
		BEGIN
			Insert Into HT3400 (TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
				CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth)
			Select NewID(), HT2400.EmployeeID, @DivisionID, HT2400.DepartmentID, HT2400.TeamID, @TranMonth, @TranYear, @PayrollMethodID, 
							@UserID, getdate(),@UserID, getdate(), HT2400.IsOtherDayPerMonth
			From HT2400
			Left Join HT3400 On
				HT2400.DivisionID = HT3400.DivisionID And
				HT2400.TranYear = HT3400.TranYear And
				HT2400.Tranmonth = HT3400.Tranmonth And
				HT2400.DepartmentID = HT3400.DepartmentID And
				Isnull(HT2400.TeamID,'') = isnull(HT3400.TeamID,'') And
				HT2400.EmployeeID = HT3400.EmployeeID And isnull(HT3400.PayrollMethodID,'') = @PayrollMethodID 
			Where 	HT2400.DivisionID =@DivisionID and  HT2400.TranMonth = @TranMonth and HT2400.TranYear =@TranYear and
					HT2400.DepartmentID like @DepartmentID1 and
					IsNull(HT2400.TeamID,'') like IsNull(@TeamID1,'') and
					(HT2400.DepartmentID In (Select DepartmentID From HT5004 Where PayrollMethodID = @PayrollMethodID And IsDetail = 0  And DivisionID = @DivisionID)
	 				Or HT2400.EmployeeID In (Select EmployeeID From HT5040 Where PayrollMethodID = @PayrollMethodID  And DivisionID = @DivisionID))
	 				And HT3400.DivisionID Is NULL
	 				AND HT2400.IsJobWage = 1
		END
	IF @PayrollMethodID LIKE 'PPLSP%' --- N?u l� l??ng s?n ph?m ch? hi?n th? nh?ng ng??i ???c check l??ng s?n ph?m
		BEGIN
			Insert Into HT3400 (TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
							CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth)
			Select NewID(), HT2400.EmployeeID, @DivisionID, HT2400.DepartmentID, HT2400.TeamID, @TranMonth, @TranYear, @PayrollMethodID, 
							@UserID, getdate(),@UserID, getdate(), HT2400.IsOtherDayPerMonth
			From HT2400
			Left Join HT3400 On
				HT2400.DivisionID = HT3400.DivisionID And
				HT2400.TranYear = HT3400.TranYear And
				HT2400.Tranmonth = HT3400.Tranmonth And
				HT2400.DepartmentID = HT3400.DepartmentID And
				Isnull(HT2400.TeamID,'') = isnull(HT3400.TeamID,'') And
				HT2400.EmployeeID = HT3400.EmployeeID And isnull(HT3400.PayrollMethodID,'') = @PayrollMethodID 
			Where 	HT2400.DivisionID =@DivisionID and  HT2400.TranMonth = @TranMonth and HT2400.TranYear =@TranYear and
					HT2400.DepartmentID like @DepartmentID1 and
					IsNull(HT2400.TeamID,'') like IsNull(@TeamID1,'') and
					(HT2400.DepartmentID In (Select DepartmentID From HT5004 Where PayrollMethodID = @PayrollMethodID And IsDetail = 0  And DivisionID = @DivisionID)
	 				Or HT2400.EmployeeID In (Select EmployeeID From HT5040 Where PayrollMethodID = @PayrollMethodID  And DivisionID = @DivisionID))
	 				And HT3400.DivisionID Is NULL
	 				AND HT2400.IsPiecework = 1
		END
	END
-----------<<<<< Customize C?ng s�i g�n	
ELSE 	
	BEGIN
	SET @sSQL = N'
		Select	NewID() AS TransactionID, HT2400.EmployeeID, '''+@DivisionID+''' AS DivisionID, HT2400.DepartmentID AS DepartmentID, 
				HT2400.TeamID AS TeamID, '+STR(@TranMonth)+' AS TranMonth, '+STR(@TranYear)+' AS TranYear, '''+@PayrollMethodID+''' AS PayrollMethodID, 
				'''+@UserID+''' AS CreateUserID, getdate() AS CreateDate, '''+@UserID+''' AS LastModifyUserID, getdate() AS LastModifyDate, 
				HT2400.IsOtherDayPerMonth
		INTO #HP5000_MK_HT3400
		From '+@TableHT2400+' HT2400
		Left Join HT3400 On
			HT2400.DivisionID = HT3400.DivisionID And
			HT2400.TranYear = HT3400.TranYear And
			HT2400.Tranmonth = HT3400.Tranmonth And
			HT2400.DepartmentID = HT3400.DepartmentID And
			Isnull(HT2400.TeamID,'''') = isnull(HT3400.TeamID,'''') And
			HT2400.EmployeeID = HT3400.EmployeeID And isnull(HT3400.PayrollMethodID,'''') = '''+@PayrollMethodID+''' 
		Where 	HT2400.DivisionID = '''+@DivisionID+''' and  HT2400.TranMonth = '+STR(@TranMonth)+' and HT2400.TranYear = '+STR(@TranYear)+' and
				HT2400.DepartmentID like '''+@DepartmentID1+''' and
				IsNull(HT2400.TeamID,'''') like IsNull('''+@TeamID1+''','''') and
				(HT2400.DepartmentID In (Select DepartmentID 
										From HT5004 Where DivisionID = '''+@DivisionID+''' And PayrollMethodID = '''+@PayrollMethodID+''' And IsDetail = 0)
 				Or HT2400.EmployeeID In (Select EmployeeID From HT5040 Where DivisionID = '''+@DivisionID+''' And PayrollMethodID = '''+@PayrollMethodID+'''))
 				And HT3400.DivisionID Is Null	
				 --And HT2400.EmployeeID between  ''008361'' and ''008361''
				 --and HT2400.DepartmentID like ''P000000''

		Insert Into HT3400 (TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
					CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth)		
		Select TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
				CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth
		From #HP5000_MK_HT3400'


		IF @CustomerName = 50 --MEIKO: B? sung insert v�o HT3499
		BEGIN			
			SET  @sSQL = @sSQL + N'
			Insert Into HT3499 (TransactionID,EmployeeID, DivisionID, TranMonth , TranYear )
			Select TransactionID, EmployeeID, DivisionID,  TranMonth, TranYear
			From #HP5000_MK_HT3400
			WHERE DivisionID = '''+@DivisionID+'''
			'
		END
			SET  @sSQL = @sSQL + N'DROP TABLE #HP5000_MK_HT3400'
			EXEC(@sSQL)
			
	END		
		
---------------------- Xu ly tung khoan thu nhap 
IF @CustomerName = 19
BEGIN
	SET @HT5005_cur = CURSOR SCROLL KEYSET FOR
		Select IncomeID, MethodID, BaseSalaryField, BaseSalary, GeneralCoID, GeneralAbsentID, 
			(Select Top 1 Isnull(TotalAmount,0) From HT9999 Where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear=@TranYear),
			AbsentAmount, right(IncomeID,2) as Orders, 1 as IsIncome,1			
		From HT5005
		Where HT5005.PayrollMethodID =@PayrollMethodID and HT5005.DivisionID = @DivisionID
		Order by MethodID	
END	 
ELSE
	SET @HT5005_cur = CURSOR SCROLL KEYSET FOR
		Select IncomeID, MethodID, BaseSalaryField, BaseSalary, GeneralCoID, GeneralAbsentID, 
			SalaryTotal, AbsentAmount, CONVERT(INT,STUFF(IncomeID,1,1,'')) as Orders, 1 as IsIncome,1			
		From HT5005
		Where HT5005.DivisionID = @DivisionID and HT5005.PayrollMethodID =@PayrollMethodID
		Order by MethodID 
	
	Open @HT5005_cur
	FETCH NEXT FROM @HT5005_cur INTO  @IncomeID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
		 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome,  @ExchangeRate

	WHILE @@FETCH_STATUS = 0
	  BEGIN
		If @AbsentAmount IS NULL
			Set @AbsentAmount = (Select DayPerMonth  From HT0000 where DivisionID = @DivisionID )
			Set 	@SalaryTotal = isnull(@SalaryTotal,0)* @ExchangeRate
			

						
			Exec HP5001 	@DivisionID, @TranMonth, @TranYear,  
							@PayrollMethodID, 
							@IncomeID,   	--- Ma thu nhap
							@MethodID, 	--- PP tinh luong
							@BaseSalaryField,  ----- Muc luong co ban lay tu dau
							@BaseSalary, 		---- Muc luong co ban cu the (Chi su dung khi @BaseSalaryField ='Others'), 
							@GeneralCoID, 		---PP Xac dinh he so chung
							@GeneralAbsentID, 	--- PP xac dinh ngay cong tong hop
							@SalaryTotal, 		---- Quy luong chi ap dung trong truong hop la luong khoan
							@AbsentAmount , 	---- So ngay quy dinh (he so chi				

							@Orders,	--- Thu tu
							@IsIncome ,
							@DepartmentID1,
							@TeamID1,
							@ExchangeRate
					
			IF 	@CustomerName = 19	AND @IncomeID = 'I04'
				BEGIN
							----- 	Xac dinh he so chung:	--- To�n c�ng ty
						EXEC HP5009	@DivisionID, @TranMonth, @TranYear, @PayrollMethodID, @GeneralCoID, @MethodID,
								@BaseSalaryField, @BaseSalary

							---	Xac dinh ngay cong tong hop: --- To�n c�ng ty
						EXEC HP5008	@DivisionID, @TranMonth, @TranYear, @PayrollMethodID, @GeneralAbsentID	
				END

		FETCH NEXT FROM @HT5005_cur INTO  @IncomeID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
		 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome,  @ExchangeRate

	  END
	Close @HT5005_cur
	
	IF @CustomerName = 19 --- Tinh t?ng qu? l??ng ph�n b? xu?ng Customize ri�ng cho C?ng s�i g�n
	EXEC HP5014
		@DivisionID,
		@TranMonth,
		@TranYear,
		@PayrollMethodID,
		@SalaryTotal		
-------------------------------------------------------------------------------------------------------

EXEC HP5106 @PayrollMethodID, @TranMonth, @TranYear, @DivisionID,@DepartmentID1,@TeamID1

-----------------------Xu ly tung khoan giam tru ( khong phai tu ket chuyen)
SET @HT5006_cur1 = CURSOR SCROLL KEYSET FOR
	Select HT5006.SubID, IsNull(MethodID,'P01') as MethodID, BaseSalaryField, BaseSalary, GeneralCoID, GeneralAbsentID, 
		IsNull(SalaryTotal,0) as SalaryTotal, AbsentAmount, CONVERT(INT,STUFF(HT5006.SubID,1,1,'')) as Orders, 0 as IsIncome,
		1
	From HT5006  inner join HT0005  on HT5006.DivisionID = HT0005.DivisionID And HT5006.SubID = HT0005.SubID
	Where HT5006.DivisionID = @DivisionID and HT5006.PayrollMethodID =@PayrollMethodID and IsTranfer = 0
	Order by MethodID

	Open @HT5006_cur1
	FETCH NEXT FROM @HT5006_cur1 INTO  @SubID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
				 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome, @ExchangeRate

	WHILE @@FETCH_STATUS = 0
	  BEGIN					
		If @AbsentAmount IS NULL
			Set @AbsentAmount = (Select DayPerMonth  From HT0000 WHERE DivisionID = @DivisionID)
			Exec HP5001 	@DivisionID, @TranMonth, @TranYear,  
					@PayrollMethodID, 
					@SubID,   	--- Ma thu nhap
					@MethodID, 	--- PP tinh luong
					@BaseSalaryField,  ----- Muc luong co ban lay tu dau
					@BaseSalary, 		---- Muc luong co ban cu the (Chi su dung khi @BaseSalaryField ='Others'), 
					@GeneralCoID, 		---PP Xac dinh he so chung
					@GeneralAbsentID, 	--- PP xac dinh ngay cong tong hop
					@SalaryTotal, 		---- Quy luong chi ap dung trong truong hop la luong khoan
					@AbsentAmount , 	---- So ngay quy (he so chi				
					@Orders,	--- Thu thu
					@IsIncome,
					@DepartmentID1,
					@TeamID1,
					@ExchangeRate

		FETCH NEXT FROM @HT5006_cur1 INTO  @SubID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
				 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome, @ExchangeRate
	  END

	Close @HT5006_cur1
		
----------------------------Xu ly tung khoan giam tru tu ket chuyen	

SET @HT5006_cur2 = CURSOR SCROLL KEYSET FOR
	Select HT00.SubID, right(HT00.SubID,2) as Orders,  
		SourceFieldName, SourceTableName
	From HT5006 HT00 inner join HT0005 HT01 on HT00.SubID = HT01.SubID and HT00.DivisionID = HT01.DivisionID			
	Where HT00.PayrollMethodID =@PayrollMethodID and IsTranfer = 1 and HT00.DivisionID = @DivisionID
	Order by Orders
	
	Open @HT5006_cur2 
	FETCH NEXT FROM @HT5006_cur2 INTO  @SubID,  @Orders, @SourceFieldName, @SourceTableName
	
	While @@FETCH_STATUS = 0
	Begin	
		EXEC HP5005   @PayrollMethodID,	@DivisionID,	@TranMonth,	@TranYear,
			@SubID,  	@Orders, 	@SourceFieldName,	@SourceTableName, @DepartmentID1, @TeamID1 --, @CurrencyID

		FETCH NEXT FROM @HT5006_cur2 INTO  @SubID,  @Orders, @SourceFieldName, @SourceTableName
	End

Set Nocount off

IF @CustomerName = 50
BEGIN
	-- Customize Meiko: Tính đặc thù các khoản không thiết lập được bằng phương pháp tính lương---------
	---1. BH cho người lao động làm HĐ thời vụ: (mã chức vụ: OST)	
	SET @sSQl1 = N'
	-- Tinh gio cong thuc te
	SELECT		EmployeeID, SUM(AbsentAmount) AS Amount1
	INTO		#HT2402_HP5103_1
	FROM		'+@TableHT2402+' HT2402
	WHERE		HT2402.TranMonth = ' + cast(@TranMonth as nvarchar(2))+' 
				AND HT2402.TranYear = ' + cast(@TranYear as nvarchar(4)) + '  
				AND HT2402.DivisionID = ''' + @DivisionID + ''' 		
				AND	HT2402.DepartmentID like ''' + @DepartmentID1 + '''
				AND	ISNULL(HT2402.TeamID,'''') like ''' + @TeamID1 + '''
				AND HT2402.AbsentTypeID IN (
							SELECT  CActAbsentTypeID AS AbsentTypeID
							FROM HT0000
							WHERE HT0000.DivisionID = '''+@DivisionID+'''
							UNION ALL
							SELECT  TActAbsentTypeID AS AbsentTypeID
							FROM HT0000
							WHERE HT0000.DivisionID = '''+@DivisionID+''')
	GROUP BY EmployeeID
	
	SELECT  EmployeeID, SUM(AbsentAmount) AS Amount2
	INTO		#HT2402_HP5103_2
	FROM '+@TableHT2402+' HT2402
	WHERE   HT2402.TranMonth = ' + cast(@TranMonth as nvarchar(2))+' 
			AND HT2402.TranYear = ' + cast(@TranYear as nvarchar(4)) + '  
			AND HT2402.DivisionID = ''' + @DivisionID + ''' 
			AND	HT2402.DepartmentID like ''' + @DepartmentID1 + '''
			AND	ISNULL(HT2402.TeamID,'''') like ''' + @TeamID1 + '''
			AND AbsentTypeID IN (
						SELECT  Distinct ParentID						
						FROM HT1013 left join HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID 
						AND HT1013.DivisionID = HT0383.DivisionID
						WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
						AND HT1013.DivisionID = '''+@DivisionID+''' AND HT0383.ReportID = ''BCCT'' AND HT0383.DataTypeID in (''Amount01'',''Amount03'',''Amount04'') )
	GROUP BY EmployeeID
			

	UPDATE	H00
	SET		H00.C147 = CASE WHEN T5.TitleID in (''EST'', ''OST'', ''OST1'', ''OST2'')THEN  CASE WHEN isnull(T4.C15,0) = 0 THEN 0 ELSE (isnull(T3.[Income42],0) * 0.215 * (isnull(T1.Amount1,0) - isnull(T2.Amount2,0)) )/ T4.C15 END
						ELSE 0 END
	FROM	HT2499 H00 
	LEFT JOIN #HT2402_HP5103_1 T1 ON H00.EmployeeID = T1.EmployeeID
	LEFT JOIN #HT2402_HP5103_2 T2 ON H00.EmployeeID = T2.EmployeeID
	LEFT JOIN HT3499 T3 ON H00.EmployeeID = T3.EmployeeID AND H00.TranMonth = T3.TranMonth AND H00.TranYear = T3.TranYear 
	LEFT JOIN '+@TableHT2400+' T4 ON H00.EmployeeID = T4.EmployeeID AND H00.TranMonth = T4.TranMonth AND H00.TranYear = T4.TranYear 
	LEFT JOIN HT1403 T5 ON H00.EmployeeID = T5.EmployeeID
	WHERE	H00.TranMonth = ' + cast(@TranMonth as nvarchar(2))+' 
		AND	H00.TranYear = ' + cast(@TranYear as nvarchar(4)) + '  
		AND	H00.DivisionID = ''' + @DivisionID + ''' 				
		AND	T4.DepartmentID like ''' + @DepartmentID1 + '''
		AND	ISNULL(T4.TeamID,'''') like ''' + @TeamID1 + '''	

	UPDATE	T1
	SET		T1.[Income135] = T2.C147
	FROM HT3499 T1
	LEFT JOIN HT2499 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear 
	LEFT JOIN '+@TableHT2400+' T3 ON T2.EmployeeID = T3.EmployeeID AND T2.TranMonth = T3.TranMonth AND T2.TranYear = T3.TranYear 
	WHERE	T1.TranMonth = ' + cast(@TranMonth as nvarchar(2))+' 
			AND T1.TranYear = ' + cast(@TranYear as nvarchar(4)) + '  
			AND T1.DivisionID = ''' + @DivisionID + ''' 
			AND	T3.DepartmentID like ''' + @DepartmentID1 + '''
			AND	ISNULL(T3.TeamID,'''') like ''' + @TeamID1 + '''			

	'
	--Print @sSQl1
	EXEC(@sSQl1)
	

	-----2. Tổng giảm trừ đi sớm, về muộn, bỏ làm	
	SET @sSQl1 = N'	
	
	UPDATE	H00
	SET		H00.C145 = Isnull(T3.[SubAmount35],0) + Isnull(T3.[SubAmount36],0) + Isnull(T3.[SubAmount37],0) + Isnull(T3.[SubAmount38],0) 
	FROM	HT2499 H00 	
	LEFT JOIN HT3499 T3 ON H00.EmployeeID = T3.EmployeeID AND H00.TranMonth = T3.TranMonth AND H00.TranYear = T3.TranYear 	
	LEFT JOIN '+@TableHT2400+' T4 ON H00.EmployeeID = T4.EmployeeID AND H00.TranMonth = T4.TranMonth AND H00.TranYear = T4.TranYear 
	WHERE	H00.TranMonth = ' + cast(@TranMonth as nvarchar(2))+' 
			AND H00.TranYear = ' + cast(@TranYear as nvarchar(4)) + '  
			AND H00.DivisionID = ''' + @DivisionID + ''' 
			AND	T4.DepartmentID like ''' + @DepartmentID1 + '''
			AND	ISNULL(T4.TeamID,'''') like ''' + @TeamID1 + '''

	UPDATE	T1
	SET		T1.[SubAmount06] = T2.C145
	FROM HT3400 T1
	LEFT JOIN HT2499 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear 
	LEFT JOIN '+@TableHT2400+' T3 ON T2.EmployeeID = T3.EmployeeID AND T2.TranMonth = T3.TranMonth AND T2.TranYear = T3.TranYear 
	WHERE	T1.TranMonth = ' + cast(@TranMonth as nvarchar(2))+' 
			AND T1.TranYear = ' + cast(@TranYear as nvarchar(4)) + '  
			AND T1.DivisionID = ''' + @DivisionID + ''' 
			AND	T3.DepartmentID like ''' + @DepartmentID1 + '''
			AND	ISNULL(T3.TeamID,'''') like ''' + @TeamID1 + '''
	'
	--Print @sSQl1
	EXEC(@sSQl1)	

	-----3. Tổng giảm trừ nghỉ không hưởng lương
	
	SET @sSQl1 = N'	
	
	UPDATE	H00
	SET		H00.C146 = Isnull(T3.[SubAmount31],0) + Isnull(T3.[SubAmount32],0) + Isnull(T3.[SubAmount33],0) + Isnull(T3.[SubAmount34],0) 
	FROM	HT2499 H00 	
	LEFT JOIN HT3499 T3 ON H00.EmployeeID = T3.EmployeeID AND H00.TranMonth = T3.TranMonth AND H00.TranYear = T3.TranYear 	
	LEFT JOIN '+@TableHT2400+' T4 ON H00.EmployeeID = T4.EmployeeID AND H00.TranMonth = T4.TranMonth AND H00.TranYear = T4.TranYear 
	WHERE	H00.TranMonth = ' + cast(@TranMonth as nvarchar(2))+' 
			AND H00.TranYear = ' + cast(@TranYear as nvarchar(4)) + '  
			AND H00.DivisionID = ''' + @DivisionID + ''' 
			AND	T4.DepartmentID like ''' + @DepartmentID1 + '''
			AND	Isnull(T4.TeamID,'''') like ''' + @TeamID1 + '''
	
	UPDATE	T1
	SET		T1.[SubAmount05] = T2.C146
	FROM HT3400 T1
	LEFT JOIN HT2499 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear 
	LEFT JOIN '+@TableHT2400+' T3 ON T2.EmployeeID = T3.EmployeeID AND T2.TranMonth = T3.TranMonth AND T2.TranYear = T3.TranYear 
	WHERE	T1.TranMonth = ' + cast(@TranMonth as nvarchar(2))+' 
			AND T1.TranYear = ' + cast(@TranYear as nvarchar(4)) + '  
			AND T1.DivisionID = ''' + @DivisionID + ''' 
			AND	T3.DepartmentID like ''' + @DepartmentID1 + '''
			AND	Isnull(T3.TeamID,'''') like ''' + @TeamID1 + '''
	'
	--Print @sSQl1
	EXEC(@sSQl1)
	

	-----4. Tổng giảm trừ OT	
	SET @sSQl1 = N'	
	
	UPDATE	H00
	SET		H00.C144 = isnull(T3.[SubAmount39],0) + 
	isnull(T3.[SubAmount40],0) + isnull(T3.[SubAmount41],0) + isnull(T3.[SubAmount42],0) + isnull(T3.[SubAmount43],0) + isnull(T3.[SubAmount44],0) +
	isnull(T3.[SubAmount45],0) + isnull(T3.[SubAmount46],0) + isnull(T3.[SubAmount47],0) + isnull(T3.[SubAmount48],0) + isnull(T3.[SubAmount49],0) +
	isnull(T3.[SubAmount50],0) + isnull(T3.[SubAmount51],0) + isnull(T3.[SubAmount52],0) + isnull(T3.[SubAmount53],0) + isnull(T3.[SubAmount54],0) +
	isnull(T3.[SubAmount55],0) + isnull(T3.[SubAmount56],0) + isnull(T3.[SubAmount57],0) + isnull(T3.[SubAmount58],0) + isnull(T3.[SubAmount59],0) +
	isnull(T3.[SubAmount60],0) + isnull(T3.[SubAmount61],0) + isnull(T3.[SubAmount62],0) + isnull(T3.[SubAmount63],0) + isnull(T3.[SubAmount64],0) +
	isnull(T3.[SubAmount65],0) + isnull(T3.[SubAmount66],0) + isnull(T3.[SubAmount67],0) + isnull(T3.[SubAmount68],0) + isnull(T3.[SubAmount69],0) +
	isnull(T3.[SubAmount70],0) + isnull(T3.[SubAmount71],0) + isnull(T3.[SubAmount72],0) + isnull(T3.[SubAmount73],0) + isnull(T3.[SubAmount74],0) + isnull(T3.[SubAmount75],0) 
	FROM	HT2499 H00 	
	LEFT JOIN HT3499 T3 ON H00.EmployeeID = T3.EmployeeID AND H00.TranMonth = T3.TranMonth AND H00.TranYear = T3.TranYear 	
	LEFT JOIN '+@TableHT2400+' T4 ON H00.EmployeeID = T4.EmployeeID AND H00.TranMonth = T4.TranMonth AND H00.TranYear = T4.TranYear
	WHERE	H00.TranMonth = ' + cast(@TranMonth as nvarchar(2))+' 
			AND H00.TranYear = ' + cast(@TranYear as nvarchar(4)) + '  
			AND H00.DivisionID = ''' + @DivisionID + ''' 
			AND	T4.DepartmentID like ''' + @DepartmentID1 + '''
			AND	Isnull(T4.TeamID,'''') like ''' + @TeamID1 + '''
	
	UPDATE	T1
	SET		T1.[SubAmount12] = T2.C144
	FROM HT3400 T1
	LEFT JOIN HT2499 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear 
	LEFT JOIN '+@TableHT2400+' T3 ON T2.EmployeeID = T3.EmployeeID AND T2.TranMonth = T3.TranMonth AND T2.TranYear = T3.TranYear 
	WHERE	T1.TranMonth = ' + cast(@TranMonth as nvarchar(2))+' 
			AND T1.TranYear = ' + cast(@TranYear as nvarchar(4)) + '  
			AND T1.DivisionID = ''' + @DivisionID + ''' 
			AND	T3.DepartmentID like ''' + @DepartmentID1 + '''
			AND	Isnull(T3.TeamID,'''') like ''' + @TeamID1 + '''
	'
	--Print @sSQl1
	EXEC(@sSQl1)


END

----------------------------------Tinh thue thu nhap 
IF exists (Select Top 1 1 From HT2400 
	Where DivisionID = @DivisionID and TranMonth = @TranMonth and 	TranYear = @TranYear and 	Isnull(TaxObjectID, '') <> '') 	

	If @PayrollMethodID='PPY' OR @PayrollMethodID='PPZ'
		EXEC HP5007 @DivisionID,	@TranMonth,	@TranYear ,	@PayrollMethodID, @DepartmentID1, @TeamID1
	Else
		EXEC HP5006 @DivisionID,	@TranMonth,	@TranYear ,	@PayrollMethodID , @DepartmentID1, @TeamID1

-- N?u KH l� SGPT th� update Salary02: Doanh s? b�nh qu�n th�ng, t�nh ng�y c�ng ngh? vi?c
IF @CustomerName = 36 
BEGIN
DECLARE @Cur CURSOR,
	    @Salary02 DECIMAL(28,8) = 0
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT HT34.DivisionID, HT34.EmployeeID, HT34.DepartmentID, HT34.TeamID, HT34.PayRollMethodID,
	   ISNULL(AVG(ISNULL(HT24.Salary01,0)*ISNULL(HT24.C06,0)),0) AS Salary02
FROM HT3400 HT34
LEFT JOIN HT2400 HT24 ON HT24.DivisionID = HT34.DivisionID AND HT24.EmployeeID = HT34.EmployeeID 
AND HT24.DepartmentID = HT34.DepartmentID AND ISNULL(HT24.TeamID,'') = ISNULL(HT34.TeamID,'')
AND HT24.TranMonth = HT34.TranMonth AND HT24.TranYear = HT34.TranYear
LEFT JOIN HT1400 HT14 ON HT14.DivisionID = HT24.DivisionID AND HT14.EmployeeID = HT24.EmployeeID 
AND HT14.DepartmentID = HT24.DepartmentID AND ISNULL(HT14.TeamID,'') = ISNULL(HT24.TeamID,'')
WHERE HT34.DivisionID = @DivisionID AND HT34.PayRollMethodID = @PayrollMethodID AND 
      (HT34.TranYear*12 + HT34.TranMonth) <= (@TranYear*12 + @TranMonth)
      AND ISNULL(HT14.EmployeeStatus,0) = 9
GROUP BY HT34.DivisionID, HT34.EmployeeID, HT34.DepartmentID, HT34.TeamID, HT34.PayRollMethodID
OPEN @Cur
FETCH NEXT FROM @Cur INTO @DivisionID,@EmployeeID,@DepartmentID,@TeamID,@PayrollMethodID,@Salary02
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE HT2400 SET 
		Salary02 = ISNULL(@Salary02,0)
	WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID AND TranYear = @TranYear AND TranMonth = @TranMonth AND DepartmentID = @DepartmentID AND ISNULL(TeamID,'') = ISNULL(@TeamID,'')
FETCH NEXT FROM @Cur INTO @DivisionID,@EmployeeID,@DepartmentID,@TeamID,@PayrollMethodID,@Salary02
END
CLOSE @Cur
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
