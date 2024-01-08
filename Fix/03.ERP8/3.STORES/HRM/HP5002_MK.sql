IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP5002_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP5002_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







----- Created by Nguyen Van Nhan, Date 26/04/2004.
----- Purpose: Xac dinh he so chung
----- Edit by: Dang LeBao Quynh ; Date: 10/06/2006
----- Purpose: Them tham so truyen vao @MethodID de tinh thu nhap tong hop
----- Edit by: Dang Le Bao Quynh; Date: 11/06/2007
----- Purpose: Sua cach thuc lay nguon du lieu luong de nghi tu bang HT1403
----- Edit by: Dang Le Bao Quynh; Date: 02/10/2007
----- Purpose: Sua lai cach lay he so co dinh
----- Edit by: Dang Le Bao Quynh; Date: 27/03/2013: Bo sung tinh he so theo cong trinh
----- Modify on 22/10/2013 by Bảo Anh: Nếu là chấm công theo công trình, lấy lương cơ bản từ phụ cấp theo công trình (Unicare)
---- Modified on 14/11/2013 by Lê Thị Thu Hiền : Bổ sung thêm customize cho cảng sài gòn
---- Modified on 14/11/2013 by Bảo Anh : Nếu tính lương công trình và không có chấm công tháng thì lấy hệ số từ chấm công theo công trình (Unicare)
---- Modified on 25/12/2013 by Lê Thị Thu Hiền : Viết điều kiện lại là customize cho Unicare không viết IF theo bảng
---- Modified on 30/12/2013 by Bảo Anh : Sửa câu tạo view HV5002, nếu là Unicare thì luôn join thêm HT2430 bất kể phương pháp tính lương nào
---- Modified on 10/04/2014 by Bảo Anh : Bỏ Where TeamID khi join HT2400 và HT2430 khi tạo view HV5002 nếu là phương pháp P06
---- Modified on 17/10/2014 by Trí Thiện : Fix lỗi không phân biệt column Salaty02, Salary03, Them @CustomerName 39 Van khanh
---- Modified on 07/12/2016 by Phuong Thao: Bổ sung lên 150 hệ số 
---- Modified on 17/07/2017 by Phuong Thao: Bổ sung truyền biến @EmployeeID (chỉ được gọi từ màn hình tra cứu thông tin lương)
---- Modified on 19/08/2017 by Huỳnh Thử: Customer MEKIO: Lấy lương từ bảng HT2400M+Month+Year
-- <Example> HP5002_MK 'UN',3,2014,'LCTM001','NQD','P06','BaseSalary',NULL,'CN','%'
----

CREATE PROCEDURE [dbo].[HP5002_MK]	
				@DivisionID AS nvarchar(50),	
				@TranMonth AS int, 
				@TranYear AS int , 
				@PayrollMethodID AS nvarchar(50), 
				@GeneralCoID AS nvarchar(50),
				@MethodID nvarchar(50),
				@BaseSalaryField  AS nvarchar(50),
				@BaseSalary AS decimal (28,8),
				@DepartmentID1 AS nvarchar(50),
				@TeamID1 AS nvarchar(50),
				@EmployeeID AS NVARCHAR(50) = '%'
AS

Declare 
    @sSQL AS nvarchar(MAX),
	@ListOfCo AS nvarchar(MAX),
	@Temp AS nvarchar(MAX),
	@Pos1 AS int,
	@Pos2 AS int,
	@Pos3 AS int,
	@Value1 AS decimal (28,8),
	@Value2 AS decimal (28,8),
	@Value3 AS decimal (28,8),
	@Cur AS cursor,
	@CoefficientID nvarchar(50),
	@sWhere AS NVARCHAR(MAX),
	@TableHT2400 AS NVARCHAR(50),
	@sTranMonth NVARCHAR(2)


	--- Tách bảng nghiệp vụ
SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT @TableHT2400 = 'HT2400'
END

