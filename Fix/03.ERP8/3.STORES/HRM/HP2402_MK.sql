IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2402_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2402_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



 
 -- <Summary>
 ---- 
 ---- Ket chuyen cham cong ngay sang cham cong thang
 -- <Param>
 ----  Customize MEIKO 
 -- <Return>
 ---- 
 -- <Reference> 
 ---- Gọi từ sp HP2402
 -- <History>
 ----Created by: Phương Thảo, Date: 22/10/2016
---- Modified on 09/11/2016 by Bảo Thy: Bổ sung xử lý tách bảng nghiệp vụ 
---- Modified by Phương Thảo on 27/04/2017: Chỉnh sửa cách tính giờ công thực tế cho NV vừa CT, vừa TV
---- Modified by Phương Thảo on 01/06/2017: Bổ sung kết chuyển công nghỉ không hưởng lương theo thiết lập\
---- Modified by Phương Thảo on 08/12/2017: Chỉnh sửa cách kết chuyển công phụ nữ (theo yêu cầu mới của Meiko)
 /*-- <Example>
 	exec HP2402 @DivisionID=N'MK',@DepartmentID=N'M000000',@TeamID=N'%',@EmployeeID=N'000870',@AbsentTypeID=N'%',@TranMonth=3,@TranYear=2017,@CreateUserID=N'ASOFTADMIN',@PeriodID=N'P01',@BeginDate='2017-03-01 00:00:00',@EndDate='2017-03-31 00:00:00'
 ----*/


CREATE PROCEDURE [dbo].[HP2402_MK] 
				@DivisionID AS nvarchar(50),
				@DepartmentID AS nvarchar(50),
				@TeamID AS nvarchar(50),
				@EmployeeID AS nvarchar(50),
				@AbsentTypeID AS nvarchar(50),
				@TranMonth AS int,
				@TranYear AS int,
				@CreateUserID AS nvarchar(50),
				@PeriodID nvarchar(50) = Null,
				@BeginDate Datetime = Null,
				@EndDate Datetime = Null
AS

DECLARE	@sSQL1 AS nvarchar(4000),
		@sSQL2 AS nvarchar(4000),
		@sSQL3 AS nvarchar(4000),
		@sSQL4 AS nvarchar(4000),
		@sSQL41 AS nvarchar(4000),
		@sSQL5 AS nvarchar(4000),
		@sSQL6 AS nvarchar(4000),
		@sSQL7 AS nvarchar(4000),
		@cursor AS cursor,
		@TimeConvert AS decimal(28,8),	
		@AbsentAmount AS decimal(28,8),
		@ChildUnitID AS nvarchar(50),
		@ParentUnitID AS nvarchar(50),
		@ParentID AS nvarchar(50),
		@ConvertAmount AS decimal(28,8),
		@ParentAmount AS decimal(28,8),		
		@TeamID1 nvarchar(50),
		@DepartmentID1 nvarchar(50),
		@CustomerIndex int,
		@FirstDate datetime, @LastDate datetime,
		@sSQL001 Nvarchar(4000) ='',
		@sSQL002 Nvarchar(4000) ='',
		@TableHT2400 Varchar(50),
		@TableHT2401 Varchar(50),
		@TableHT2402 Varchar(50),
		@sTranMonth Varchar(2)

SET @sSQL1 = ''
SET	@sSQL2 = ''

SET @FirstDate = CONVERT(Datetime,STR(@TranMonth)+'/'+'1'+'/'++STR(@TranYear)) 
--print @Date
SET @LastDate = DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@FirstDate)+1,0))

IF NOT EXISTS (SELECT ISNULL(TimeConvert,8) FROM HT0000 WHERE DivisionID = @DivisionID)									
	Set @TimeConvert = 8
Else
	Set @TimeConvert = (SELECT ISNULL(TimeConvert,8) FROM HT0000 WHERE DivisionID = @DivisionID)
---- Tách bảng
SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),@TranYear),
			@TableHT2402 = 'HT2402M'+@sTranMonth+Convert(Varchar(4),@TranYear),
			@TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2401 = 'HT2401',
			@TableHT2402 = 'HT2402',
			@TableHT2400 = 'HT2400'
