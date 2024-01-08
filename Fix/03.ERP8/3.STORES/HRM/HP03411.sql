IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP03411]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP03411]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----- Created by Khanh Van on 20/12/2013
----- Purpose: Tinh Thue thu nhap ca nhan
--- Modified on 22/05/2015 by Lê Thị Hạnh: Cập nhật @sSQL* dạng NVARCHAR(MAX) và str() = ltrim()
--- Modified on 24/11/2015 by Kim Vũ : Cập nhật lại điều kiện update HT0338( Bổ sung TransactionID vs bảng tạm), Move Phần update HT0338 ra vòng lặp,
---										chỉ thực hiện 1 lần duy nhất khi đã tính toán xong. Bo sung SumAll cung EmployeeID @SQL11
--- Modified by Tiểu Mai on 11/03/2016: Bổ sung trường hợp lấy %tính thuế cho ANGEL
--- Modify on 03/05/2016 by Bảo Anh: Sửa lỗi Incorrect Syntax ở câu query @sSQL8
--- Modify on 15/06/2016 by Bảo Anh: Sửa lỗi chưa trừ khoản giảm trừ gia cảnh khi tính IncomeAmount cho HT0338
--- Modified by Bảo Thy on 17/01/2017: bổ sung I151 -> I200 (MEIKO)
---- Modified by Phương Thảo on 27/04/2017: Tính luôn cho những người không đủ điều kiện tính TNCN (để lấy dữ liệu giảm trừ gia cảnh)
---- Modified by Phương Thảo on 12/06/2017: Customize Meiko: Tính thuế cho lao động thời vụ và nhân viên tu nghiệp nước ngoài
---- Modified by Huỳnh Thử on 24/03/2021: ISNULL(UnitAmount,0)
---- Modified by Nhật Thanh on 01/04/2022: Xóa giá trị cũ trong bảng HT0341_1
---- Modified by Nhật Thanh on 12/04/2022: Customize luồng cho angel: Xử lý theo phương pháp tính thuế khác nhau
---- Modified by Hoàng Lâm  on 17/11/2023: Bỏ điều kiện phương pháp tính thuế khi xóa thuế cũ khi không cần phương pháp tính thuế khác nhau
---- modified by Nhựt Trường on 06/12/2023: 2023/11/IS/0121, Customer An Phúc Thịnh: Thêm mới điều kiện lọc theo phòng ban, cho phép tính thuế thu nhập theo phòng ban.

--Exec HP03411 'MK', 12, 2016,	'P05'	
					
CREATE PROCEDURE 	[dbo].[HP03411] 	
					@DivisionID as nvarchar(50),   		
					@TranMonth as int, 			
					@TranYear as int,			
					@MethodID as nvarchar(50),
					@FromDepartmentID as nvarchar(50) = '',
					@ToDepartmentID as nvarchar(50) = ''

AS
 Declare @sSQL1 NVARCHAR(MAX) = N'',  
 @sSQL2 NVARCHAR(MAX)= N'',  
 @sSQL3 NVARCHAR(MAX)= N'',  
 @sSQL4 NVARCHAR(MAX)= N'',  
 @sSQL5 NVARCHAR(MAX)= N'',  
 @sSQL6 NVARCHAR(MAX)= N'',  
 @sSQL7 NVARCHAR(MAX)= N'',  
 @sSQL8 NVARCHAR(MAX)= N'',
 @sSQL82 NVARCHAR(MAX)= N'',
 @sSQL83 NVARCHAR(MAX)= N'',
 @sSQL9 NVARCHAR(MAX)= N'',
 @sSQL10 NVARCHAR(MAX)= N'', 
 @sSQL11 NVARCHAR(MAX) =N'',  
 @sSQL12 NVARCHAR(MAX) =N'',  
 @sSQL13 NVARCHAR(MAX) =N'',
 @sSelect1 NVARCHAR(MAX) =N'',
 @sSelect2 NVARCHAR(MAX) =N'',
 @sSelect3 NVARCHAR(MAX) =N'',
 @sSelect4 NVARCHAR(MAX) =N'',
 @sSelect5 NVARCHAR(MAX) =N'',
 @sSelect6 NVARCHAR(MAX) =N'',
 @sSelect7 NVARCHAR(MAX) =N'',
 @sSelect8 VARCHAR(MAX) =N'',
 @sSelect9 NVARCHAR(MAX) =N'',
 @sSelect10 NVARCHAR(MAX) =N'',
 @sSelect11 NVARCHAR(MAX) =N'',
 @sSelect12 NVARCHAR(MAX) =N'',
 @sSelect13 NVARCHAR(MAX) =N'',
 @sSelect14 NVARCHAR(MAX) =N'',
 @sSelect15 NVARCHAR(MAX) =N'',
 @sSelect16 NVARCHAR(MAX) =N'',
 @sSelect17 NVARCHAR(MAX) =N'',
 @sSelect18 NVARCHAR(MAX) =N'',
 @sWhereEmployeeID NVARCHAR(MAX) = N'',
 @CustomerIndex INT,
 @FirstDate datetime, 
 @LastDate datetime,
  @IsForeigner TINYINT  
 
SELECT @IsForeigner = Isnull(IsForeigner,0) FROM HT0336 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND MethodID = @MethodID AND [Disabled] = 0  
  
 
  

SET @FirstDate = CONVERT(Datetime,STR(@TranMonth)+'/'+'1'+'/'++STR(@TranYear)) 
SET @LastDate = DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@FirstDate)+1,0))

SELECT @CustomerIndex = CustomerName From CustomerIndex

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HTT0337]') AND type in (N'U'))  
DROP TABLE [dbo].[HTT0337]  
  
Create table HTT0337  
(  
 IncomeID nvarchar(50) not null, 
 Coefficient decimal(28,8) NULL
     )
 ON [PRIMARY] 

insert into HTT0337 (IncomeID, Coefficient)   
Select InComeID,Coefficient
From HT0337  
where DivisionID = @DivisionID  
and MethodID = @MethodID  
and IsUsed = 1  
--Xoa tinh thue thu nhap ca nhan trong thang  
 -- Angel tính theo phương pháp
IF @CustomerIndex =57
Begin
	Delete HT0338 where DivisionID =@DivisionID and TranMonth =@TranMonth and TranYear = @TranYear AND MethodID = @MethodID  
	Delete HT0341 where DivisionID =@DivisionID and TranMonth =@TranMonth and TranYear = @TranYear AND MethodID = @MethodID
	Delete HT0341_1 where DivisionID =@DivisionID and TranMonth =@TranMonth and TranYear = @TranYear