----------->>>> Kiem tra customize cho CSG
Declare @AP4444 Table(CustomerName Int, Export Int)
Declare @CustomerName AS Int
Insert Into @AP4444(CustomerName,Export) EXEC('AP4444')
Select @CustomerName=CustomerName From @AP4444
-----------<<<< Kiem tra customize cho CSG
------------>>>>  Lọc nhân viên lương khoán hay lươngs ản phẩm
SET @sWhere = ''
IF @CustomerName = 19 --- Cảng sài gòn
	BEGIN
	IF @PayrollMethodID LIKE 'PPLKH%' --- Nếu là lương khoán chỉ hiển thị những người được check lương khoán
		SET @sWhere = N' AND HT2400.IsJobWage = 1 ' 
	IF @PayrollMethodID LIKE 'PPLSP%' --- Nếu là lương sản phẩm chỉ hiển thị những người được check lương sản phẩm
		SET @sWhere = N' AND HT2400.IsPiecework = 1 '
	END
------------<<<<<  Lọc nhân viên lương khoán hay lươngs ản phẩm
	
Set @ListOfCo =''

If @MethodID <> 'P06' 
BEGIN

	--IF (SELECT TOP 1 1 From HT5005 Where DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID And MethodID = 'P06') = 1
	--		AND (Select COUNT(*) FROM HT2402 Where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear) = 0
	IF @CustomerName in( 21) --->>> Customize Unicare
	BEGIN
		Set @ListOfCo =@ListOfCo+'( '  + (Select top 1  'isnull(HT2430.' + isnull(C01ID,'') +', isnull(HT2400.'+isnull(C01ID,'') +',0)) '+ 
					(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C02ID,'') +', isnull(HT2400.'+isnull(C02ID,'')+',0))' ELSE '' end)+
					(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C03ID,'') +', isnull(HT2400.'+isnull(C03ID,'')+',0))'  ELSE '' end)+
					(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C04ID,'') +', isnull(HT2400.'+isnull(C04ID,'')+',0))'  ELSE '' end)+
					(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C05ID,'') +', isnull(HT2400.'+isnull(C05ID,'')+',0))'  ELSE '' end)
					 From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID Order by LineID )+')'
					 			 
	if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =2)
		  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'('+' isnull(HT2430.' + isnull(C01ID,'') +', isnull(HT2400.'+isnull(C01ID,'')+',0))'  + 
						(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C02ID,'') +', isnull(HT2400.'+isnull(C02ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C03ID,'') +', isnull(HT2400.'+isnull(C03ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C04ID,'') +', isnull(HT2400.'+isnull(C04ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C05ID,'') +', isnull(HT2400.'+isnull(C05ID,'')+',0))'  ELSE '' end)
						 From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =2 )+')'

	if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =3)
		  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'('+' isnull(HT2430.' + isnull(C01ID,'') +', isnull(HT2400.'+isnull(C01ID,'')+',0))' +
						(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C02ID,'') +', isnull(HT2400.'+isnull(C02ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C03ID,'') +', isnull(HT2400.'+isnull(C03ID,'')+',0))' ELSE '' end)+
						(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C04ID,'') +', isnull(HT2400.'+isnull(C04ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C05ID,'') +', isnull(HT2400.'+isnull(C05ID,'')+',0))'  ELSE '' end)
						 From HT5001 Where GeneralCoID = @GeneralCoID  and DivisionID = @DivisionID and LineID =3 )+')'

	if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and LineID =4 and DivisionID = @DivisionID )
		  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'(' +' isnull(HT2430.' + isnull(C01ID,'') +', isnull(HT2400.'+isnull(C01ID,'')+',0))' +
						(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C02ID,'') +', isnull(HT2400.'+isnull(C02ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C03ID,'') +', isnull(HT2400.'+isnull(C03ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C04ID,'') +', isnull(HT2400.'+isnull(C04ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C05ID,'') +', isnull(HT2400.'+isnull(C05ID,'')+',0))'  ELSE '' end)
						 From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =4 )+')'

	if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and LineID =5 and DivisionID = @DivisionID )
		  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'(' +' isnull(HT2430.' + isnull(C01ID,'') +', isnull(HT2400.'+isnull(C01ID,'')+',0))' +
						(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C01ID,'') +', isnull(HT2400.'+isnull(C02ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C01ID,'') +', isnull(HT2400.'+isnull(C03ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C01ID,'') +', isnull(HT2400.'+isnull(C04ID,'')+',0))'  ELSE '' end)+
						(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull(HT2430.' + isnull(C01ID,'') +', isnull(HT2400.'+isnull(C05ID,'')+',0))'  ELSE '' end)
						 From HT5001 Where GeneralCoID = @GeneralCoID and LineID =5 and DivisionID = @DivisionID  )+')'
	END ---<<<< Customize Unicare
	
	ELSE 
	BEGIN
		Set @ListOfCo =@ListOfCo+'( '  + (Select top 1  'isnull( '+isnull(C01ID,'') +',0) '+ 
						(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull('+isnull(C02ID,'')+',0)' ELSE '' end)+
						(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull('+isnull(C03ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull('+isnull(C04ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull('+isnull(C05ID,'')+',0)'  ELSE '' end)
						 From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID Order by LineID )+')'
						 			 
		if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =2)
			  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'('+' isnull('+isnull(C01ID,'')+',0)'  + 
							(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull('+isnull(C02ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull('+isnull(C03ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull('+isnull(C04ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull('+isnull(C05ID,'')+',0)'  ELSE '' end)
							 From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =2 )+')'

		if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =3)
			  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'('+' isnull('+isnull(C01ID,'')+',0)' +
							(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull('+isnull(C02ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull('+isnull(C03ID,'')+',0)' ELSE '' end)+
							(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull('+isnull(C04ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull('+isnull(C05ID,'')+',0)'  ELSE '' end)
							 From HT5001 Where GeneralCoID = @GeneralCoID  and DivisionID = @DivisionID and LineID =3 )+')'

		if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and LineID =4 and DivisionID = @DivisionID )
			  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'(' +' isnull('+isnull(C01ID,'')+',0)' +
							(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull('+isnull(C02ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull('+isnull(C03ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull('+isnull(C04ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull('+isnull(C05ID,'')+',0)'  ELSE '' end)
							 From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =4 )+')'

		if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and LineID =5 and DivisionID = @DivisionID )
			  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'(' +' isnull('+isnull(C01ID,'')+',0)' +
							(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull('+isnull(C02ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull('+isnull(C03ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull('+isnull(C04ID,'')+',0)'  ELSE '' end)+
							(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull('+isnull(C05ID,'')+',0)'  ELSE '' end)
							 From HT5001 Where GeneralCoID = @GeneralCoID and LineID =5 and DivisionID = @DivisionID  )+')'
	END
END
ELSE  ----------<<< = 'P06'
--Xu ly luong theo cong trinh
BEGIN
	Set @ListOfCo =@ListOfCo+'( '  + (Select top 1  'isnull(HT2430.'+isnull(C01ID,'') +',0) '+ 
					(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C02ID,'')+',0)' ELSE '' end)+
					(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C03ID,'')+',0)'  ELSE '' end)+
					(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C04ID,'')+',0)'  ELSE '' end)+
					(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C05ID,'')+',0)'  ELSE '' end)
					 From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID Order by LineID )+')'
					 			 
	if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =2)
		  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'('+' isnull(HT2430.'+isnull(C01ID,'')+',0)'  + 
						(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C02ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C03ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C04ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C05ID,'')+',0)'  ELSE '' end)
						 From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =2 )+')'

	if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =3)
		  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'('+' isnull(HT2430.'+isnull(C01ID,'')+',0)' +
						(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C02ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C03ID,'')+',0)' ELSE '' end)+
						(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C04ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C05ID,'')+',0)'  ELSE '' end)
						 From HT5001 Where GeneralCoID = @GeneralCoID  and DivisionID = @DivisionID and LineID =3 )+')'

	if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and LineID =4 and DivisionID = @DivisionID )
		  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'(' +' isnull(HT2430.'+isnull(C01ID,'')+',0)' +
						(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C02ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C03ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C04ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C05ID,'')+',0)'  ELSE '' end)
						 From HT5001 Where GeneralCoID = @GeneralCoID and DivisionID = @DivisionID  and LineID =4 )+')'

	if Exists (Select top 1 1   From HT5001 Where GeneralCoID = @GeneralCoID and LineID =5 and DivisionID = @DivisionID )
		  Set @ListOfCo =@ListOfCo+ (Select top 1 [Sign]+'(' +' isnull(HT2430.'+isnull(C01ID,'')+',0)' +
						(CASE WHEN isnull(C02ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C02ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C03ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C03ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C04ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C04ID,'')+',0)'  ELSE '' end)+
						(CASE WHEN isnull(C05ID,'') <>'' THEN '+ isnull(HT2430.'+isnull(C05ID,'')+',0)'  ELSE '' end)
						 From HT5001 Where GeneralCoID = @GeneralCoID and LineID =5 and DivisionID = @DivisionID  )+')'
