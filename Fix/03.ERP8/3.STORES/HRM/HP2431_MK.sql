IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP2431_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2431_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
 ---- 
 ---- Quet tu dong may cham cong (KH Meiko)
 -- <Param>
 ---- 
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History> 
----- Created by: Dang Le Bao Quynh, date: 08/10/2007  
----- Purpose: Xu ly cham cong quet the .  
----- Edited by: [GS] [Thành Nguyên] [02/08/2010]  
----- Modify on 25/07/2013 by Bảo Anh: Bổ sung trường hợp là ngày nghỉ bù (Thuận Lợi)  
----- Modify on 15/11/2013 by Khanh Van: Cai thien toc do
----- Modify on 30/06/2015 by Bảo Anh: Bổ sung chấm công theo từng nhân viên
----- Modify on 08/07/2015 by Bảo Anh: Cải tiến tốc độ
----- Modify on 01/02/2016 by Phương Thảo: Bổ sung không xét các dòng lỗi (khi quét tự động KH Meiko)
----- Modify on 30/05/2016 by Bảo Anh: Sửa @TempDate = @ToDate + 1
----- Modify on 09/06/2016 by Bảo Anh: Xóa các ngày chỉ có 1 dòng quét thẻ mà không phải là ca đêm, bổ sung SET NOCOUNT ON
----- Modify on 19/10/2020 by Huỳnh Thử: -- Lấy thêm ngày xin quẹt thẻ ra của ngày cuối tháng tăng ca
----- Modify on 16/11/2020 by Huỳnh Thử: -- Bổ sung điều kiện check có tồn tại bảng @HT2408_02 hay không để thực hiện Union All
/*-- <Example>
OOP2061 @DivisionID='CTY',@UserID='ASOFTADMIN', @TranMonth=8, @TranYear=2015, @Day=25
----*/
 
CREATE PROCEDURE [dbo].[HP2431_MK]  @DivisionID nvarchar(50),      
    @TranMonth int,  
    @TranYear int,
    @FromDate datetime,  
    @ToDate datetime,  
    @DepartmentID nvarchar(50),  
    @CreateUserID nvarchar(50),
	@EmployeeID nvarchar(50) = '%'                                                     
AS  
  
DECLARE  @DateProcess datetime,  
  @DateTypeID nvarchar(3),  
  @TempDate datetime,
  @SQL Nvarchar(max)  

DECLARE @CustomerName int
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)  

Set @TempDate = DateAdd(d,1,@ToDate)


DECLARE	@sSQL001 Nvarchar(4000),
		@TableHT2408 Varchar(50),		
		@sTranMonth Varchar(2),
		@sTranMonth_02 Varchar(2),
		@TableHT2408_02 NVARCHAR(50)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END
SELECT @sTranMonth_02 = CASE WHEN @TranMonth + 1 >9 THEN Convert(Varchar(2),@TranMonth + 1) ELSE '0'+Convert(Varchar(1),@TranMonth + 1) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SET  @TableHT2408 = 'HT2408M'+@sTranMonth+Convert(Varchar(4),@TranYear)
	-- Nếu là tháng cuối năm. Thì lấy đầu tháng của năm sau
	IF @TranMonth = 12
	BEGIN 

		SET  @TableHT2408_02 = 'HT2408M01'+Convert(Varchar(4),@TranYear+1)
	END
	ELSE
	BEGIN 
		SET  @TableHT2408_02 = 'HT2408M'+@sTranMonth_02+Convert(Varchar(4),@TranYear)
	END
END
ELSE
BEGIN
	SET  @TableHT2408 = 'HT2408'
END

SELECT @SQL = '
Delete HTT2408  
Insert into HTT2408  
(
	APK, DivisionID, EmployeeID, TranMonth, TranYear, 
	AbsentCardNo, AbsentDate, AbsentTime, CreateUserID, 
	CreateDate, LastModifyUserID, LastModifyDate, MachineCode, ShiftCode, 
	IOCode, InputMethod, IsAO
)
Select HT08.APK,HT08.DivisionID,HT08.EmployeeID,HT08.TranMonth,HT08.TranYear,
		HT08.AbsentCardNo, HT08.AbsentDate, HT08.AbsentTime, HT08.CreateUserID,
		HT08.CreateDate, HT08.LastModifyUserID, HT08.LastModifyDate, HT08.MachineCode, HT08.ShiftCode,
		HT08.IOCode, HT08.InputMethod, 
		CASE WHEN OT90.Type = ''DXLTG'' THEN HT08.IsAO ELSE 0 END AS IsAO 
From '+@TableHT2408+' HT08
inner join HT1400 T00 on T00.EmployeeID = HT08.EmployeeID and T00.DivisionID = HT08.DivisionID 
left join 
(select EmployeeID, AbsentDate, TranMonth, TranYear, DivisionID, IOCode, Max(APKMaster) AS APKMaster
from HT2408_MK 
Group by EmployeeID, AbsentDate, TranMonth, TranYear, DivisionID, IOCode
)HT08MK on HT08.EmployeeID = HT08MK.EmployeeID AND HT08.AbsentDate = HT08MK.AbsentDate 
							  and HT08.TranMonth = HT08MK.TranMonth and HT08.TranYear = HT08MK.TranYear and HT08.DivisionID = HT08MK.DivisionID
							  and HT08.IsAO = 1 AND HT08.IOCode = HT08MK.IOCode