END
----
If @PeriodID IS NULL								
	Set @sSQL1 = '
		SELECT T01.DivisionID, T01.DepartmentID, ISNULL(T01.TeamID,'''') AS TeamID, T01.EmployeeID, T01.TranMonth, T01.TranYear, T01.AbsentTypeID, 
				T13.ConvertUnit, T13.UnitID AS ChildUnitID,
				T13.ParentID, T23.UnitID AS ParentUnitID,
				CASE WHEN (T13.UnitID = T23.UnitID) THEN SUM(ISNULL(T01.AbsentAmount,0) * ISNULL(T23.ConvertUnit,0))
				when T13.UnitID = ''D'' and T23.UnitID = ''H''  then 
				sum(isnull(T01.AbsentAmount,0) * isnull(T23.ConvertUnit,0) * '+ cast(@TimeConvert AS nvarchar(11)) + ')		
				else sum(isnull(T01.AbsentAmount,0) * isnull(T23.ConvertUnit,0) / '+ cast(@TimeConvert AS nvarchar(11)) + ') end AS ParentAmount
		INTO #HP2402_HT2401
		FROM '+@TableHT2401+' AS T01 
		INNER JOIN (SELECT  HT1013.AbsentTypeID, HT1013.AbsentName, 
							ISNULL (HT1033.ParentID,HT1013.ParentID) AS ParentID, 
							HT1013.UnitID, HT1013.DivisionID, HT1013.ConvertUnit
					FROM	HT1013 HT1013
					LEFT JOIN HT1033 HT1033
							ON HT1013.DivisionID = HT1033.DivisionID 
							AND HT1013.AbsentTypeID = HT1033.AbsentTypeID
					) AS T13 on T01.AbsentTypeID = T13.AbsentTypeID and T01.DivisionID = T13.DivisionID
		INNER JOIN HT1013 AS T23 
				on T23.AbsentTypeID = T13.ParentID 
				and T23.DivisionID = T13.DivisionID
		INNER JOIN HT1403 ON T01.EmployeeID = HT1403.EmployeeID AND T01.DivisionID = HT1403.DivisionID
		Where 			
			T01.TranMonth = ' + cast(@TranMonth AS nvarchar(2)) + ' and
			T01.TranYear = ' + cast(@TranYear AS nvarchar(4)) + ' and
			T01.DivisionID like ''' + @DivisionID + ''' and
			T01.DepartmentID like ''' + @DepartmentID + ''' and
			isnull(T01.TeamID,'''') like isnull(''' + @TeamID + ''', ''' + ''') and
			T01.EmployeeID like ''' + @EmployeeID + ''' and	
			T13.ParentID like ''' + @AbsentTypeID + ''' 
		Group by T01.DivisionID, T01.DepartmentID, ISNULL(T01.TeamID,''''), T01.EmployeeID, T01.TranMonth, T01.TranYear, T01.AbsentTypeID, 
			T13.ConvertUnit, T13.UnitID, T13.ParentID, T23.UnitID'
Else
	Set @sSQL1 = '
		SELECT T01.DivisionID, T01.DepartmentID, ISNULL(T01.TeamID,'''') AS TeamID, T01.EmployeeID, T01.TranMonth, T01.TranYear, T01.AbsentTypeID, 
			T13.ConvertUnit, T13.UnitID AS ChildUnitID,
			T13.ParentID, T23.UnitID AS ParentUnitID,
			case when (T13.UnitID = T23.UnitID)  then sum(isnull(T01.AbsentAmount,0) * isnull(T23.ConvertUnit,0))
			when T13.UnitID = ''D'' and T23.UnitID = ''H''  then 
				sum(isnull(T01.AbsentAmount,0) * isnull(T23.ConvertUnit,0) * '+ cast(@TimeConvert AS nvarchar(11)) + ')		
				else sum(isnull(T01.AbsentAmount,0) * isnull(T23.ConvertUnit,0) / '+ cast(@TimeConvert AS nvarchar(11)) + ') end AS ParentAmount
		 INTO #HP2402_HT2401
		 FROM '+@TableHT2401+' AS T01 
		 INNER JOIN (SELECT  HT1013.AbsentTypeID, HT1013.AbsentName, 
							ISNULL (HT1033.ParentID,HT1013.ParentID) AS ParentID, 
							HT1013.UnitID, HT1013.DivisionID, HT1013.ConvertUnit
					FROM	HT1013 HT1013
					LEFT JOIN HT1033 HT1033
							ON HT1013.DivisionID = HT1033.DivisionID 
							AND HT1013.AbsentTypeID = HT1033.AbsentTypeID
					) AS T13 on T01.AbsentTypeID = T13.AbsentTypeID and T01.DivisionID = T13.DivisionID
		INNER JOIN HT1013 AS T23 
				on T23.AbsentTypeID = T13.ParentID 
				and T23.DivisionID = T13.DivisionID
		
		Where T01.TranMonth = ' + cast(@TranMonth AS nvarchar(2)) + ' and
			T01.TranYear = ' + cast(@TranYear AS nvarchar(4)) + ' and
			T01.DivisionID like ''' + @DivisionID + ''' and
			T01.DepartmentID like ''' + @DepartmentID + ''' and
			isnull(T01.TeamID,'''') like isnull(''' + @TeamID + ''', ''' + ''') and
			T01.EmployeeID like ''' + @EmployeeID + ''' and	
			T13.ParentID like ''' + @AbsentTypeID + ''' and 
			T01.AbsentDate between ''' + ltrim(month(@BeginDate)) + '/' + ltrim(Day(@BeginDate)) + '/' + ltrim(Year(@BeginDate)) + ''' And ''' 
			+ ltrim(month(@EndDate)) + '/' + ltrim(Day(@EndDate)) + '/' + ltrim(Year(@EndDate)) + ''' 				
		Group by T01.DivisionID, T01.DepartmentID, ISNULL(T01.TeamID,'''') , T01.EmployeeID, T01.TranMonth, T01.TranYear, T01.AbsentTypeID, 
			T13.ConvertUnit, T13.UnitID, T13.ParentID, T23.UnitID'
	

	
--print @sSQL1;	
--IF NOT EXISTS (SELECT 1 FROM  SYSOBJECTS WHERE XTYPE ='V' AND NAME ='HV2603')
--	EXEC(' CREATE VIEW HV2603  ---tao boi HP2402
--			as '+@sSQL1)
--ELSE
--	EXEC(' ALTER VIEW HV2603  ---tao boi HP2402
--			as '+@sSQL1)

Set @sSQL2 = '				
		IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N''[dbo].[HP2402_HT2401]'') AND OBJECTPROPERTY(id, N''IsUserTable'') = 1)
			DROP TABLE HP2402_HT2401

		SELECT	T01.DivisionID, T01.DepartmentID, T01.TeamID, T01.EmployeeID, 
				T01.TranMonth, T01.TranYear, T01.ParentID AS AbsentTypeID,
				Sum(T01.ParentAmount) AS AbsentAmount, HT1403.TitleID
		INTO	HP2402_HT2401
		FROM	#HP2402_HT2401  T01
		INNER JOIN HT1403 ON T01.EmployeeID = HT1403.EmployeeID AND T01.DivisionID = HT1403.DivisionID
		WHERE	T01.DivisionID = '''+@DivisionID+'''
		GROUP BY T01.DivisionID, T01.DepartmentID, T01.TeamID, 
				T01.EmployeeID, T01.TranMonth, T01.TranYear, T01.ParentID, HT1403.TitleID
						
		---- Lam du thang 100% chinh thuc
		UPDATE	T1
		SET		T1.AbsentAmount = T2.StandardAbsentAmount
		FROM	HP2402_HT2401 T1
		INNER JOIN HT1106 T2 WITH (NOLOCK) on T1.TitleID = T2.TitleID and T1.DivisionID = T2.DivisionID		
		WHERE 
		AbsentTypeID IN (
						SELECT  CActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+'''
						)
		AND
		(
			---- Lam du thang
			(	NOT EXISTS 
				(SELECT TOP 1 1 FROM HT1380 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.LeaveDate < '''+Convert(Varchar(20),@LastDate,112)+''')
				AND
				NOT EXISTS
				(SELECT TOP 1 1 FROM HT1403 T3 WHERE T1.EmployeeID = T3.EmployeeID and T3.WorkDate > '''+Convert(Varchar(20),@FirstDate,112)+''')
			)
			-- Thoi gian lam viec trong thang hoan toan la Chinh thuc/ Thu viec
			AND 
			(
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and '''+Convert(Varchar(20),@FirstDate,112)+''' > T2.ToApprenticeTime)
				OR
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and '''+Convert(Varchar(20),@LastDate,112)+''' < T2.FromApprenticeTime)
				OR
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.ToApprenticeTime is null and T2.FromApprenticeTime is null )
			)
		)
		
		UPDATE	T1
		SET		T1.AbsentAmount = 0
		FROM	HP2402_HT2401 T1
		INNER JOIN HT1106 T2 WITH (NOLOCK) on T1.TitleID = T2.TitleID and T1.DivisionID = T2.DivisionID		
		WHERE 
		AbsentTypeID IN (
						SELECT  TActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+'''
						)
		AND
		(
			---- Lam du thang
			(	NOT EXISTS 
				(SELECT TOP 1 1 FROM HT1380 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.LeaveDate < '''+Convert(Varchar(20),@LastDate,112)+''')
				AND
				NOT EXISTS
				(SELECT TOP 1 1 FROM HT1403 T3 WHERE T1.EmployeeID = T3.EmployeeID and T3.WorkDate > '''+Convert(Varchar(20),@FirstDate,112)+''')
			)
			-- Thoi gian lam viec trong thang hoan toan la Chinh thuc/ Thu viec
			AND 
			(
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and '''+Convert(Varchar(20),@FirstDate,112)+''' > T2.ToApprenticeTime)
				OR
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and '''+Convert(Varchar(20),@LastDate,112)+''' < T2.FromApprenticeTime)
				OR
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.ToApprenticeTime is null and T2.FromApprenticeTime is null )
			)
		)

		---- Lam du thang 100% thu viec
		UPDATE	T1
		SET		T1.AbsentAmount = T2.StandardAbsentAmount
		FROM	HP2402_HT2401 T1
		INNER JOIN HT1106 T2 WITH (NOLOCK) on T1.TitleID = T2.TitleID and T1.DivisionID = T2.DivisionID		
		WHERE 
		AbsentTypeID IN (						
						SELECT  TActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+''')
		AND
		(
			---- Lam du thang
			(	NOT EXISTS 
				(SELECT TOP 1 1 FROM HT1380 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.LeaveDate < '''+Convert(Varchar(20),@LastDate,112)+''')
				AND
				NOT EXISTS
				(SELECT TOP 1 1 FROM HT1403 T3 WHERE T1.EmployeeID = T3.EmployeeID and T3.WorkDate > '''+Convert(Varchar(20),@FirstDate,112)+''')
			)
			-- Thoi gian lam viec trong thang hoan toan la Chinh thuc/ Thu viec
			AND 
			(
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.FromApprenticeTime <= '''+Convert(Varchar(20),@FirstDate,112)+'''
													AND T2.ToApprenticeTime >= '''+Convert(Varchar(20),@LastDate,112)+''' )				
			)

		)
		'

Set @sSQL3 = '	
		UPDATE	T1
		SET		T1.AbsentAmount = 0
		FROM	HP2402_HT2401 T1
		INNER JOIN HT1106 T2 WITH (NOLOCK) on T1.TitleID = T2.TitleID and T1.DivisionID = T2.DivisionID		
		WHERE 
		AbsentTypeID IN (						
						SELECT  CActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+''')
		AND
		(
			---- Lam du thang
			(	NOT EXISTS 
				(SELECT TOP 1 1 FROM HT1380 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.LeaveDate < '''+Convert(Varchar(20),@LastDate,112)+''')
				AND
				NOT EXISTS
				(SELECT TOP 1 1 FROM HT1403 T3 WHERE T1.EmployeeID = T3.EmployeeID and T3.WorkDate > '''+Convert(Varchar(20),@FirstDate,112)+''')
			)
			-- Thoi gian lam viec trong thang hoan toan la Chinh thuc/ Thu viec
			AND 
			(
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.FromApprenticeTime <= '''+Convert(Varchar(20),@FirstDate,112)+'''
													AND T2.ToApprenticeTime >= '''+Convert(Varchar(20),@LastDate,112)+''' )				
			)

		)

		-- Lay thoi gian lam viec thuc te cho phan thoi gian chinh thuc
		UPDATE	T1
		SET		T1.AbsentAmount = T2.AbsentAmount
		FROM	HP2402_HT2401 T1
		INNER JOIN 
		(
			SELECT EmployeeID, SUM(T1.AbsentAmount) AS AbsentAmount
			FROM HP2402_HT2401 T1
			WHERE 
			T1.AbsentTypeID IN (
							SELECT  Distinct ParentID						
							FROM HT1013 left join HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID 
							AND HT1013.DivisionID = HT0383.DivisionID
							WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
							AND HT1013.DivisionID = '''+@DivisionID+''' AND HT0383.ReportID = ''BCCT'' AND HT0383.DataTypeID =  ''Amount23'')	
			AND
			T1.AbsentTypeID IN (
						SELECT  CActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+'''
						)
			GROUP BY EmployeeID
		) T2 ON T1.EmployeeID = T2.EmployeeID
		WHERE 
		AbsentTypeID IN (
						SELECT  CActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+'''
						)
		AND
		(
			---- Lam du thang
			(	NOT EXISTS 
				(SELECT TOP 1 1 FROM HT1380 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.LeaveDate < '''+Convert(Varchar(20),@LastDate,112)+''')
				AND
				NOT EXISTS
				(SELECT TOP 1 1 FROM HT1403 T3 WHERE T1.EmployeeID = T3.EmployeeID and T3.WorkDate > '''+Convert(Varchar(20),@FirstDate,112)+''')
			)
			-- Thoi gian lam viec vua la thu viec, vua la chinh thuc
			AND 
			(
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.ToApprenticeTime >= '''+Convert(Varchar(20),@BeginDate,112)+''' AND T2.ToApprenticeTime < '''+Convert(Varchar(20),@EndDate,112)+''')				
				OR
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.FromApprenticeTime > '''+Convert(Varchar(20),@BeginDate,112)+''' AND T2.FromApprenticeTime < ='''+Convert(Varchar(20),@EndDate,112)+''')				

			)

		)
		
		 '