end
else if @CustomerIndex = 27 -- An Phúc Thịnh
begin
	SELECT DISTINCT EmployeeID
	INTO #EmployeeID
	FROM HT1400 WITH(NOLOCK)
	WHERE DivisionID IN (@DivisionID,'@@@') AND DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID

	SET @sWhereEmployeeID = N' AND EmployeeID IN (SELECT EmployeeID FROM #EmployeeID)'

	Delete HT0338 where DivisionID =@DivisionID and TranMonth =@TranMonth and TranYear = @TranYear AND EmployeeID IN (SELECT EmployeeID FROM #EmployeeID)
	Delete HT0341 where DivisionID =@DivisionID and TranMonth =@TranMonth and TranYear = @TranYear AND EmployeeID IN (SELECT EmployeeID FROM #EmployeeID)
	Delete HT0341_1 where DivisionID =@DivisionID and TranMonth =@TranMonth and TranYear = @TranYear AND EmployeeID IN (SELECT EmployeeID FROM #EmployeeID)
end
else
begin
	Delete HT0338 where DivisionID =@DivisionID and TranMonth =@TranMonth and TranYear = @TranYear
	Delete HT0341 where DivisionID =@DivisionID and TranMonth =@TranMonth and TranYear = @TranYear
	Delete HT0341_1 where DivisionID =@DivisionID and TranMonth =@TranMonth and TranYear = @TranYear
end
  
-- Xac dinh cac khoan thu nhap giam tru  
Set  @sSQL1 = N'  
Select HT3400.DivisionID, HT3400.TransactionID, HT3400.EmployeeID, HT3400.TranMonth,  HT3400.TranYear,    
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I01'') then Income01 *(Select Coefficient from HTT0337 where IncomeID = ''I01'') else 0 end) as Income01 ,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I02'') then Income02 *(Select Coefficient from HTT0337 where IncomeID = ''I02'') else 0 end) as Income02,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I03'') then Income03 *(Select Coefficient from HTT0337 where IncomeID = ''I03'') else 0 end) as Income03,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I04'') then Income04 *(Select Coefficient from HTT0337 where IncomeID = ''I04'') else 0 end) as Income04,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I05'') then Income05 *(Select Coefficient from HTT0337 where IncomeID = ''I05'') else 0 end) as Income05,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I06'') then Income06 *(Select Coefficient from HTT0337 where IncomeID = ''I06'') else 0 end) as Income06,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I07'') then Income07 *(Select Coefficient from HTT0337 where IncomeID = ''I07'') else 0 end) as Income07,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I08'') then Income08 *(Select Coefficient from HTT0337 where IncomeID = ''I08'') else 0 end) as Income08,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I09'') then Income09 *(Select Coefficient from HTT0337 where IncomeID = ''I09'') else 0 end) as Income09,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I10'') then Income10 *(Select Coefficient from HTT0337 where IncomeID = ''I10'') else 0 end) as Income10,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I11'') then Income11 *(Select Coefficient from HTT0337 where IncomeID = ''I11'') else 0 end) as Income11,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I12'') then Income12 *(Select Coefficient from HTT0337 where IncomeID = ''I12'') else 0 end) as Income12,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I13'') then Income13 *(Select Coefficient from HTT0337 where IncomeID = ''I13'') else 0 end) as Income13,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I14'') then Income14 *(Select Coefficient from HTT0337 where IncomeID = ''I14'') else 0 end) as Income14,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I15'') then Income15 *(Select Coefficient from HTT0337 where IncomeID = ''I15'') else 0 end) as Income15,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I16'') then Income16 *(Select Coefficient from HTT0337 where IncomeID = ''I16'') else 0 end) as Income16,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I17'') then Income17 *(Select Coefficient from HTT0337 where IncomeID = ''I17'') else 0 end) as Income17,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I18'') then Income18 *(Select Coefficient from HTT0337 where IncomeID = ''I18'') else 0 end) as Income18,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I19'') then Income19 *(Select Coefficient from HTT0337 where IncomeID = ''I19'') else 0 end) as Income19,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I20'') then Income20 *(Select Coefficient from HTT0337 where IncomeID = ''I20'') else 0 end) as Income20,  '
Set  @sSQL2 = N' 
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I21'') then Income21 *(Select Coefficient from HTT0337 where IncomeID = ''I21'') else 0 end) as Income21,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I22'') then Income22 *(Select Coefficient from HTT0337 where IncomeID = ''I22'') else 0 end) as Income22,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I23'') then Income23 *(Select Coefficient from HTT0337 where IncomeID = ''I23'') else 0 end) as Income23,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I24'') then Income24 *(Select Coefficient from HTT0337 where IncomeID = ''I24'') else 0 end) as Income24,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I25'') then Income25 *(Select Coefficient from HTT0337 where IncomeID = ''I25'') else 0 end) as Income25,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I26'') then Income26 *(Select Coefficient from HTT0337 where IncomeID = ''I26'') else 0 end) as Income26,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I27'') then Income27 *(Select Coefficient from HTT0337 where IncomeID = ''I27'') else 0 end) as Income27,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I28'') then Income28 *(Select Coefficient from HTT0337 where IncomeID = ''I28'') else 0 end) as Income28,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I29'') then Income29 *(Select Coefficient from HTT0337 where IncomeID = ''I29'') else 0 end) as Income29,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I30'') then Income30 *(Select Coefficient from HTT0337 where IncomeID = ''I30'') else 0 end) as Income30,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I31'') then Income31 *(Select Coefficient from HTT0337 where IncomeID = ''I31'') else 0 end) as Income31,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I32'') then Income32 *(Select Coefficient from HTT0337 where IncomeID = ''I32'') else 0 end) as Income32,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I33'') then Income33 *(Select Coefficient from HTT0337 where IncomeID = ''I33'') else 0 end) as Income33,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I34'') then Income34 *(Select Coefficient from HTT0337 where IncomeID = ''I34'') else 0 end) as Income34,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I35'') then Income35 *(Select Coefficient from HTT0337 where IncomeID = ''I35'') else 0 end) as Income35,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I36'') then Income36 *(Select Coefficient from HTT0337 where IncomeID = ''I36'') else 0 end) as Income36,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I37'') then Income37 *(Select Coefficient from HTT0337 where IncomeID = ''I37'') else 0 end) as Income37,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I38'') then Income38 *(Select Coefficient from HTT0337 where IncomeID = ''I38'') else 0 end) as Income38,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I39'') then Income39 *(Select Coefficient from HTT0337 where IncomeID = ''I39'') else 0 end) as Income39,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I40'') then Income40 *(Select Coefficient from HTT0337 where IncomeID = ''I40'') else 0 end) as Income40,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I41'') then Income41 *(Select Coefficient from HTT0337 where IncomeID = ''I41'') else 0 end) as Income41,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I42'') then Income42 *(Select Coefficient from HTT0337 where IncomeID = ''I42'') else 0 end) as Income42,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I43'') then Income43 *(Select Coefficient from HTT0337 where IncomeID = ''I43'') else 0 end) as Income43,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I44'') then Income44 *(Select Coefficient from HTT0337 where IncomeID = ''I44'') else 0 end) as Income44,'
SET @sSelect1 = '  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I45'') then Income45 *(Select Coefficient from HTT0337 where IncomeID = ''I45'') else 0 end) as Income45,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I46'') then Income46 *(Select Coefficient from HTT0337 where IncomeID = ''I46'') else 0 end) as Income46,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I47'') then Income47 *(Select Coefficient from HTT0337 where IncomeID = ''I47'') else 0 end) as Income47,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I48'') then Income48 *(Select Coefficient from HTT0337 where IncomeID = ''I48'') else 0 end) as Income48,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I49'') then Income49 *(Select Coefficient from HTT0337 where IncomeID = ''I49'') else 0 end) as Income49,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I50'') then Income50 *(Select Coefficient from HTT0337 where IncomeID = ''I50'') else 0 end) as Income50,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I51'') then Income51 *(Select Coefficient from HTT0337 where IncomeID = ''I51'') else 0 end) as Income51,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I52'') then Income52 *(Select Coefficient from HTT0337 where IncomeID = ''I52'') else 0 end) as Income52,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I53'') then Income53 *(Select Coefficient from HTT0337 where IncomeID = ''I53'') else 0 end) as Income53,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I54'') then Income54 *(Select Coefficient from HTT0337 where IncomeID = ''I54'') else 0 end) as Income54,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I55'') then Income55 *(Select Coefficient from HTT0337 where IncomeID = ''I55'') else 0 end) as Income55,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I56'') then Income56 *(Select Coefficient from HTT0337 where IncomeID = ''I56'') else 0 end) as Income56,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I57'') then Income57 *(Select Coefficient from HTT0337 where IncomeID = ''I57'') else 0 end) as Income57,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I58'') then Income58 *(Select Coefficient from HTT0337 where IncomeID = ''I58'') else 0 end) as Income58,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I59'') then Income59 *(Select Coefficient from HTT0337 where IncomeID = ''I59'') else 0 end) as Income59,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I60'') then Income60 *(Select Coefficient from HTT0337 where IncomeID = ''I60'') else 0 end) as Income60,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I61'') then Income61 *(Select Coefficient from HTT0337 where IncomeID = ''I61'') else 0 end) as Income61,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I62'') then Income62 *(Select Coefficient from HTT0337 where IncomeID = ''I62'') else 0 end) as Income62,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I63'') then Income63 *(Select Coefficient from HTT0337 where IncomeID = ''I63'') else 0 end) as Income63,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I64'') then Income64 *(Select Coefficient from HTT0337 where IncomeID = ''I64'') else 0 end) as Income64,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I65'') then Income65 *(Select Coefficient from HTT0337 where IncomeID = ''I65'') else 0 end) as Income65,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I66'') then Income66 *(Select Coefficient from HTT0337 where IncomeID = ''I66'') else 0 end) as Income66,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I67'') then Income67 *(Select Coefficient from HTT0337 where IncomeID = ''I67'') else 0 end) as Income67,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I68'') then Income68 *(Select Coefficient from HTT0337 where IncomeID = ''I68'') else 0 end) as Income68,'
SET @sSelect2 = '
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I69'') then Income69 *(Select Coefficient from HTT0337 where IncomeID = ''I69'') else 0 end) as Income69,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I70'') then Income70 *(Select Coefficient from HTT0337 where IncomeID = ''I70'') else 0 end) as Income70, 
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I71'') then Income71 *(Select Coefficient from HTT0337 where IncomeID = ''I71'') else 0 end) as Income71,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I72'') then Income72 *(Select Coefficient from HTT0337 where IncomeID = ''I72'') else 0 end) as Income72,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I73'') then Income73 *(Select Coefficient from HTT0337 where IncomeID = ''I73'') else 0 end) as Income73,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I74'') then Income74 *(Select Coefficient from HTT0337 where IncomeID = ''I74'') else 0 end) as Income74,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I75'') then Income75 *(Select Coefficient from HTT0337 where IncomeID = ''I75'') else 0 end) as Income75,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I76'') then Income76 *(Select Coefficient from HTT0337 where IncomeID = ''I76'') else 0 end) as Income76,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I77'') then Income77 *(Select Coefficient from HTT0337 where IncomeID = ''I77'') else 0 end) as Income77,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I78'') then Income78 *(Select Coefficient from HTT0337 where IncomeID = ''I78'') else 0 end) as Income78,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I79'') then Income79 *(Select Coefficient from HTT0337 where IncomeID = ''I79'') else 0 end) as Income79,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I80'') then Income80 *(Select Coefficient from HTT0337 where IncomeID = ''I80'') else 0 end) as Income80,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I81'') then Income81 *(Select Coefficient from HTT0337 where IncomeID = ''I81'') else 0 end) as Income81,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I82'') then Income82 *(Select Coefficient from HTT0337 where IncomeID = ''I82'') else 0 end) as Income82,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I83'') then Income83 *(Select Coefficient from HTT0337 where IncomeID = ''I83'') else 0 end) as Income83,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I84'') then Income84 *(Select Coefficient from HTT0337 where IncomeID = ''I84'') else 0 end) as Income84,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I85'') then Income85 *(Select Coefficient from HTT0337 where IncomeID = ''I85'') else 0 end) as Income85,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I86'') then Income86 *(Select Coefficient from HTT0337 where IncomeID = ''I86'') else 0 end) as Income86,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I87'') then Income87 *(Select Coefficient from HTT0337 where IncomeID = ''I87'') else 0 end) as Income87,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I88'') then Income88 *(Select Coefficient from HTT0337 where IncomeID = ''I88'') else 0 end) as Income88,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I89'') then Income89 *(Select Coefficient from HTT0337 where IncomeID = ''I89'') else 0 end) as Income89,'
SET @sSelect3 = '  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I90'') then Income90 *(Select Coefficient from HTT0337 where IncomeID = ''I90'') else 0 end) as Income90, 
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I91'') then Income91 *(Select Coefficient from HTT0337 where IncomeID = ''I91'') else 0 end) as Income91,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I92'') then Income92 *(Select Coefficient from HTT0337 where IncomeID = ''I92'') else 0 end) as Income92,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I93'') then Income93 *(Select Coefficient from HTT0337 where IncomeID = ''I93'') else 0 end) as Income93,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I94'') then Income94 *(Select Coefficient from HTT0337 where IncomeID = ''I94'') else 0 end) as Income94,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I95'') then Income95 *(Select Coefficient from HTT0337 where IncomeID = ''I95'') else 0 end) as Income95,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I96'') then Income96 *(Select Coefficient from HTT0337 where IncomeID = ''I96'') else 0 end) as Income96,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I97'') then Income97 *(Select Coefficient from HTT0337 where IncomeID = ''I97'') else 0 end) as Income97,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I98'') then Income98 *(Select Coefficient from HTT0337 where IncomeID = ''I98'') else 0 end) as Income98,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I99'') then Income99 *(Select Coefficient from HTT0337 where IncomeID = ''I99'') else 0 end) as Income99,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I100'') then Income100 *(Select Coefficient from HTT0337 where IncomeID = ''I100'') else 0 end) as Income100,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I101'') then Income101 *(Select Coefficient from HTT0337 where IncomeID = ''I101'') else 0 end) as Income101 ,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I102'') then Income102 *(Select Coefficient from HTT0337 where IncomeID = ''I102'') else 0 end) as Income102,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I103'') then Income103 *(Select Coefficient from HTT0337 where IncomeID = ''I103'') else 0 end) as Income103,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I104'') then Income104 *(Select Coefficient from HTT0337 where IncomeID = ''I104'') else 0 end) as Income104,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I105'') then Income105 *(Select Coefficient from HTT0337 where IncomeID = ''I105'') else 0 end) as Income105,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I106'') then Income106 *(Select Coefficient from HTT0337 where IncomeID = ''I106'') else 0 end) as Income106,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I107'') then Income107 *(Select Coefficient from HTT0337 where IncomeID = ''I107'') else 0 end) as Income107,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I108'') then Income108 *(Select Coefficient from HTT0337 where IncomeID = ''I108'') else 0 end) as Income108,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I109'') then Income109 *(Select Coefficient from HTT0337 where IncomeID = ''I109'') else 0 end) as Income109,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I110'') then Income110 *(Select Coefficient from HTT0337 where IncomeID = ''I110'') else 0 end) as Income110,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I111'') then Income111 *(Select Coefficient from HTT0337 where IncomeID = ''I111'') else 0 end) as Income111,'
SET @sSelect4 = '    
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I112'') then Income112 *(Select Coefficient from HTT0337 where IncomeID = ''I112'') else 0 end) as Income112,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I113'') then Income113 *(Select Coefficient from HTT0337 where IncomeID = ''I113'') else 0 end) as Income113,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I114'') then Income114 *(Select Coefficient from HTT0337 where IncomeID = ''I114'') else 0 end) as Income114,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I115'') then Income115 *(Select Coefficient from HTT0337 where IncomeID = ''I115'') else 0 end) as Income115,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I116'') then Income116 *(Select Coefficient from HTT0337 where IncomeID = ''I116'') else 0 end) as Income116,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I117'') then Income117 *(Select Coefficient from HTT0337 where IncomeID = ''I117'') else 0 end) as Income117,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I118'') then Income118 *(Select Coefficient from HTT0337 where IncomeID = ''I118'') else 0 end) as Income118,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I119'') then Income119 *(Select Coefficient from HTT0337 where IncomeID = ''I119'') else 0 end) as Income119,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I120'') then Income120 *(Select Coefficient from HTT0337 where IncomeID = ''I120'') else 0 end) as Income120,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I121'') then Income121 *(Select Coefficient from HTT0337 where IncomeID = ''I121'') else 0 end) as Income121,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I122'') then Income122 *(Select Coefficient from HTT0337 where IncomeID = ''I122'') else 0 end) as Income122,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I123'') then Income123 *(Select Coefficient from HTT0337 where IncomeID = ''I123'') else 0 end) as Income123,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I124'') then Income124 *(Select Coefficient from HTT0337 where IncomeID = ''I124'') else 0 end) as Income124,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I125'') then Income125 *(Select Coefficient from HTT0337 where IncomeID = ''I125'') else 0 end) as Income125,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I126'') then Income126 *(Select Coefficient from HTT0337 where IncomeID = ''I126'') else 0 end) as Income126,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I127'') then Income127 *(Select Coefficient from HTT0337 where IncomeID = ''I127'') else 0 end) as Income127,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I128'') then Income128 *(Select Coefficient from HTT0337 where IncomeID = ''I128'') else 0 end) as Income128,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I129'') then Income129 *(Select Coefficient from HTT0337 where IncomeID = ''I129'') else 0 end) as Income129,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I130'') then Income130 *(Select Coefficient from HTT0337 where IncomeID = ''I130'') else 0 end) as Income130,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I131'') then Income131 *(Select Coefficient from HTT0337 where IncomeID = ''I131'') else 0 end) as Income131,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I132'') then Income132 *(Select Coefficient from HTT0337 where IncomeID = ''I132'') else 0 end) as Income132,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I133'') then Income133 *(Select Coefficient from HTT0337 where IncomeID = ''I133'') else 0 end) as Income133,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I134'') then Income134 *(Select Coefficient from HTT0337 where IncomeID = ''I134'') else 0 end) as Income134,'
SET @sSelect5 = '  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I135'') then Income135 *(Select Coefficient from HTT0337 where IncomeID = ''I135'') else 0 end) as Income135, 
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I136'') then Income136 *(Select Coefficient from HTT0337 where IncomeID = ''I136'') else 0 end) as Income136,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I137'') then Income137 *(Select Coefficient from HTT0337 where IncomeID = ''I137'') else 0 end) as Income137,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I138'') then Income138 *(Select Coefficient from HTT0337 where IncomeID = ''I138'') else 0 end) as Income138,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I139'') then Income139 *(Select Coefficient from HTT0337 where IncomeID = ''I139'') else 0 end) as Income139,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I140'') then Income140 *(Select Coefficient from HTT0337 where IncomeID = ''I140'') else 0 end) as Income140,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I141'') then Income141 *(Select Coefficient from HTT0337 where IncomeID = ''I141'') else 0 end) as Income141,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I142'') then Income142 *(Select Coefficient from HTT0337 where IncomeID = ''I142'') else 0 end) as Income142,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I143'') then Income143 *(Select Coefficient from HTT0337 where IncomeID = ''I143'') else 0 end) as Income143,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I144'') then Income144 *(Select Coefficient from HTT0337 where IncomeID = ''I144'') else 0 end) as Income144,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I145'') then Income145 *(Select Coefficient from HTT0337 where IncomeID = ''I145'') else 0 end) as Income145, 
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I146'') then Income146 *(Select Coefficient from HTT0337 where IncomeID = ''I146'') else 0 end) as Income146,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I147'') then Income147 *(Select Coefficient from HTT0337 where IncomeID = ''I147'') else 0 end) as Income147,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I148'') then Income148 *(Select Coefficient from HTT0337 where IncomeID = ''I148'') else 0 end) as Income148,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I149'') then Income149 *(Select Coefficient from HTT0337 where IncomeID = ''I149'') else 0 end) as Income149,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I150'') then Income150 *(Select Coefficient from HTT0337 where IncomeID = ''I150'') else 0 end) as Income150, '
SET @sSelect14 = '
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I151'') then Income151 *(Select Coefficient from HTT0337 where IncomeID = ''I151'') else 0 end) as Income151 ,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I152'') then Income152 *(Select Coefficient from HTT0337 where IncomeID = ''I152'') else 0 end) as Income152,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I153'') then Income153 *(Select Coefficient from HTT0337 where IncomeID = ''I153'') else 0 end) as Income153,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I154'') then Income154 *(Select Coefficient from HTT0337 where IncomeID = ''I154'') else 0 end) as Income154,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I155'') then Income155 *(Select Coefficient from HTT0337 where IncomeID = ''I155'') else 0 end) as Income155,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I156'') then Income156 *(Select Coefficient from HTT0337 where IncomeID = ''I156'') else 0 end) as Income156,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I157'') then Income157 *(Select Coefficient from HTT0337 where IncomeID = ''I157'') else 0 end) as Income157,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I158'') then Income158 *(Select Coefficient from HTT0337 where IncomeID = ''I158'') else 0 end) as Income158,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I159'') then Income159 *(Select Coefficient from HTT0337 where IncomeID = ''I159'') else 0 end) as Income159,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I160'') then Income160 *(Select Coefficient from HTT0337 where IncomeID = ''I160'') else 0 end) as Income160,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I161'') then Income161 *(Select Coefficient from HTT0337 where IncomeID = ''I161'') else 0 end) as Income161,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I162'') then Income162 *(Select Coefficient from HTT0337 where IncomeID = ''I162'') else 0 end) as Income162,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I163'') then Income163 *(Select Coefficient from HTT0337 where IncomeID = ''I163'') else 0 end) as Income163,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I164'') then Income164 *(Select Coefficient from HTT0337 where IncomeID = ''I164'') else 0 end) as Income164,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I165'') then Income165 *(Select Coefficient from HTT0337 where IncomeID = ''I165'') else 0 end) as Income165,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I166'') then Income166 *(Select Coefficient from HTT0337 where IncomeID = ''I166'') else 0 end) as Income166,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I167'') then Income167 *(Select Coefficient from HTT0337 where IncomeID = ''I167'') else 0 end) as Income167,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I168'') then Income168 *(Select Coefficient from HTT0337 where IncomeID = ''I168'') else 0 end) as Income168,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I169'') then Income169 *(Select Coefficient from HTT0337 where IncomeID = ''I169'') else 0 end) as Income169,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I170'') then Income170 *(Select Coefficient from HTT0337 where IncomeID = ''I170'') else 0 end) as Income170,'
SET @sSelect15 = '
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I171'') then Income171 *(Select Coefficient from HTT0337 where IncomeID = ''I171'') else 0 end) as Income171,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I172'') then Income172 *(Select Coefficient from HTT0337 where IncomeID = ''I172'') else 0 end) as Income172,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I173'') then Income173 *(Select Coefficient from HTT0337 where IncomeID = ''I173'') else 0 end) as Income173,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I174'') then Income174 *(Select Coefficient from HTT0337 where IncomeID = ''I174'') else 0 end) as Income174,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I175'') then Income175 *(Select Coefficient from HTT0337 where IncomeID = ''I175'') else 0 end) as Income175,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I176'') then Income176 *(Select Coefficient from HTT0337 where IncomeID = ''I176'') else 0 end) as Income176,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I177'') then Income177 *(Select Coefficient from HTT0337 where IncomeID = ''I177'') else 0 end) as Income177,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I178'') then Income178 *(Select Coefficient from HTT0337 where IncomeID = ''I178'') else 0 end) as Income178,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I179'') then Income179 *(Select Coefficient from HTT0337 where IncomeID = ''I179'') else 0 end) as Income179,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I180'') then Income180 *(Select Coefficient from HTT0337 where IncomeID = ''I180'') else 0 end) as Income180,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I181'') then Income181 *(Select Coefficient from HTT0337 where IncomeID = ''I181'') else 0 end) as Income181,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I182'') then Income182 *(Select Coefficient from HTT0337 where IncomeID = ''I182'') else 0 end) as Income182,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I183'') then Income183 *(Select Coefficient from HTT0337 where IncomeID = ''I183'') else 0 end) as Income183,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I184'') then Income184 *(Select Coefficient from HTT0337 where IncomeID = ''I184'') else 0 end) as Income184,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I185'') then Income185 *(Select Coefficient from HTT0337 where IncomeID = ''I185'') else 0 end) as Income185, 
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I186'') then Income186 *(Select Coefficient from HTT0337 where IncomeID = ''I186'') else 0 end) as Income186,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I187'') then Income187 *(Select Coefficient from HTT0337 where IncomeID = ''I187'') else 0 end) as Income187,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I188'') then Income188 *(Select Coefficient from HTT0337 where IncomeID = ''I188'') else 0 end) as Income188,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I189'') then Income189 *(Select Coefficient from HTT0337 where IncomeID = ''I189'') else 0 end) as Income189,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I190'') then Income190 *(Select Coefficient from HTT0337 where IncomeID = ''I190'') else 0 end) as Income190,'
SET @sSelect16 = '
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I191'') then Income191 *(Select Coefficient from HTT0337 where IncomeID = ''I191'') else 0 end) as Income191,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I192'') then Income192 *(Select Coefficient from HTT0337 where IncomeID = ''I192'') else 0 end) as Income192,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I193'') then Income193 *(Select Coefficient from HTT0337 where IncomeID = ''I193'') else 0 end) as Income193,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I194'') then Income194 *(Select Coefficient from HTT0337 where IncomeID = ''I194'') else 0 end) as Income194,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I195'') then Income195 *(Select Coefficient from HTT0337 where IncomeID = ''I195'') else 0 end) as Income195, 
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I196'') then Income196 *(Select Coefficient from HTT0337 where IncomeID = ''I196'') else 0 end) as Income196,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I197'') then Income197 *(Select Coefficient from HTT0337 where IncomeID = ''I197'') else 0 end) as Income197,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I198'') then Income198 *(Select Coefficient from HTT0337 where IncomeID = ''I198'') else 0 end) as Income198,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I199'') then Income199 *(Select Coefficient from HTT0337 where IncomeID = ''I199'') else 0 end) as Income199,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''I200'') then Income200 *(Select Coefficient from HTT0337 where IncomeID = ''I200'') else 0 end) as Income200,
'
Set  @sSQL3 = N'   
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S01'') then SubAmount01 *(Select Coefficient from HTT0337 where IncomeID = ''S01'')else 0 end) as SubAmount01,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S02'') then SubAmount02 *(Select Coefficient from HTT0337 where IncomeID = ''S02'')else 0 end) as SubAmount02,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S03'') then SubAmount03 *(Select Coefficient from HTT0337 where IncomeID = ''S03'')else 0 end) as SubAmount03,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S04'') then SubAmount04 *(Select Coefficient from HTT0337 where IncomeID = ''S04'')else 0 end) as SubAmount04,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S05'') then SubAmount05 *(Select Coefficient from HTT0337 where IncomeID = ''S05'')else 0 end) as SubAmount05,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S06'') then SubAmount06 *(Select Coefficient from HTT0337 where IncomeID = ''S06'')else 0 end) as SubAmount06,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S07'') then SubAmount07 *(Select Coefficient from HTT0337 where IncomeID = ''S07'')else 0 end) as SubAmount07,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S08'') then SubAmount08 *(Select Coefficient from HTT0337 where IncomeID = ''S08'')else 0 end) as SubAmount08,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S09'') then SubAmount09 *(Select Coefficient from HTT0337 where IncomeID = ''S09'')else 0 end) as SubAmount09,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S10'') then SubAmount10 *(Select Coefficient from HTT0337 where IncomeID = ''S10'')else 0 end) as SubAmount10,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S11'') then SubAmount11 *(Select Coefficient from HTT0337 where IncomeID = ''S11'')else 0 end) as SubAmount11,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S12'') then SubAmount12 *(Select Coefficient from HTT0337 where IncomeID = ''S12'')else 0 end) as SubAmount12,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S13'') then SubAmount13 *(Select Coefficient from HTT0337 where IncomeID = ''S13'')else 0 end) as SubAmount13,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S14'') then SubAmount14 *(Select Coefficient from HTT0337 where IncomeID = ''S14'')else 0 end) as SubAmount14,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S15'') then SubAmount15 *(Select Coefficient from HTT0337 where IncomeID = ''S15'')else 0 end) as SubAmount15,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S16'') then SubAmount16 *(Select Coefficient from HTT0337 where IncomeID = ''S16'')else 0 end) as SubAmount16,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S17'') then SubAmount17 *(Select Coefficient from HTT0337 where IncomeID = ''S17'')else 0 end) as SubAmount17,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S18'') then SubAmount18 *(Select Coefficient from HTT0337 where IncomeID = ''S18'')else 0 end) as SubAmount18,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S19'') then SubAmount19 *(Select Coefficient from HTT0337 where IncomeID = ''S19'')else 0 end) as SubAmount19,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S20'') then SubAmount20 *(Select Coefficient from HTT0337 where IncomeID = ''S20'')else 0 end) as SubAmount20 ,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S21'') then SubAmount21 *(Select Coefficient from HTT0337 where IncomeID = ''S21'') else 0 end) as SubAmount21,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S22'') then SubAmount22 *(Select Coefficient from HTT0337 where IncomeID = ''S22'') else 0 end) as SubAmount22,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S23'') then SubAmount23 *(Select Coefficient from HTT0337 where IncomeID = ''S23'') else 0 end) as SubAmount23,'
SET @sSelect6 = '   
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S24'') then SubAmount24 *(Select Coefficient from HTT0337 where IncomeID = ''S24'') else 0 end) as SubAmount24,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S25'') then SubAmount25 *(Select Coefficient from HTT0337 where IncomeID = ''S25'') else 0 end) as SubAmount25,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S26'') then SubAmount26 *(Select Coefficient from HTT0337 where IncomeID = ''S26'') else 0 end) as SubAmount26,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S27'') then SubAmount27 *(Select Coefficient from HTT0337 where IncomeID = ''S27'') else 0 end) as SubAmount27,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S28'') then SubAmount28 *(Select Coefficient from HTT0337 where IncomeID = ''S28'') else 0 end) as SubAmount28,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S29'') then SubAmount29 *(Select Coefficient from HTT0337 where IncomeID = ''S29'') else 0 end) as SubAmount29,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S30'') then SubAmount30 *(Select Coefficient from HTT0337 where IncomeID = ''S30'') else 0 end) as SubAmount30,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S31'') then SubAmount31 *(Select Coefficient from HTT0337 where IncomeID = ''S31'') else 0 end) as SubAmount31,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S32'') then SubAmount32 *(Select Coefficient from HTT0337 where IncomeID = ''S32'') else 0 end) as SubAmount32,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S33'') then SubAmount33 *(Select Coefficient from HTT0337 where IncomeID = ''S33'') else 0 end) as SubAmount33,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S34'') then SubAmount34 *(Select Coefficient from HTT0337 where IncomeID = ''S34'') else 0 end) as SubAmount34,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S35'') then SubAmount35 *(Select Coefficient from HTT0337 where IncomeID = ''S35'') else 0 end) as SubAmount35,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S36'') then SubAmount36 *(Select Coefficient from HTT0337 where IncomeID = ''S36'') else 0 end) as SubAmount36,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S37'') then SubAmount37 *(Select Coefficient from HTT0337 where IncomeID = ''S37'') else 0 end) as SubAmount37,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S38'') then SubAmount38 *(Select Coefficient from HTT0337 where IncomeID = ''S38'') else 0 end) as SubAmount38,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S39'') then SubAmount39 *(Select Coefficient from HTT0337 where IncomeID = ''S39'') else 0 end) as SubAmount39,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S40'') then SubAmount40 *(Select Coefficient from HTT0337 where IncomeID = ''S40'') else 0 end) as SubAmount40,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S41'') then SubAmount41 *(Select Coefficient from HTT0337 where IncomeID = ''S41'') else 0 end) as SubAmount41,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S42'') then SubAmount42 *(Select Coefficient from HTT0337 where IncomeID = ''S42'') else 0 end) as SubAmount42,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S43'') then SubAmount43 *(Select Coefficient from HTT0337 where IncomeID = ''S43'') else 0 end) as SubAmount43,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S44'') then SubAmount44 *(Select Coefficient from HTT0337 where IncomeID = ''S44'') else 0 end) as SubAmount44,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S45'') then SubAmount45 *(Select Coefficient from HTT0337 where IncomeID = ''S45'') else 0 end) as SubAmount45,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S46'') then SubAmount46 *(Select Coefficient from HTT0337 where IncomeID = ''S46'') else 0 end) as SubAmount46,'
SET @sSelect7 = '
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S47'') then SubAmount47 *(Select Coefficient from HTT0337 where IncomeID = ''S47'') else 0 end) as SubAmount47,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S48'') then SubAmount48 *(Select Coefficient from HTT0337 where IncomeID = ''S48'') else 0 end) as SubAmount48,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S49'') then SubAmount49 *(Select Coefficient from HTT0337 where IncomeID = ''S49'') else 0 end) as SubAmount49,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S50'') then SubAmount50 *(Select Coefficient from HTT0337 where IncomeID = ''S50'') else 0 end) as SubAmount50,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S51'') then SubAmount51 *(Select Coefficient from HTT0337 where IncomeID = ''S51'') else 0 end) as SubAmount51,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S52'') then SubAmount52 *(Select Coefficient from HTT0337 where IncomeID = ''S52'') else 0 end) as SubAmount52,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S53'') then SubAmount53 *(Select Coefficient from HTT0337 where IncomeID = ''S53'') else 0 end) as SubAmount53,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S54'') then SubAmount54 *(Select Coefficient from HTT0337 where IncomeID = ''S54'') else 0 end) as SubAmount54,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S55'') then SubAmount55 *(Select Coefficient from HTT0337 where IncomeID = ''S55'') else 0 end) as SubAmount55,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S56'') then SubAmount56 *(Select Coefficient from HTT0337 where IncomeID = ''S56'') else 0 end) as SubAmount56,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S57'') then SubAmount57 *(Select Coefficient from HTT0337 where IncomeID = ''S57'') else 0 end) as SubAmount57,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S58'') then SubAmount58 *(Select Coefficient from HTT0337 where IncomeID = ''S58'') else 0 end) as SubAmount58,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S59'') then SubAmount59 *(Select Coefficient from HTT0337 where IncomeID = ''S59'') else 0 end) as SubAmount59,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S60'') then SubAmount60 *(Select Coefficient from HTT0337 where IncomeID = ''S60'') else 0 end) as SubAmount60,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S61'') then SubAmount61 *(Select Coefficient from HTT0337 where IncomeID = ''S61'') else 0 end) as SubAmount61,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S62'') then SubAmount62 *(Select Coefficient from HTT0337 where IncomeID = ''S62'') else 0 end) as SubAmount62,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S63'') then SubAmount63 *(Select Coefficient from HTT0337 where IncomeID = ''S63'') else 0 end) as SubAmount63,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S64'') then SubAmount64 *(Select Coefficient from HTT0337 where IncomeID = ''S64'') else 0 end) as SubAmount64,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S65'') then SubAmount65 *(Select Coefficient from HTT0337 where IncomeID = ''S65'') else 0 end) as SubAmount65,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S66'') then SubAmount66 *(Select Coefficient from HTT0337 where IncomeID = ''S66'') else 0 end) as SubAmount66,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S67'') then SubAmount67 *(Select Coefficient from HTT0337 where IncomeID = ''S67'') else 0 end) as SubAmount67,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S68'') then SubAmount68 *(Select Coefficient from HTT0337 where IncomeID = ''S68'') else 0 end) as SubAmount68,'
SET @sSelect8 = '  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S69'') then SubAmount69 *(Select Coefficient from HTT0337 where IncomeID = ''S69'') else 0 end) as SubAmount69,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S70'') then SubAmount70 *(Select Coefficient from HTT0337 where IncomeID = ''S70'') else 0 end) as SubAmount70,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S71'') then SubAmount71 *(Select Coefficient from HTT0337 where IncomeID = ''S71'') else 0 end) as SubAmount71,      
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S72'') then SubAmount72 *(Select Coefficient from HTT0337 where IncomeID = ''S72'') else 0 end) as SubAmount72,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S73'') then SubAmount73 *(Select Coefficient from HTT0337 where IncomeID = ''S73'') else 0 end) as SubAmount73,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S74'') then SubAmount74 *(Select Coefficient from HTT0337 where IncomeID = ''S74'') else 0 end) as SubAmount74,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S75'') then SubAmount75 *(Select Coefficient from HTT0337 where IncomeID = ''S75'') else 0 end) as SubAmount75,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S76'') then SubAmount76 *(Select Coefficient from HTT0337 where IncomeID = ''S76'') else 0 end) as SubAmount76,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S77'') then SubAmount77 *(Select Coefficient from HTT0337 where IncomeID = ''S77'') else 0 end) as SubAmount77,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S78'') then SubAmount78 *(Select Coefficient from HTT0337 where IncomeID = ''S78'') else 0 end) as SubAmount78,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S79'') then SubAmount79 *(Select Coefficient from HTT0337 where IncomeID = ''S79'') else 0 end) as SubAmount79,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S80'') then SubAmount80 *(Select Coefficient from HTT0337 where IncomeID = ''S80'') else 0 end) as SubAmount80,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S81'') then SubAmount81 *(Select Coefficient from HTT0337 where IncomeID = ''S81'') else 0 end) as SubAmount81,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S82'') then SubAmount82 *(Select Coefficient from HTT0337 where IncomeID = ''S82'') else 0 end) as SubAmount82,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S83'') then SubAmount83 *(Select Coefficient from HTT0337 where IncomeID = ''S83'') else 0 end) as SubAmount83,'

