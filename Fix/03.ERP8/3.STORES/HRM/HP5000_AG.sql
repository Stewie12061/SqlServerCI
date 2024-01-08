IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5000_AG]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP5000_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Nguyen Van Nhan, Date 26/04/2004.
----- Purpose: Tinh Luong thang

-----Edited by: Vo Thanh Huong
-----Edited date: 19/08/2004
-----purpose: Tính các kho?n gi?m tr? luong

-----Edited by: Dang Le Bao Quynh
-----Purpose: Thay doi sap xep theo truong MethodID tu bang HT5005,HT5006 phuc vu cho tinh khoan thu nhap tong hop
-----Edit by: Dang Le Bao Quynh; Date:17/07/2006
-----Purpose: Bo sung tinh luong san pham theo phuong phap phan bo
-----Dang Le Bao Quynh; Date: 08/12/2006
-----Purpose: Loc danh sach tinh luong theo chi dinh chi tiet cua phuong phap tinh luong.
--Edit by: Dang Le Bao Quynh; 27/03/2013: Toi uu lai cau lenh, sinh TransactionID bang NewID()	
--Edit by: Dang Le Bao Quynh; 28/03/2013: Xoa tinh luong cong trinh	
---- Modified on 13/11/2013 by Le Thi Thu Hien : Bo sung HP5014
----- Modified on 25/03/2015 by Lê Thị Hạnh: update Salary02: Doanh số bình quân tháng, tính ngày công nghỉ việc [CustomizeIndex: 36 - SGPT]
---- Modified by: Kim Thư 09/10/2018 - Bổ sung tính lương theo từng nhân viên, truyền thêm EmployeeID1
-- <Example>
---- 

CREATE PROCEDURE 	[dbo].[HP5000_AG] 	
					@DivisionID as nvarchar(50),   		---- Don vi tinh luong
					@TranMonth as int, 			---- Ky tinh luong
					@TranYear as int,			---- Nam tinh luong
					@PayrollMethodID as nvarchar(50),	---- PP tinh luong	
					@VoucherDate as Datetime,		---- ngay tinh luong
					@UserID as nvarchar(50),			---- Nguoi tinh luong
					@DepartmentID1 as nvarchar(50),
					@TeamID1 as nvarchar(50),
					@SalaryAmount as decimal(28,8) = 0,
					@EmployeeID1 AS varchar(50)  
						
AS
	Declare @sSQL as nvarchar(4000),
		@IncomeID as nvarchar(50), 
		@SubID as nvarchar(50), 
		@MethodID as nvarchar(50),  
		@BaseSalaryField as nvarchar(50),  
		@BaseSalary as decimal(28,8),
		@GeneralCoID as nvarchar(50),  
		@GeneralAbsentID as nvarchar(50),  
		@SalaryTotal as decimal(28,8),  
		@AbsentAmount decimal(28,8),
		@Orders as tinyint,
		@HT5005_cur as cursor,
		@HT5006_cur1 as cursor,
		@HT5006_cur2 as cursor,
		@TransactionID as nvarchar(50),
		@HT3400_cur as cursor,
		@EmployeeID as nvarchar(50), 
		@DepartmentID  as nvarchar(50),  
		@TeamID as nvarchar(50) ,
		@CYear as nvarchar(50),
		@IsIncome tinyint, ----1: thu nh?p, 0: các kho?n gi?m tr?
		@SourceFieldName nvarchar(100),
		@IsOtherDayPerMonth as tinyint,
		@SourceTableName nvarchar(50),
		@CurrencyID as nvarchar(50),
		@ExchangeRate decimal(28,8)

----------->>>> Kiem tra customize
Declare @AP4444 Table(CustomerName Int, Export Int)
Declare @CustomerName AS Int
Insert Into @AP4444(CustomerName,Export) EXEC('AP4444')
Select @CustomerName=CustomerName From @AP4444
-----------<<<< Kiem tra customize

Set Nocount on
Set  @CYear = LTRIM(str(@TranYear))

-- Nếu tính cho 1 nhân viên cụ thể thì lấy DepartmentID1 và TeamID1 của nhân viên đó, ngược lại lấy theo dữ liệu người dùng chọn
IF  @EmployeeID1 <>'%'
BEGIN
	SELECT @DepartmentID1 = DepartmentID, @TeamID1 = TeamID FROM HT1403 WHERE DivisionID=@DivisionID AND EmployeeID=@EmployeeID1
END


--Xoa tinh luong cong trinh
Delete HT340001 Where TransactionID In 
(Select APK From HT3400 WITH (NOLOCK)
Where 	DivisionID = @DivisionID and
		TranMonth =@TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID
		AND EmployeeID LIKE @EmployeeID1)
		
Delete HT3400 Where DivisionID = @DivisionID and
		TranMonth =@TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID
		AND EmployeeID LIKE @EmployeeID1

DELETE HT3404 Where DivisionID = @DivisionID and
		TranMonth =@TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID
		AND EmployeeID LIKE @EmployeeID1	 
		