SET @sSQL4 = N'
		-- Tinh so cong thuc te Thu viec  = Gio cong tieu chuan - thoi gian lam viec thuc te cho phan thoi gian chinh thuc
		UPDATE	T1
		SET		T1.AbsentAmount = T2.StandardAbsentAmount - T3.AbsentAmount
		FROM	HP2402_HT2401 T1
		INNER JOIN HT1106 T2 WITH (NOLOCK) on T1.TitleID = T2.TitleID and T1.DivisionID = T2.DivisionID		
		INNER JOIN 
		(
			SELECT EmployeeID, SUM(T1.AbsentAmount) AS AbsentAmount
			FROM HP2402_HT2401 T1
			WHERE 
			T1.AbsentTypeID IN  (						
						SELECT  CActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+''')
			GROUP BY EmployeeID
		) T3 ON T1.EmployeeID = T3.EmployeeID
		WHERE 
		AbsentTypeID IN (						
						SELECT  TActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+''')
		AND
		(
			---- Lam du thang
			(	NOT EXISTS 
				(SELECT TOP 1 1 FROM HT1380 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.LeaveDate < '''+Convert(Varchar(20),@LastDate,112)+''')
				AND
				NOT EXISTS
				(SELECT TOP 1 1 FROM HT1403 T3 WHERE T1.EmployeeID = T3.EmployeeID and T3.WorkDate > '''+Convert(Varchar(20),@FirstDate,112)+''')
			)
			-- Thoi gian lam viec vua la thu viec, vua la chinh thuc
			AND 
			(
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.ToApprenticeTime >= '''+Convert(Varchar(20),@BeginDate,112)+''' AND T2.ToApprenticeTime < '''+Convert(Varchar(20),@EndDate,112)+''')				
				OR
				EXISTS 
				(SELECT TOP 1 1 FROM HT1403 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.FromApprenticeTime > '''+Convert(Varchar(20),@BeginDate,112)+''' AND T2.FromApprenticeTime < ='''+Convert(Varchar(20),@EndDate,112)+''')				
			
			)

		)

		-- Khong lam du thang: Lay du lieu thuc te
		UPDATE	T1
		SET		T1.AbsentAmount = T2.AbsentAmount
		FROM	HP2402_HT2401 T1
		INNER JOIN 
		(
			SELECT EmployeeID, SUM(T1.AbsentAmount) AS AbsentAmount
			FROM HP2402_HT2401 T1
			WHERE 
			T1.AbsentTypeID IN (
							SELECT  Distinct ParentID						
							FROM HT1013 left join HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID 
							AND HT1013.DivisionID = HT0383.DivisionID
							WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
							AND HT1013.DivisionID = '''+@DivisionID+''' AND HT0383.ReportID = ''BCCT'' AND HT0383.DataTypeID =  ''Amount23'')	
			AND
			T1.AbsentTypeID IN (
						SELECT  CActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+'''
						)
			GROUP BY EmployeeID
		) T2 ON T1.EmployeeID = T2.EmployeeID
		WHERE 
		AbsentTypeID IN (
						SELECT  CActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+'''
						)
		AND
		(
			EXISTS 
			(SELECT TOP 1 1 FROM HT1380 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.LeaveDate < '''+Convert(Varchar(20),@LastDate,112)+''')
			OR
			EXISTS
			(SELECT TOP 1 1 FROM HT1403 T3 WHERE T1.EmployeeID = T3.EmployeeID and T3.WorkDate > '''+Convert(Varchar(20),@FirstDate,112)+''')
		)
		'
SET @sSQL41 = N'
		UPDATE	T1
		SET		T1.AbsentAmount = T2.AbsentAmount
		FROM	HP2402_HT2401 T1
		INNER JOIN 
		(
			SELECT EmployeeID, SUM(T1.AbsentAmount) AS AbsentAmount
			FROM HP2402_HT2401 T1
			WHERE 
			T1.AbsentTypeID IN (
							SELECT  Distinct ParentID						
							FROM HT1013 left join HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID 
							AND HT1013.DivisionID = HT0383.DivisionID
							WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
							AND HT1013.DivisionID = '''+@DivisionID+''' AND HT0383.ReportID = ''BCCT'' AND HT0383.DataTypeID =  ''Amount23'')	
			AND 
			T1.AbsentTypeID IN (
						SELECT  TActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+'''
						)
			GROUP BY EmployeeID
		) T2 ON T1.EmployeeID = T2.EmployeeID
		WHERE 
		AbsentTypeID IN (
						SELECT  TActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+'''
						)
		AND
		(
			EXISTS 
			(SELECT TOP 1 1 FROM HT1380 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.LeaveDate < '''+Convert(Varchar(20),@LastDate,112)+''')
			OR
			EXISTS
			(SELECT TOP 1 1 FROM HT1403 T3 WHERE T1.EmployeeID = T3.EmployeeID and T3.WorkDate > '''+Convert(Varchar(20),@FirstDate,112)+''')
		)
		'
SET @sSQL5 = '

		DECLARE @MinPeriod Int
		--SELECT	@MinPeriod = Min(TranYear*100+TranMonth)
		--FROM	HT2400
		--WHERE	DivisionID = '''+@DivisionID+'''

		--SELECT  Distinct ParentID						
		--INTO #ParentID_NB
		--FROM HT1013 left join HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID 
		--AND HT1013.DivisionID = HT0383.DivisionID
		--WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
		--AND HT1013.DivisionID = '''+@DivisionID+''' AND HT0383.ReportID = ''BCCT'' AND HT0383.DataTypeID =  ''Amount06''

		SELECT  Distinct ParentID						
		INTO #ParentID_NB
		FROM HT1013 
		WHERE  HT1013.DivisionID = '''+@DivisionID+''' AND TypeID = ''NB'' 
		AND ISNULL(ParentID,'''') <> ''''

		DECLARE @cursorNB AS cursor,
				@ParentIDNB AS Varchar(50)
		
		SET @cursorNB = Cursor scroll keyset for
		SELECT	ParentID
		FROM	#ParentID_NB 
		Open @cursorNB
		Fetch next from @cursorNB into @ParentIDNB
		WHILE @@FETCH_STATUS = 0
		Begin
			
			INSERT INTO HP2402_HT2401		
			SELECT	'''+@DivisionID+''', T1.DepartmentID, Isnull(T1.TeamID,'''') AS TeamID, T1.EmployeeID, 
					T1.TranMonth, T1.TranYear, @ParentIDNB,
					0 AS AbsentAmount, T1.TitleID	
			FROM	HP2402_HT2401 T1		
			WHERE  NOT EXISTS 
					(SELECT TOP 1 1 FROM HP2402_HT2401 T2 WHERE T1.DivisionID = T2.DivisionID and T1.EmployeeID = T2.EmployeeID AND 
							T2.AbsentTypeID = @ParentIDNB)
					AND T1.AbsentTypeID = @ParentIDNB
		Fetch next from @cursorNB into @ParentIDNB
  		End
		Close @cursorNB
		Deallocate @cursorNB


		SELECT @MinPeriod = 201610

		UPDATE	T1
		SET		T1.AbsentAmount = T1.AbsentAmount + Isnull(Convert(Int,T2.N01),0)
		FROM	HP2402_HT2401 T1
		LEFT JOIN HT1413 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID		
		WHERE  T1.TranMonth+T1.TranYear*100 = @MinPeriod And AbsentTypeID = ''T.NB''
			
		UPDATE	T1
		SET		T1.AbsentAmount = T1.AbsentAmount + Isnull(T3.AbsentAmount,0)
		FROM	HP2402_HT2401 T1			
		LEFT JOIN '+@TableHT2402+' T3 WITH (NOLOCK) on T1.EmployeeID = T3.EmployeeID and T1.DivisionID = T3.DivisionID And T1.AbsentTypeID = T3.AbsentTypeID
										and ( (T1.TranMonth = T3.TranMonth + 1 and T1.TranYear = T3.TranYear ) 			
											or (T1.TranYear = T3.TranYear + 1 and T3.TranMonth = 12 ) )			
		WHERE   T1.TranMonth+T1.TranYear*100 > @MinPeriod AND
		T1.AbsentTypeID IN (
						SELECT  Distinct ParentID						
						FROM HT1013 left join HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID 
						AND HT1013.DivisionID = HT0383.DivisionID
						WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
						AND HT1013.DivisionID = '''+@DivisionID+''' AND HT0383.ReportID = ''BCCT'' AND HT0383.DataTypeID =  ''Amount06'')	

		
		'
--- Xử lý các loại công nghỉ không hưởng lương
SET @sSQL6 = '
DECLARE @AccumulateAmount Decimal(28,8) = 0

SELECT	ROW_NUMBER() OVER(PARTITION BY T1.EmployeeID ORDER BY T1.EmployeeID, T2.Priority) AS OrderNum,
		T1.EmployeeID, T1.AbsentTypeID, T1.AbsentAmount, T3.StandardAbsentAmount, Convert(Decimal(28,8),0) AS AccumulateAmount
INTO #HP2402_HT2401_NKL
FROM HP2402_HT2401 T1
INNER JOIN HT0019  T2 ON T1.DivisionID = T2.DivisionID AND T1.AbsentTypeID = T2.AbsentTypeID
INNER JOIN HT1106 T3 WITH (NOLOCK) on T1.TitleID = T3.TitleID and T1.DivisionID = T3.DivisionID		
ORDER BY T2.Priority


UPDATE T1
SET @AccumulateAmount = @AccumulateAmount + T1.AbsentAmount
FROM #HP2402_HT2401_NKL T1
--INNER JOIN #HP2402_HT2401_NKL T2 ON T1.OrderNum = T2.OrderNum + 1 AND T1.EmployeeID = T2.EmployeeID

UPDATE T1
SET T1.AbsentAmount = CASE WHEN T1.AccumulateAmount <= T1.StandardAbsentAmount 
						THEN T1.AbsentAmount 
					ELSE CASE WHEN T1.AccumulateAmount - T1.StandardAbsentAmount <= 0 
							THEN 0 
						 ELSE T1.StandardAbsentAmount - T2.AccumulateAmount END 
					END
FROM #HP2402_HT2401_NKL T1
INNER JOIN #HP2402_HT2401_NKL T2 ON T1.OrderNum = T2.OrderNum + 1 AND T1.EmployeeID = T2.EmployeeID

UPDATE  T1
SET		T1.AbsentAmount = T2.AbsentAmount
FROM	HP2402_HT2401 T1
INNER JOIN #HP2402_HT2401_NKL T2 ON T1.EmployeeID = T2.EmployeeID AND T1.AbsentTypeID = T2.AbsentTypeID

'
--print @sSQL1
--print @sSQL2
--print @sSQL3
--print @sSQL4
--print @sSQL41
--print @sSQL5
--print @sSQL6
EXEC (@sSQL1 + @sSQL2 + @sSQL3+ @sSQL4+ @sSQL41+ @sSQL5+ @sSQL6)

--IF NOT EXISTS (SELECT 1 FROM  SYSOBJECTS WHERE XTYPE ='V' AND NAME ='HV2604')
--	EXEC(' CREATE VIEW HV2604 AS '+@sSQL2) ---tao boi HP2402
--ELSE
--	EXEC(' ALTER VIEW HV2604 AS '+@sSQL2)  ---tao boi HP2402

If @PeriodID Is Null
Begin
	SET @sSQL001 = '	
	DELETE '+@TableHT2402+'
	FROM '+@TableHT2402+' T1
	INNER JOIN  HP2402_HT2401  T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
	WHERE T1.DivisionID = '''+@DivisionID+'''
		and T1.EmployeeID like '''+@EmployeeID +'''
		and T1.TranMonth = '+STR(@TranMonth)+' 
		and T1.TranYear = '+STR(@TranYear)+'
		and T1.DepartmentID like '''+@DepartmentID+''' 
		and isnull(T1.TeamID,'''')  like isnull('''+@TeamID+''','''')


	Insert into '+@TableHT2402+' ( EmployeeID, TranMonth, TranYear, DivisionID, DepartmentID, TeamID, 
								AbsentTypeID, AbsentAmount, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, PeriodID)
	Select	EmployeeID, TranMonth, TranYear, DivisionID,  DepartmentID, TeamID, AbsentTypeID, AbsentAmount,
			getdate(), getdate(), '''+@CreateUserID+''', '''+@CreateUserID+''', '''+ISNULL(@PeriodID,'')+'''
	From	HP2402_HT2401
			'
End
Else
Begin
	SET @sSQL001 = '
	DELETE '+@TableHT2402+'
	FROM '+@TableHT2402+' T1
	INNER JOIN  HP2402_HT2401  T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
	WHERE T1.DivisionID = '''+@DivisionID+'''
		and T1.EmployeeID like '''+@EmployeeID +'''
		and T1.TranMonth = '+STR(@TranMonth)+' 
		and T1.TranYear = '+STR(@TranYear)+'
		and T1.DepartmentID like '''+@DepartmentID+''' 
		and isnull(T1.TeamID,'''')  like isnull('''+@TeamID+''','''')
		and PeriodID = '''+@PeriodID+'''

	Insert into '+@TableHT2402+' ( EmployeeID, TranMonth, TranYear, DivisionID, DepartmentID, TeamID, 
								AbsentTypeID, AbsentAmount, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, PeriodID)
	Select	EmployeeID, TranMonth, TranYear, DivisionID,  DepartmentID, TeamID, AbsentTypeID, AbsentAmount,
			getdate(), getdate(), '''+@CreateUserID+''', '''+@CreateUserID+''', '''+@PeriodID+'''
	From	HP2402_HT2401

			'
End
--Print @sSQL001
EXEC (@sSQL001)

--Cap nhat bang HT7777
	If @PeriodID is not null
	Begin
		If not Exists (Select Top 1 1 From HT7777 Where DivisionID = @DivisionID 	
								and TranYear = @TranYear and
								TranMonth = @TranMonth and
								PeriodID = @PeriodID)
			Insert Into HT7777(DivisionID, TranYear,TranMonth,PeriodID,BeginDate,EndDate)
				Values (@DivisionID , @TranYear,@TranMonth,@PeriodID,@BeginDate,@EndDate)
		Else
			Update HT7777 Set BeginDate=@BeginDate, EndDate=@EndDate
					Where DivisionID = @DivisionID
						and TranYear = @TranYear and
						TranMonth = @TranMonth and
						PeriodID = @PeriodID	
	End
--Cap nhat bang HT6666
	If @PeriodID is not null
	Begin
		Update HT6666 Set IsDefault=0 Where PeriodID <> @PeriodID and DivisionID = @DivisionID
		Update HT6666 Set IsDefault=1 Where PeriodID = @PeriodID and DivisionID = @DivisionID
	End

--- Customize Meiko: cộng số giờ OT phụ nữ đối với nhân viên nữ
SELECT @CustomerIndex = CustomerName From CustomerIndex
IF @CustomerIndex = 50
BEGIN
	Declare @FEAbsentTypeID nvarchar(50),
			@UnitID NVARCHAR(50),
			@ConvertUnit decimal(28,8),
			@Amount1 decimal(28,8),
			@Amount2 decimal(28,8),
			@Amount3 decimal(28,8)
			
	SELECT @FEAbsentTypeID = FEAbsentTypeID FROM HT0000 WHERE DivisionID = @DivisionID
	SELECT @UnitID = UnitID, @ConvertUnit = Isnull(ConvertUnit,1) FROM HT1013
	WHERE DivisionID = @DivisionID AND AbsentTypeID = @FEAbsentTypeID

	SELECT  @Amount1 = @ConvertUnit*(case when @UnitID = 'H' then 0.5 else 0.5/8 end),
			@Amount2 = @ConvertUnit*(case when @UnitID = 'H' then 1 else 0.5/8 end),
			@Amount3 = @ConvertUnit*(case when @UnitID = 'H' then 2 else 0.5/8 end)

	SELECT @FEAbsentTypeID = ParentID
	FROM HT1013 
	WHERE AbsentTypeID = @FEAbsentTypeID


	 SELECT T1.EmployeeID, SUM(T1.AbsentAmount) AS Amount	 
	 INTO #TEMP1
	 FROM HP2402_HT2401 T1
	 INNER JOIN HT1400 T2 On T1.DivisionID = T2.DivisionID and T1.EmployeeID = T2.EmployeeID and T2.IsMale = 0	
	 WHERE AbsentTypeID IN (
							SELECT  Distinct ParentID						
							FROM HT1013 left join HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID 
							AND HT1013.DivisionID = HT0383.DivisionID
							WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
							AND HT1013.DivisionID = @DivisionID AND HT0383.ReportID = 'BCCT' AND HT0383.DataTypeID in ('Amount01','Amount02','Amount03','Amount04'))
	GROUP BY T1.EmployeeID						
						
	SELECT EmployeeID, SUM(AbsentAmount) AS Amount	 
	INTO #TEMP2
	FROM HP2402_HT2401 
	WHERE AbsentTypeID IN (
						SELECT  Distinct ParentID						
						FROM HT1013 left join HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID 
						AND HT1013.DivisionID = HT0383.DivisionID
						WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
						AND HT1013.DivisionID = @DivisionID AND HT0383.ReportID = 'BCCT' AND HT0383.DataTypeID in ('Amount23'))
	GROUP BY EmployeeID			

	
	SELECT DISTINCT EmployeeID
	INTO #ListEmp
	FROM
	(
		SELECT EmployeeID, ShiftID
		FROM 
 			(SELECT T1.DivisionID, T1.EmployeeID, T1.TranMonth, T1.TranYear, D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
 			D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31
 			FROM HT1025 T1 WITH (NOLOCK)
			INNER JOIN HP2402_HT2401 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
			INNER JOIN HT1400 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID
 			WHERE T1.DivisionID = @DivisionID AND T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear AND T3.IsMale = 0	  
			) AS P
		UNPIVOT (ShiftID FOR DateShift IN (D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
		D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) AS UNPV
	) T
	WHERE ShiftID = 'DT'

	SET @sSQL002 ='
	DELETE '+@TableHT2402+' WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+'
		AND DepartmentID like '''+@DepartmentID+''' AND Isnull(TeamID,'''') like '''+@TeamID+'''
		AND EmployeeID like '''+@EmployeeID+''' AND AbsentTypeID = '''+@FEAbsentTypeID+''' AND Isnull(PeriodID,'''') = '''+@PeriodID+'''
	

	Insert into '+@TableHT2402+' (EmployeeID, TranMonth, TranYear, DivisionID, DepartmentID, TeamID, 
							AbsentTypeID, AbsentAmount, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, PeriodID)
	SELECT	Distinct HV26.EmployeeID, '+STR(@TranMonth)+', '+STR(@TranYear)+', '''+@DivisionID+''', HT1400.DepartmentID, HT1400.TeamID,
			'''+@FEAbsentTypeID+''', '+Convert(Varchar(50),@Amount1)+', getdate(),getdate(), '''+@CreateUserID+''', '''+@CreateUserID+''', '''+@PeriodID+'''
	FROM HP2402_HT2401 HV26
	INNER JOIN '+@TableHT2400+' HT1400 On HV26.DivisionID = HT1400.DivisionID and HV26.EmployeeID = HT1400.EmployeeID 		
	INNER JOIN HT1400 A On HV26.DivisionID = A.DivisionID and HV26.EmployeeID = A.EmployeeID and A.IsMale = 0	
	WHERE HV26.EmployeeID IN (Select T1.EmployeeID From #TEMP2 T1 LEFT JOIN #TEMP1 T2 ON T1.EmployeeID = T2.EmployeeID 
								  Where  Isnull(T1.Amount,0) - Isnull(T2.Amount,0) >=4 AND Isnull(T1.Amount,0) - Isnull(T2.Amount,0) < 12)
		  AND NOT EXISTS (SELECT TOP 1 1 FROM #ListEmp Tmp WHERE HV26.EmployeeID = Tmp.EmployeeID )

	Insert into '+@TableHT2402+' (EmployeeID, TranMonth, TranYear, DivisionID, DepartmentID, TeamID, 
							AbsentTypeID, AbsentAmount, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, PeriodID)
	SELECT	Distinct HV26.EmployeeID, '+STR(@TranMonth)+', '+STR(@TranYear)+', '''+@DivisionID+''', HT1400.DepartmentID, HT1400.TeamID,
			'''+@FEAbsentTypeID+''', '+Convert(Varchar(50),@Amount2)+', getdate(),getdate(), '''+@CreateUserID+''', '''+@CreateUserID+''', '''+@PeriodID+'''
	FROM HP2402_HT2401 HV26
	INNER JOIN '+@TableHT2400+' HT1400 On HV26.DivisionID = HT1400.DivisionID and HV26.EmployeeID = HT1400.EmployeeID 		
	INNER JOIN HT1400 A On HV26.DivisionID = A.DivisionID and HV26.EmployeeID = A.EmployeeID and A.IsMale = 0	
	WHERE HV26.EmployeeID IN (Select T1.EmployeeID From #TEMP2 T1 LEFT JOIN #TEMP1 T2 ON T1.EmployeeID = T2.EmployeeID 
								  Where  Isnull(T1.Amount,0) - Isnull(T2.Amount,0) >=12 AND Isnull(T1.Amount,0) - Isnull(T2.Amount,0) < 20)
		  AND NOT EXISTS (SELECT TOP 1 1 FROM #ListEmp Tmp WHERE HV26.EmployeeID = Tmp.EmployeeID )

	Insert into '+@TableHT2402+' (EmployeeID, TranMonth, TranYear, DivisionID, DepartmentID, TeamID, 
							AbsentTypeID, AbsentAmount, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, PeriodID)
	SELECT	Distinct HV26.EmployeeID, '+STR(@TranMonth)+', '+STR(@TranYear)+', '''+@DivisionID+''', HT1400.DepartmentID, HT1400.TeamID,
			'''+@FEAbsentTypeID+''', '+Convert(Varchar(50),@Amount3)+', getdate(),getdate(), '''+@CreateUserID+''', '''+@CreateUserID+''', '''+@PeriodID+'''
	FROM HP2402_HT2401 HV26
	INNER JOIN '+@TableHT2400+' HT1400 On HV26.DivisionID = HT1400.DivisionID and HV26.EmployeeID = HT1400.EmployeeID 		
	INNER JOIN HT1400 A On HV26.DivisionID = A.DivisionID and HV26.EmployeeID = A.EmployeeID and A.IsMale = 0	
	WHERE HV26.EmployeeID IN (Select T1.EmployeeID From #TEMP2 T1 LEFT JOIN #TEMP1 T2 ON T1.EmployeeID = T2.EmployeeID 
								  Where  Isnull(T1.Amount,0) - Isnull(T2.Amount,0) >= 20 )
		  AND NOT EXISTS (SELECT TOP 1 1 FROM #ListEmp Tmp WHERE HV26.EmployeeID = Tmp.EmployeeID )
	'
	--Print @sSQL002
	EXEC (@sSQL002)


------------------------- Kết chuyển Tiền trợ cấp đi lại ---------------------------------
SET @sSQL002 ='

UPDATE T1
SET		T1.C02 = CASE WHEN T2.Target01ID = ''1''  THEN 
					CASE WHEN T3.AbsentAmount is null THEN 0 ELSE
ISNULL(T3.AbsentAmount,0) * T1.C01 END ELSE 0 END 
FROM '+@TableHT2400+' T1
INNER JOIN HT1403 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.DivisionID = T2.DivisionID
LEFT JOIN 
(SELECT A.DivisionID, A.EmployeeID, A.TranMonth, A.TranYear, SUM(A.AbsentAmount) AS AbsentAmount
FROM '+@TableHT2402+' A
-- ket them HP2402_HT2401  se bi double dong
--INNER JOIN HP2402_HT2401 B ON A.EmployeeID = B.EmployeeID AND A.DivisionID = B.DivisionID
WHERE A.AbsentTypeID in (SELECT ParentID 
								FROM HT1013 
								LEFT JOIN HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID AND HT1013.DivisionID = HT0383.DivisionID
								WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
								AND HT1013.DivisionID = '''+@DivisionID+''' 
								AND HT0383.ReportID = ''BCCT'' AND HT0383.DataTypeID =  ''Amount19'' )
GROUP BY A.DivisionID, A.EmployeeID, A.TranMonth, A.TranYear
)T3 ON T1.EmployeeID = T3.EmployeeID AND T1.DivisionID = T3.DivisionID AND T1.TranMonth = T3.TranMonth AND T1.TranYear = T3.TranYear
WHERE	T1.DivisionID = '''+@DivisionID+''' AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+'	and
		T1.DepartmentID like ''' + @DepartmentID + ''' and
		isnull(T1.TeamID,'''') like isnull(''' + @TeamID + ''', ''' + ''') and
		T1.EmployeeID like ''' + @EmployeeID + '''
'
--Print @sSQL002
EXEC (@sSQL002)

--------------------------- Kết chuyển tiền thưởng chuyên cần ----------------------------------
--=IF(OR(AW16="TO",AW16="WW"),0,IF(M16<L16,0,IF(N16+P16+Q16<=0,200000,IF(AND((N16+P16+Q16<=8),S16<3),100000,0))))
--Giờ công thực tế <Giờ công tiêu chuẩn  bang 0
SELECT T1.EmployeeID
into #TEMP3
FROM	HP2402_HT2401 T1
LEFT JOIN HT1403 ON T1.EmployeeID = HT1403.EmployeeID AND T1.DivisionID = HT1403.DivisionID
left join HT1414 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
					AND	@LastDate BETWEEN ISNULL(T2.BeginDate,HT1403.WorkDate) AND Isnull(T2.EndDate,@LastDate) 
LEFT JOIN HT1106 WITH (NOLOCK) on HT1403.TitleID = HT1106.TitleID and HT1403.DivisionID = HT1106.DivisionID	
LEFT JOIN #TEMP2 WITH (NOLOCK) on T1.EmployeeID = #TEMP2.EmployeeID 	
WHERE CASE WHEN ISNULL(T2.EmployeeMode,'') <> '' THEN  T2.EmployeeMode ELSE T2.EmployeeStatus END in ('TO','WW')
or ISNULL(#TEMP2.Amount,0)  < HT1106.StandardAbsentAmount

--SELECT * FROM  #TEMP2 WHERE EmployeeID like  + @EmployeeID 
--SELECT * FROM  #TEMP3 WHERE EmployeeID like  + @EmployeeID 

SELECT Distinct T1.DivisionID, T1.EmployeeID,  Isnull(T2.Amount1,0) AS Amount1, Convert(Int,0) AS Times	 
INTO #TEMP4
FROM HP2402_HT2401 T1
LEFT JOIN 
(SELECT  DivisionID, EmployeeID, SUM(AbsentAmount) AS Amount1
FROM HP2402_HT2401 
WHERE 
(AbsentTypeID IN (
					SELECT  Distinct ParentID						
					FROM HT1013 left join HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID 
					AND HT1013.DivisionID = HT0383.DivisionID
					WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
					AND HT1013.DivisionID = @DivisionID AND HT0383.ReportID = 'BCCT' AND HT0383.DataTypeID in ('Amount01','Amount03','Amount04'))
) 					
AND NOT EXISTS (SELECT TOP 1 1 FROM #TEMP3 WHERE HP2402_HT2401.EmployeeID = #TEMP3.EmployeeID)
GROUP BY DivisionID, EmployeeID	 	
-- HAVING ISNULL(SUM(AbsentAmount),0) <= 8
) T2 ON T1.EmployeeID = T2.EmployeeID AND T1.DivisionID = T2.DivisionID 	
WHERE ISNULL(T2.Amount1,0) <=8

 

--SELECT * FROM  HP2402_HT2401 WHERE EmployeeID like  + @EmployeeID 
---SELECT * FROM  #TEMP4 WHERE EmployeeID like + @EmployeeID 

SET @sSQL002 ='
UPDATE T1
set		T1.Times = T2.Amount
from	#TEMP4 T1
INNER JOIN
(
SELECT	HT2401.DivisionID, HT2401.EmployeeID, 			
		COUNT(EmployeeID) AS Amount
FROM	'+@TableHT2401+' AS HT2401
LEFT JOIN HT1013 ON HT2401.DivisionID = HT1013.DivisionID AND HT2401.AbsentTypeID = HT1013.AbsentTypeID
WHERE	HT2401.TranMonth = '+STR(@TranMonth)+' AND HT2401.TranYear = '+STR(@TranYear)+'
		AND HT2401.AbsentTypeID In (SELECT ParentID 
									FROM HT1013 
									LEFT JOIN HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID AND HT1013.DivisionID = HT0383.DivisionID
									WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
									AND HT1013.DivisionID = '''+@DivisionID+'''
									AND HT0383.ReportID = ''BCCT'' AND HT0383.DataTypeID IN (''Amount01'',''Amount04'') )
GROUP BY HT2401.DivisionID, HT2401.EmployeeID
) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID 

													   
UPDATE T1
--SET		T1.C20 = CASE WHEN T2.Amount1 is null THEN 0 ELSE CASE WHEN 
--ISNULL(T2.Amount1,0) <=0 THEN 200000 ELSE CASE WHEN ISNULL(T2.Times,0) <3 THEN 100000 END END END
SET		T1.C20 = CASE WHEN T2.Amount1 is null THEN 0 
					ELSE 
						CASE WHEN ISNULL(T2.Amount1,0) <=0 THEN 200000 
							ELSE -- NHAN VIEN CÓ SỐ GIỜ CÔNG <8 VÀ Số lần nghỉ trừ  tiền thưởng chuyên cần <3 THÌ DC TRỢ CẤP 100K
								CASE WHEN ISNULL(T2.Amount1,0) <=8 AND ISNULL(T2.Times,0) <3 THEN 100000 END 
						END 
				END
FROM '+@TableHT2400+' T1
INNER JOIN #TEMP4 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID 
INNER JOIN HP2402_HT2401 T3 ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID 
WHERE	T1.DivisionID = '''+@DivisionID+''' AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+'	
AND NOT EXISTS (SELECT TOP 1 1 FROM #TEMP3 WHERE T1.EmployeeID = #TEMP3.EmployeeID)

-- TRUONG HOP NHAN VIEN DI TU NGHIEP HOAC NGHI CHO VIEC THI TRO CAP DI LAI =0
UPDATE T1
set		T1.C20 = 0
FROM '+@TableHT2400+' T1
WHERE EXISTS (SELECT TOP 1 1 FROM #TEMP3 WHERE T1.EmployeeID = #TEMP3.EmployeeID)

UPDATE T1
SET		T1.C20 = 0
FROM '+@TableHT2400+' T1
LEFT JOIN #TEMP4 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID 
INNER JOIN HP2402_HT2401 T3 ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID 
WHERE	T2.EmployeeID IS NULL AND
T1.DivisionID = '''+@DivisionID+''' AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+'	

--SELECT * FROM '+@TableHT2400+' WHERE EmployeeID like  '''+@EmployeeID+'''
'

--Print @sSQL002
EXEC (@sSQL002)

------------------------- Kết chuyển số người phụ thuộc vào hệ số 16 ---------------------------------

--SET @sSQL002 ='
--UPDATE T1
--SET		T1.C16 = T2.Relation
--FROM '+@TableHT2400+' T1
--INNER JOIN 
--(
--SELECT DivisionID, EmployeeID, Count(1) AS Relation
--FROM HT0334
--GROUP BY DivisionID, EmployeeID
--) T2 ON T1.EmployeeID = T2.EmployeeID AND T1.DivisionID = T2.DivisionID
--WHERE	T1.DivisionID = '''+@DivisionID+''' AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+'		
--'
--Print @sSQL002
--EXEC (@sSQL002)



------------------------- Kết chuyển giờ công tiêu chuẩn vào hệ số 15 ---------------------------------

SET @sSQL002 ='
UPDATE T1
SET		T1.C15 = T3.StandardAbsentAmount
FROM '+@TableHT2400+' T1
INNER JOIN HT1403 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID		
INNER JOIN HT1106 T3 WITH (NOLOCK) on T2.TitleID = T3.TitleID and T2.DivisionID = T3.DivisionID		
WHERE	T1.DivisionID = '''+@DivisionID+''' AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+'		
and exists (select top 1 1 from HP2402_HT2401 T2 where T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID	)
'
--Print @sSQL002
EXEC (@sSQL002)

----------------------- Kết chuyển 2 hệ số 149 và hệ số 150 : phân biệt thử việc, chính thức ----------------
-------------->> HS149: Nếu 100% TV = 1, 100% CT = 0, vừa CT, vừa TV = 0
-------------->> HS150: Nếu 100% TV = 0, 100% CT = 1, vừa CT, vừa TV = 1
SET @sSQL002 ='
UPDATE T1
SET	 T1.C148 = 1,
	 T1.C149 = 0,
	 T1.C150 = 0	
FROM	HT2499 T1
LEFT JOIN HT1403 T2 ON T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID	
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+'	
and exists (select top 1 1 from HP2402_HT2401 T2 where T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID	)
AND (
	-- TV hoan toan
	(T2.ToApprenticeTime is not null or  T2.FromApprenticeTime is not null) 
	and (FromApprenticeTime <= '''+Convert(Varchar(20),@FirstDate,112)+'''
	and ToApprenticeTime >= '''+Convert(Varchar(20),@LastDate,112)+''')
)

UPDATE T1
SET	 T1.C148 = 0,
	 T1.C149 = 1,
	 T1.C150 = 0	
FROM	HT2499 T1
LEFT JOIN HT1403 T2 ON T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID	
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+'	
and exists (select top 1 1 from HP2402_HT2401 T2 where T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID	)
AND 
(	T2.ToApprenticeTime is null and T2.FromApprenticeTime is null
  or	
	-- CT hoan toan
	(
	 
	'''+Convert(Varchar(20),@FirstDate,112)+''' > T2.ToApprenticeTime 
	OR
	'''+Convert(Varchar(20),@LastDate,112)+''' < T2.FromApprenticeTime
	)	
)

UPDATE T1
SET	 T1.C148 = 0,
	 T1.C149 = 0,
	 T1.C150 = 1	
FROM	HT2499 T1
LEFT JOIN HT1403 T2 ON T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID	
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+'	
and exists (select top 1 1 from HP2402_HT2401 T2 where T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID	)
AND 
(	-- vua CT, vua TV
	(T2.ToApprenticeTime >= '''+Convert(Varchar(20),@BeginDate,112)+''' AND T2.ToApprenticeTime < '''+Convert(Varchar(20),@EndDate,112)+''')
	or
	(T2.FromApprenticeTime > '''+Convert(Varchar(20),@BeginDate,112)+''' AND T2.FromApprenticeTime < ='''+Convert(Varchar(20),@EndDate,112)+''')
)
'


EXEC(@sSQL002)
--print @sSQL002
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
