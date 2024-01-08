IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0197]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0197]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET NOCOUNT ON
GO

--- Created by: Bảo Anh, date: 04/09/2013
--- Purpose: Tìm kiếm mã lỗi khi quét thẻ
--- Modify on 24/11/2213 by Bảo Anh: Sửa lỗi tìm mã sai khi quét ca đêm
--- Modify on 26/11/2213 by Bảo Anh: Bổ sung load các dòng không lỗi (dùng store này đổ nguồn cho lưới)
--- Modify on 01/12/2213 by Bảo Anh: Bổ sung trường hợp khách hàng không quét ca đêm
--- Modify on 08/12/2213 by Bảo Anh: Sửa lỗi cho trường hợp có ngày không phân ca (TaTung)
--- Modify on 27/12/2213 by Bảo Anh: Bổ sung distinct ShiftCode khi không phải ca đêm
--- Modify on 30/12/2213 by Bảo Anh: Không báo lỗi ngày mà trước đó hoặc sau ngày đó nhân viên không có thông tin chấm công (Thuận Lợi)
--- Modify on 23/01/2015 by Mai Duyen: cai tien toc do
--- Modify on 01/07/2015 by Bảo Anh: cải tiến tốc độ
--- Modify on 25/12/2015 by Phương Thảo: Sửa lại cách tìm mã sai khi quét ca đêm (Vì máy chấm công không phân biệt được check in/ check out)
--- Modify on 23/02/2016 by Phương Thảo: Bổ sung customize KH Meiko: Đẩy dữ liệu lỗi vào bảng tạm và đẩy dữ liệu bât thường qua Approve Online
--- Modify on 01/04/2016 by Phương Thảo: Bỏ phần đẩy dữ liệu bất thường (đưa ra sp HP0198)
--- Modify on 20/04/2016 by Phương Thảo: Bỏ phần xử lý cho Meiko, đưa vào sp HP0197_MK
--- Modify on 27/04/2016 by Phương Thảo: Bổ sung where thêm departmentID theo điều kiện lộc
--- Modify on 27/06/2016 by Bảo Anh: Cải tiến tốc độ
--- Modify on 18/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
--- Modified on 17/05/2017 by Bảo Thy: Bổ sung trường HT2406.APK để thực thi kiểm tra tại màn hình Hiệu chỉnh mã thẻ lỗi (HF0413)
--- Modified by Phương Thảo on 17/05/2017 : Sửa danh mục dùng chung
--- Modified on 16/11/2017 by Bảo Thy: Fix lỗi lấy dòng lỗi cho trường hợp ca đêm nối ca ngày (GODREJ)
--- Modified on 27/03/2018 by Bảo Anh: Bổ sung store customize Tiến Hưng
--- Modified on 16/04/2018 by Bảo Anh: Bổ sung thêm dữ liệu quét của ngày đầu tháng sau để quét được ca đêm ngày cuối tháng (GODREJ)
--- exec HP0197 @DivisionID=N'CTY',@DepartmentID=N'%',@TranMonth=11,@TranYear=2014,@FromDate='2014-11-01 00:00:00',@ToDate='2014-11-30 00:00:00'

CREATE PROCEDURE [dbo].[HP0197]
				@DivisionID as nvarchar(50),
				@DepartmentID as nvarchar(50),
				@TranMonth as int,
				@TranYear as int,
				@FromDate as datetime,
				@ToDate as datetime

AS

DECLARE @CustomerName int
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 90	--- Tiến Hưng
BEGIN
	EXEC HP0197_TH @DivisionID, @DepartmentID, @TranMonth, @TranYear, @FromDate, @ToDate