--------->>>>>Edit by: Dang Le Bao Quynh; 27/02/2013: Toi uu lai cau lenh, sinh TransactionID bang NewID()	
----------->>>>>> Customize Cảng sài gòn
IF @CustomerName = 19 AND (@PayrollMethodID LIKE 'PPLKH%' OR @PayrollMethodID LIKE 'PPLSP%')		--- Cảng sài gòn
	BEGIN
	IF @PayrollMethodID LIKE 'PPLKH%' --- Nếu là lương khoán chỉ hiển thị những người được check lương khoán
		BEGIN
			Insert Into HT3400 (TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
				CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth)
			Select NewID(), HT2400.EmployeeID, @DivisionID, HT2400.DepartmentID, HT2400.TeamID, @TranMonth, @TranYear, @PayrollMethodID, 
							@UserID, getdate(),@UserID, getdate(), HT2400.IsOtherDayPerMonth
			From HT2400  WITH (NOLOCK)
			Left Join HT3400  WITH (NOLOCK) On
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
	IF @PayrollMethodID LIKE 'PPLSP%' --- Nếu là lương sản phẩm chỉ hiển thị những người được check lương sản phẩm
		BEGIN
			Insert Into HT3400 (TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
							CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth)
			Select NewID(), HT2400.EmployeeID, @DivisionID, HT2400.DepartmentID, HT2400.TeamID, @TranMonth, @TranYear, @PayrollMethodID, 
							@UserID, getdate(),@UserID, getdate(), HT2400.IsOtherDayPerMonth
			From HT2400 WITH (NOLOCK)
			Left Join HT3400  WITH (NOLOCK) On
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
-----------<<<<< Customize Cảng sài gòn	
ELSE 	
	BEGIN
	Insert Into HT3400 (TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
				CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth)
	Select NewID(), HT2400.EmployeeID, @DivisionID, HT2400.DepartmentID, HT2400.TeamID, @TranMonth, @TranYear, @PayrollMethodID, 
					@UserID, getdate(),@UserID, getdate(), HT2400.IsOtherDayPerMonth
	From HT2400 WITH (NOLOCK)
	Left Join HT3400 WITH (NOLOCK) On
		HT2400.DivisionID = HT3400.DivisionID And
		HT2400.TranYear = HT3400.TranYear And
		HT2400.Tranmonth = HT3400.Tranmonth And
		HT2400.DepartmentID = HT3400.DepartmentID And
		Isnull(HT2400.TeamID,'') = isnull(HT3400.TeamID,'') And
		HT2400.EmployeeID = HT3400.EmployeeID And isnull(HT3400.PayrollMethodID,'') = @PayrollMethodID 
	Where 	HT2400.DivisionID =@DivisionID and  HT2400.TranMonth = @TranMonth and HT2400.TranYear =@TranYear and
			HT2400.DepartmentID like @DepartmentID1 and
			IsNull(HT2400.TeamID,'') like IsNull(@TeamID1,'') and
			(HT2400.DepartmentID In (Select DepartmentID From HT5004 Where DivisionID = @DivisionID And PayrollMethodID = @PayrollMethodID And IsDetail = 0)
 			Or HT2400.EmployeeID In (Select EmployeeID From HT5040 Where DivisionID = @DivisionID And PayrollMethodID = @PayrollMethodID))
 			--And HT3400.DivisionID Is Null	
			AND HT2400.EmployeeID LIKE @EmployeeID1
	END

			 	
---------------------- Xu ly tung khoan thu nhap 
IF @CustomerName = 19
	BEGIN
	SET @HT5005_cur = CURSOR SCROLL KEYSET FOR
		Select IncomeID, MethodID, BaseSalaryField, BaseSalary, GeneralCoID, GeneralAbsentID, 
			(Select Top 1 Isnull(TotalAmount,0) From HT9999 Where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear=@TranYear),
			AbsentAmount, right(IncomeID,2) as Orders, 1 as IsIncome,1			
		From HT5005 WITH (NOLOCK)
		Where HT5005.PayrollMethodID =@PayrollMethodID and HT5005.DivisionID = @DivisionID
		Order by MethodID

	

	END	 