SET @sSelect9 = ' 
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S84'') then SubAmount84 *(Select Coefficient from HTT0337 where IncomeID = ''S84'') else 0 end) as SubAmount84,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S85'') then SubAmount85 *(Select Coefficient from HTT0337 where IncomeID = ''S85'') else 0 end) as SubAmount85,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S86'') then SubAmount86 *(Select Coefficient from HTT0337 where IncomeID = ''S86'') else 0 end) as SubAmount86,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S87'') then SubAmount87 *(Select Coefficient from HTT0337 where IncomeID = ''S87'') else 0 end) as SubAmount87,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S88'') then SubAmount88 *(Select Coefficient from HTT0337 where IncomeID = ''S88'') else 0 end) as SubAmount88,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S89'') then SubAmount89 *(Select Coefficient from HTT0337 where IncomeID = ''S89'') else 0 end) as SubAmount89,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S90'') then SubAmount90 *(Select Coefficient from HTT0337 where IncomeID = ''S90'') else 0 end) as SubAmount90,
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S91'') then SubAmount91 *(Select Coefficient from HTT0337 where IncomeID = ''S91'') else 0 end) as SubAmount91,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S92'') then SubAmount92 *(Select Coefficient from HTT0337 where IncomeID = ''S92'') else 0 end) as SubAmount92,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S93'') then SubAmount93 *(Select Coefficient from HTT0337 where IncomeID = ''S93'') else 0 end) as SubAmount93,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S94'') then SubAmount94 *(Select Coefficient from HTT0337 where IncomeID = ''S94'') else 0 end) as SubAmount94,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S95'') then SubAmount95 *(Select Coefficient from HTT0337 where IncomeID = ''S95'') else 0 end) as SubAmount95,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S96'') then SubAmount96 *(Select Coefficient from HTT0337 where IncomeID = ''S96'') else 0 end) as SubAmount96,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S97'') then SubAmount97 *(Select Coefficient from HTT0337 where IncomeID = ''S97'') else 0 end) as SubAmount97,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S98'') then SubAmount98 *(Select Coefficient from HTT0337 where IncomeID = ''S98'') else 0 end) as SubAmount98,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S99'') then SubAmount99 *(Select Coefficient from HTT0337 where IncomeID = ''S99'') else 0 end) as SubAmount99,  
(Case when Exists(Select 1 from HTT0337 where IncomeID = ''S100'') then SubAmount100 *(Select Coefficient from HTT0337 where IncomeID = ''S100'') else 0 end) as SubAmount100
 Into #HV3400  
 From HT3400 
 LEFT JOIN HT3499 ON HT3400.DivisionID =  HT3499.DivisionID AND HT3400.TransactionID =  HT3499.TransactionID
 Where HT3400.DivisionID ='''+@DivisionID+'''   
 and HT3400.TranMonth ='+LTRIM(@TranMonth)+' and HT3400.TranYear ='+LTRIM(@TranYear)+'    
 '+REPLACE(@sWhereEmployeeID,'AND EmployeeID','AND HT3400.EmployeeID')+'