left join OOT9000 OT90 on HT08MK.APKMaster = OT90.APK and OT90.DivisionID = HT08MK.DivisionID
Where	HT08.DivisionID = '''+@DivisionID+'''
		and HT08.EmployeeID like '''+@EmployeeID+'''
		and HT08.TranYear = ' + ltrim(@TranYear) + ' and HT08.TranMonth = ' + ltrim(@TranMonth) + '
		and HT08.AbsentDate between '''+Convert(NVarchar(10),@FromDate,101)+''' and '''+Convert(NVarchar(10),@TempDate,101)+'''
		and T00.DepartmentID like '''+@DepartmentID+''''

		IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(@TableHT2408_02) AND TYPE IN (N'U'))
		 -- Lấy thêm ngày xin quẹt thẻ ra của ngày cuối tháng tăng ca
		BEGIN
			SET @SQL = @SQL +'
			UNION ALL
			SELECT HT08.APK,HT08.DivisionID,HT08.EmployeeID,'+@sTranMonth+',HT08.TranYear,
					HT08.AbsentCardNo, HT08.AbsentDate, HT08.AbsentTime, HT08.CreateUserID,
					HT08.CreateDate, HT08.LastModifyUserID, HT08.LastModifyDate, HT08.MachineCode, HT08.ShiftCode,
					HT08.IOCode, HT08.InputMethod,  0   
			FROM  '+@TableHT2408_02+' HT08 WITH (NOLOCK)
			inner join HT1400 T00 on T00.EmployeeID = HT08.EmployeeID and T00.DivisionID = HT08.DivisionID 
			WHERE HT08.EmployeeID = '''+@EmployeeID+'''
			AND T00.DepartmentID like '''+@DepartmentID+'''
			AND DAY(HT08.AbsentDate) = 1 AND HT08.IOCode = 1 AND HT08.IsAO = 1
			ORDER BY AbsentDate	'
		END
		
		--'+ CASE WHEN @CustomerName = 50 THEN '
		--AND HT08.EmployeeID + ''-''+ HT08.AbsentCardNo+''-''+Convert(Varchar(50),HT08.AbsentDate,112)+''-''+HT08.AbsentTime NOT IN (SELECT EmployeeID + ''-''+AbsentCardNo+''-''+Convert(Varchar(50),HT08.AbsentDate,112)+''-''+AbsentTime FROM HT2407_ER)'
		--ELSE '' END 

EXEC (@SQL)

--- Không chấm các ngày chỉ có 1 dòng quét thẻ
--Select HT.AbsentDate, HT.EmployeeID,
--	(Select CASE Day(HT.AbsentDate)  
--            WHEN 1 THEN H25.D01 WHEN 2 THEN H25.D02 WHEN 3 THEN H25.D03 WHEN 4 THEN H25.D04 WHEN 5 THEN H25.D05 WHEN 6 THEN H25.D06 WHEN    
--            7 THEN H25.D07 WHEN 8 THEN H25.D08 WHEN 9 THEN H25.D09 WHEN 10 THEN H25.D10 WHEN 11 THEN H25.D11 WHEN 12 THEN H25.D12 WHEN    
--            13 THEN H25.D13 WHEN 14 THEN H25.D14 WHEN 15 THEN H25.D15 WHEN 16 THEN H25.D16 WHEN 17 THEN H25.D17 WHEN 18 THEN H25.D18 WHEN    
--            19 THEN H25.D19 WHEN 20 THEN H25.D20 WHEN 21 THEN H25.D21 WHEN 22 THEN H25.D22 WHEN 23 THEN H25.D23 WHEN 24 THEN H25.D24 WHEN    
--            25 THEN H25.D25 WHEN 26 THEN H25.D26 WHEN 27 THEN H25.D27 WHEN 28 THEN H25.D28 WHEN 29 THEN H25.D29 WHEN 30 THEN H25.D30 WHEN    
--            31 THEN H25.D31 ELSE NULL END
--	From HT1025 H25 Where H25.DivisionID = @DivisionID And H25.TranMonth = @TranMonth And H25.TranYear = @TranYear And H25.EmployeeID = HT.EmployeeID)
--			as ShiftCode  
--INTO #TAM
--From HTT2408 HT
--Group by HT.EmployeeID, HT.AbsentDate
--having count(HT.EmployeeID) = 1

--Delete HTT2408
--Where exists (Select 1
--				From #TAM HT
--				Where HT.EmployeeID = HTT2408.EmployeeID and HT.AbsentDate = HTT2408.AbsentDate
--				And Isnull((Select Top 1 IsNextDay
--					From HV1020 Where DivisionID = @DivisionID And ShiftID = HT.ShiftCode And DateTypeID = Left(datename(dw,HT.AbsentDate),3)
--					Order by IsNextDay Desc),0) = 0)

Set @DateProcess = @FromDate		
--Lap tung ngay va thuc hien viec tinh toan  
While @DateProcess <= @ToDate  
Begin  
 --Gan gia tri DataTypeID, xac dinh ngay thu may trong tuan  
 IF exists (Select Top 1 1 From HT1026 Where DivisionID = @DivisionID And Tranyear = @TranYear And Holiday = @DateProcess And Isnull(IsTimeOff,0) = 0)  
  Set @DateTypeID = 'HOL'  
 ELSE IF exists (Select Top 1 1 From HT1026 Where DivisionID = @DivisionID And Tranyear = @TranYear And Holiday = @DateProcess And Isnull(IsTimeOff,0) <> 0)  
  Set @DateTypeID = 'SUN'  
 Else  
  Set @DateTypeID = DateName(dw,@DateProcess)  
  
 EXEC HP2432 @DivisionID, @TranMonth, @TranYear, @DateProcess, @DateTypeID, @DepartmentID, @CreateUserID, @EmployeeID 
  
 Set @DateProcess = DateAdd(d,1,@DateProcess)  
 
End

SET NOCOUNT OFF





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