END
--print @ListOfCo
-- Add new by : Dang Le Bao Quynh
----------------------------------------------------------------------------------------------------
--Set @Cur = cursor static for
--Select CoefficientID From HT0003 Where IsConstant = 1  and DivisionID = @DivisionID 
--Open @Cur
--Fetch Next From @Cur Into @CoefficientID
--While @@Fetch_Status=0
--Begin
--	Set @Pos1=PATINDEX('%' + @CoefficientID + '%' ,@ListOfCo )	
--	If @Pos1 <>0 
--	Begin
--		Select @Value1= ValueOfConstant From HT0003 Where CoefficientID=@CoefficientID and DivisionID = @DivisionID 
--		IF @MethodID <> 'P06' AND (Select COUNT(*) FROM HT2402 Where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear) > 0 
--			Set @ListOfCo=REPLACE(@ListOfCo,@CoefficientID, cast( @Value1 AS varchar(20)))
--		Else
--			Set @ListOfCo=REPLACE(@ListOfCo,'HT2430.'+@CoefficientID, cast( @Value1 AS varchar(20)))	
--	End
--	Fetch Next From @Cur Into @CoefficientID
--END

Set @Cur = cursor static for
Select CoefficientID From HT0003 Where IsConstant = 1  and DivisionID = @DivisionID 
Open @Cur
Fetch Next From @Cur Into @CoefficientID
While @@Fetch_Status=0
Begin
	Set @Pos1=PATINDEX('%' + @CoefficientID + '%' ,@ListOfCo )	
	If @Pos1 <>0 
	Begin
		Select @Value1= ValueOfConstant From HT0003 Where CoefficientID=@CoefficientID and DivisionID = @DivisionID 
		
		IF @CustomerName  in ( 21 )
			Set @ListOfCo=REPLACE(@ListOfCo,'HT2430.'+@CoefficientID, cast( @Value1 AS varchar(20)))
		ELSE 
			BEGIN
				IF @MethodID <> 'P06'
					Set @ListOfCo=REPLACE(@ListOfCo,@CoefficientID, cast( @Value1 AS varchar(20)))
				Else
					Set @ListOfCo=REPLACE(@ListOfCo,'HT2430.'+@CoefficientID, cast( @Value1 AS varchar(20)))	
			END

	End
	Fetch Next From @Cur Into @CoefficientID