'  

-- Sum cac cot neu cung EmployeeID
Set @sSQL11 = N'
select DivisionID,EmployeeID, TranMonth, TranYear, Sum(Income01) as Income01, Sum(Income02) as InCome02, Sum(Income03) as InCome03,Sum(Income04) as InCome04,
 Sum(Income05) as InCome05,Sum(Income06) as InCome06, Sum(Income07) as InCome07,Sum(Income08) as InCome08,Sum(Income09) as InCome09,Sum(Income10) as InCome10,
 Sum(Income11) as InCome11,Sum(Income12) as InCome12,Sum(Income13) as InCome13,Sum(Income14) as InCome14, Sum(Income15) as InCome15,Sum(Income16) as InCome16,
 Sum(Income17) as InCome17,Sum(Income18) as InCome18, Sum(Income19) as InCome19,Sum(Income20) as InCome20,Sum(Income21) as InCome21,Sum(Income22) as InCome22,
 Sum(Income23) as InCome23,Sum(Income24) as InCome24,Sum(Income25) as InCome25,Sum(Income26) as InCome26, Sum(Income27) as InCome27,Sum(Income28) as InCome28,
 Sum(Income29) as InCome29,Sum(Income30) as InCome30, Sum(ISNULL(Income31,0)) AS Income31, Sum(ISNULL(Income32,0)) AS Income32,
 Sum(ISNULL(Income33,0)) AS Income33, Sum(ISNULL(Income34,0)) AS Income34, Sum(ISNULL(Income35,0)) AS Income35, Sum(ISNULL(Income36,0)) AS Income36, 
 Sum(ISNULL(Income37,0)) AS Income37, Sum(ISNULL(Income38,0)) AS Income38, Sum(ISNULL(Income39,0)) AS Income39, Sum(ISNULL(Income40,0)) AS Income40, 
 Sum(ISNULL(Income41,0)) AS Income41, Sum(ISNULL(Income42,0)) AS Income42, Sum(ISNULL(Income43,0)) AS Income43, Sum(ISNULL(Income44,0)) AS Income44, 
 Sum(ISNULL(Income45,0)) AS Income45, Sum(ISNULL(Income46,0)) AS Income46, Sum(ISNULL(Income47,0)) AS Income47, Sum(ISNULL(Income48,0)) AS Income48, 
 Sum(ISNULL(Income49,0)) AS Income49, Sum(ISNULL(Income50,0)) AS Income50, Sum(ISNULL(Income51,0)) AS Income51, Sum(ISNULL(Income52,0)) AS Income52, 
 Sum(ISNULL(Income53,0)) AS Income53, Sum(ISNULL(Income54,0)) AS Income54, Sum(ISNULL(Income55,0)) AS Income55, Sum(ISNULL(Income56,0)) AS Income56, 
 Sum(ISNULL(Income57,0)) AS Income57, Sum(ISNULL(Income58,0)) AS Income58, Sum(ISNULL(Income59,0)) AS Income59, Sum(ISNULL(Income60,0)) AS Income60, 
 Sum(ISNULL(Income61,0)) AS Income61, Sum(ISNULL(Income62,0)) AS Income62, Sum(ISNULL(Income63,0)) AS Income63, Sum(ISNULL(Income64,0)) AS Income64, 
 Sum(ISNULL(Income65,0)) AS Income65, Sum(ISNULL(Income66,0)) AS Income66, Sum(ISNULL(Income67,0)) AS Income67, Sum(ISNULL(Income68,0)) AS Income68, 
 Sum(ISNULL(Income69,0)) AS Income69, Sum(ISNULL(Income70,0)) AS Income70, Sum(ISNULL(Income71,0)) AS Income71, Sum(ISNULL(Income72,0)) AS Income72, 
 Sum(ISNULL(Income73,0)) AS Income73, Sum(ISNULL(Income74,0)) AS Income74, Sum(ISNULL(Income75,0)) AS Income75, Sum(ISNULL(Income76,0)) AS Income76, 
 Sum(ISNULL(Income77,0)) AS Income77, Sum(ISNULL(Income78,0)) AS Income78, Sum(ISNULL(Income79,0)) AS Income79, Sum(ISNULL(Income80,0)) AS Income80, 
 Sum(ISNULL(Income81,0)) AS Income81, Sum(ISNULL(Income82,0)) AS Income82, Sum(ISNULL(Income83,0)) AS Income83, Sum(ISNULL(Income84,0)) AS Income84, 
 Sum(ISNULL(Income85,0)) AS Income85, Sum(ISNULL(Income86,0)) AS Income86, Sum(ISNULL(Income87,0)) AS Income87, Sum(ISNULL(Income88,0)) AS Income88, 
 Sum(ISNULL(Income89,0)) AS Income89, Sum(ISNULL(Income90,0)) AS Income90, Sum(ISNULL(Income91,0)) AS Income91, Sum(ISNULL(Income92,0)) AS Income92, 
 Sum(ISNULL(Income93,0)) AS Income93, Sum(ISNULL(Income94,0)) AS Income94, Sum(ISNULL(Income95,0)) AS Income95, Sum(ISNULL(Income96,0)) AS Income96, 
 Sum(ISNULL(Income97,0)) AS Income97, Sum(ISNULL(Income98,0)) AS Income98, Sum(ISNULL(Income99,0)) AS Income99, Sum(ISNULL(Income100,0)) AS Income100,'
