IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP2436_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2436_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---Created by : Dang Le Bao Quynh, Date : 15/10/2007
---Purpose: Ket chuyen sang cham cong ngay 
/********************************************
'* Edited by: [GS] [Thành Nguyên] [02/08/2010]
'********************************************/
--- Modify on 04/08/2013 by Bao Anh: Bo sung tinh so cong theo dieu kien (Hung Vuong)
--- Modify on 27/12/2013 by Bao Anh: Sửa thứ tự Where cho các bảng HT2407, HT2401 theo Index để cải thiện tốc độ
--- Modify on 07/02/2015 by Bảo Anh: Gọi HP0354 customize cho IPL
--- Modify on 14/12/2015 by Bảo Anh: Nhân thêm hệ số khi tính số công, kết chuyển chấm công từ các loại đơn xin phép trên ApproveOnline (Meiko)
--- Modify on 15/02/2016 by Bảo Anh: Lấy mức tối đa nếu số công > mức tối đa (Meiko)
--- Modify on 19/02/2016 by Bảo Anh: Xóa trước khi kết chuyển từ Approve Online (Meiko)
--- Modify on 24/04/2016 by Bảo Anh: Bỏ gọi HP0354 customize cho IPL, phần này đã chuyển qua store chấm công HP2433
--- Modify on 20/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
--- Modify on 07/02/2017 by Phương Thảo: Chuyển phần xử lý customize Meiko vào chuẩn
--- Modify on 01/03/2017 by Phương Thảo: Cải tiến tốc độ
--- Modify on 19/06/2023 by Đình Định: Lấy bảng hồ sơ lương nhân viên.

CREATE PROCEDURE [dbo].[HP2436_MK]   	@DivisionID nvarchar(50),
					@DepartmentID nvarchar(50),
					@EmployeeID nvarchar(50),
				 	@TranMonth int,
				 	@TranYear int,
				 	@FromDate datetime,
				 	@ToDate datetime,
					@UserID nvarchar(50)
				
AS

DECLARE	@curHT2407 cursor,
		@mDepartmentID nvarchar(50),
		@mTeamID nvarchar(50),
		@mEmployeeID nvarchar(50),
		@AbsentTypeID nvarchar(50),
		@AbsentDate datetime,
		@AbsentAmount decimal(28,8),
		@ShiftID nvarchar(50),
		@UnitID nvarchar(50),
		@WorkingTime decimal(28,8),
		@IsCondition tinyint,
		@ConditionCode nvarchar(4000),
		@ConditionAmount decimal(28,8),
		@CustomerIndex int,
		@ConvertUnit DECIMAL(28,8),
		@MaxValue DECIMAL(28,8)

DECLARE	@sSQL001 Nvarchar(4000),
		@sSQL002 Nvarchar(4000),
		@sSQL003 Nvarchar(4000),		
		@sSQL004 Nvarchar(4000),	
		@TableHT2407 Varchar(50),		
		@TableHT2401 Varchar(50),	
		@TableHT2400 Varchar(50),		
		@sTranMonth Varchar(2),
		@OrderNum Decimal(28,0)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2407 = 'HT2407M'+@sTranMonth+Convert(Varchar(4),@TranYear),
			@TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),@TranYear),
			@TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2407 = 'HT2407',
			@TableHT2401 = 'HT2401',
			@TableHT2400 = 'HT2400'
END	

Set @ConditionAmount = 0
Set @AbsentDate = @FromDate
SELECT @CustomerIndex = CustomerName From CustomerIndex

CREATE TABLE #HP2436_MK_HT2407 (OrderNum Decimal(28,0) IDENTITY(1,1), 
							 DepartmentID Varchar(50), TeamID Varchar(50), EmployeeID Varchar(50), ShiftID Varchar(50),
							 AbsentHour Decimal(28,8), AbsentTypeID Varchar(50), IsCondition Tinyint, 							 
							 ConditionCode Nvarchar (4000), ConvertUnit Decimal(28, 8), MaxValue Decimal(28, 8),  
							 AbsentAmount Decimal(28, 8), AbsentDate Datetime)

