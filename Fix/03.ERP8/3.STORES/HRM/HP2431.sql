IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2431]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2431]
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
----- Modify on 03/09/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
----- Modify on 16/04/2018 by Bảo Anh: Sửa cho trường hợp quét vào ca đêm ngày cuối tháng
----- Modify on 11/12/2019 by Văn Tài: Format lại cách trình bày, không thay đổi về code.
----- Modify on 02/10/2020 by Nhựt Trường: Bổ sung thêm cột khi AOType INSERT INTO HTT2408.
/*-- <Example>
OOP2061 @DivisionID='CTY',@UserID='ASOFTADMIN', @TranMonth=8, @TranYear=2015, @Day=25
----*/
 
CREATE PROCEDURE [dbo].[HP2431]  @DivisionID NVARCHAR(50),      
    @TranMonth INT,  
    @TranYear INT,
    @FromDate DATETIME,  
    @ToDate DATETIME,  
    @DepartmentID NVARCHAR(50),  
    @CreateUserID NVARCHAR(50),
	@EmployeeID NVARCHAR(50) = '%'                                                     
AS  
  
DECLARE  @DateProcess DATETIME,  
  @DateTypeID NVARCHAR(3),  
  @TempDate DATETIME,
  @SQL NVARCHAR(MAX)  

DECLARE @CustomerName INT
SET @CustomerName = (SELECT TOP 1 CustomerName FROM dbo.CustomerIndex)  

IF @CustomerName = 50 OR @CustomerName = 115 -- MEKIO và MTE
BEGIN
	EXEC dbo.HP2431_MK @DivisionID ,                 -- nvarchar(50)
	                @TranMonth  ,                    -- int
	                @TranYear ,                     -- int
	                @FromDate , -- datetime
	                @ToDate ,   -- datetime
	                @DepartmentID ,               -- nvarchar(50)
	                @CreateUserID ,               -- nvarchar(50)
	                @EmployeeID                   -- nvarchar(50)
	
END
ELSE
BEGIN
	
	SET @TempDate = DATEADD(d, 1, @ToDate)

	DECLARE	@sSQL001 NVARCHAR(4000),
			@TableHT2408 VARCHAR(50),		
			@sTranMonth VARCHAR(2)

	SELECT @sTranMonth = CASE WHEN @TranMonth > 9 THEN CONVERT(VARCHAR(2), @TranMonth) ELSE '0' + CONVERT(VARCHAR(1), @TranMonth) END

	IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
	BEGIN
		SET  @TableHT2408 = 'HT2408M' + @sTranMonth + CONVERT(VARCHAR(4), @TranYear)
	END
	ELSE
	BEGIN
		SET  @TableHT2408 = 'HT2408'
	END

	SELECT @SQL = '

	DELETE HTT2408  
	INSERT INTO HTT2408  
	SELECT HT08.APK
			, HT08.DivisionID
			, HT08.EmployeeID
			, ' + LTRIM(@TranMonth) + ' AS TranMonth
			, ' + LTRIM(@TranYear) + ' AS TranYear
			, HT08.AbsentCardNo
			, HT08.AbsentDate
			, HT08.AbsentTime
			, HT08.CreateUserID
			, HT08.CreateDate
			, HT08.LastModifyUserID
			, HT08.LastModifyDate
			, HT08.MachineCode
			, HT08.ShiftCode
			, HT08.IOCode
			, HT08.InputMethod
			, HT08.IsAO
			, HT08.AOType
	FROM ' + @TableHT2408 + ' HT08
	INNER JOIN HT1400 T00 ON T00.DivisionID = HT08.DivisionID 
						 AND T00.EmployeeID = HT08.EmployeeID 
	WHERE HT08.DivisionID = ''' + @DivisionID + '''
	  AND HT08.EmployeeID LIKE ''' + @EmployeeID + '''
	  -- AND HT08.TranYear = ' + LTRIM(@TranYear) + ' AND HT08.TranMonth = ' + LTRIM(@TranMonth) + '
	  AND HT08.AbsentDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @TempDate, 101) + '''
	  AND T00.DepartmentID LIKE ''' + @DepartmentID + '''
	'
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

	SET @DateProcess = @FromDate		
	--Lap tung ngay va thuc hien viec tinh toan  
	WHILE @DateProcess <= @ToDate  
	BEGIN  
		--Gan gia tri DataTypeID, xac dinh ngay thu may trong tuan  
		IF EXISTS (
					SELECT TOP 1 1 
					FROM HT1026 
					WHERE DivisionID = @DivisionID 
					  AND Tranyear = @TranYear 
					  AND Holiday = @DateProcess 
					  AND ISNULL(IsTimeOff, 0) = 0
					)  
		SET @DateTypeID = 'HOL'  
		ELSE IF EXISTS (
						 SELECT TOP 1 1 
						 FROM HT1026 
						 WHERE DivisionID = @DivisionID 
				   		   AND Tranyear = @TranYear 
						   AND Holiday = @DateProcess 
						   AND ISNULL(IsTimeOff, 0) <> 0
						)
		SET @DateTypeID = 'SUN'  
		ELSE  
		SET @DateTypeID = DATENAME(dw, @DateProcess)  
  
		EXEC HP2432 @DivisionID, @TranMonth, @TranYear, @DateProcess, @DateTypeID, @DepartmentID, @CreateUserID, @EmployeeID 
  
		SET @DateProcess = DATEADD(d, 1, @DateProcess)  
	END
END


SET NOCOUNT OFF


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
