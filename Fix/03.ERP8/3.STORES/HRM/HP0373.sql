IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP0373]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0373]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created by: Kim Vũ, date: 26/02/2016
--- Purpose: In quét thẻ chấm công tương tự HP0197
--- Modify by Phương Thảo on 09/09/2016: Bổ sung tách bảng nghiệp vụ
--- Modified on 08/01/2018 by Bảo Anh: Bổ sung in nhiều đơn vị

CREATE PROCEDURE [dbo].[HP0373]
				@DivisionID nvarchar(50),
				@FromDepartmentID nvarchar(50),
				@ToDepartmentID nvarchar(50),
				@TeamID nvarchar(50),
				@FromEmployeeID nvarchar(50),
				@ToEmployeeID nvarchar(50),
				@FromMonth int,
				@FromYear int,
				@ToMonth int,
				@ToYear int,
				@lstEmployeeID as VARCHAR(8000),
				@StrDivisionID AS NVARCHAR(4000) = ''

AS

Declare @sSQL VARCHAR(8000),
		@sSQL_Where VARCHAR(8000),		
		@CustomerIndex int,
		@StrDivisionID_New AS NVARCHAR(4000),
		@sSQL1 VARCHAR(8000),
		@sSQL2 VARCHAR(8000),
		@sSQL3 VARCHAR(8000)

SET @StrDivisionID_New = ''		

IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = ' = ''' + @DivisionID + ''''

SELECT @CustomerIndex = CustomerName From CustomerIndex

IF(@CustomerIndex = 72)
BEGIN
	EXEC HP0373_TUV @DivisionID, @FromDepartmentID, @ToDepartmentID, @TeamID, @FromEmployeeID, @ToEmployeeID, @FromMonth, @FromYear, @ToMonth, @ToYear, @lstEmployeeID
END
ELSE
BEGIN
	

	DECLARE	@sSQL001 Nvarchar(4000),
			@TableHT2408 Varchar(50),		
			@sTranMonth Varchar(2)

	SELECT @sTranMonth = CASE WHEN @FromMonth >9 THEN Convert(Varchar(2),@FromMonth) ELSE '0'+Convert(Varchar(1),@FromMonth) END

	IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
	BEGIN
		IF(@FromMonth = @ToMonth and @FromYear = @ToYear)
		BEGIN
			SET  @TableHT2408 = 'HT2408M'+@sTranMonth+Convert(Varchar(4),@FromYear)
		END
		ELSE
		IF(@FromMonth <> @ToMonth and @FromYear = @ToYear)
		BEGIN
			SET  @TableHT2408 = 'HT2408Y'+Convert(Varchar(4),@FromYear)
		END
		ELSE
			SET  @TableHT2408 = 'HT2408'
	END
	ELSE
	BEGIN
		SET  @TableHT2408 = 'HT2408'
	END

	if(ISNULL(@lstEmployeeID,'') = '')
	begin
		SET @sSQL_Where =''
	end
	else
	begin
		SET @sSQL_Where = 'WHERE EmployeeID  in (''' + @lstEmployeeID + ''') '
	end
	--- Tạo bảng #HQ2406 chứa các mã lỗi		
	Create table #HQ2406 
	(
		APK uniqueidentifier,
		AbsentCardNo nvarchar(50),
		AbsentDate datetime,
		AbsentTime nvarchar (100)
	)


	CREATE TABLE #HP0373_HT2408 (
							DivisionID varchar(50),
							TranMonth int,
							Tranyear int,
							AbsentCardNo varchar(50),
							LoadAbsentDate datetime,
							AbsentTime nvarchar(100),
							MachineCode NVARCHAR(50),
							IOCode TINYINT,
							InputMethod TINYINT,
							EmployeeID VARCHAR(50),
							Notes nvarchar(250),
							ShiftCode NVARCHAR(50),
							IsNightShift Tinyint,
							AbsentDate datetime
		)



	SET @sSQL001 = N'
	INSERT INTO #HP0373_HT2408 (DivisionID,TranMonth,Tranyear,AbsentCardNo,LoadAbsentDate,AbsentTime,MachineCode,
								IOCode,InputMethod,EmployeeID,Notes,ShiftCode, IsNightShift, AbsentDate)
	SELECT     H06.DivisionID, H06.TranMonth, H06.Tranyear, H06.AbsentCardNo, H06.AbsentDate AS LoadAbsentDate, H06.AbsentTime, H06.MachineCode, H06.IOCode,     
						  H06.InputMethod, H07.EmployeeID, Null as Notes,  
						  Isnull(H06.ShiftCode,CASE Day(AbsentDate)     
						  WHEN 1 THEN H25.D01 WHEN 2 THEN H25.D02 WHEN 3 THEN H25.D03 WHEN 4 THEN H25.D04 WHEN 5 THEN H25.D05 WHEN 6 THEN H25.D06 WHEN    
						   7 THEN H25.D07 WHEN 8 THEN H25.D08 WHEN 9 THEN H25.D09 WHEN 10 THEN H25.D10 WHEN 11 THEN H25.D11 WHEN 12 THEN H25.D12 WHEN    
						   13 THEN H25.D13 WHEN 14 THEN H25.D14 WHEN 15 THEN H25.D15 WHEN 16 THEN H25.D16 WHEN 17 THEN H25.D17 WHEN 18 THEN H25.D18 WHEN    
						   19 THEN H25.D19 WHEN 20 THEN H25.D20 WHEN 21 THEN H25.D21 WHEN 22 THEN H25.D22 WHEN 23 THEN H25.D23 WHEN 24 THEN H25.D24 WHEN    
						   25 THEN H25.D25 WHEN 26 THEN H25.D26 WHEN 27 THEN H25.D27 WHEN 28 THEN H25.D28 WHEN 29 THEN H25.D29 WHEN 30 THEN H25.D30 WHEN    
						   31 THEN H25.D31 ELSE NULL END) as ShiftCode, Convert(Tinyint,0) AS IsNightShift,  H06.AbsentDate

	FROM         '+@TableHT2408+' AS H06     
	 LEFT OUTER JOIN HT1407 AS H07 ON H07.AbsentCardNo = H06.AbsentCardNo and H07.DivisionID = H06.DivisionID    
	 LEFT OUTER JOIN HT1025 AS H25 ON H07.EmployeeID = H25.EmployeeID and H07.DivisionID = H25.DivisionID    
	 WHERE  H06.DivisionID '+@StrDivisionID_New+' AND H25.TranMonth =  H06.TranMonth  AND H25.TranYear = H06.TranYear 
	 AND   H06.TranMonth + H06.TranYear*100 between '+STR(@FromMonth+ @FromYear * 100)+'  AND '+STR(@ToMonth + @ToYear * 100)+' 
	 AND H06.EmployeeID Between '''+@FromEmployeeID+''' and '''+@ToEmployeeID+'''
	 '
 
	 --print @sSQL001
	EXEC (@sSQL001)

	 UPDATE T1
	 SET	T1.IsNightShift = 1
	 FROM	#HP0373_HT2408 T1
	 INNER JOIN HT1021 T2 ON T1.DivisionID = T2.DivisionID AND T1.ShiftCode = T2.ShiftID
	 WHERE T2.IsNextDay = 1
 

	 UPDATE A
	 SET	A.AbsentDate = A.AbsentDate - 1
	 FROM	#HP0373_HT2408 A
	 WHERE	A.IsNightShift = 1
	AND (EXISTS 
	(Select Top 1 1
	From	#HP0373_HT2408 B
	Where B.LoadAbsentDate = A.LoadAbsentDate AND B.AbsentCardNo = A.AbsentCardNo 
	AND B.IsNightShift = A.IsNightShift
	Having A.AbsentTime = Min(B.AbsentTime) and Count(B.LoadAbsentDate) >1)
	OR
	(
	EXISTS 
	(Select Top 1 1
	From	#HP0373_HT2408 B
	Where B.LoadAbsentDate = A.LoadAbsentDate AND B.AbsentCardNo = A.AbsentCardNo 
	AND B.IsNightShift = A.IsNightShift
	Having A.AbsentTime = Min(B.AbsentTime))
	AND NOT EXISTS 
	(Select Top 1 1
	From	#HP0373_HT2408 C
	Where C.LoadAbsentDate = A.LoadAbsentDate +1 AND C.AbsentCardNo = A.AbsentCardNo 
	AND C.IsNightShift = A.IsNightShift)
	)
	)

	 UPDATE A
	 SET	A.IOCode = CASE WHEN A.IsNightShift = 0 THEN 0 ELSE 1 END
	 FROM	#HP0373_HT2408 A
	 WHERE	-- A.IsNightShift = 1
	EXISTS 
	(Select Top 1 1
	From	#HP0373_HT2408 B
	Where B.LoadAbsentDate = A.LoadAbsentDate AND B.AbsentCardNo = A.AbsentCardNo 
	AND B.IsNightShift = A.IsNightShift
	Having A.AbsentTime = Min(B.AbsentTime))

	 UPDATE A
	 SET	A.IOCode = CASE WHEN A.IsNightShift = 0 THEN 1 ELSE 0 END
	 FROM	#HP0373_HT2408 A
	 WHERE	-- A.IsNightShift = 1
	EXISTS 
	(Select Top 1 1
	From	#HP0373_HT2408 B
	Where B.LoadAbsentDate = A.LoadAbsentDate AND B.AbsentCardNo = A.AbsentCardNo 
	AND B.IsNightShift = A.IsNightShift
	Having A.AbsentTime = Max(B.AbsentTime))

	SET @sSQL1 = '
	IF NOT EXISTS (Select 1 From HT1021 Where DivisionID '+@StrDivisionID_New+' And Isnull(IsNextDay,0) = 1)	--- Nếu là khách hàng cũ, không có quét ca đêm
		BEGIN
			INSERT INTO #HQ2406 (AbsentCardNo,AbsentDate,AbsentTime)
			Select HQ2406.AbsentCardNo,HQ2406.AbsentDate,NULL
			From #HP0373_HT2408 HQ2406
			left join HT1400 on HT1400.DivisionID=HQ2406.DivisionID and HT1400.EmployeeID=HQ2406.EmployeeID
			right join
					(select AbsentCardNo,AbsentDate
					from #HP0373_HT2408 HQ2406
					where DivisionID '+@StrDivisionID_New+'
					And HQ2406.TranMonth + HQ2406.TranYear *100 between ' + LTRIM(@FromMonth) + ' + ' + LTRIM(@FromYear) + ' * 100 AND ' + LTRIM(@ToMonth) + ' + ' + LTRIM(@ToYear) + ' * 100				
					Group by AbsentCardNo,EmployeeID,AbsentDate having count(AbsentCardNo)%2<>0 ) as X
			On HQ2406.AbsentCardNo=X.AbsentCardNo and HQ2406.AbsentDate=X.AbsentDate
			where HQ2406.DivisionID '+@StrDivisionID_New+'
			And HQ2406.TranMonth+ HQ2406.TranYear * 100 between ' + LTRIM(@FromMonth) + ' + ' + LTRIM(@FromYear) + ' * 100  AND ' + LTRIM(@ToMonth) + ' + ' + LTRIM(@ToYear) + ' * 100 
			And HT1400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + '''
			And HT1400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + '''
			and HT1400.TeamID like ''' + @TeamID + '''
			Order by HQ2406.AbsentDate,HQ2406.AbsentCardNo,HQ2406.AbsentTime
		END'

	SET @sSQL2 = '
	ELSE --- có quét ca đêm
		BEGIN	
			--- Insert các mã quét không đầy đủ hoặc quét dư In/Out và không phải ca đêm	 
			INSERT INTO #HQ2406 (AbsentCardNo,AbsentDate,AbsentTime)
			Select AbsentCardNo,AbsentDate,NULL
			From #HP0373_HT2408 HQ2406 
			left join HT1400 on HT1400.DivisionID=HQ2406.DivisionID and HT1400.EmployeeID=HQ2406.EmployeeID
			Where HQ2406.DivisionID '+@StrDivisionID_New+'
			And HQ2406.TranMonth + HQ2406.TranYear between ' + LTRIM(@FromMonth) + ' + ' + LTRIM(@FromYear) + ' * 100  AND ' + LTRIM(@ToMonth) + ' + ' + LTRIM(@ToYear) + ' * 100 
			And HT1400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + '''
			And HT1400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + '''
			and HT1400.TeamID like ''' + @TeamID + '''
			Group by HQ2406.DivisionID,AbsentCardNo,HQ2406.EmployeeID,AbsentDate,ShiftCode
			having (count(AbsentCardNo)%2<>0
					and (Isnull((select top 1 1 from HT1021 Where DivisionID '+@StrDivisionID_New+' 
					and ShiftID= (case when Isnull(HQ2406.ShiftCode,'''') = '''' 
									then (	Select distinct HQ.ShiftCode 
											from #HP0373_HT2408  HQ 
											Where HQ.DivisionID = HQ2406.DivisionID 
											and HQ.AbsentDate = dateadd(day,-1,HQ2406.AbsentDate) 
											and HQ.AbsentCardNo = HQ2406.AbsentCardNo 
											and Isnull(HQ.ShiftCode,'''') <> '''' and IOCode = 0) 
									else HQ2406.ShiftCode end)
					and DateTypeID = Left(datename(dw,HQ2406.AbsentDate),3) and Isnull(IsNextDay,0)=1),0)=0))'


	SET @sSQL3 = '			
			--- Insert các mã là ca đêm	nhưng quét không đầy đủ In/Out
			Union
		
			Select AbsentCardNo,AbsentDate,AbsentTime
			From #HP0373_HT2408 HQ2406 
			left join HT1400 on HT1400.DivisionID=HQ2406.DivisionID and HT1400.EmployeeID=HQ2406.EmployeeID
			Where HQ2406.DivisionID '+@StrDivisionID_New+'
			And HQ2406.TranMonth + HQ2406.TranYear between ' + LTRIM(@FromMonth) + ' + ' + LTRIM(@FromYear) + ' * 100 AND ' + LTRIM(@ToMonth) + ' + ' + LTRIM(@ToYear) + ' * 100
			And HT1400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + @ToDepartmentID + '''
			And HT1400.EmployeeID between ''' + @FromEmployeeID + ''' and ''' + @ToEmployeeID + '''
			and HT1400.TeamID like ''' + @TeamID + '''
			AND EXISTS 
			(Select Top 1 1
			From	#HP0373_HT2408 B
			Where B.AbsentDate = HQ2406.AbsentDate AND B.AbsentCardNo = HQ2406.AbsentCardNo 
			AND B.IsNightShift = HQ2406.IsNightShift
			Having  Count(B.AbsentDate)%2<>0)
			and(
			(Isnull((select top 1 1 from HT1021 Where DivisionID '+@StrDivisionID_New+' and ShiftID=HQ2406.ShiftCode 
			and DateTypeID = Left(datename(dw,HQ2406.AbsentDate),3) and Isnull(IsNextDay,0)=1),0)=1)
			or 
			(Isnull((select top 1 1 From #HP0373_HT2408 H1 Where H1.AbsentCardNo = HQ2406.AbsentCardNo 
			And H1.AbsentDate = HQ2406.AbsentDate And H1.AbsentTime <> HQ2406.AbsentTime And IOCode = HQ2406.IOCode),0) = 1)
			)
		END'

	--- Trả ra các dòng lỗi
	SET @sSQL = '
	SELECT * FROM (
	Select HQ2406.AbsentCardNo, HQ2406.LoadAbsentDate AS AbsentDate, HQ2406.AbsentTime, HQ2406.EmployeeID, HQ2406.MachineCode, HQ2406.ShiftCode, HQ2406.IOCode, HQ2406.Notes,
	HV1400.FullName,HV1400.DepartmentName, HV1400.TeamName, 1 as IsError, HQ2406.AbsentDate AS RefAbsentDate
	From #HP0373_HT2408 HQ2406
	left join HV1400 on HV1400.DivisionID=HQ2406.DivisionID and HV1400.EmployeeID=HQ2406.EmployeeID and HV1400.DepartmentID between ''' + @FromDepartmentID+ ''' and ''' + @ToDepartmentID +'''
	right join #HQ2406 X On HQ2406.AbsentCardNo=X.AbsentCardNo and HQ2406.AbsentDate=X.AbsentDate and HQ2406.AbsentTime = Isnull(X.AbsentTime,HQ2406.AbsentTime) 

	--- Bổ sung các dòng không lỗi
	UNION ALL
	Select HQ2406.AbsentCardNo, HQ2406.LoadAbsentDate AS AbsentDate, HQ2406.AbsentTime, HQ2406.EmployeeID, HQ2406.MachineCode, HQ2406.ShiftCode, HQ2406.IOCode, HQ2406.Notes,
	HV1400.FullName,HV1400.DepartmentName, HV1400.TeamName, 0 as IsError, HQ2406.AbsentDate  AS RefAbsentDate
	From #HP0373_HT2408 HQ2406
	left join HV1400 on HV1400.DivisionID=HQ2406.DivisionID and HV1400.EmployeeID=HQ2406.EmployeeID and HV1400.DepartmentID between ''' + @FromDepartmentID+ ''' and ''' + @ToDepartmentID +'''
	Where
		NOT EXISTS (Select top 1 1 From #HQ2406 Where AbsentCardNo = HQ2406.AbsentCardNo And convert(varchar(20),AbsentDate,101) = convert(varchar(20),HQ2406.AbsentDate,101)
					and Isnull(AbsentTime,HQ2406.AbsentTime) = HQ2406.AbsentTime)
	) A
	' + @sSQL_Where + '
	Order by AbsentDate,AbsentCardNo,AbsentTime
	'

	--PRINT(@sSQL)
	EXEC(@sSQL1 + @sSQL2 + @sSQL3)
	EXEC(@sSQL)

	Drop table #HQ2406

END


SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