SET @sSelect10 = '
 Sum(ISNULL(Income101,0)) AS Income101, Sum(ISNULL(Income102,0)) AS Income102, Sum(ISNULL(Income103,0)) AS Income103, Sum(ISNULL(Income104,0)) AS Income104, 
 Sum(ISNULL(Income105,0)) AS Income105, Sum(ISNULL(Income106,0)) AS Income106, Sum(ISNULL(Income107,0)) AS Income107, Sum(ISNULL(Income108,0)) AS Income108, 
 Sum(ISNULL(Income109,0)) AS Income109, Sum(ISNULL(Income110,0)) AS Income110, Sum(ISNULL(Income111,0)) AS Income111, Sum(ISNULL(Income112,0)) AS Income112, 
 Sum(ISNULL(Income113,0)) AS Income113, Sum(ISNULL(Income114,0)) AS Income114, Sum(ISNULL(Income115,0)) AS Income115, Sum(ISNULL(Income116,0)) AS Income116, 
 Sum(ISNULL(Income117,0)) AS Income117, Sum(ISNULL(Income118,0)) AS Income118, Sum(ISNULL(Income119,0)) AS Income119, Sum(ISNULL(Income120,0)) AS Income120, 
 Sum(ISNULL(Income121,0)) AS Income121, Sum(ISNULL(Income122,0)) AS Income122, Sum(ISNULL(Income123,0)) AS Income123, Sum(ISNULL(Income124,0)) AS Income124, 
 Sum(ISNULL(Income125,0)) AS Income125, Sum(ISNULL(Income126,0)) AS Income126, Sum(ISNULL(Income127,0)) AS Income127, Sum(ISNULL(Income128,0)) AS Income128, 
 Sum(ISNULL(Income129,0)) AS Income129, Sum(ISNULL(Income130,0)) AS Income130, Sum(ISNULL(Income131,0)) AS Income131, Sum(ISNULL(Income132,0)) AS Income132, 
 Sum(ISNULL(Income133,0)) AS Income133, Sum(ISNULL(Income134,0)) AS Income134, Sum(ISNULL(Income135,0)) AS Income135, Sum(ISNULL(Income136,0)) AS Income136, 
 Sum(ISNULL(Income137,0)) AS Income137, Sum(ISNULL(Income138,0)) AS Income138, Sum(ISNULL(Income139,0)) AS Income139, Sum(ISNULL(Income140,0)) AS Income140, 
 Sum(ISNULL(Income141,0)) AS Income141, Sum(ISNULL(Income142,0)) AS Income142, Sum(ISNULL(Income143,0)) AS Income143, Sum(ISNULL(Income144,0)) AS Income144, 
 Sum(ISNULL(Income145,0)) AS Income145, Sum(ISNULL(Income146,0)) AS Income146, Sum(ISNULL(Income147,0)) AS Income147, Sum(ISNULL(Income148,0)) AS Income148, 
 Sum(ISNULL(Income149,0)) AS Income149, Sum(ISNULL(Income150,0)) AS Income150, Sum(ISNULL(Income151,0)) AS Income151, Sum(ISNULL(Income152,0)) AS Income152, 
 Sum(ISNULL(Income153,0)) AS Income153, Sum(ISNULL(Income154,0)) AS Income154, Sum(ISNULL(Income155,0)) AS Income155, Sum(ISNULL(Income156,0)) AS Income156, 
 Sum(ISNULL(Income157,0)) AS Income157, Sum(ISNULL(Income158,0)) AS Income158, Sum(ISNULL(Income159,0)) AS Income159, Sum(ISNULL(Income160,0)) AS Income160, '
SET @sSelect17 = '
 Sum(ISNULL(Income161,0)) AS Income161, Sum(ISNULL(Income162,0)) AS Income162, Sum(ISNULL(Income163,0)) AS Income163, Sum(ISNULL(Income164,0)) AS Income164, 
 Sum(ISNULL(Income165,0)) AS Income165, Sum(ISNULL(Income166,0)) AS Income166, Sum(ISNULL(Income167,0)) AS Income167, Sum(ISNULL(Income168,0)) AS Income168, 
 Sum(ISNULL(Income169,0)) AS Income169, Sum(ISNULL(Income170,0)) AS Income170, Sum(ISNULL(Income171,0)) AS Income171, Sum(ISNULL(Income172,0)) AS Income172, 
 Sum(ISNULL(Income173,0)) AS Income173, Sum(ISNULL(Income174,0)) AS Income174, Sum(ISNULL(Income175,0)) AS Income175, Sum(ISNULL(Income176,0)) AS Income176, 
 Sum(ISNULL(Income177,0)) AS Income177, Sum(ISNULL(Income178,0)) AS Income178, Sum(ISNULL(Income179,0)) AS Income179, Sum(ISNULL(Income180,0)) AS Income180, 
 Sum(ISNULL(Income181,0)) AS Income181, Sum(ISNULL(Income182,0)) AS Income182, Sum(ISNULL(Income183,0)) AS Income183, Sum(ISNULL(Income184,0)) AS Income184, 
 Sum(ISNULL(Income185,0)) AS Income185, Sum(ISNULL(Income186,0)) AS Income186, Sum(ISNULL(Income187,0)) AS Income187, Sum(ISNULL(Income188,0)) AS Income188, 
 Sum(ISNULL(Income189,0)) AS Income189, Sum(ISNULL(Income190,0)) AS Income190, Sum(ISNULL(Income191,0)) AS Income191, Sum(ISNULL(Income192,0)) AS Income192, 
 Sum(ISNULL(Income193,0)) AS Income193, Sum(ISNULL(Income194,0)) AS Income194, Sum(ISNULL(Income195,0)) AS Income195, Sum(ISNULL(Income196,0)) AS Income196, 
 Sum(ISNULL(Income197,0)) AS Income197, Sum(ISNULL(Income198,0)) AS Income198, Sum(ISNULL(Income199,0)) AS Income199, Sum(ISNULL(Income200,0)) AS Income200,
 SUM(SubAmount01) as SubAmount01,SUM(SubAmount02) as SubAmount02,SUM(SubAmount03) as SubAmount03,SUM(SubAmount04) as SubAmount04,
 SUM(SubAmount05) as SubAmount05,SUM(SubAmount06) as SubAmount06,SUM(SubAmount07) as SubAmount07,SUM(SubAmount08) as SubAmount08,
 SUM(SubAmount09) as SubAmount09,SUM(SubAmount10) as SubAmount10,SUM(SubAmount11) as SubAmount11,SUM(SubAmount12) as SubAmount12,
 SUM(SubAmount13) as SubAmount13,SUM(SubAmount14) as SubAmount14,SUM(SubAmount15) as SubAmount15,SUM(SubAmount16) as SubAmount16,
 SUM(SubAmount17) as SubAmount17,SUM(SubAmount18) as SubAmount18,SUM(SubAmount19) as SubAmount19,SUM(SubAmount20) as SubAmount20,
 Sum(SubAmount21) as SubAmount21, Sum(SubAmount22) as SubAmount22, Sum(SubAmount23) as SubAmount23,Sum(SubAmount24) as SubAmount24,Sum(SubAmount25) as SubAmount25,
 Sum(SubAmount26) as SubAmount26, Sum(SubAmount27) as SubAmount27, Sum(SubAmount28) as SubAmount28,Sum(SubAmount29) as SubAmount29,Sum(SubAmount30) as SubAmount30,
 Sum(ISNULL(SubAmount31,0)) AS SubAmount31, Sum(ISNULL(SubAmount32,0)) AS SubAmount32,'
SET @sSelect11 = '
 Sum(ISNULL(SubAmount33,0)) AS SubAmount33, Sum(ISNULL(SubAmount34,0)) AS SubAmount34, Sum(ISNULL(SubAmount35,0)) AS SubAmount35, Sum(ISNULL(SubAmount36,0)) AS SubAmount36, 
 Sum(ISNULL(SubAmount37,0)) AS SubAmount37, Sum(ISNULL(SubAmount38,0)) AS SubAmount38, Sum(ISNULL(SubAmount39,0)) AS SubAmount39, Sum(ISNULL(SubAmount40,0)) AS SubAmount40, 
 Sum(ISNULL(SubAmount41,0)) AS SubAmount41, Sum(ISNULL(SubAmount42,0)) AS SubAmount42, Sum(ISNULL(SubAmount43,0)) AS SubAmount43, Sum(ISNULL(SubAmount44,0)) AS SubAmount44, 
 Sum(ISNULL(SubAmount45,0)) AS SubAmount45, Sum(ISNULL(SubAmount46,0)) AS SubAmount46, Sum(ISNULL(SubAmount47,0)) AS SubAmount47, Sum(ISNULL(SubAmount48,0)) AS SubAmount48, 
 Sum(ISNULL(SubAmount49,0)) AS SubAmount49, Sum(ISNULL(SubAmount50,0)) AS SubAmount50, Sum(ISNULL(SubAmount51,0)) AS SubAmount51, Sum(ISNULL(SubAmount52,0)) AS SubAmount52, 
 Sum(ISNULL(SubAmount53,0)) AS SubAmount53, Sum(ISNULL(SubAmount54,0)) AS SubAmount54, Sum(ISNULL(SubAmount55,0)) AS SubAmount55, Sum(ISNULL(SubAmount56,0)) AS SubAmount56, 
 Sum(ISNULL(SubAmount57,0)) AS SubAmount57, Sum(ISNULL(SubAmount58,0)) AS SubAmount58, Sum(ISNULL(SubAmount59,0)) AS SubAmount59, Sum(ISNULL(SubAmount60,0)) AS SubAmount60, 
 Sum(ISNULL(SubAmount61,0)) AS SubAmount61, Sum(ISNULL(SubAmount62,0)) AS SubAmount62, Sum(ISNULL(SubAmount63,0)) AS SubAmount63, Sum(ISNULL(SubAmount64,0)) AS SubAmount64, 
 Sum(ISNULL(SubAmount65,0)) AS SubAmount65, Sum(ISNULL(SubAmount66,0)) AS SubAmount66, Sum(ISNULL(SubAmount67,0)) AS SubAmount67, Sum(ISNULL(SubAmount68,0)) AS SubAmount68, 
 Sum(ISNULL(SubAmount69,0)) AS SubAmount69, Sum(ISNULL(SubAmount70,0)) AS SubAmount70, Sum(ISNULL(SubAmount71,0)) AS SubAmount71, Sum(ISNULL(SubAmount72,0)) AS SubAmount72, 
 Sum(ISNULL(SubAmount73,0)) AS SubAmount73, Sum(ISNULL(SubAmount74,0)) AS SubAmount74, Sum(ISNULL(SubAmount75,0)) AS SubAmount75, Sum(ISNULL(SubAmount76,0)) AS SubAmount76, 
 Sum(ISNULL(SubAmount77,0)) AS SubAmount77, Sum(ISNULL(SubAmount78,0)) AS SubAmount78, Sum(ISNULL(SubAmount79,0)) AS SubAmount79, Sum(ISNULL(SubAmount80,0)) AS SubAmount80, 
 Sum(ISNULL(SubAmount81,0)) AS SubAmount81, Sum(ISNULL(SubAmount82,0)) AS SubAmount82, Sum(ISNULL(SubAmount83,0)) AS SubAmount83, Sum(ISNULL(SubAmount84,0)) AS SubAmount84, 
 Sum(ISNULL(SubAmount85,0)) AS SubAmount85, Sum(ISNULL(SubAmount86,0)) AS SubAmount86, Sum(ISNULL(SubAmount87,0)) AS SubAmount87, Sum(ISNULL(SubAmount88,0)) AS SubAmount88, 
 Sum(ISNULL(SubAmount89,0)) AS SubAmount89, Sum(ISNULL(SubAmount90,0)) AS SubAmount90, Sum(ISNULL(SubAmount91,0)) AS SubAmount91, Sum(ISNULL(SubAmount92,0)) AS SubAmount92, 
 Sum(ISNULL(SubAmount93,0)) AS SubAmount93, Sum(ISNULL(SubAmount94,0)) AS SubAmount94, Sum(ISNULL(SubAmount95,0)) AS SubAmount95, Sum(ISNULL(SubAmount96,0)) AS SubAmount96, 
 Sum(ISNULL(SubAmount97,0)) AS SubAmount97, Sum(ISNULL(SubAmount98,0)) AS SubAmount98, Sum(ISNULL(SubAmount99,0)) AS SubAmount99, Sum(ISNULL(SubAmount100,0)) AS SubAmount100
 into #HV34001
 from #HV3400
 group by DivisionID,EmployeeID, TranMonth, TranYear'


Set  @sSQL4 = N'   
Select *, Isnull(Income01, 0) + Isnull(Income02, 0)  + Isnull(Income03, 0)  + Isnull(Income04, 0)  + Isnull(Income05, 0) +     
 Isnull(Income06, 0) + Isnull(Income07, 0)  + Isnull(Income08, 0)  + Isnull(Income09, 0)  + Isnull(Income10, 0) + Isnull(Income11, 0) + Isnull(Income12, 0) +
 Isnull(Income13, 0) + Isnull(Income14, 0)  + Isnull(Income15, 0) + Isnull(Income16, 0) + Isnull(Income17, 0)  + Isnull(Income18, 0) + Isnull(Income19, 0) + 
 Isnull(Income20, 0) +  Isnull(Income21, 0) + Isnull(Income22, 0)  + Isnull(Income23, 0)  + Isnull(Income24, 0)  + Isnull(Income25, 0) +    
 Isnull(Income26, 0) + Isnull(Income27, 0)  + Isnull(Income28, 0)  + Isnull(Income29, 0)  + Isnull(Income30, 0) + ISNULL(Income31,0)  + ISNULL(Income32,0) + 
 ISNULL(Income33,0) + ISNULL(Income34,0) + ISNULL(Income35,0) + ISNULL(Income36,0) + ISNULL(Income37,0) + ISNULL(Income38,0) + ISNULL(Income39,0) + ISNULL(Income40,0) + 
 ISNULL(Income41,0) + ISNULL(Income42,0) + ISNULL(Income43,0) + ISNULL(Income44,0) + ISNULL(Income45,0) + ISNULL(Income46,0) + ISNULL(Income47,0) + ISNULL(Income48,0) + 
 ISNULL(Income49,0) + ISNULL(Income50,0) + ISNULL(Income51,0) + ISNULL(Income52,0) + ISNULL(Income53,0) + ISNULL(Income54,0) + ISNULL(Income55,0) + ISNULL(Income56,0) + 
 ISNULL(Income57,0) + ISNULL(Income58,0) + ISNULL(Income59,0) + ISNULL(Income60,0) + ISNULL(Income61,0) + ISNULL(Income62,0) + ISNULL(Income63,0) + ISNULL(Income64,0) + 
 ISNULL(Income65,0) + ISNULL(Income66,0) + ISNULL(Income67,0) + ISNULL(Income68,0) + ISNULL(Income69,0) + ISNULL(Income70,0) + ISNULL(Income71,0) + ISNULL(Income72,0) + 
 ISNULL(Income73,0) + ISNULL(Income74,0) + ISNULL(Income75,0) + ISNULL(Income76,0) + ISNULL(Income77,0) + ISNULL(Income78,0) + ISNULL(Income79,0) + ISNULL(Income80,0) + 
 ISNULL(Income81,0) + ISNULL(Income82,0) + ISNULL(Income83,0) + ISNULL(Income84,0) + ISNULL(Income85,0) + ISNULL(Income86,0) + ISNULL(Income87,0) + ISNULL(Income88,0) + 
 ISNULL(Income89,0) + ISNULL(Income90,0) + ISNULL(Income91,0) + ISNULL(Income92,0) + ISNULL(Income93,0) + ISNULL(Income94,0) + ISNULL(Income95,0) + ISNULL(Income96,0) + 
 ISNULL(Income97,0) + ISNULL(Income98,0) + ISNULL(Income99,0) + ISNULL(Income100,0) + ISNULL(Income101,0) + ISNULL(Income102,0) + ISNULL(Income103,0) + ISNULL(Income104,0) + 
 ISNULL(Income105,0) + ISNULL(Income106,0) + ISNULL(Income107,0) + ISNULL(Income108,0) + ISNULL(Income109,0) + ISNULL(Income110,0) + ISNULL(Income111,0) + 
 ISNULL(Income112,0) + ISNULL(Income113,0) + ISNULL(Income114,0) + ISNULL(Income115,0) + ISNULL(Income116,0) + ISNULL(Income117,0) + ISNULL(Income118,0) + 
 ISNULL(Income119,0) + ISNULL(Income120,0) + ISNULL(Income121,0) + ISNULL(Income122,0) + ISNULL(Income123,0) + ISNULL(Income124,0) + ISNULL(Income125,0) + 
 ISNULL(Income126,0) + ISNULL(Income127,0) + ISNULL(Income128,0) + ISNULL(Income129,0) + ISNULL(Income130,0) + ISNULL(Income131,0) + ISNULL(Income132,0) + 
 ISNULL(Income133,0) + ISNULL(Income134,0) + ISNULL(Income135,0) + ISNULL(Income136,0) + ISNULL(Income137,0) + ISNULL(Income138,0) + ISNULL(Income139,0) + 
 ISNULL(Income140,0) + ISNULL(Income141,0) + ISNULL(Income142,0) + ISNULL(Income143,0) + ISNULL(Income144,0) + ISNULL(Income145,0) + ISNULL(Income146,0) + 
 ISNULL(Income147,0) + ISNULL(Income148,0) + ISNULL(Income149,0) + ISNULL(Income150,0) + ISNULL(Income151,0) + ISNULL(Income152,0) + 
 ISNULL(Income153,0) + ISNULL(Income154,0) + ISNULL(Income155,0) + ISNULL(Income156,0) + ISNULL(Income157,0) + ISNULL(Income158,0) + 
 ISNULL(Income159,0) + ISNULL(Income160,0) + ISNULL(Income161,0) + ISNULL(Income162,0) + ISNULL(Income163,0) + ISNULL(Income164,0) + 
 ISNULL(Income165,0) + ISNULL(Income166,0) + ISNULL(Income167,0) + ISNULL(Income168,0) + ISNULL(Income169,0) + ISNULL(Income170,0) + 
 ISNULL(Income171,0) + ISNULL(Income172,0) + ISNULL(Income173,0) + ISNULL(Income174,0) + ISNULL(Income175,0) + ISNULL(Income176,0) +'
 SET @sSelect18 = '
 ISNULL(Income177,0) + ISNULL(Income178,0) + ISNULL(Income179,0) + ISNULL(Income180,0) + ISNULL(Income181,0) + ISNULL(Income182,0) + 
 ISNULL(Income183,0) + ISNULL(Income184,0) + ISNULL(Income185,0) + ISNULL(Income186,0) + ISNULL(Income187,0) + ISNULL(Income188,0) + 
 ISNULL(Income189,0) + ISNULL(Income190,0) + ISNULL(Income191,0) + ISNULL(Income192,0) + ISNULL(Income193,0) + ISNULL(Income194,0) + 
 ISNULL(Income195,0) + ISNULL(Income196,0) + ISNULL(Income197,0) + ISNULL(Income198,0) + ISNULL(Income199,0) + ISNULL(Income200,0) AS TotalAmount,'
 SET @sSelect12 = '
 Isnull(SubAmount01, 0) + Isnull(SubAmount02, 0)  + Isnull(SubAmount03, 0)  + Isnull(SubAmount04, 0)  + Isnull(SubAmount05, 0) +   
 Isnull(SubAmount06, 0) + Isnull(SubAmount07, 0)  + Isnull(SubAmount08, 0)  + Isnull(SubAmount09, 0)  + Isnull(SubAmount10, 0) +    
 Isnull(SubAmount11, 0) + Isnull(SubAmount12, 0)  + Isnull(SubAmount13, 0)  + Isnull(SubAmount14, 0)  + Isnull(SubAmount15, 0) +   
 Isnull(SubAmount16, 0) + Isnull(SubAmount17, 0)  + Isnull(SubAmount18, 0)  + Isnull(SubAmount19, 0)  + Isnull(SubAmount20, 0) +
 Isnull(SubAmount21, 0) + Isnull(SubAmount22, 0)  + Isnull(SubAmount23, 0)  + Isnull(SubAmount24, 0)  + Isnull(SubAmount25, 0) +    
 Isnull(SubAmount26, 0) + Isnull(SubAmount27, 0)  + Isnull(SubAmount28, 0)  + Isnull(SubAmount29, 0)  + Isnull(SubAmount30, 0) +
 ISNULL(SubAmount31,0)  + ISNULL(SubAmount32,0) + ISNULL(SubAmount33,0) + ISNULL(SubAmount34,0) + ISNULL(SubAmount35,0) + 
 ISNULL(SubAmount36,0) + ISNULL(SubAmount37,0) + ISNULL(SubAmount38,0) + ISNULL(SubAmount39,0) + ISNULL(SubAmount40,0) + 
 ISNULL(SubAmount41,0) + ISNULL(SubAmount42,0) + ISNULL(SubAmount43,0) + ISNULL(SubAmount44,0) + ISNULL(SubAmount45,0) + 
 ISNULL(SubAmount46,0) + ISNULL(SubAmount47,0) + ISNULL(SubAmount48,0) + ISNULL(SubAmount49,0) + ISNULL(SubAmount50,0) + 
 ISNULL(SubAmount51,0) + ISNULL(SubAmount52,0) + ISNULL(SubAmount53,0) + ISNULL(SubAmount54,0) + ISNULL(SubAmount55,0) + 
 ISNULL(SubAmount56,0) + ISNULL(SubAmount57,0) + ISNULL(SubAmount58,0) + ISNULL(SubAmount59,0) + ISNULL(SubAmount60,0) + 
 ISNULL(SubAmount61,0) + ISNULL(SubAmount62,0) + ISNULL(SubAmount63,0) + ISNULL(SubAmount64,0) + ISNULL(SubAmount65,0) + 
 ISNULL(SubAmount66,0) + ISNULL(SubAmount67,0) + ISNULL(SubAmount68,0) + ISNULL(SubAmount69,0) + ISNULL(SubAmount70,0) + 
 ISNULL(SubAmount71,0) + ISNULL(SubAmount72,0) + ISNULL(SubAmount73,0) + ISNULL(SubAmount74,0) + ISNULL(SubAmount75,0) + 
 ISNULL(SubAmount76,0) + ISNULL(SubAmount77,0) + ISNULL(SubAmount78,0) + ISNULL(SubAmount79,0) + ISNULL(SubAmount80,0) + 
 ISNULL(SubAmount81,0) + ISNULL(SubAmount82,0) + ISNULL(SubAmount83,0) + ISNULL(SubAmount84,0) + ISNULL(SubAmount85,0) + 
 ISNULL(SubAmount86,0) + ISNULL(SubAmount87,0) + ISNULL(SubAmount88,0) + ISNULL(SubAmount89,0) + ISNULL(SubAmount90,0) + 
 ISNULL(SubAmount91,0) + ISNULL(SubAmount92,0) + ISNULL(SubAmount93,0) + ISNULL(SubAmount94,0) + ISNULL(SubAmount95,0) + 
 ISNULL(SubAmount96,0) + ISNULL(SubAmount97,0) + ISNULL(SubAmount98,0) + ISNULL(SubAmount99,0) + ISNULL(SubAmount100,0)  AS TotalSubAmount    
 Into #HV3401  
 From #HV34001 HV3400  
 Where DivisionID ='''+@DivisionID+'''  

'
-- Tinh thue thu nhap ca nhan  
DECLARE @TaxStepID AS NVARCHAR(50),    
  @TaxCur CURSOR,    
  @Orders int,    
  @FromSalary decimal(28,8),    
  @ToSalary decimal(28,8),     
  @TempSalary decimal(28,8),  
  @Rate decimal(28,8)  ,  
  @ReduceUnit decimal(28,8)  
      
