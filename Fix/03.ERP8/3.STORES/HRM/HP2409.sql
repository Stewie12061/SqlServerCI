IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP2409]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2409]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Created by: Vo Thanh Huong, date: 16/10/2004
---Purpose:  Insert vào HT2408 tu Table tam  HT2406
---Edit by: Dang Le Bao Quynh, date 05/10/2007
---Thay doi cach luu du lieu vao bang tam 
--- Modify on 27/06/2016 by Bảo Anh: Cải tiến tốc độ
/********************************************
'* Edited by: [GS] [Mỹ Tuyền] [30/07/2010]
'********************************************/
--- Modified on 18/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
--- Modified on 07/02/2017 by Phương Thảo: Chuyển phần xử lý của meiko vào chuẩn
--- Modified on 08/06/2017 by Phương Thảo: Xử lý không phân biệt In/Out theo thiết lập
--- Modified on 27/03/2018 by Bảo Anh: Bổ sung store customize Tiến Hưng
--- Modified on 05/07/2019 by Kim Thư: Bổ sung (ISNULL(@IsNotIO,0)
--- Modified on 10/10/2023 by Kiều Nga: [2023/10/IS/0084] Fix lỗi làm đơn bổ sung quẹt thẻ vào ngày cuối tháng nhưng quét dữ liệu lại không lên (customize MEIKO)
--- Modified on 30/11/2023 by Kiều Nga: [2023/11/IS/0175] Fix lỗi quét thẻ chấm công bị quét 2 lần dữ liệu chấm công ra (customize MEIKO)

CREATE PROCEDURE [dbo].[HP2409] @DivisionID nvarchar(50),
				@TranMonth int,
				@TranYear int,
				@FromDate datetime, 
				@ToDate datetime,
				@DepartmentID nvarchar(50),
				@CreateUserID nvarchar(50)				
AS

Declare @cur as cursor,
	@EmployeeID nvarchar(50),
	@BeginDate datetime,
	@EndDate datetime,
	@sSQL000 Nvarchar(4000),
	@sSQL001 Nvarchar(4000),
	@sSQL002 Nvarchar(4000),
	@sSQL003 Nvarchar(4000)='',
	@TableHT2406 Varchar(50),
	@TableHT2408 Varchar(50),
	@sTranMonth Varchar(2),
	@IsNotIO Tinyint,
	@CustomerName int

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 90	--- Tiến Hưng
BEGIN
	EXEC HP2409_TH @DivisionID, @TranMonth, @TranYear, @FromDate, @ToDate, @DepartmentID, @CreateUserID
END
ELSE
BEGIN
	SELECT	@IsNotIO = IsNotIO
	FROM	HT0000
	WHERE	DivisionID = @DivisionID

	SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

	IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
	BEGIN
		SELECT  @TableHT2406 = 'HT2406M'+@sTranMonth+Convert(Varchar(4),@TranYear),
				@TableHT2408 = 'HT2408M'+@sTranMonth+Convert(Varchar(4),@TranYear)
	END
	ELSE
	BEGIN
		SELECT  @TableHT2406 = 'HT2406',
				@TableHT2408 = 'HT2408'
	END

	SET @sSQL000 = '
	SELECT DISTINCT AbsentCardNo
	INTO #HP2409_NightShift
	FROM 
	(
	SELECT  H07.DivisionID,
	'''+Convert(Varchar(20),@ToDate,101)+''' AS AbsentDate,
	H07.AbsentCardNo, 
	CASE Day('''+Convert(Varchar(20),@ToDate,101)+''' )     
					WHEN 1 THEN H25.D01 WHEN 2 THEN H25.D02 WHEN 3 THEN H25.D03 WHEN 4 THEN H25.D04 WHEN 5 THEN H25.D05 WHEN 6 THEN H25.D06 WHEN    
					7 THEN H25.D07 WHEN 8 THEN H25.D08 WHEN 9 THEN H25.D09 WHEN 10 THEN H25.D10 WHEN 11 THEN H25.D11 WHEN 12 THEN H25.D12 WHEN    
					13 THEN H25.D13 WHEN 14 THEN H25.D14 WHEN 15 THEN H25.D15 WHEN 16 THEN H25.D16 WHEN 17 THEN H25.D17 WHEN 18 THEN H25.D18 WHEN    
					19 THEN H25.D19 WHEN 20 THEN H25.D20 WHEN 21 THEN H25.D21 WHEN 22 THEN H25.D22 WHEN 23 THEN H25.D23 WHEN 24 THEN H25.D24 WHEN    
					25 THEN H25.D25 WHEN 26 THEN H25.D26 WHEN 27 THEN H25.D27 WHEN 28 THEN H25.D28 WHEN 29 THEN H25.D29 WHEN 30 THEN H25.D30 WHEN    
					31 THEN H25.D31 ELSE NULL END as ShiftCode
	FROM    HT1407 AS H07 
	LEFT OUTER JOIN HT1025 AS H25 ON H07.EmployeeID = H25.EmployeeID and H07.DivisionID = H25.DivisionID 
	WHERE  H07.DivisionID = '''+@DivisionID +'''
	AND   H25.TranMonth = '+STR(@TranMonth)+' AND H25.TranYear = '+STR(@TranYear)+'
	) T1
	INNER JOIN 
	( SELECT DivisionID, ShiftID, MAX(IsNextDay) AS IsNextDay, DateTypeID
	FROM HT1021 
	GROUP BY  DivisionID, ShiftID, DateTypeID
	) T2 ON T1.DivisionID = T2.DivisionID  and T1.ShiftCode = T2.ShiftID AND LEFT(Datename(dw,T1.AbsentDate),3) = T2.DateTypeID
	WHERE T2.IsNextDay = 1
	'

	IF(ISNULL(@IsNotIO,0) = 0)
	BEGIN
		SET @sSQL001 = '
		Delete HT2408 
		From '+@TableHT2408+ ' AS HT2408 
		inner join  HT1400 on HT1400.EmployeeID=HT2408.EmployeeID and HT1400.DivisionID=HT2408.DivisionID
		Where 	HT2408.DivisionID = '''+@DivisionID+''' and
			HT2408.TranMonth = '+STR(@TranMonth)+' and
			HT2408.TranYear = '+STR(@TranYear)+' and
			HT1400.DepartmentID like '''+@DepartmentID+''' 
			And	
			(
				(
				EXISTS (SELECT TOP 1 1 FROM #HP2409_NightShift NS WHERE HT2408.AbsentCardNo = NS.AbsentCardNo)
				AND HT2408.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate+1,101)+'''
				)
			Or
			HT2408.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate,101)+'''
			)'

		IF @CustomerName = 50	--- MEIKO
		BEGIN
			SET @sSQL002 = '
			Insert '+@TableHT2408+ '(DivisionID, TranMonth, TranYear, AbsentCardNo,  EmployeeID, AbsentDate, AbsentTime, 
					CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, MachineCode, ShiftCode, IOCode,InputMethod, IsAO) 
			Select 	'''+@DivisionID+''', '+STR(@TranMonth)+', '+STR(@TranYear)+', T00.AbsentCardNo, T01.EmployeeID, T00.AbsentDate, MIN(T00.AbsentTime),
				'''+@CreateUserID+''', getdate(), '''+@CreateUserID+''', getdate(), MachineCode, ShiftCode, IOCode,InputMethod, 0
			From 	'+@TableHT2406+' T00
			inner  join HT1407 T01 on T00.AbsentCardNo = T01.AbsentCardNo and T00.DivisionID = T01.DivisionID
			inner join  HT1400 on HT1400.EmployeeID=T01.EmployeeID and HT1400.DivisionID=T01.DivisionID
			Where T00.DivisionID = '''+@DivisionID+'''
				And T00.TranMonth = '+STR(@TranMonth)+'
				And	T00.TranYear = '+STR(@TranYear)+'
				And	
				(
					(
					EXISTS (SELECT TOP 1 1 FROM #HP2409_NightShift NS WHERE T01.AbsentCardNo = NS.AbsentCardNo)
					AND T00.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate+1,101)+'''
					)
				Or
				T00.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate,101)+'''
				)	
				And T00.AbsentDate Between  T01.BeginDate And isnull(T01.EndDate,''12/31/9999'')
				And HT1400.DepartmentID like '''+@DepartmentID+'''
				AND IOCode = 0
			Group by T00.AbsentCardNo, T01.EmployeeID, T00.AbsentDate, MachineCode, ShiftCode, InputMethod,IOCode

			Insert '+@TableHT2408+ '(DivisionID, TranMonth, TranYear, AbsentCardNo,  EmployeeID, AbsentDate, AbsentTime, 
					CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, MachineCode, ShiftCode, IOCode,InputMethod, IsAO) 
			Select 	'''+@DivisionID+''', '+STR(@TranMonth)+', '+STR(@TranYear)+', T00.AbsentCardNo, T01.EmployeeID, T00.AbsentDate, MAX(T00.AbsentTime),
				'''+@CreateUserID+''', getdate(), '''+@CreateUserID+''', getdate(), MachineCode, ShiftCode, IOCode,InputMethod, 0
			From 	'+@TableHT2406+' T00
			inner  join HT1407 T01 on T00.AbsentCardNo = T01.AbsentCardNo and T00.DivisionID = T01.DivisionID
			inner join  HT1400 on HT1400.EmployeeID=T01.EmployeeID and HT1400.DivisionID=T01.DivisionID
			Where T00.DivisionID = '''+@DivisionID+'''
				And T00.TranMonth = '+STR(@TranMonth)+'
				And	T00.TranYear = '+STR(@TranYear)+'
				And	
				(
					(
					EXISTS (SELECT TOP 1 1 FROM #HP2409_NightShift NS WHERE T01.AbsentCardNo = NS.AbsentCardNo)
					AND T00.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate+1,101)+'''
					)
				Or
				T00.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate,101)+'''
				)	
				And T00.AbsentDate Between  T01.BeginDate And isnull(T01.EndDate,''12/31/9999'')
				And HT1400.DepartmentID like '''+@DepartmentID+'''
				AND IOCode = 1
			Group by T00.AbsentCardNo, T01.EmployeeID, T00.AbsentDate, MachineCode, ShiftCode, InputMethod,IOCode

			'
		END
		ELSE
		BEGIN
		SET @sSQL002 = '
		Insert '+@TableHT2408+ '(DivisionID, TranMonth, TranYear, AbsentCardNo,  EmployeeID, AbsentDate, AbsentTime, 
				CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, MachineCode, ShiftCode, IOCode,InputMethod, IsAO) 
		Select 	'''+@DivisionID+''', '+STR(@TranMonth)+', '+STR(@TranYear)+', T00.AbsentCardNo, T01.EmployeeID, T00.AbsentDate, T00.AbsentTime,
			'''+@CreateUserID+''', getdate(), '''+@CreateUserID+''', getdate(), MachineCode, ShiftCode, IOCode,InputMethod, 0
		From 	'+@TableHT2406+' T00
		inner  join HT1407 T01 on T00.AbsentCardNo = T01.AbsentCardNo and T00.DivisionID = T01.DivisionID
		inner join  HT1400 on HT1400.EmployeeID=T01.EmployeeID and HT1400.DivisionID=T01.DivisionID
		Where T00.DivisionID = '''+@DivisionID+'''
			And T00.TranMonth = '+STR(@TranMonth)+'
			And	T00.TranYear = '+STR(@TranYear)+'
			And	
			(
				(
				EXISTS (SELECT TOP 1 1 FROM #HP2409_NightShift NS WHERE T01.AbsentCardNo = NS.AbsentCardNo)
				AND T00.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate+1,101)+'''
				)
			Or
			T00.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate,101)+'''
			)	
			And T00.AbsentDate Between  T01.BeginDate And isnull(T01.EndDate,''12/31/9999'')
			And HT1400.DepartmentID like '''+@DepartmentID+'''

		'
		END
	END
	ELSE
	BEGIN
		SET @sSQL001 = '
		Delete HT2408 
		From '+@TableHT2408+ ' AS HT2408 
		inner join  HT1400 on HT1400.EmployeeID=HT2408.EmployeeID and HT1400.DivisionID=HT2408.DivisionID
		Where 	HT2408.DivisionID = '''+@DivisionID+''' and
			HT2408.TranMonth = '+STR(@TranMonth)+' and
			HT2408.TranYear = '+STR(@TranYear)+' and
			HT1400.DepartmentID like '''+@DepartmentID+''' 
			And	
			(
				(
				EXISTS (SELECT TOP 1 1 FROM #HP2409_NightShift NS WHERE HT2408.AbsentCardNo = NS.AbsentCardNo)
				AND HT2408.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate+1,101)+'''
				)
			Or
			HT2408.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate,101)+'''
			)	

		Select 	'''+@DivisionID+''' as DivisionID, '+STR(@TranMonth)+' as TranMonth, '+STR(@TranYear)+' as TranYear, T00.AbsentCardNo, T01.EmployeeID, T00.AbsentDate, T00.AbsentTime,
				MachineCode, ShiftCode, IOCode,InputMethod, 0 AS IsAO
		Into	#HP24049_HT2406
		From 	'+@TableHT2406+' T00
		inner  join HT1407 T01 on T00.AbsentCardNo = T01.AbsentCardNo and T00.DivisionID = T01.DivisionID
		inner join  HT1400 on HT1400.EmployeeID=T01.EmployeeID and HT1400.DivisionID=T01.DivisionID
		Where T00.DivisionID = '''+@DivisionID+'''
			And T00.TranMonth = '+STR(@TranMonth)+'
			And	T00.TranYear = '+STR(@TranYear)+'
			And	
			(
				(
				EXISTS (SELECT TOP 1 1 FROM #HP2409_NightShift NS WHERE T01.AbsentCardNo = NS.AbsentCardNo)
				AND T00.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate+1,101)+'''
				)
			Or
			T00.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate,101)+'''
			)	
			And T00.AbsentDate Between  T01.BeginDate And isnull(T01.EndDate,''12/31/9999'')
			And HT1400.DepartmentID like '''+@DepartmentID+'''
		'
	
		SET @sSQL002 = '	
			
		Insert '+@TableHT2408+ '(DivisionID, TranMonth, TranYear, AbsentCardNo,  EmployeeID, AbsentDate, AbsentTime, 
				CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, MachineCode, ShiftCode, IOCode,InputMethod, IsAO) 	
		--- Lay nhung dong min lam du lieu quet vao
		Select 	'''+@DivisionID+''' as DivisionID, '+STR(@TranMonth)+' as TranMonth, '+STR(@TranYear)+' as TranYear, AbsentCardNo, EmployeeID, AbsentDate, AbsentTime,
			'''+@CreateUserID+''' as CreateUserID, getdate() as CreateDate, '''+@CreateUserID+''' as LastModifyUserID, getdate() as LastModifyDate, 
				MachineCode, ShiftCode, 0 as IOCode,InputMethod, 0
		From 	#HP24049_HT2406	T
		WHERE 
		EXISTS (	SELECT TOP 1 1 FROM #HP24049_HT2406 HT2406 
						WHERE T.AbsentCardNo = HT2406.AbsentCardNo AND T.EmployeeID = HT2406.EmployeeID AND T.AbsentDate = HT2406.AbsentDate 
						GROUP BY AbsentCardNo, EmployeeID, AbsentDate, MachineCode, ShiftCode, InputMethod
						HAVING Count(1) = 1
						)
	
		Insert '+@TableHT2408+ '(DivisionID, TranMonth, TranYear, AbsentCardNo,  EmployeeID, AbsentDate, AbsentTime, 
				CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, MachineCode, ShiftCode, IOCode,InputMethod, IsAO) 
		SELECT *
		FROM (
		--- Lay nhung dong min lam du lieu quet vao
		Select 	'''+@DivisionID+''' as DivisionID, '+STR(@TranMonth)+' as TranMonth, '+STR(@TranYear)+' as TranYear, AbsentCardNo, EmployeeID, 
				AbsentDate, Min(AbsentTime) AS AbsentTime,
			'''+@CreateUserID+''' as CreateUserID, getdate() as CreateDate, '''+@CreateUserID+''' as LastModifyUserID, getdate() as LastModifyDate, 
			MachineCode, ShiftCode, 0 as IOCode,InputMethod, 0 AS IsAO
		From 	#HP24049_HT2406
		Group by AbsentCardNo, EmployeeID, AbsentDate, MachineCode, ShiftCode, InputMethod
		union all 
		--- Lay nhung dong max lam du lieu quet ra	
		Select 	'''+@DivisionID+''', '+STR(@TranMonth)+', '+STR(@TranYear)+', AbsentCardNo, EmployeeID, AbsentDate, Max(AbsentTime) AS AbsentTime,
			'''+@CreateUserID+''', getdate(), '''+@CreateUserID+''', getdate(), MachineCode, ShiftCode, 1 as IOCode,InputMethod, 0 AS IsAO
		From 	#HP24049_HT2406
		Group by AbsentCardNo, EmployeeID, AbsentDate, MachineCode, ShiftCode, InputMethod ) T
		WHERE EXISTS (	SELECT TOP 1 1 FROM #HP24049_HT2406 HT2406 
						WHERE T.AbsentCardNo = HT2406.AbsentCardNo AND T.EmployeeID = HT2406.EmployeeID AND T.AbsentDate = HT2406.AbsentDate 
						GROUP BY AbsentCardNo, EmployeeID, AbsentDate, MachineCode, ShiftCode, InputMethod
						HAVING Count(1) > 1
						)
	
		'
	END
	
	IF @CustomerName = 50	--- MEIKO
	BEGIN
	SET @sSQL003 = N'

	--kiểm tra trong bảng HT2408 chưa có dữ liệu thì insert vào từ bảng tạm HT2408_MK
	INSERT INTO  '+@TableHT2408+ ' (DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo,
				AbsentDate, AbsentTime, CreateUserID, CreateDate, LastModifyUserID,
				LastModifyDate, IOCode, IsAO )
	SELECT H28MK.DivisionID, H28MK.EmployeeID, '+STR(@TranMonth)+', '+STR(@TranYear)+', H28MK.AbsentCardNo,
				H28MK.AbsentDate, H28MK.AbsentTime, H28MK.CreateUserID, H28MK.CreateDate, H28MK.LastModifyUserID,
				H28MK.LastModifyDate, H28MK.IOCode, 1
	FROM HT2408_MK H28MK WITH (NOLOCK)
	INNER JOIN HT1407 T01 WITH (NOLOCK) on H28MK.AbsentCardNo = T01.AbsentCardNo and H28MK.DivisionID = T01.DivisionID
	INNER JOIN  HT1400 WITH (NOLOCK) on HT1400.EmployeeID = T01.EmployeeID and HT1400.DivisionID=T01.DivisionID
	WHERE H28MK.DivisionID = '''+@DivisionID+'''
	And HT1400.DepartmentID like '''+@DepartmentID+'''
	And	
		(
			(
			EXISTS (SELECT TOP 1 1 FROM #HP2409_NightShift NS WHERE T01.AbsentCardNo = NS.AbsentCardNo)
			AND H28MK.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate+1,101)+'''
			)
		Or
		H28MK.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate,101)+'''
		)


	'	
	END
	ELSE
	BEGIN
	SET @sSQL003 = N'

	--kiểm tra trong bảng HT2408 chưa có dữ liệu thì insert vào từ bảng tạm HT2408_MK
	INSERT INTO  '+@TableHT2408+ ' (DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo,
				AbsentDate, AbsentTime, CreateUserID, CreateDate, LastModifyUserID,
				LastModifyDate, IOCode, IsAO )
	SELECT H28MK.DivisionID, H28MK.EmployeeID, H28MK.TranMonth, H28MK.TranYear, H28MK.AbsentCardNo,
				H28MK.AbsentDate, H28MK.AbsentTime, H28MK.CreateUserID, H28MK.CreateDate, H28MK.LastModifyUserID,
				H28MK.LastModifyDate, H28MK.IOCode, 1
	FROM HT2408_MK H28MK
	INNER JOIN HT1407 T01 on H28MK.AbsentCardNo = T01.AbsentCardNo and H28MK.DivisionID = T01.DivisionID
	INNER JOIN  HT1400 on HT1400.EmployeeID = T01.EmployeeID and HT1400.DivisionID=T01.DivisionID	
	WHERE H28MK.DivisionID = '''+@DivisionID+'''
	AND H28MK.TranMonth= '+STR(@TranMonth)+'
	AND H28MK.TranYear= '+STR(@TranYear)+'	
	And HT1400.DepartmentID like '''+@DepartmentID+'''
	And	
		(
			(
			EXISTS (SELECT TOP 1 1 FROM #HP2409_NightShift NS WHERE T01.AbsentCardNo = NS.AbsentCardNo)
			AND H28MK.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate+1,101)+'''
			)
		Or
		H28MK.AbsentDate Between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate,101)+'''
		)


	'	
	END
	--print @sSQL000
	--print @sSQL001
	--print @sSQL002
	--print @sSQL003

	EXEC (@sSQL000+@sSQL001+@sSQL002+@sSQL003)

	--EXEC HP2430  @DivisionID, 	@TranMonth,	 @TranYear,	@FromDate,	 @ToDate, 	@CreateUserID
END

SET NOCOUNT OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