SET @sSQL001 = N'
	INSERT INTO #HP2436_MK_HT2407
	SELECT HT00.DepartmentID, HT00.TeamID, HT00.EmployeeID, MAX(HT07.ShiftID) AS ShiftID,
		   SUM(ISNULL(HT07.AbsentHour,0)), HT07.AbsentTypeID,
		   HT1013.IsCondition, HT1013.ConditionCode, ISNULL(HT1013.ConvertUnit,1), HT1013.MaxValue,
		   Convert(Decimal(28,8),0) AS AbsentAmount,
		   HT07.AbsentDate
	FROM '+@TableHT2407+' HT07 WITH (NOLOCK) INNER JOIN 
	( SELECT DivisionID, DepartmentID, TeamID, EmployeeID 
		FROM '+@TableHT2400+' WITH (NOLOCK)
	   WHERE DivisionID = '''+@DivisionID+''' AND
			 TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+' AND
			 DepartmentID Like '''+@DepartmentID+''' AND
			 EmployeeID Like '''+@EmployeeID+''') HT00 
	ON HT07.EmployeeID = HT00.EmployeeID AND HT07.DivisionID = HT00.DivisionID
	LEFT JOIN HT1013 WITH (NOLOCK) ON HT07.DivisionID = HT1013.DivisionID AND HT07.AbsentTypeID = HT1013.AbsentTypeID
	WHERE HT07.DivisionID = '''+@DivisionID+''' And
		  HT07.AbsentDate BETWEEN '''+Convert(NVarchar(10),@AbsentDate,101)+''' AND '''+Convert(NVarchar(10),@ToDate,101)+'''   	
	GROUP BY HT00.DepartmentID, HT00.TeamID, HT00.EmployeeID, 
			 HT07.AbsentTypeID, IsCondition, ConditionCode, ISNULL(HT1013.ConvertUnit,1), HT1013.MaxValue, HT07.AbsentDate	 '

	