END

------------------------------------------------------------------------------------------------------
-- Rem by: Dang Le Bao Quynh
/*
Set @Pos1=PATINDEX('%C11%' ,@ListOfCo )
Set @Pos2=PATINDEX('%C12%' ,@ListOfCo )
Set @Pos3=PATINDEX('%C13%' ,@ListOfCo )

If @Pos1 <>0 
Begin
Select @Value1= ValueOfConstant From HT0003 Where CoefficientID='C11'
Set @ListOfCo=REPLACE(@ListOfCo,'C11', cast( @Value1 AS nvarchar(5)))
End
If @Pos2 <>0 
Begin
Select @Value2= ValueOfConstant From HT0003 Where CoefficientID='C12'
Set @ListOfCo=REPLACE(@ListOfCo,'C12', cast( @Value2 AS nvarchar(5)))
End
If @Pos3 <>0 
Begin
Select @Value3= ValueOfConstant From HT0003 Where CoefficientID='C13'
Set @ListOfCo=REPLACE(@ListOfCo,'C13', cast( @Value3 AS nvarchar(5)))
End
--print @ListOfCo
*/



IF @MethodID = 'P10'
	Set @Temp =  '0 AS BaseSalary, '
ELSE IF @MethodID = 'P06'	--- tinh luong theo cong trinh
	BEGIN
		If @BaseSalaryField ='Others' 
		begin 
			Set @Temp =  str(@BaseSalary)+ ' AS BaseSalary, '
		end
		Else
			If  @BaseSalaryField = 'SuggestSalary'
				Set @Temp =  '(Select SuggestSalary From HT1403 Where EmployeeID=HT2400.EmployeeID  and DivisionID = '''+@DivisionID+''' ) AS BaseSalary, '
			Else
				Set @Temp = 'HT2430.'+ @BaseSalaryField+' AS BaseSalary, '
	END
ELSE
	BEGIN
		If @BaseSalaryField ='Others' 
		begin 
			Set @Temp =  str(@BaseSalary)+ ' AS BaseSalary, '
		end
		Else
			If  @BaseSalaryField = 'SuggestSalary'
				Set @Temp =  '(Select SuggestSalary From HT1403 Where EmployeeID=HT2400.EmployeeID  and DivisionID = '''+@DivisionID+''' ) AS BaseSalary, '
			Else
			begin
				IF @CustomerName in ( 21)
			
					Set @Temp = 'HT2430.' + @BaseSalaryField+' AS BaseSalary, ' -- Bổ sung thêm Alias table
				else 
					Set @Temp = '' + @BaseSalaryField+' AS BaseSalary, ' -- Bổ sung thêm Alias table

			end
	END
	

If @MethodID<>'P06' ---- Khong phai luong cong trinh
BEGIN
	IF @CustomerName in ( 21) --->>> Customize Unicare
		Set @sSQL =' 	
				SELECT	ProjectID, HT2400.TranMonth, HT2400.TranYear,  
						HT2400.EmployeeID, HT2400.DivisionID, HT2400.DepartmentID, 
						'+@Temp+' HT2400.TeamID, 
						'+@ListOfCo+' AS GeneralCo
				FROM	HT2400 
				LEFT JOIN HT2430 On
						HT2400.DivisionID = HT2430.DivisionID And 
						HT2400.TranMonth = HT2430.TranMonth And 
						HT2400.TranYear = HT2430.TranYear And 
						HT2400.DepartmentID = HT2430.DepartmentID And 
						Isnull(HT2400.TeamID,'''') = isnull(HT2430.TeamID,'''') And 
						HT2400.EmployeeID = HT2430.EmployeeID 
				WHERE 	HT2400.DivisionID ='''+@DivisionID+''' and
						HT2400.TranMonth ='+str(@TranMonth)+' and
						HT2400.TranYear ='+str(@TranYear)+'  and
						HT2400.DepartmentID Like ''' + @DepartmentID1+ ''' and 
						IsNull(HT2400.TeamID,'''') like  ''' + @TeamID1+ ''' and 						
						HT2400.DepartmentID in (Select DepartmentID From HT5004 Where PayrollMethodID ='''+@PayrollMethodID+'''   and DivisionID = '''+@DivisionID+''' ) '
	ELSE
	BEGIN
		DECLARE @Join NVarchar(4000) = ''
		IF @CustomerName = 50
			SET  @Join = 'LEFT JOIN HT2499 T2 ON T1.EmpFileID = T2.EmpFileID 
						AND T1.TranMonth = T2.TranMonth 
						AND T1.TranYear = T2.TranYear 
						AND T1.DivisionID = T2.DivisionID'
		Set @sSQL =' 	
				SELECT	NULL AS ProjectID, T1.TranMonth, T1.TranYear,  
						T1.EmployeeID, T1.DivisionID, T1.DepartmentID, 
						'+@Temp+' TeamID, 
						'+@ListOfCo+' AS GeneralCo
				FROM	'+@TableHT2400+' T1
				'+@Join+'
				WHERE 	T1.DivisionID ='''+@DivisionID+''' and
						T1.TranMonth ='+str(@TranMonth)+' and
						T1.TranYear ='+str(@TranYear)+'  and
						T1.DepartmentID Like ''' + @DepartmentID1+ ''' and 
						IsNull(T1.TeamID,'''') like  ''' + @TeamID1+ ''' and 
						T1.EmployeeID LIKE '''+@EmployeeID+''' and
						T1.DepartmentID IN (SELECT DepartmentID FROM HT5004 WHERE PayrollMethodID ='''+@PayrollMethodID+''' AND DivisionID = '''+@DivisionID+''' ) 
					'
	END 
	--IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME=  'HV5002')
	--	EXEC ('CREATE VIEW HV5002 AS '+@sSQL +@sWhere)
	--ELSE
	--	EXEC (' ALTER VIEW HV5002 AS  '+@sSQL +@sWhere)
END
	--Xu ly he so cong trinh	
ELSE
BEGIN
	Set @sSQL =' 	
	SELECT	ProjectID, HT2400.TranMonth, HT2400.TranYear,  
			HT2400.EmployeeID, HT2400.DivisionID, HT2400.DepartmentID, 
			'+@Temp+' HT2400.TeamID, 
			'+@ListOfCo+' AS GeneralCo
	FROM	HT2400 
	LEFT JOIN HT2430 On
			HT2400.DivisionID = HT2430.DivisionID And 
			HT2400.TranMonth = HT2430.TranMonth And 
			HT2400.TranYear = HT2430.TranYear And 
			HT2400.DepartmentID = HT2430.DepartmentID And 
		---	Isnull(HT2400.TeamID,'''') = isnull(HT2430.TeamID,'''') And 
			HT2400.EmployeeID = HT2430.EmployeeID 
	WHERE 	HT2400.DivisionID ='''+@DivisionID+''' and
			HT2400.TranMonth ='+str(@TranMonth)+' and
			HT2400.TranYear ='+str(@TranYear)+'  and
			HT2400.DepartmentID Like ''' + @DepartmentID1+ ''' and 
			IsNull(HT2400.TeamID,'''') like  ''' + @TeamID1+ ''' and 
			HT2400.EmployeeID LIKE '''+@EmployeeID+''' and
			HT2400.DepartmentID in (Select DepartmentID From HT5004 Where PayrollMethodID ='''+@PayrollMethodID+'''   and DivisionID = '''+@DivisionID+''' ) '	

--	IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME=  'HV5002')
--		EXEC ('CREATE VIEW HV5002 AS '+@sSQL +@sWhere)
--	ELSE
--		EXEC (' ALTER VIEW HV5002 AS  '+@sSQL +@sWhere)
END	

--print(@sSQL)
--print(@sWhere)

INSERT INTO #HV5002 (ProjectID, TranMonth, TranYear, EmployeeID, DivisionID, DepartmentID, BaseSalary, TeamID, GeneralCo)
EXEC(@sSQL +@sWhere)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