ELSE
	SET @HT5005_cur = CURSOR SCROLL KEYSET FOR
		Select IncomeID, MethodID, BaseSalaryField, BaseSalary, GeneralCoID, GeneralAbsentID, 
			SalaryTotal, AbsentAmount, right(IncomeID,2) as Orders, 1 as IsIncome,1			
		From HT5005 WITH (NOLOCK)
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
			

						
			Exec HP5001_AG 	@DivisionID, @TranMonth, @TranYear,  
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
							@ExchangeRate,
							@EmployeeID1
					
			IF 	@CustomerName = 19	AND @IncomeID = 'I04'
				BEGIN
							----- 	Xac dinh he so chung:	--- Toàn công ty
						EXEC HP5009	@DivisionID, @TranMonth, @TranYear, @PayrollMethodID, @GeneralCoID, @MethodID,
								@BaseSalaryField, @BaseSalary

							---	Xac dinh ngay cong tong hop: --- Toàn công ty
						EXEC HP5008	@DivisionID, @TranMonth, @TranYear, @PayrollMethodID, @GeneralAbsentID	
				END

		FETCH NEXT FROM @HT5005_cur INTO  @IncomeID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
		 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome,  @ExchangeRate

	  END
	Close @HT5005_cur
	
	IF @CustomerName = 19 --- Tinh tổng quỹ lương phân bổ xuống Customize riêng cho Cảng sài gòn
	EXEC HP5014
		@DivisionID,
		@TranMonth,
		@TranYear,
		@PayrollMethodID,
		@SalaryTotal		
-------------------------------------------------------------------------------------------------------

EXEC HP5106_AG @PayrollMethodID, @TranMonth, @TranYear, @DivisionID,@DepartmentID1,@TeamID1, @EmployeeID1

-----------------------Xu ly tung khoan giam tru ( khong phai tu ket chuyen)
SET @HT5006_cur1 = CURSOR SCROLL KEYSET FOR
	Select HT5006.SubID, IsNull(MethodID,'P01') as MethodID, BaseSalaryField, BaseSalary, GeneralCoID, GeneralAbsentID, 
		IsNull(SalaryTotal,0) as SalaryTotal, AbsentAmount, right(HT5006.SubID,2) as Orders, 0 as IsIncome,
		1
	From HT5006  WITH (NOLOCK) inner join HT0005  WITH (NOLOCK) on HT5006.DivisionID = HT0005.DivisionID And HT5006.SubID = HT0005.SubID
	Where HT5006.DivisionID = @DivisionID and HT5006.PayrollMethodID =@PayrollMethodID and IsTranfer = 0
	Order by MethodID

	Open @HT5006_cur1
	FETCH NEXT FROM @HT5006_cur1 INTO  @SubID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
				 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome, @ExchangeRate

	WHILE @@FETCH_STATUS = 0
	  BEGIN					
		If @AbsentAmount IS NULL
			Set @AbsentAmount = (Select DayPerMonth  From HT0000 WHERE DivisionID = @DivisionID)
			Exec HP5001_AG 	@DivisionID, @TranMonth, @TranYear,  
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
					@ExchangeRate, 
					@EmployeeID1

		FETCH NEXT FROM @HT5006_cur1 INTO  @SubID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
				 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome, @ExchangeRate
	  END

	Close @HT5006_cur1


----------------------------Xu ly tung khoan giam tru tu ket chuyen	

SET @HT5006_cur2 = CURSOR SCROLL KEYSET FOR
	Select HT00.SubID, right(HT00.SubID,2) as Orders,  
		SourceFieldName, SourceTableName
	From HT5006 HT00  WITH (NOLOCK) inner join HT0005 HT01  WITH (NOLOCK) on HT00.SubID = HT01.SubID and HT00.DivisionID = HT01.DivisionID
			
	Where HT00.PayrollMethodID =@PayrollMethodID and IsTranfer = 1 and HT00.DivisionID = @DivisionID
	Order by Orders
	
	Open @HT5006_cur2 
	FETCH NEXT FROM @HT5006_cur2 INTO  @SubID,  @Orders, @SourceFieldName, @SourceTableName
	
	While @@FETCH_STATUS = 0
	Begin	
		EXEC HP5005_AG   @PayrollMethodID,	@DivisionID,	@TranMonth,	@TranYear,
			@SubID,  	@Orders, 	@SourceFieldName,	@SourceTableName, @DepartmentID1, @TeamID1, @EmployeeID1 --, @CurrencyID

		FETCH NEXT FROM @HT5006_cur2 INTO  @SubID,  @Orders, @SourceFieldName, @SourceTableName
	End

Set Nocount off

----------------------------------Tinh thue thu nhap 
IF exists (Select Top 1 1 From HT2400 
	Where DivisionID = @DivisionID and TranMonth = @TranMonth and 	TranYear = @TranYear and 	Isnull(TaxObjectID, '') <> '') 	

	If @PayrollMethodID='PPY' OR @PayrollMethodID='PPZ'
		EXEC HP5007_AG @DivisionID,	@TranMonth,	@TranYear ,	@PayrollMethodID, @DepartmentID1, @TeamID1, @EmployeeID1
	Else
		EXEC HP5006_AG @DivisionID,	@TranMonth,	@TranYear ,	@PayrollMethodID , @DepartmentID1, @TeamID1, @EmployeeID1

-- Nếu KH là SGPT thì update Salary02: Doanh số bình quân tháng, tính ngày công nghỉ việc
IF @CustomerName = 36 
BEGIN
DECLARE @Cur CURSOR,
	    @Salary02 DECIMAL(28,8) = 0IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5000_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP5000_AG]
END
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