SET @sSQL002 = N'
UPDATE T1
SET		ConditionCode =  REPLACE(ConditionCode, ''If'' , '' Case When '')
FROM #HP2436_MK_HT2407 T1
WHERE	IsCondition = 1  and ISNULL(ConditionCode,'''') <> ''''

UPDATE T1
SET		ConditionCode =  REPLACE(ConditionCode , ''@AbsentAmount'' , ''isnull(AbsentHour , 0)'')
FROM #HP2436_MK_HT2407 T1
WHERE	IsCondition = 1 and ISNULL(ConditionCode,'''') <> ''''


UPDATE T1
SET		AbsentAmount =  AbsentHour
FROM #HP2436_MK_HT2407 T1
WHERE	IsCondition = 0 
'
--PRINT @sSQL001
--PRINT @sSQL002
EXEC (@sSQL001+@sSQL002)

Set @curHT2407 = cursor static for 
		Select	distinct ConditionCode
		From	#HP2436_MK_HT2407
		WHERE	IsCondition = 1
	Open @curHT2407
	
	Fetch Next From @curHT2407 Into @ConditionCode
	While @@Fetch_Status = 0
	Begin
	SET @sSQL003 = N'
	UPDATE T1
	SET		AbsentAmount = '+@ConditionCode+'
	FROM #HP2436_MK_HT2407 T1
	WHERE	IsCondition = 1 and ConditionCode = '''+@ConditionCode+'''

	'
	--Print @sSQL003
	EXEC (@sSQL003)
	Fetch Next From @curHT2407 Into @ConditionCode
	End
	Close @curHT2407

	--select * from #HP2436_MK_HT2407

	UPDATE #HP2436_MK_HT2407
	SET		AbsentAmount = AbsentAmount * ConvertUnit 

	IF (@CustomerIndex = 50)
	BEGIN
		UPDATE	#HP2436_MK_HT2407
		SET		AbsentAmount = MaxValue
		WHERE   AbsentAmount > Isnull(MaxValue,AbsentAmount)
	END

SET @sSQL004 = N'
	UPDATE T1 
	SET T1.AbsentAmount = (Case When T4.UnitID = ''H'' Then  T1.AbsentAmount
		Else T1.AbsentAmount/T3.WorkingTime End), 
		LastModifyUserID = '''+@UserID+''', LastModifyDate = getDate()
	FROM '+@TableHT2401+'  T1
	INNER JOIN #HP2436_MK_HT2407 T2 ON T1.DepartmentID = T2.DepartmentID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate
								AND T1.AbsentTypeID = T2.AbsentTypeID
	LEFT JOIN HT1020 T3 ON  T2.ShiftID = T3.ShiftID
	LEFT JOIN HT1013 T4 ON  T2.AbsentTypeID = T4.AbsentTypeID	
	WHERE 
	EXISTS (SELECT TOP 1 1 FROM '+@TableHT2401+' A WHERE  T1.DivisionID = A.DivisionID AND T1.TranYear = A.TranYear AND T1.TranMonth = A.TranMonth
								AND T1.DepartmentID = A.DepartmentID AND T1.EmployeeID = A.EmployeeID AND T1.AbsentDate = A.AbsentDate
								AND T1.AbsentTypeID = A.AbsentTypeID )

	Insert Into '+@TableHT2401+' (	AbsentDate,EmployeeID,DivisionID,TranMonth,TranYear,DepartmentID,TeamID,
									AbsentTypeID,AbsentAmount,CreateDate,
									LastModifyDate,CreateUserID,LastModifyUserID	)
	SELECT	T1.AbsentDate,	T1.EmployeeID,	'''+@DivisionID+''',	'+STR(@TranMonth)+','+STR(@TranYear)+',	T1.DepartmentID,	T1.TeamID,
			T1.AbsentTypeID,	(Case When T4.UnitID = ''H'' Then T1.AbsentAmount Else T1.AbsentAmount/T3.WorkingTime End),			
			getDate(),getDate(),'''+@UserID+''','''+@UserID+'''
	FROM	#HP2436_MK_HT2407 	T1							
	LEFT JOIN HT1020 T3 ON  T1.ShiftID = T3.ShiftID
	LEFT JOIN HT1013 T4 ON  T1.AbsentTypeID = T4.AbsentTypeID	
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@TableHT2401+' A WHERE  A.DivisionID = '''+@DivisionID+''' AND A.TranYear = '+STR(@TranYear)+' AND A.TranMonth = '+STR(@TranMonth)+'
								AND T1.DepartmentID = A.DepartmentID AND T1.EmployeeID = A.EmployeeID AND T1.AbsentDate = A.AbsentDate
								AND T1.AbsentTypeID = A.AbsentTypeID )
'
--Print @sSQL004
EXEC(@sSQL004)

--- Customize Meiko: Chuyển phần chấm công từ Approve Online vào bảng chấm công ngày
SET @sSQL002 = '
	DELETE T1
	FROM '+@TableHT2401+' T1
	INNER JOIN '+@TableHT2400+' T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID and T1.TranMonth = T2.TranMonth and T1.TranYear = T2.TranYear
	WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.DepartmentID like '''+@DepartmentID+''' AND T1.EmployeeID like '''+@EmployeeID+'''
	AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+' AND (T1.AbsentDate between '''+CONVERT(VARCHAR(50),@FromDate,120)+''' and '''+CONVERT(VARCHAR(50),@ToDate,120)+''')
	AND T1.IsFromAO = 1
		 
	INSERT INTO '+@TableHT2401+' (AbsentDate,EmployeeID,DivisionID,TranMonth,TranYear,DepartmentID,TeamID,AbsentTypeID,AbsentAmount,CreateDate,LastModifyDate,CreateUserID,LastModifyUserID, IsFromAO)
	SELECT	T1.AbsentDate, T1.EmployeeID, T1.DivisionID, T1.TranMonth, T1.TranYear, T2.DepartmentID, T2.TeamID,
			T1.AbsentTypeID, T1.AbsentAmount, T1.CreateDate, T1.LastModifyDate, T1.CreateUserID, T1.LastModifyUserID, 1
	FROM HT2401_MK T1
	INNER JOIN '+@TableHT2400+' T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID and T1.TranMonth = T2.TranMonth and T1.TranYear = T2.TranYear
	WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.DepartmentID like '''+@DepartmentID+''' AND T1.EmployeeID like '''+@EmployeeID+'''
	AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+' AND (T1.AbsentDate between '''+CONVERT(VARCHAR(50),@FromDate,120)+''' and '''+CONVERT(VARCHAR(50),@ToDate,120)+''')

'
EXEC (@sSQL002)
--PRINT ('2'+@sSQL002)

DROP TABLE #HP2436_MK_HT2407



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