END
ELSE
BEGIN
	DECLARE 	@TableHT2408 Varchar(50),
				@TableHT2406 Varchar(50),
				@sTranMonth Varchar(2)

	SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

	IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
	BEGIN
		SET  @TableHT2408 = 'HT2408M'+@sTranMonth+Convert(Varchar(4),@TranYear)
		SET  @TableHT2406 = 'HT2406M'+@sTranMonth+Convert(Varchar(4),@TranYear)
	END
	ELSE
	BEGIN
		SET  @TableHT2408 = 'HT2408'
		SET  @TableHT2406 = 'HT2406'
	END

	IF(@CustomerName = 50)
	BEGIN

		EXEC HP0197_MK @DivisionID, @DepartmentID, @TranMonth, @TranYear, @FromDate, @ToDate
	END
	ELSE
	BEGIN
		--- Tạo bảng tạm thay cho view HQ2406A
		IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#HQ2406A')) 
		DROP TABLE #HQ2406A

		CREATE TABLE #HQ2406A (
							APK VARCHAR(50),
							DivisionID varchar(50),
							TranMonth int,
							Tranyear int,
							AbsentCardNo varchar(50),
							AbsentDate datetime,
							AbsentTime nvarchar(100),
							MachineCode NVARCHAR(50),
							IOCode TINYINT,
							InputMethod TINYINT,
							EmployeeID VARCHAR(50),
							Notes nvarchar(250),
							ShiftCode NVARCHAR(50),
							IsError tinyint,
							ActualDate DATETIME
		)
		--- Tạo bảng @HQ2406 chứa các mã lỗi		
		Declare @HQ2406 table
		(
			APK uniqueidentifier,
			AbsentCardNo nvarchar(50),
			AbsentDate datetime,
			AbsentTime nvarchar (100)
		)
		Declare @SQL as varchar(8000)
	
		Set @SQL ='
		INSERT INTO #HQ2406A (APK, DivisionID,TranMonth,Tranyear,AbsentCardNo,AbsentDate,AbsentTime,MachineCode,IOCode,InputMethod,EmployeeID,Notes,ShiftCode,IsError, ActualDate)
		SELECT     HT2406.APK, H06.DivisionID, H06.TranMonth, H06.Tranyear, H06.AbsentCardNo, H06.AbsentDate, H06.AbsentTime, H06.MachineCode, H06.IOCode,     
					H06.InputMethod, H06.EmployeeID,
					Null as Notes,  
					CASE WHEN ISNULL(H06.ShiftCode,'''') = '''' THEN CASE Day(H06.AbsentDate)     
					WHEN 1 THEN H25.D01 WHEN 2 THEN H25.D02 WHEN 3 THEN H25.D03 WHEN 4 THEN H25.D04 WHEN 5 THEN H25.D05 WHEN 6 THEN H25.D06 WHEN    
					7 THEN H25.D07 WHEN 8 THEN H25.D08 WHEN 9 THEN H25.D09 WHEN 10 THEN H25.D10 WHEN 11 THEN H25.D11 WHEN 12 THEN H25.D12 WHEN    
					13 THEN H25.D13 WHEN 14 THEN H25.D14 WHEN 15 THEN H25.D15 WHEN 16 THEN H25.D16 WHEN 17 THEN H25.D17 WHEN 18 THEN H25.D18 WHEN    
					19 THEN H25.D19 WHEN 20 THEN H25.D20 WHEN 21 THEN H25.D21 WHEN 22 THEN H25.D22 WHEN 23 THEN H25.D23 WHEN 24 THEN H25.D24 WHEN    
					25 THEN H25.D25 WHEN 26 THEN H25.D26 WHEN 27 THEN H25.D27 WHEN 28 THEN H25.D28 WHEN 29 THEN H25.D29 WHEN 30 THEN H25.D30 WHEN    
					31 THEN H25.D31 ELSE NULL END ELSE H06.ShiftCode END as ShiftCode,
					0 as IsError, NULL AS ActualDate
		FROM        '+@TableHT2408+ ' AS H06
		LEFT OUTER JOIN HT1025 AS H25 ON H06.EmployeeID = H25.EmployeeID and H06.DivisionID = H25.DivisionID AND H06.TranMonth = H25.TranMonth AND H06.TranYear = H25.TranYear  
		LEFT JOIN '+@TableHT2406+' AS HT2406 ON H06.AbsentCardNo = HT2406.AbsentCardNo AND H06.AbsentDate = HT2406.AbsentDate AND H06.Absenttime = HT2406.Absenttime
		AND H06.DivisionID = HT2406.DivisionID  
		WHERE  H06.DivisionID = ''' + @DivisionID + '''
		AND   H06.TranMonth = '+ str(@TranMonth) + ' AND H06.TranYear = ' +  str(@TranYear) + '
		And (Select top 1 DepartmentID From HT1400 Where DivisionID = H06.DivisionID and EmployeeID = H06.EmployeeID) like '''+@DepartmentID+'''
		AND (H06.AbsentDate Between '''	+convert(nvarchar(10),@FromDate,101)+ ''' and  '''+convert(nvarchar(10),@ToDate,101)+ ''')'
	
	IF @CustomerName = 74 AND @ToDate = EOMONTH(@ToDate)
	BEGIN
		SET @SQL = @SQL + '
		UNION ALL
		SELECT     HT2406.APK, H06.DivisionID, H06.TranMonth, H06.Tranyear, H06.AbsentCardNo, H06.AbsentDate, H06.AbsentTime, H06.MachineCode, H06.IOCode,     
				H06.InputMethod, H06.EmployeeID,
				Null as Notes,  
				CASE WHEN ISNULL(H06.ShiftCode,'''') = '''' THEN CASE Day(H06.AbsentDate)     
				WHEN 1 THEN H25.D01 WHEN 2 THEN H25.D02 WHEN 3 THEN H25.D03 WHEN 4 THEN H25.D04 WHEN 5 THEN H25.D05 WHEN 6 THEN H25.D06 WHEN    
				7 THEN H25.D07 WHEN 8 THEN H25.D08 WHEN 9 THEN H25.D09 WHEN 10 THEN H25.D10 WHEN 11 THEN H25.D11 WHEN 12 THEN H25.D12 WHEN    
				13 THEN H25.D13 WHEN 14 THEN H25.D14 WHEN 15 THEN H25.D15 WHEN 16 THEN H25.D16 WHEN 17 THEN H25.D17 WHEN 18 THEN H25.D18 WHEN    
				19 THEN H25.D19 WHEN 20 THEN H25.D20 WHEN 21 THEN H25.D21 WHEN 22 THEN H25.D22 WHEN 23 THEN H25.D23 WHEN 24 THEN H25.D24 WHEN    
				25 THEN H25.D25 WHEN 26 THEN H25.D26 WHEN 27 THEN H25.D27 WHEN 28 THEN H25.D28 WHEN 29 THEN H25.D29 WHEN 30 THEN H25.D30 WHEN    
				31 THEN H25.D31 ELSE NULL END ELSE H06.ShiftCode END as ShiftCode,
				0 as IsError, NULL AS ActualDate
		FROM        '+@TableHT2408+ ' AS H06
		LEFT OUTER JOIN HT1025 AS H25 ON H06.EmployeeID = H25.EmployeeID and H06.DivisionID = H25.DivisionID AND H06.TranMonth = H25.TranMonth AND H06.TranYear = H25.TranYear
		LEFT JOIN '+@TableHT2406+' AS HT2406 ON H06.AbsentCardNo = HT2406.AbsentCardNo AND H06.AbsentDate = HT2406.AbsentDate AND H06.Absenttime = HT2406.Absenttime
		AND H06.DivisionID = HT2406.DivisionID  
		WHERE  H06.DivisionID = ''' + @DivisionID + '''
		AND   H06.TranMonth + H06.TranYear *100  = '+ str((@TranMonth + 1) + (@TranYear * 100)) + '
		And (Select top 1 DepartmentID From HT1400 Where DivisionID = H06.DivisionID and EmployeeID = H06.EmployeeID) like '''+@DepartmentID+'''
		AND (H06.AbsentDate = '''+ convert(nvarchar(10),dateadd(d,1,@ToDate),101)+ ''') AND H06.IOCode = 1'
	END
	
	SET @SQL = @SQL + '	
		UPDATE HQ2406
		SET HQ2406.ShiftCode = (Select distinct HQ.ShiftCode 
								from #HQ2406A  HQ Where HQ.DivisionID = HQ2406.DivisionID 
								and HQ.AbsentDate = HQ2406.ActualDate and HQ.AbsentCardNo = HQ2406.AbsentCardNo 
								and Isnull(HQ.ShiftCode,'''') <> '''' and IOCode = 0)
		FROM #HQ2406A HQ2406
		WHERE ISNULL(HQ2406.ShiftCode,'''') = ''''
		'
		--print @SQL
		EXEC(@SQL)

		--IF NOT EXISTS(SELECT name FROM sysobjects WHERE id = Object_id(N'[dbo].[HQ2406A]') AND OBJECTPROPERTY(id, N'IsView') = 1)
		--	EXEC(' CREATE VIEW HQ2406A AS ' + @SQL)
		--ELSE
		--	EXEC(' ALTER VIEW HQ2406A AS ' + @SQL)    
    
		--- Nếu là khách hàng cũ, không có quét ca đêm
		IF NOT EXISTS (Select top 1 1 From HT1021 Where DivisionID = @DivisionID And Isnull(IsNextDay,0) = 1)
			BEGIN
				UPDATE #HQ2406A
				SET IsError = 1
				WHERE exists
						(select 1
						from #HQ2406A A
						Where A.AbsentCardNo = #HQ2406A.AbsentCardNo and A.AbsentDate = #HQ2406A.AbsentDate 
						Group by A.AbsentCardNo, A.EmployeeID, A.AbsentDate having count(A.AbsentCardNo)%2<>0)
			END
		ELSE --- có quét ca đêm
			BEGIN
		
				UPDATE HQ2406
				SET HQ2406.ActualDate = CASE WHEN (HQ2406.IOCode = 1 AND Convert(int,LEFT(HQ2406.Absenttime,2))<12 
												  AND HQ2406.Absenttime <= T1.BeginTime) OR ISNULL(HQ2406.ShiftCode,'') = ''
											 THEN dateadd(day,-1,HQ2406.AbsentDate) ELSE HQ2406.AbsentDate END
				FROM #HQ2406A HQ2406
				LEFT JOIN HT1020 T1 ON T1.ShiftID = HQ2406.ShiftCode --AND T1.DateTypeID = Left(datename(dw,HQ2406.AbsentDate),3)
			

				UPDATE #HQ2406A
				SET IsError = 1
				WHERE exists
				(select 1 From
				--- Insert các mã quét không đầy đủ hoặc quét dư In/Out và không phải ca đêm	 
				(
				Select AbsentCardNo,ActualDate AS AbsentDate, NULL AS AbsentTime
				From #HQ2406A HQ2406
				Group by DivisionID,AbsentCardNo,ActualDate
				having count(AbsentCardNo)%2<>0
			
				--From #HQ2406A HQ2406
				--Group by DivisionID,AbsentCardNo,EmployeeID,AbsentDate,ShiftCode,ActualDate
				--having (count(AbsentCardNo)%2<>0
				--		and (Isnull((select top 1 1 from HT1021 Where DivisionID = @DivisionID and ShiftID= (case when Isnull(HQ2406.ShiftCode,'') = '' then (Select distinct HQ.ShiftCode from #HQ2406A  HQ Where HQ.DivisionID = HQ2406.DivisionID and HQ.AbsentDate = HQ2406.ActualDate and HQ.AbsentCardNo = HQ2406.AbsentCardNo and Isnull(HQ.ShiftCode,'') <> '' and IOCode = 0) else HQ2406.ShiftCode end)
				--		and DateTypeID = Left(datename(dw,HQ2406.ActualDate),3) and Isnull(IsNextDay,0)=1),0)=0))
				
				--- Insert các mã là ca đêm	nhưng quét không đầy đủ In/Out
				Union
				Select AbsentCardNo,ActualDate AS AbsentDate,AbsentTime
				From #HQ2406A HQ2406
				Where DivisionID = @DivisionID
				And HQ2406.TranMonth=@TranMonth And HQ2406.TranYear = @TranYear
				And CONVERT(DATETIME,CONVERT(varchar(20), LTRIM(RTRIM(ActualDate)),101),101) BETWEEN CONVERT(datetime,CONVERT(VARCHAR(20), @FromDate, 101)) AND CONVERT(datetime,CONVERT(VARCHAR(20), @ToDate, 101))	  
				Group by AbsentCardNo,EmployeeID,ActualDate,AbsentTime,ShiftCode,IOCOde
				having (---count(AbsentCardNo)%2<>0
				---and 
				(Isnull((select top 1 1 from HT1021 Where DivisionID = @DivisionID and ShiftID=HQ2406.ShiftCode
				and DateTypeID = Left(datename(dw,HQ2406.ActualDate),3) and Isnull(IsNextDay,0)=1),0)=1))
				and 
				(
					(sum(IOCode) = 0 and Isnull((select top 1 IOCode From #HQ2406A H1 Where H1.AbsentCardNo = HQ2406.AbsentCardNo And H1.ActualDate = HQ2406.ActualDate Order by AbsentTime),1)<>1)
					or (Sum(IOCode) = 1 and Isnull((select top 1 IOCode From #HQ2406A H1 Where H1.AbsentCardNo = HQ2406.AbsentCardNo And H1.ActualDate = HQ2406.ActualDate Order by AbsentTime DESC),0)<>0)
					or Isnull((select top 1 1 From #HQ2406A H1 Where H1.AbsentCardNo = HQ2406.AbsentCardNo And H1.ActualDate = HQ2406.ActualDate And H1.AbsentTime <> HQ2406.AbsentTime And IOCode = HQ2406.IOCode),0) = 1)
				) A Where A.AbsentCardNo = #HQ2406A.AbsentCardNo and A.AbsentDate = #HQ2406A.ActualDate
				)
			END
	
		----Lấy ca làm việc trường hợp không nhập ca khi import
		UPDATE #HQ2406A
		SET ShiftCode = CASE Day(ActualDate)     
						WHEN 1 THEN H25.D01 WHEN 2 THEN H25.D02 WHEN 3 THEN H25.D03 WHEN 4 THEN H25.D04 WHEN 5 THEN H25.D05 WHEN 6 THEN H25.D06 WHEN    
						7 THEN H25.D07 WHEN 8 THEN H25.D08 WHEN 9 THEN H25.D09 WHEN 10 THEN H25.D10 WHEN 11 THEN H25.D11 WHEN 12 THEN H25.D12 WHEN    
						13 THEN H25.D13 WHEN 14 THEN H25.D14 WHEN 15 THEN H25.D15 WHEN 16 THEN H25.D16 WHEN 17 THEN H25.D17 WHEN 18 THEN H25.D18 WHEN    
						19 THEN H25.D19 WHEN 20 THEN H25.D20 WHEN 21 THEN H25.D21 WHEN 22 THEN H25.D22 WHEN 23 THEN H25.D23 WHEN 24 THEN H25.D24 WHEN    
						25 THEN H25.D25 WHEN 26 THEN H25.D26 WHEN 27 THEN H25.D27 WHEN 28 THEN H25.D28 WHEN 29 THEN H25.D29 WHEN 30 THEN H25.D30 WHEN    
						31 THEN H25.D31 ELSE NULL END
		FROM #HQ2406A
		LEFT JOIN HT1025 AS H25 ON #HQ2406A.EmployeeID = H25.EmployeeID and #HQ2406A.DivisionID = H25.DivisionID AND #HQ2406A.TranMonth = H25.TranMonth AND #HQ2406A.TranYear = H25.TranYear
		--WHERE ISNULL(ShiftCode,'') = ''

		--- Trả ra các dòng lỗi
		Select	HQ2406.APK, HQ2406.AbsentCardNo, HQ2406.AbsentDate, HQ2406.AbsentTime, HQ2406.EmployeeID, HQ2406.MachineCode, HQ2406.ShiftCode, HQ2406.IOCode, HQ2406.Notes,
				Ltrim(RTrim(isnull(HT1400.LastName,'')))+ ' ' + LTrim(RTrim(isnull(HT1400.MiddleName,''))) + ' ' + LTrim(RTrim(Isnull(HT1400.FirstName,''))) As FullName,
				AT1102.DepartmentName, HQ2406.IsError
		From #HQ2406A HQ2406
		left join HT1400 on HT1400.DivisionID=HQ2406.DivisionID and HT1400.EmployeeID=HQ2406.EmployeeID
		left join AT1102 on AT1102.DepartmentID=HT1400.DepartmentID
		Order by HQ2406.AbsentDate,HQ2406.AbsentCardNo,HQ2406.AbsentTime
	
		--SELECT * FROM (
		--Select HQ2406.AbsentCardNo, HQ2406.AbsentDate, HQ2406.AbsentTime, HQ2406.EmployeeID, HQ2406.MachineCode, HQ2406.ShiftCode, HQ2406.IOCode, HQ2406.Notes,
		--HV1400.FullName,HV1400.DepartmentName, 1 as IsError
		--From #HQ2406A HQ2406
		--left join HV1400 on HV1400.DivisionID=HQ2406.DivisionID and HV1400.EmployeeID=HQ2406.EmployeeID and HV1400.DepartmentID like @DepartmentID
		--right join @HQ2406 X On HQ2406.AbsentCardNo=X.AbsentCardNo and HQ2406.AbsentDate=X.AbsentDate and HQ2406.AbsentTime = Isnull(X.AbsentTime,HQ2406.AbsentTime) 

		----- Bổ sung các dòng không lỗi
		--UNION ALL
		--Select HQ2406.AbsentCardNo, HQ2406.AbsentDate, HQ2406.AbsentTime, HQ2406.EmployeeID, HQ2406.MachineCode, HQ2406.ShiftCode, HQ2406.IOCode, HQ2406.Notes,
		--HV1400.FullName,HV1400.DepartmentName, 0 as IsError
		--From #HQ2406A HQ2406
		--left join HV1400 on HV1400.DivisionID=HQ2406.DivisionID and HV1400.EmployeeID=HQ2406.EmployeeID and HV1400.DepartmentID like @DepartmentID
		--Where
		--	NOT EXISTS (Select top 1 1 From @HQ2406 Where AbsentCardNo = HQ2406.AbsentCardNo And convert(varchar(20),AbsentDate,101) = convert(varchar(20),HQ2406.AbsentDate,101)
		--				and Isnull(AbsentTime,HQ2406.AbsentTime) = HQ2406.AbsentTime)
		--) A
		--Order by AbsentDate,AbsentCardNo,AbsentTime

	END
END

SET NOCOUNT OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON