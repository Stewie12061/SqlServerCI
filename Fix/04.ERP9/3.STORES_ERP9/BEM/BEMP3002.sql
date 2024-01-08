IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP3002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP3002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load dữ liệu báo cáo phiếu DNCT.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by	Tấn Thành	on 25/06/2020.
---- Modified by: Vĩnh Tâm	on 14/12/2020: Fix lỗi store không trả về kết quả khi chạy ở SQL2014
---- Modified by: Trọng Kiên on 19/02/2021: Fix lỗi kiểm tra detail thanh toán đi lại đã được kế thừa.
-- <Example>

CREATE PROCEDURE BEMP3002 
( 
	@DivisionID VARCHAR(50),
	@FromDatePeriodControl DATETIME = NULL,
	@ToDatePeriodControl DATETIME = NULL,
	@CheckListPeriodControl VARCHAR(200) = NULL,
	@IsPeriod VARCHAR(1) = NULL,
	@VoucherDate VARCHAR(200) = NULL,
	@DepartmentID VARCHAR(MAX),
	@CountryID NVARCHAR(MAX)
)
AS 
BEGIN

	DECLARE @sSQL VARCHAR (MAX),
			@sSQL0 VARCHAR (MAX),
			@sSQL1 VARCHAR (MAX),
			@sSQL2 VARCHAR (MAX),
			@sSQL3 VARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@TableName VARCHAR(50) = (SELECT 'BEMT3002_' + SUBSTRING(CONVERT(VARCHAR(50), NEWID()),0, 8))
	
	IF (@IsPeriod = '0')
	BEGIN
		--PRINT('NGÀY')
		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDatePeriodControl, 111)
		SET @ToDateText = CONVERT(NVARCHAR(10), @ToDatePeriodControl, 111) + ' 23:59:59'
		SET @sWhere = '(B1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
	END
	ELSE IF @IsPeriod = '1' AND ISNULL(@CheckListPeriodControl, '') != ''
	BEGIN
		--PRINT('KỲ')
		SET @sWhere = 'RIGHT(CONCAT(''0'', B1.TranMonth, ''/'',B1.TranYear), 7) IN ( ''' + @CheckListPeriodControl + ''') '
	END
	ELSE
		SET @sWhere = '1 = 1'

	IF ISNULL(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' AND B1.DivisionID IN (''' + @DivisionID + ''') '

	IF ISNULL(@DepartmentID, '') != ''
		SET @sWhere = @sWhere + ' AND B1.DepartmentID IN (''' + @DepartmentID + ''') '

	IF ISNULL(@CountryID, '') != ''
		SET @sWhere = @sWhere + ' AND B1.CountryID IN (''' + @CountryID + ''') '

	BEGIN
		SET @sSQL0 = '
		Select	Distinct B2.APKInherited,B3.DivisionID
				, STUFF(
				 (SELECT DISTINCT ''; '' + temp1.VoucherDate
				  FROM 
						  (Select	Distinct B2.APKInherited
						, REPLACE(FORMAT(CONVERT(DATE,A7.VoucherDate),''dd-MM-yyyy''),''-'',''/'') AS VoucherDate

						From BEMT2001 B3
						LEFT JOIN BEMT2000 B2 WITH (NOLOCK) ON B3.APKMaster = B2.APK AND B2.DivisionID = B3.DivisionID
						INNER JOIN AT9000 A7 WITH (NOLOCK) ON A7.InheritTransactionID = CONVERT(VARCHAR(50),B3.APK) AND a7.InheritVoucherID= CONVERT(VARCHAR(50),B2.APK) AND A7.InheritTableID = ''BEMT2001'' AND A7.DivisionID = B3.DivisionID)
				   temp1 
				  WHERE temp1.APKInherited = B2.APKInherited-- AND temp1.DivisionID = B3.DivisionID
				  FOR XML PATH (''''))
				  , 1, 1, '''') AS GenVoucherDate
				,STUFF(
				 (SELECT DISTINCT ''; '' + temp2.VoucherNo
				 FROM 
						  (Select	Distinct B2.APKInherited
						, A7.VoucherNo AS VoucherNo

						From BEMT2001 B3
						LEFT JOIN BEMT2000 B2 WITH (NOLOCK) ON B3.APKMaster = B2.APK AND B2.DivisionID = B3.DivisionID
						INNER JOIN AT9000 A7 WITH (NOLOCK) ON A7.InheritTransactionID = CONVERT(VARCHAR(50),B3.APK) AND a7.InheritVoucherID= CONVERT(VARCHAR(50),B2.APK) AND A7.InheritTableID = ''BEMT2001'' AND A7.DivisionID = B3.DivisionID)
				   temp2
				  WHERE temp2.APKInherited = B2.APKInherited-- AND temp1.DivisionID = B3.DivisionID
				  FOR XML PATH (''''))
				  , 1, 1, '''') AS GenVoucherNo
		INTO #ReportBS_00
		From BEMT2001 B3
		LEFT JOIN BEMT2000 B2 WITH (NOLOCK) ON B3.APKMaster = B2.APK AND B2.DivisionID = B3.DivisionID
		INNER JOIN AT9000 A7 WITH (NOLOCK) ON A7.InheritTransactionID = CONVERT(VARCHAR(50),B3.APK) AND a7.InheritVoucherID= CONVERT(VARCHAR(50), B2.APK)
		Where A7.InheritTableID = ''BEMT2001'' AND A7.DivisionID = B3.DivisionID
		--B2.APKInherited=''AA6D989A-F1E7-42FE-8092-A2E9A0826824''
		Group by B2.APKInherited,B3.DivisionID'
		SET @sSQL1 = '
				SELECT 	B1.VoucherNo VoucherNoBS
						, REPLACE(FORMAT(CONVERT(DATE,B1.VoucherDate),''dd-MM-yyyy''),''-'',''/'') AS VoucherDate
						, B1.Purpose
						, B1.TheOthers
						, B1.Applicant ApplicantID
						, A2.FullName AS ApplicantName
						, B1.DepartmentID DepartmentID
						, A3.AnaName DepartmentName
						, B1.DutyID
						, H1.DutyName
						, CASE
							WHEN (A4.CountryName IS NULL OR A4.CountryName = '''') AND (A5.CityName IS NULL OR A5.CityName = '''')
							THEN ''''
							WHEN (A4.CountryName IS NOT NULL OR A4.CountryName <> '''') AND (A5.CityName IS NULL OR A5.CityName = '''')
							THEN A4.CountryName
							WHEN (A4.CountryName IS NULL OR A4.CountryName = '''') AND (A5.CityName IS NOT NULL OR A5.CityName <> '''')
							THEN A5.CityName
							WHEN (A4.CountryName IS NOT NULL OR A4.CountryName <> '''') AND (A5.CityName IS NOT NULL OR A5.CityName <> '''')
							THEN dbo._Trim(CONCAT(A4.CountryName,'','', A5.CityName))
						END AS WorkPlace
						, CONCAT(REPLACE(FORMAT(CONVERT(DATE, B1.StartDate),''dd-MM-yyyy''), ''-'', ''/''),'' - '', REPLACE(FORMAT(CONVERT(DATE, B1.EndDate), ''dd-MM-yyyy''), ''-'', ''/'')) BusinessTripTime
						, B4.VoucherNo VoucherNoTravelPay
						, B5.FeeID
						, B6.FeeName
						, B5.ConvertedAmount AS Amount
						, B5.CurrencyID
						--, A7.VoucherNo AS GenVoucherNo
						--, REPLACE(FORMAT(CONVERT(DATE,A7.VoucherDate),''dd-MM-yyyy''),''-'',''/'') AS GenVoucherDate
						, A9.GenVoucherNo
						, A9.GenVoucherDate
				INTO #ReportBS_TB
				FROM BEMT2010 B1 WITH (NOLOCK)
					-- Get những phiếu DNCT đã duyệt
					LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON O1.APK = B1.APK AND O1.DivisionID = B1.DivisionID
					LEFT JOIN (
						SELECT OO2.APKMaster, OO2.DivisionID, MIN(OO2.[Status]) AS Status
						FROM OOT9001 OO2 WITH (NOLOCK)
						WHERE ISNULL(OO2.DeleteFlag, 0) = 0
						GROUP BY OO2.APKMaster, OO2.DivisionID
						HAVING MIN(OO2.[Status]) > 0
						) AS O2 ON O2.APKMaster = O1.APK AND O2.DivisionID = B1.DivisionID
					LEFT JOIN BEMT2000 B2 WITH (NOLOCK) ON B2.APKInherited = B1.APK AND B2.DivisionID = B1.DivisionID
					LEFT JOIN BEMT2001 B3 WITH (NOLOCK) ON B3.APKMaster = B2.APK AND B3.DivisionID = B1.DivisionID 
					LEFT JOIN BEMT2020 B4 WITH (NOLOCK) ON B4.APKMaster = B1.APK AND ISNULL(B4.DeleteFlg,0) = 0
					LEFT JOIN BEMT2021 B5 WITH (NOLOCK) ON B5.APKMaster = B4.APK AND B5.DivisionID = B1.DivisionID AND B5.IsInherited = 1
					LEFT JOIN BEMT1000 B6 WITH (NOLOCK) ON B6.FeeID = B5.FeeID AND B6.DivisionID IN (B1.DivisionID, ''@@@'') -- B6.DivisionID = B1.DivisionID
					LEFT JOIN AT1004 A1 WITH (NOLOCK) ON A1.CurrencyID = B5.CurrencyID AND A1.DivisionID = B1.DivisionID
					LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = B1.Applicant AND A2.DivisionID = B1.DivisionID
					LEFT JOIN BEMT0000 B7 WITH(NOLOCK) ON B7.DivisionID = B1.DivisionID
					LEFT JOIN AT1011 A3 WITH (NOLOCK) ON A3.AnaID = B1.DepartmentID AND A3.DivisionID = B1.DivisionID AND A3.AnaTypeID = ''A02''
					LEFT JOIN AT1001 A4 WITH (NOLOCK) ON A4.CountryID = B1.CountryID AND A4.DivisionID = B1.DivisionID
					LEFT JOIN AT1002 A5 WITH (NOLOCK) ON A5.CityID = B1.CityID AND A5.DivisionID = B1.DivisionID
					LEFT JOIN HT1102 H1 WITH (NOLOCK) ON H1.DutyID = B1.DutyID AND H1.DivisionID = B1.DivisionID'

		SET @sSQL2 = ' 
					--LEFT JOIN AT9010 A6 WITH (NOLOCK) ON A6.InheritTransactionID = B3.APK AND A6.InheritTableID = ''BEMT2001'' AND A6.DivisionID = B1.DivisionID 
					--LEFT JOIN AT9000 A7 WITH (NOLOCK) ON A7.InheritTransactionID = B3.APK AND a7.InheritVoucherID= B2.APK AND A7.InheritTableID = ''BEMT2001'' AND A7.DivisionID = B1.DivisionID				
					LEFT JOIN #ReportBS_00 A9 ON A9.APKInherited = B1.APK
					
				WHERE ' + @sWhere + ' AND B1.DeleteFlg = 0
				GROUP BY B1.VoucherNo, B1.Applicant, B1.DepartmentID, B1.VoucherDate, B1.StartDate, B1.EndDate, B1.Purpose, B1.TheOthers, B1.DutyID, 
						H1.DutyName, B4.VoucherNo, B5.FeeID, B5.CurrencyID, B6.FeeName, A2.FullName, A3.AnaName, A4.CountryName, A5.CityName
						--A7.VoucherNo, A7.VoucherDate
						, A9.GenVoucherNo
						, A9.GenVoucherDate
						, B5.ConvertedAmount
				ORDER BY B1.VoucherNo

				DECLARE @cols AS NVARCHAR(MAX),
						@createCols AS NVARCHAR(MAX),
						@castCols AS NVARCHAR(MAX),
						@sumColsFunc AS NVARCHAR(MAX),
						@select AS NVARCHAR(MAX),
						@subsSQL AS NVARCHAR(MAX),
						@subsSQL1 AS NVARCHAR(MAX),
						@subsSQL2 AS NVARCHAR(MAX)
				SET @cols = (STUFF((SELECT DISTINCT '','' + QUOTENAME(FeeID) FROM #ReportBS_TB WHERE FeeName IS NOT NULL FOR XML PATH(''''),TYPE).value(''.'', ''NVARCHAR(MAX)'') ,1,1,''''))
				SET @createCols = REVERSE((STUFF(REVERSE((SELECT DISTINCT QUOTENAME(FeeID) + '' DECIMAL(28,8),'' FROM #ReportBS_TB WHERE FeeName IS NOT NULL FOR XML PATH(''''),TYPE).value(''.'', ''NVARCHAR(MAX)'')),1,0,'''')))
				SET @castCols = REVERSE(STUFF(REVERSE((SELECT DISTINCT ''CAST(ISNULL('' + QUOTENAME(FeeID) + '',0) AS DECIMAL(28,8)) + '' FROM #ReportBS_TB WHERE FeeName IS NOT NULL FOR XML PATH(''''),TYPE).value(''.'', ''NVARCHAR(MAX)'')) ,1,2,''''))
				SET @sumColsFunc = REVERSE(STUFF(REVERSE((SELECT DISTINCT ''SUM(CAST(ISNULL('' + QUOTENAME(FeeID) + '',0) AS DECIMAL(28,8))) AS '' + QUOTENAME(FeeID) + '', '' FROM #ReportBS_TB WHERE FeeName IS NOT NULL FOR XML PATH(''''),TYPE).value(''.'', ''NVARCHAR(MAX)'')) ,1,2,''''))

				--PRINT @createCols
				SET @createCols = ISNULL(@createCols, '''')

				DECLARE @sSQL NVARCHAR(MAX) = ''
					CREATE TABLE ' + @TableName + '(
						Row INT,
						VoucherNoBS VARCHAR(50),
						VoucherDate VARCHAR(50),
						Purpose NVARCHAR(MAX),
						TheOthers NVARCHAR(MAX),
						ApplicantID VARCHAR(50),
						ApplicantName NVARCHAR(250),
						DepartmentName NVARCHAR(250),
						DutyName NVARCHAR(250),
						GenVoucherNo VARCHAR(50),
						GenVoucherDate VARCHAR(50),
						WorkPlace NVARCHAR(MAX),
						BusinessTripTime VARCHAR(50),
						VoucherNoTravelPay NVARCHAR(250),
						'' + @createCols + ''
						TotalFee DECIMAL(28,8)
					)''
				EXEC(@sSQL)

				SET @select = ''
							  VoucherNoBS
							, VoucherDate
							, Purpose
							, TheOthers
							, ApplicantID
							, ApplicantName
							, DepartmentName
							, DutyName
							, GenVoucherNo
							, GenVoucherDate
							, WorkPlace
							, BusinessTripTime
							, VoucherNoTravelPay
							, '' + @cols + '', '' + @castCols + '' AS TotalFee''

				SET @subsSQL1 = ''
					SELECT '' + @select + '' INTO #TEMP_TB
					FROM 
					(
						SELECT VoucherNoBS, VoucherDate, Purpose, TheOthers, ApplicantID, ApplicantName, DepartmentName, DutyName, GenVoucherNo, GenVoucherDate, WorkPlace, BusinessTripTime, VoucherNoTravelPay, FeeName,Amount, FeeID
						FROM #ReportBS_TB
					) TB
					PIVOT 
					(
						SUM(Amount)
						FOR FeeID in ('' + @cols + '')
					) P ''

				SET @subsSQL2 = ''

					INSERT INTO ' + @TableName + '
					SELECT ROW_NUMBER() OVER (ORDER BY VoucherNoBS) AS Row 
							, VoucherNoBS
							, VoucherDate
							, Purpose
							, TheOthers
							, ApplicantID
							, ApplicantName
							, DepartmentName
							, DutyName
							, GenVoucherNo
							, GenVoucherDate
							, WorkPlace
							, BusinessTripTime
							, VoucherNoTravelPay
							, '' + @sumColsFunc +''
							, SUM(TotalFee) AS TotalFee
					FROM #TEMP_TB
					GROUP BY VoucherNoBS, VoucherDate, Purpose, TheOthers, ApplicantID, ApplicantName, DepartmentName, DutyName, GenVoucherNo, GenVoucherDate, WorkPlace, BusinessTripTime, VoucherNoTravelPay
				''

				SET @subsSQL = @subsSQL1 + @subsSQL2
				EXEC(@subsSQL)
				SELECT * FROM ' + @TableName + '
				DROP TABLE ' + @TableName + '
				'

		SET @sSQL = @sSQL0+ @sSQL1 + @sSQL2
		PRINT(@sSQL)
		EXEC (@sSQL)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