SET @ReduceUnit  = ISNULL((SELECT UnitAmount FROM HT0336 WHERE MethodID = @MethodID AND DivisionID = @DivisionID),0)   
SET @TaxStepID  = (SELECT TaxStepID FROM HT0336 WHERE MethodID = @MethodID AND DivisionID = @DivisionID)   
IF @CustomerIndex = 57 ---- Customize Angel
BEGIN	
	IF @IsForeigner <> 0 ---- ANGEL áp dụng % tính thuế riêng cho người nước ngoài
	BEGIN	

		Set  @sSQL5 = N'  
		Insert into HT0338 (DivisionID, TransactionID, EmployeeID, TranMonth,  TranYear,TotalAmount, IncomeAmount, TaxReducedAmount, IncomeTax, MethodID)  
		Select HV3401.DivisionID,(select top 1 TransactionID from #HV3400 A where A.EmployeeID = HV3401.EmployeeID) as TransactionID, HV3401.EmployeeID, 
		HV3401.TranMonth, HV3401.TranYear, HV3401.TotalAmount, HV3401.TotalAmount-HV3401.TotalSubAmount,
		isnull(( Select Count(Ht0334.transactionID) From HT0334 where HV3401.DivisionID = HT0334.DivisionID and HV3401.EmployeeID = HT0334.EmployeeID and HT0334.Status = 0 ),0)*'+LTRIM(ISNULL(@ReduceUnit,0))+' ,0,
		''' + @MethodID + ''' AS MethodID    
		From #HV3401 HV3401 
		LEFT JOIN HT1400 WITH (NOLOCK) ON HV3401.DivisionID = HT1400.DivisionID and HV3401.EmployeeID = HT1400.EmployeeID 
		WHERE ISNULL(HT1400.RatePerTax,0) <> 0
	
		Select HV3401.DivisionID,(select top 1 TransactionID from #HV3400 A where A.EmployeeID = HV3401.EmployeeID) as TransactionID, HV3401.EmployeeID, 
		HV3401.TranMonth, HV3401.TranYear, HV3401.TotalAmount, HV3401.TotalAmount-HV3401.TotalSubAmount,
		isnull(( Select Count(Ht0334.transactionID) From HT0334 where HV3401.DivisionID = HT0334.DivisionID and HV3401.EmployeeID = HT0334.EmployeeID and HT0334.Status = 0 ),0)*'+LTRIM(ISNULL(@ReduceUnit,0))+' ,0,
		''' + @MethodID + ''' AS MethodID    
		From #HV3401 HV3401 
		LEFT JOIN HT1400 WITH (NOLOCK) ON HV3401.DivisionID = HT1400.DivisionID and HV3401.EmployeeID = HT1400.EmployeeID 
		WHERE ISNULL(HT1400.RatePerTax,0) <> 0
		' 
	
		--PRINT @sSQL5
	   
		SET @sSQL6 = N'    
		 SELECT DivisionID, TransactionID, EmployeeID, TranMonth,  TranYear,TotalAmount, isnull(IncomeTax,0) as IncomeTax, IncomeAmount, IncomeAmount -TaxReducedAmount as Remain, 0 as status     
		 INTO #Temp1    
		 FROM HT0338   
		 Where DivisionID ='''+@DivisionID+'''   
		 and HT0338.TranMonth ='+LTRIM(@TranMonth)+'  
		 and HT0338.TranYear ='+LTRIM(@TranYear)+'  
	 

		 '  
	   
		SET @sSQL7 = @sSQL7+N'   
		SELECT DivisionID, TransactionID, EmployeeID, TranMonth, TranYear, IncomeAmount, IncomeTax 
		INTO #Sum    
		FROM #Temp1 
		'  
	
		SET @sSQL8=@sSQL8+ N'	  
		UPDATE T  
		Set T.IncomeTax =T.IncomeTax + (T.Remain * HT1400.RatePerTax)/100,  
		T.Status =1  
		FROM #SUM S inner join #Temp1 T ON S.EmployeeID = T.EmployeeID   
		LEFT JOIN HT1400 on T.DivisionID = HT1400.DivisionID AND T.EmployeeID = HT1400.EmployeeID 
	'
	
	END
	ELSE
	BEGIN 
		Set  @sSQL5 = N'  
		Insert into HT0338 (DivisionID, TransactionID, HV3401.EmployeeID, TranMonth,  TranYear,TotalAmount, IncomeAmount, TaxReducedAmount, IncomeTax, MethodID)  
		Select HV3401.DivisionID,(select top 1 TransactionID from #HV3400 A where A.EmployeeID = HV3401.EmployeeID) as TransactionID, HV3401.EmployeeID, 
		HV3401.TranMonth, HV3401.TranYear, HV3401.TotalAmount, HV3401.TotalAmount-HV3401.TotalSubAmount,
		isnull(( Select Count(Ht0334.transactionID) From HT0334 where HV3401.DivisionID = HT0334.DivisionID and HV3401.EmployeeID = HT0334.EmployeeID and HT0334.Status = 0 ),0)*'+LTRIM(@ReduceUnit)+' ,0,
		''' + @MethodID + ''' AS MethodID  
		From #HV3401 HV3401 
		inner join HT0332 on HV3401.DivisionID = HT0332.DivisionID   
		LEFT JOIN HT1400 WITH (NOLOCK) ON HV3401.DivisionID = HT1400.DivisionID and HV3401.EmployeeID = HT1400.EmployeeID 
		where TaxStepID ='''+@TaxStepID+'''  
		and HT0332.Orders =1  
		and HV3401.TotalAmount-HV3401.TotalSubAmount >= FromSalary
		and ISNULL(HT1400.RatePerTax, 0) = 0
		'   
  
		SET @TaxCur = CURSOR SCROLL KEYSET FOR    
		SELECT Orders,FromSalary,ToSalary , Rate     
		FROM HT0332     
		WHERE TaxStepID = @TaxStepID  AND DivisionID = @DivisionID ORDER BY Orders     
		OPEN @TaxCur    
		FETCH NEXT FROM @TaxCur INTO @Orders,@FromSalary,@ToSalary , @Rate    
  
		SET @sSQL6 = N'    
		 SELECT DivisionID, TransactionID, EmployeeID, TranMonth,  TranYear,TotalAmount, isnull(IncomeTax,0) as IncomeTax, IncomeAmount, IncomeAmount -TaxReducedAmount as Remain, 0 as status     
		 INTO #Temp1    
		 FROM HT0338   
		 Where DivisionID ='''+@DivisionID+'''   
		 and HT0338.TranMonth ='+LTRIM(@TranMonth)+'  
		 and HT0338.TranYear ='+LTRIM(@TranYear)+'  
  
		 '    
		WHILE @@Fetch_Status = 0    
		BEGIN    
		 If (@ToSalary = -1)   
		 Set  @ToSalary = 999999999   
 
		 SET @sSQL7 = @sSQL7+N'    
		 SELECT DivisionID, TransactionID, EmployeeID, TranMonth, TranYear, IncomeAmount, IncomeTax 
		 INTO #Sum'+CONVERT(VARCHAR(1),@Orders)+'    
		 FROM #Temp1       
		 where Remain between '+LTRIM(@FromSalary)+' and '+LTRIM(@ToSalary)+'    
		 '  
		 SET @sSQL8=@sSQL8+ N'  
		 UPDATE T  
		 Set T.IncomeTax =T.IncomeTax + 0,  
		 T.Status =1  
		 FROM #SUM'+CONVERT(VARCHAR(1),@Orders)+' S inner join #Temp1 T
		 LEFT JOIN HT1400 on T.DivisionID = HT1400.DivisionID AND T.EmployeeID = HT1400.EmployeeID    
		 ON S.EmployeeID = T.EmployeeID   
		 where T.Remain <= '+LTRIM(@FromSalary)+'  
   
		 UPDATE T  
		 Set T.IncomeTax = T.IncomeTax+ ((T.Remain -'+LTRIM(@FromSalary)+')*'+LTRIM(@Rate)+')/100 ,  
		 T.Status =1  
		 FROM #SUM'+CONVERT(VARCHAR(1),@Orders)+' S inner join #Temp1 T   
		 LEFT JOIN HT1400 on T.DivisionID = HT1400.DivisionID AND T.EmployeeID = HT1400.EmployeeID   
		 ON S.EmployeeID = T.EmployeeID   
		 Where T.Remain between '+LTRIM(@FromSalary)+' and '+LTRIM(@ToSalary)+'   
   
		UPDATE T  
		 Set T.IncomeTax = T.IncomeTax+ (('+LTRIM(@ToSalary)+'-'+LTRIM(@FromSalary)+')/100)*'+LTRIM(@Rate)+' 
		 FROM #Temp1 T 
		 LEFT JOIN HT1400 on T.DivisionID = HT1400.DivisionID AND T.EmployeeID = HT1400.EmployeeID       
		 Where T.Remain >='+LTRIM(@ToSalary)+'    '
 
		FETCH NEXT FROM @TaxCur INTO @Orders,@FromSalary,@ToSalary , @Rate    
		END
	END  
END
ELSE
BEGIN
	Set  @sSQL5 = N'  
	Insert into HT0338 (DivisionID, TransactionID, EmployeeID, TranMonth,  TranYear,TotalAmount, IncomeAmount, TaxReducedAmount, IncomeTax)  
	Select HV3401.DivisionID,(select top 1 TransactionID from #HV3400 A where A.EmployeeID = HV3401.EmployeeID) as TransactionID, EmployeeID, 
	TranMonth,  TranYear,TotalAmount,
	--TotalAmount-TotalSubAmount,
	case when TotalAmount-TotalSubAmount - isnull((Select Count(Ht0334.transactionID) From HT0334 where HV3401.DivisionID = HT0334.DivisionID and HV3401.EmployeeID = HT0334.EmployeeID and HT0334.Status = 0),0)*'+LTRIM(@ReduceUnit)+' < 0
		then 0 else TotalAmount-TotalSubAmount - isnull((Select Count(Ht0334.transactionID) From HT0334 where HV3401.DivisionID = HT0334.DivisionID and HV3401.EmployeeID = HT0334.EmployeeID and HT0334.Status = 0),0)*'+LTRIM(@ReduceUnit)+' end,
	isnull(( Select Count(Ht0334.transactionID) From HT0334 where HV3401.DivisionID = HT0334.DivisionID and HV3401.EmployeeID = HT0334.EmployeeID and HT0334.Status = 0 ),0)*'+LTRIM(@ReduceUnit)+' ,0  
	From #HV3401 HV3401 inner join HT0332 on HV3401.DivisionID = HT0332.DivisionID   
	where TaxStepID ='''+@TaxStepID+'''  
	and Orders =1  
	-- Tinh thue cho ca nhung nv khong chiu thue
	-- and TotalAmount-TotalSubAmount >= FromSalary
	'+@sWhereEmployeeID+'

	'   
  
	SET @TaxCur = CURSOR SCROLL KEYSET FOR    
	SELECT Orders,FromSalary,ToSalary , Rate     
	FROM HT0332     
	WHERE TaxStepID = @TaxStepID  AND DivisionID = @DivisionID ORDER BY Orders     
	OPEN @TaxCur    
	FETCH NEXT FROM @TaxCur INTO @Orders,@FromSalary,@ToSalary , @Rate    
 
	SET @sSQL6 = N'    
		SELECT DivisionID, TransactionID, EmployeeID, TranMonth,  TranYear,TotalAmount, isnull(IncomeTax,0) as IncomeTax, IncomeAmount, IncomeAmount as Remain, 0 as status     
		INTO #Temp1    
		FROM HT0338   
		Where DivisionID ='''+@DivisionID+'''   
		and HT0338.TranMonth ='+LTRIM(@TranMonth)+'  
		and HT0338.TranYear ='+LTRIM(@TranYear)+'    ' 

	WHILE @@Fetch_Status = 0    
	BEGIN    
	 If (@ToSalary = -1)   
	 Set  @ToSalary = 999999999   
 
	 SET @sSQL7 = @sSQL7+N'    
	 SELECT DivisionID, TransactionID, EmployeeID, TranMonth, TranYear, IncomeAmount, IncomeTax 
	 INTO #Sum'+CONVERT(VARCHAR(1),@Orders)+'    
	 FROM #Temp1       
	 where Remain between '+LTRIM(@FromSalary)+' and '+LTRIM(@ToSalary)+'   

	 ' 

	 SET @sSQL8=@sSQL8+ N'  
	 UPDATE T  
	 Set T.IncomeTax =T.IncomeTax + (CASE WHEN '+LTRIM(@CustomerIndex)+' = 57 AND Isnull(HT1400.RatePerTax,0) <> 0 THEN (T.Remain * HT1400.RatePerTax)/100 ELSE 0 END),  
	 T.Status =1  
	 FROM #SUM'+CONVERT(VARCHAR(1),@Orders)+' S inner join #Temp1 T
	 LEFT JOIN HT1400 on T.DivisionID = HT1400.DivisionID AND T.EmployeeID = HT1400.EmployeeID    
	 ON S.EmployeeID = T.EmployeeID   
	 where T.Remain <= '+LTRIM(@FromSalary)+'  '

	SET @sSQL8=@sSQL8+ N'    
	 UPDATE T  
	 Set T.IncomeTax = T.IncomeTax+ (CASE WHEN '+LTRIM(@CustomerIndex)+' = 57 AND Isnull(HT1400.RatePerTax,0) <> 0 THEN ((T.Remain -'+LTRIM(@FromSalary)+')* HT1400.RatePerTax)/100  ELSE ((T.Remain -'+LTRIM(@FromSalary)+')*'+LTRIM(@Rate)+')/100 END),  
	 T.Status =1  
	 FROM #SUM'+CONVERT(VARCHAR(1),@Orders)+' S inner join #Temp1 T   
	 LEFT JOIN HT1400 on T.DivisionID = HT1400.DivisionID AND T.EmployeeID = HT1400.EmployeeID   
	 ON S.EmployeeID = T.EmployeeID   
	 Where T.Remain between '+LTRIM(@FromSalary)+' and '+LTRIM(@ToSalary)+'   '

	 SET @sSQL8=@sSQL8+ N'    
	 UPDATE T  
	 Set T.IncomeTax = T.IncomeTax+ (CASE WHEN '+LTRIM(@CustomerIndex)+' = 57 AND Isnull(HT1400.RatePerTax,0) <> 0 THEN (('+LTRIM(@ToSalary)+'-'+LTRIM(@FromSalary)+')/100)* HT1400.RatePerTax ELSE (('+LTRIM(@ToSalary)+'-'+LTRIM(@FromSalary)+')/100)*'+LTRIM(@Rate)+' END)  
	 FROM #Temp1 T 
	 LEFT JOIN HT1400 on T.DivisionID = HT1400.DivisionID AND T.EmployeeID = HT1400.EmployeeID       
	 Where T.Remain >='+LTRIM(@ToSalary)+'    '
 
	FETCH NEXT FROM @TaxCur INTO @Orders,@FromSalary,@ToSalary , @Rate    
End 



---- Tính thuế thu nhập cho công nhân thời vụ và nhân viên đi tu nghiệp nước ngoài
IF(@CustomerIndex = 50 )
	BEGIN
		SET @sSQL9=@sSQL9+ N'  
		--- Công nhân thời vụ thì không trừ thuế
		UPDATE	H00
		SET		IncomeTax = 0
		FROM	#Temp1 H00 	
		LEFT JOIN HT1403 ON H00.EmployeeID = HT1403.EmployeeID AND H00.DivisionID = HT1403.DivisionID							  							
		WHERE H00.DivisionID = '''+@DivisionID+''' 
		AND (HT1403.TitleID = ''OST'' ) 

		--- Nhân viên có thời gian đào tạo ở nước ngoài thì tính 20%
		UPDATE	H00
		SET		IncomeTax = Remain * 0.2
		FROM	#Temp1 H00 	
		LEFT JOIN HT1403 ON H00.EmployeeID = HT1403.EmployeeID AND H00.DivisionID = HT1403.DivisionID							  
		 LEFT JOIN HT1414 ON HT1414.DivisionID = H00.DivisionID AND HT1414.EmployeeID = H00.EmployeeID
					AND	'''+Convert(Varchar(20),@LastDate,120)+''' BETWEEN ISNULL(HT1414.BeginDate,HT1403.WorkDate) AND Isnull(HT1414.EndDate,'''+Convert(Varchar(20),@LastDate,120)+''') 						  							
		WHERE H00.DivisionID = '''+@DivisionID+''' 
		AND (CASE WHEN ISNULL(HT1414.EmployeeMode,'''') <> '''' THEN  HT1414.EmployeeMode ELSE HT1414.EmployeeStatus END = ''TO'')   
		'
	END
END

SET @sSQL9=@sSQL9+ N'     
 Update HT0338  
 Set HT0338.IncomeTax = T.IncomeTax  
 From HT0338 inner join #Temp1 T on HT0338.DivisionID = T.DivisionID and HT0338.EmployeeID = T.EmployeeID  and HT0338.TransactionID = T.TransactionID
 Where HT0338.DivisionID ='''+@DivisionID+'''   
 and HT0338.TranMonth ='+LTRIM(@TranMonth)+'  
 and HT0338.TranYear ='+LTRIM(@TranYear)+'  
 and T.Status =1  
 '  
 
 --print @sSQL5
 --print @sSQL6
 --print @sSQL7
 --print @sSQL8
 --print @sSQL9


 -- Angel tính theo phương pháp
IF @CustomerIndex = 57
	Set  @sSQL10 = 
	N'Insert into HT0341 (DivisionID,TransactionID,EmployeeID,TranMonth,TranYear,Income01,Income02,Income03,Income04,Income05,Income06,Income07,Income08,Income09,Income10,Income11,Income12,Income13,Income14,Income15,Income16,Income17,Income18,Income19,Income20,Income21,Income22,Income23,Income24,Income25,Income26,Income27,Income28,Income29,Income30,SubAmount01,SubAmount02,SubAmount03,SubAmount04,SubAmount05,SubAmount06,SubAmount07,SubAmount08,SubAmount09,SubAmount10,SubAmount11,SubAmount12,SubAmount13,SubAmount14,SubAmount15,SubAmount16,SubAmount17,SubAmount18,SubAmount19,SubAmount20, MethodID)
	Select DivisionID,TransactionID,EmployeeID,TranMonth,TranYear,Income01,Income02,Income03,Income04,Income05,Income06,Income07,Income08,Income09,Income10,Income11,Income12,Income13,Income14,Income15,Income16,Income17,Income18,Income19,Income20,Income21,Income22,Income23,Income24,Income25,Income26,Income27,Income28,Income29,Income30,SubAmount01,SubAmount02,SubAmount03,SubAmount04,SubAmount05,SubAmount06,SubAmount07,SubAmount08,SubAmount09,SubAmount10,SubAmount11,SubAmount12,SubAmount13,SubAmount14,SubAmount15,SubAmount16,SubAmount17,SubAmount18,SubAmount19,SubAmount20, ''' + @MethodID + ''' AS MethodID 
	from #HV3400 
	where EmployeeID in (select EmployeeID from HT0338 
						 where DivisionID ='''+@DivisionID+''' 
							   and TranMonth ='+LTRIM(@TranMonth)+' 
							   and TranYear = '+LTRIM(@TranYear)+'
							   and MethodID = ''' + @MethodID + ''')
	'
else
	Set  @sSQL10 = 
	N'Insert into HT0341 (DivisionID,TransactionID,EmployeeID,TranMonth,TranYear,Income01,Income02,Income03,Income04,Income05,Income06,Income07,Income08,Income09,Income10,Income11,Income12,Income13,Income14,Income15,Income16,Income17,Income18,Income19,Income20,Income21,Income22,Income23,Income24,Income25,Income26,Income27,Income28,Income29,Income30,SubAmount01,SubAmount02,SubAmount03,SubAmount04,SubAmount05,SubAmount06,SubAmount07,SubAmount08,SubAmount09,SubAmount10,SubAmount11,SubAmount12,SubAmount13,SubAmount14,SubAmount15,SubAmount16,SubAmount17,SubAmount18,SubAmount19,SubAmount20)
	Select DivisionID,TransactionID,EmployeeID,TranMonth,TranYear,Income01,Income02,Income03,Income04,Income05,Income06,Income07,Income08,Income09,Income10,Income11,Income12,Income13,Income14,Income15,Income16,Income17,Income18,Income19,Income20,Income21,Income22,Income23,Income24,Income25,Income26,Income27,Income28,Income29,Income30,SubAmount01,SubAmount02,SubAmount03,SubAmount04,SubAmount05,SubAmount06,SubAmount07,SubAmount08,SubAmount09,SubAmount10,SubAmount11,SubAmount12,SubAmount13,SubAmount14,SubAmount15,SubAmount16,SubAmount17,SubAmount18,SubAmount19,SubAmount20 
	from #HV3400 where EmployeeID in (select EmployeeID from HT0338 where DivisionID ='''+@DivisionID+''' and TranMonth ='+LTRIM(@TranMonth)+' and TranYear = '+LTRIM(@TranYear)+') '


SET @sSQL12 = '
Insert into HT0341_1 
(DivisionID,TransactionID,EmployeeID,TranMonth,TranYear,
Income31, Income32, Income33, Income34, Income35, Income36, Income37, Income38, Income39, Income40, Income41, Income42, Income43, Income44, Income45, Income46, Income47, Income48, Income49, Income50, 
Income51, Income52, Income53, Income54, Income55, Income56, Income57, Income58, Income59, Income60, Income61, Income62, Income63, Income64, Income65, Income66, Income67, Income68, Income69, Income70, 
Income71, Income72, Income73, Income74, Income75, Income76, Income77, Income78, Income79, Income80, Income81, Income82, Income83, Income84, Income85, Income86, Income87, Income88, Income89, Income90, 
Income91, Income92, Income93, Income94, Income95, Income96, Income97, Income98, Income99, Income100, Income101, Income102, Income103, Income104, Income105, Income106, Income107, Income108, Income109, Income110, 
Income111, Income112, Income113, Income114, Income115, Income116, Income117, Income118, Income119, Income120, Income121, Income122, Income123, Income124, Income125, Income126, Income127, Income128, Income129, Income130, 
Income131, Income132, Income133, Income134, Income135, Income136, Income137, Income138, Income139, Income140, Income141, Income142, Income143, Income144, Income145, Income146, Income147, Income148, Income149, Income150,
Income151, Income152, Income153, Income154, Income155, Income156, Income157, Income158, Income159, Income160, 
Income161, Income162, Income163, Income164, Income165, Income166, Income167, Income168, Income169, Income170, 
Income171, Income172, Income173, Income174, Income175, Income176, Income177, Income178, Income179, Income180, 
Income181, Income182, Income183, Income184, Income185, Income186, Income187, Income188, Income189, Income190, 
Income191, Income192, Income193, Income194, Income195, Income196, Income197, Income198, Income199, Income200,
SubAmount21, SubAmount22, SubAmount23, SubAmount24, SubAmount25, SubAmount26, SubAmount27, SubAmount28, SubAmount29, SubAmount30, 
SubAmount31, SubAmount32, SubAmount33, SubAmount34, SubAmount35, SubAmount36, SubAmount37, SubAmount38, SubAmount39, SubAmount40, 
SubAmount41, SubAmount42, SubAmount43, SubAmount44, SubAmount45, SubAmount46, SubAmount47, SubAmount48, SubAmount49, SubAmount50, 
SubAmount51, SubAmount52, SubAmount53, SubAmount54, SubAmount55, SubAmount56, SubAmount57, SubAmount58, SubAmount59, SubAmount60, 
SubAmount61, SubAmount62, SubAmount63, SubAmount64, SubAmount65, SubAmount66, SubAmount67, SubAmount68, SubAmount69, SubAmount70, 
SubAmount71, SubAmount72, SubAmount73, SubAmount74, SubAmount75, SubAmount76, SubAmount77, SubAmount78, SubAmount79, SubAmount80, 
SubAmount81, SubAmount82, SubAmount83, SubAmount84, SubAmount85, SubAmount86, SubAmount87, SubAmount88, SubAmount89, SubAmount90, 
SubAmount91, SubAmount92, SubAmount93, SubAmount94, SubAmount95, SubAmount96, SubAmount97, SubAmount98, SubAmount99, SubAmount100)'

SET @sSQL13 ='			
Select DivisionID,TransactionID,EmployeeID,TranMonth,TranYear,
Income31, Income32, Income33, Income34, Income35, Income36, Income37, Income38, Income39, Income40, Income41, Income42, Income43, Income44, Income45, Income46, Income47, Income48, Income49, Income50, 
Income51, Income52, Income53, Income54, Income55, Income56, Income57, Income58, Income59, Income60, Income61, Income62, Income63, Income64, Income65, Income66, Income67, Income68, Income69, Income70, 
Income71, Income72, Income73, Income74, Income75, Income76, Income77, Income78, Income79, Income80, Income81, Income82, Income83, Income84, Income85, Income86, Income87, Income88, Income89, Income90, 
Income91, Income92, Income93, Income94, Income95, Income96, Income97, Income98, Income99, Income100, Income101, Income102, Income103, Income104, Income105, Income106, Income107, Income108, Income109, Income110, 
Income111, Income112, Income113, Income114, Income115, Income116, Income117, Income118, Income119, Income120, Income121, Income122, Income123, Income124, Income125, Income126, Income127, Income128, Income129, Income130, 
Income131, Income132, Income133, Income134, Income135, Income136, Income137, Income138, Income139, Income140, Income141, Income142, Income143, Income144, Income145, Income146, Income147, Income148, Income149, Income150,
Income151, Income152, Income153, Income154, Income155, Income156, Income157, Income158, Income159, Income160, 
Income161, Income162, Income163, Income164, Income165, Income166, Income167, Income168, Income169, Income170, 
Income171, Income172, Income173, Income174, Income175, Income176, Income177, Income178, Income179, Income180, 
Income181, Income182, Income183, Income184, Income185, Income186, Income187, Income188, Income189, Income190, 
Income191, Income192, Income193, Income194, Income195, Income196, Income197, Income198, Income199, Income200,
SubAmount21, SubAmount22, SubAmount23, SubAmount24, SubAmount25, SubAmount26, SubAmount27, SubAmount28, SubAmount29, SubAmount30, 
SubAmount31, SubAmount32, SubAmount33, SubAmount34, SubAmount35, SubAmount36, SubAmount37, SubAmount38, SubAmount39, SubAmount40, 
SubAmount41, SubAmount42, SubAmount43, SubAmount44, SubAmount45, SubAmount46, SubAmount47, SubAmount48, SubAmount49, SubAmount50, 
SubAmount51, SubAmount52, SubAmount53, SubAmount54, SubAmount55, SubAmount56, SubAmount57, SubAmount58, SubAmount59, SubAmount60, 
SubAmount61, SubAmount62, SubAmount63, SubAmount64, SubAmount65, SubAmount66, SubAmount67, SubAmount68, SubAmount69, SubAmount70, 
SubAmount71, SubAmount72, SubAmount73, SubAmount74, SubAmount75, SubAmount76, SubAmount77, SubAmount78, SubAmount79, SubAmount80, 
SubAmount81, SubAmount82, SubAmount83, SubAmount84, SubAmount85, SubAmount86, SubAmount87, SubAmount88, SubAmount89, SubAmount90, 
SubAmount91, SubAmount92, SubAmount93, SubAmount94, SubAmount95, SubAmount96, SubAmount97, SubAmount98, SubAmount99, SubAmount100
from #HV3400 where EmployeeID in (select EmployeeID from HT0338 where DivisionID ='''+@DivisionID+''' and TranMonth ='+LTRIM(@TranMonth)+' and TranYear = '+LTRIM(@TranYear)+')'

--PRINT ('--@sSql1'+ @sSql1 )
--PRINT ('--@sSql2'+ @sSql2 )
--PRINT ('--@sSelect1'+ @sSelect1) 
--PRINT ('--@sSelect2'+ @sSelect2) 
--PRINT ('--@sSelect3'+ @sSelect3) 
--PRINT ('--@sSelect4'+ @sSelect4) 
--PRINT ('--@sSelect5'+ @sSelect5) 
--PRINT ('--@sSelect14'+ @sSelect14) 
--PRINT ('--@sSelect15'+ @sSelect15) 
--PRINT ('--@sSelect16'+ @sSelect16) 
--PRINT ('--@sSql3'+ @sSql3 )
--PRINT ('--@sSelect6'+ @sSelect6) 
--PRINT ('--@sSelect7'+ @sSelect7) 
--PRINT ('--@sSelect8'+ @sSelect8) 
--PRINT ('--@sSelect9'+ @sSelect9) 
--PRINT ('--@sSQL11'+ @sSQL11 )
--PRINT ('--@sSelect10'+ @sSelect10 )
--PRINT ('--@sSelect17'+ @sSelect17 )
--PRINT ('--@sSelect11'+@sSelect11 )
--PRINT ('--@sSql4'+ @sSql4 )
--PRINT ('--@sSelect18'+@sSelect18 )
--PRINT ('--@sSelect12'+@sSelect12 )
--PRINT ('--@sSql5'+ @sSql5) 
--PRINT ('--@sSql6'+ @sSql6) 
--PRINT ('--@sSQl7'+ @sSQl7) 
--PRINT ('--@sSQL8'+ @sSQL8) 
--PRINT ('--@sSQL9'+ @sSQL9) 
--PRINT ('--@sSQL10'+ @sSQL10) 
--PRINT ('--@sSQL12'+@sSQL12)
--PRINT ('--@sSQL13'+@sSQL13)
Exec (@sSql1+@sSql2+@sSelect1+@sSelect2+@sSelect3+@sSelect4+@sSelect5+@sSelect14+@sSelect15+@sSelect16+@sSql3+@sSelect6+@sSelect7+@sSelect8+@sSelect9+@sSQL11+@sSelect10+@sSelect17+@sSelect11+@sSql4+@sSelect18+@sSelect12+@sSql5+@sSql6+@sSQl7+@sSQL8+@sSQL9+@sSQL10+@sSQL12+@sSQL13)  





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
