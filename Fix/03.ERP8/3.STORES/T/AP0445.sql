IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0445]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0445]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Xuất excel báo cáo số lượng bán hàng theo nhóm hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Trọng Phúc on: 22/12/2023
-- <Example>
/*
	EXEC AP0445 'PC',''
*/

CREATE PROCEDURE AP0445
(
	@DivisionID nvarchar(50),
	@Period1 DATETIME,
	@Period2 DATETIME,
	@Period3 DATETIME,
	@isDate INT, --0. Năm  1.Tháng  2. Kỳ
	@EmployeeIDFrom VARCHAR(100),
	@EmployeeIDTo VARCHAR(100),
	@InventoryFrom VARCHAR(100),
	@InventoryTo VARCHAR(100)
)
AS
BEGIN
	DECLARE @sSQL nvarchar(max) = '',
			@sSQL1 nvarchar(50) ='',
			@sSQL2 nvarchar(50) ='',
			@sSQL3 nvarchar(50) =''

	SELECT AnaID, AnaName
		INTO #model
		FROM AT1011 WHERE AnaTypeID = 'A04' AND AnaID BETWEEN @InventoryFrom AND @InventoryTo
	SELECT * FROM #model --nhóm hàng

---------------BEGIN Tháng năm chu kỳ
	IF(@isDate = 0)  --Năm
	BEGIN	
		IF(@Period1 = @Period2 AND @Period1 = @Period3 AND @Period2 = @Period3)
		BEGIN
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'') as AnaID, ISNULL(m.AnaName,'') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear), '') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = 'T04' AND A00T04.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = 'T24' AND A00T04.TranYear = YEAR(@Period1)
					WHERE A9.Ana07ID BETWEEN @EmployeeIDFrom AND @EmployeeIDTo
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
		END
		ELSE IF(@Period1 = @Period2)
		BEGIN
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'') as AnaID, ISNULL(m.AnaName,'') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear), '') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A93 ON m.AnaID = A93.Ana04ID AND A93.TranYear = YEAR(@Period3)
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = 'T04' AND A00T04.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = 'T24' AND A00T04.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A00T043 ON A00T043.TransactionTypeID = 'T04' AND A00T043.TranYear = YEAR(@Period3)
					LEFT JOIN AT9000 A00T243 ON A00T243.TransactionTypeID = 'T24' AND A00T043.TranYear = YEAR(@Period3)
					WHERE A9.Ana07ID BETWEEN @EmployeeIDFrom AND @EmployeeIDTo
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
		END
		ELSE IF(@Period2 = @Period3)
		BEGIN
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'') as AnaID, ISNULL(m.AnaName,'') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear), '') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A93 ON m.AnaID = A93.Ana04ID AND A93.TranYear = YEAR(@Period3)
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = 'T04' AND A00T04.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = 'T24' AND A00T04.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A00T043 ON A00T043.TransactionTypeID = 'T04' AND A00T043.TranYear = YEAR(@Period3)
					LEFT JOIN AT9000 A00T243 ON A00T243.TransactionTypeID = 'T24' AND A00T043.TranYear = YEAR(@Period3)
					WHERE A9.Ana07ID BETWEEN @EmployeeIDFrom AND @EmployeeIDTo
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
		END
		ELSE IF(@Period1 = @Period3)
		BEGIN
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T042.ConvertedQuantity, 0) - ISNULL(A00T242.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'') as AnaID, ISNULL(m.AnaName,'') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear), '') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A92.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A92 ON m.AnaID = A92.Ana04ID AND A92.TranYear = YEAR(@Period2)
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = 'T04' AND A00T04.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = 'T24' AND A00T04.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A00T042 ON A00T042.TransactionTypeID = 'T04' AND A00T042.TranYear = YEAR(@Period2)
					LEFT JOIN AT9000 A00T242 ON A00T242.TransactionTypeID = 'T24' AND A00T042.TranYear = YEAR(@Period2)
					WHERE A9.Ana07ID BETWEEN @EmployeeIDFrom AND @EmployeeIDTo
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
		END
		ELSE
		BEGIN
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T042.ConvertedQuantity, 0) - ISNULL(A00T242.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'') as AnaID, ISNULL(m.AnaName,'') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear), '') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A92.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A92 ON m.AnaID = A92.Ana04ID AND A92.TranYear = YEAR(@Period2)
					LEFT JOIN AT9000 A93 ON m.AnaID = A93.Ana04ID AND A93.TranYear = YEAR(@Period3)
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = 'T04' AND A00T04.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = 'T24' AND A00T04.TranYear = YEAR(@Period1)
					LEFT JOIN AT9000 A00T042 ON A00T042.TransactionTypeID = 'T04' AND A00T042.TranYear = YEAR(@Period2)
					LEFT JOIN AT9000 A00T242 ON A00T242.TransactionTypeID = 'T24' AND A00T042.TranYear = YEAR(@Period2)
					LEFT JOIN AT9000 A00T043 ON A00T043.TransactionTypeID = 'T04' AND A00T043.TranYear = YEAR(@Period3)
					LEFT JOIN AT9000 A00T243 ON A00T243.TransactionTypeID = 'T24' AND A00T043.TranYear = YEAR(@Period3)
					WHERE A9.Ana07ID BETWEEN @EmployeeIDFrom AND @EmployeeIDTo
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
		END
	END
	ELSE IF(@isDate = 1)  --Tháng
	BEGIN
		IF(@Period1 = @Period2 AND @Period1 = @Period3 AND @Period2 = @Period3)
		BEGIN
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'') as AnaID, ISNULL(m.AnaName,'') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear), '') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = 'T04' AND A00T04.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = 'T24' AND A00T04.TranMonth = MONTH(@Period1)
					WHERE A9.Ana07ID BETWEEN @EmployeeIDFrom AND @EmployeeIDTo
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
		END
		ELSE IF(@Period1 = @Period2)
		BEGIN
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'') as AnaID, ISNULL(m.AnaName,'') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear), '') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A93 ON m.AnaID = A93.Ana04ID AND A93.TranMonth = MONTH(@Period3)
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = 'T04' AND A00T04.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = 'T24' AND A00T04.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A00T043 ON A00T043.TransactionTypeID = 'T04' AND A00T043.TranMonth = MONTH(@Period3)
					LEFT JOIN AT9000 A00T243 ON A00T243.TransactionTypeID = 'T24' AND A00T043.TranMonth = MONTH(@Period3)
					WHERE A9.Ana07ID BETWEEN @EmployeeIDFrom AND @EmployeeIDTo
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
		END
		ELSE IF(@Period2 = @Period3)
		BEGIN
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'') as AnaID, ISNULL(m.AnaName,'') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear), '') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A93 ON m.AnaID = A93.Ana04ID AND A93.TranMonth = MONTH(@Period3)
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = 'T04' AND A00T04.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = 'T24' AND A00T04.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A00T043 ON A00T043.TransactionTypeID = 'T04' AND A00T043.TranMonth = MONTH(@Period3)
					LEFT JOIN AT9000 A00T243 ON A00T243.TransactionTypeID = 'T24' AND A00T043.TranMonth = MONTH(@Period3)
					WHERE A9.Ana07ID BETWEEN @EmployeeIDFrom AND @EmployeeIDTo
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
		END
		ELSE IF(@Period1 = @Period3)
		BEGIN
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T042.ConvertedQuantity, 0) - ISNULL(A00T242.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'') as AnaID, ISNULL(m.AnaName,'') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear), '') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A92.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A92 ON m.AnaID = A92.Ana04ID AND A92.TranMonth = MONTH(@Period2)
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = 'T04' AND A00T04.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = 'T24' AND A00T04.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A00T042 ON A00T042.TransactionTypeID = 'T04' AND A00T042.TranMonth = MONTH(@Period2)
					LEFT JOIN AT9000 A00T242 ON A00T242.TransactionTypeID = 'T24' AND A00T042.TranMonth = MONTH(@Period2)
					WHERE A9.Ana07ID BETWEEN @EmployeeIDFrom AND @EmployeeIDTo
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
		END
		ELSE
		BEGIN
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T042.ConvertedQuantity, 0) - ISNULL(A00T242.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'') as AnaID, ISNULL(m.AnaName,'') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear), '') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A92.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A92 ON m.AnaID = A92.Ana04ID AND A92.TranMonth = MONTH(@Period2)
					LEFT JOIN AT9000 A93 ON m.AnaID = A93.Ana04ID AND A93.TranMonth = MONTH(@Period3)
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = 'T04' AND A00T04.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = 'T24' AND A00T04.TranMonth = MONTH(@Period1)
					LEFT JOIN AT9000 A00T042 ON A00T042.TransactionTypeID = 'T04' AND A00T042.TranMonth = MONTH(@Period2)
					LEFT JOIN AT9000 A00T242 ON A00T242.TransactionTypeID = 'T24' AND A00T042.TranMonth = MONTH(@Period2)
					LEFT JOIN AT9000 A00T043 ON A00T043.TransactionTypeID = 'T04' AND A00T043.TranMonth = MONTH(@Period3)
					LEFT JOIN AT9000 A00T243 ON A00T243.TransactionTypeID = 'T24' AND A00T043.TranMonth = MONTH(@Period3)
					WHERE A9.Ana07ID BETWEEN @EmployeeIDFrom AND @EmployeeIDTo
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +'/'+CONVERT(varchar(50),A9.TranYear)
		END
	END
	ELSE  --Kỳ
	BEGIN
		IF(MONTH(@Period1) = 1)		
			SET @sSQL1 = '(1,2,3)'
		IF(MONTH(@Period1) = 2)
			SET @sSQL1 = '(4,5,6)'
		IF(MONTH(@Period1) = 3)
			SET @sSQL1 = '(7,8,9)'
		IF(MONTH(@Period1) = 4)
			SET @sSQL1 = '(10,11,12)'

		IF(MONTH(@Period2) = 1)
			SET @sSQL2 = '(1,2,3)'
		IF(MONTH(@Period2) = 2)
			SET @sSQL2 = '(4,5,6)'
		IF(MONTH(@Period2) = 3)
			SET @sSQL2 = '(7,8,9)'
		IF(MONTH(@Period2) = 4)
			SET @sSQL2 = '(10,11,12)'

		IF(MONTH(@Period3) = 1)
			SET @sSQL3 = '(1,2,3)'
		IF(MONTH(@Period3) = 2)
			SET @sSQL3 = '(4,5,6)'
		IF(MONTH(@Period3) = 3)
			SET @sSQL3 = '(7,8,9)'
		IF(MONTH(@Period3) = 4)
			SET @sSQL3 = '(10,11,12)'

		IF(@Period1 = @Period2 AND @Period1 = @Period3 AND @Period2 = @Period3)
		BEGIN
			SET @sSQL = ' 
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS					ConvertedQuantity1,
						SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity2,
						SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity3,
						ISNULL(m.AnaID,'''') as AnaID, ISNULL(m.AnaName,'''') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear), '''') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount3
					FROM #model m
						LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
						LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = ''T04'' AND A00T04.TranMonth IN '+@sSQL1+'
						LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = ''T24'' AND A00T04.TranMonth IN '+@sSQL1+'
						LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TransactionTypeID = ''T01'' AND A91.TranMonth IN '+@sSQL1+'
						WHERE A9.Ana07ID BETWEEN '''+@EmployeeIDFrom+''' AND '''+@EmployeeIDTo+'''
						GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear)
						ORDER BY CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear)'
			PRINT(@sSQL)
			EXEC(@sSQL)
		END
		ELSE IF(@Period1 = @Period2)
		BEGIN
			SET @sSQL = ' 
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'''') as AnaID, ISNULL(m.AnaName,'''') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear), '''') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A93 ON m.AnaID = A93.Ana04ID AND A93.TranMonth IN '+@sSQL3+'
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = ''T04'' AND A00T04.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = ''T24'' AND A00T04.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A00T043 ON A00T043.TransactionTypeID = ''T04'' AND A00T043.TranMonth IN '+@sSQL3+'
					LEFT JOIN AT9000 A00T243 ON A00T243.TransactionTypeID = ''T24'' AND A00T043.TranMonth IN '+@sSQL3+'
					WHERE A9.Ana07ID BETWEEN '''+@EmployeeIDFrom+''' AND '''+@EmployeeIDTo+'''
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear)'
			EXEC(@sSQL)
		END
		ELSE IF(@Period2 = @Period3)
		BEGIN
			SET @sSQL = ' 
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'''') as AnaID, ISNULL(m.AnaName,'''') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear), '''') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A93 ON m.AnaID = A93.Ana04ID AND A93.TranMonth IN '+@sSQL3+'
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = ''T04'' AND A00T04.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = ''T24'' AND A00T04.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A00T043 ON A00T043.TransactionTypeID = ''T04'' AND A00T043.TranMonth IN '+@sSQL3+'
					LEFT JOIN AT9000 A00T243 ON A00T243.TransactionTypeID = ''T24'' AND A00T043.TranMonth IN '+@sSQL3+'
					WHERE A9.Ana07ID BETWEEN '''+@EmployeeIDFrom+''' AND '''+@EmployeeIDTo+'''
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear)'
			EXEC(@sSQL)
		END
		ELSE IF(@Period1 = @Period3)
		BEGIN
			SET @sSQL = ' 
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T042.ConvertedQuantity, 0) - ISNULL(A00T242.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'''') as AnaID, ISNULL(m.AnaName,'''') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear), '''') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A92.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A92 ON m.AnaID = A92.Ana04ID AND A92.TranMonth IN '+@sSQL2+'
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = ''T04'' AND A00T04.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = ''T24'' AND A00T04.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A00T042 ON A00T042.TransactionTypeID = ''T04'' AND A00T042.TranMonth IN '+@sSQL2+'
					LEFT JOIN AT9000 A00T242 ON A00T242.TransactionTypeID = ''T24'' AND A00T042.TranMonth IN '+@sSQL2+'
					WHERE A9.Ana07ID BETWEEN '''+@EmployeeIDFrom+''' AND '''+@EmployeeIDTo+'''
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear)'
			EXEC(@sSQL)
		END
		ELSE
		BEGIN
			SET @sSQL = ' 
			SELECT  SUM(ISNULL(A00T04.ConvertedQuantity, 0) - ISNULL(A00T24.ConvertedQuantity, 0)) AS ConvertedQuantity1,
					SUM(ISNULL(A00T042.ConvertedQuantity, 0) - ISNULL(A00T242.ConvertedQuantity, 0)) AS ConvertedQuantity2,
					SUM(ISNULL(A00T043.ConvertedQuantity, 0) - ISNULL(A00T243.ConvertedQuantity, 0)) AS ConvertedQuantity3,
					ISNULL(m.AnaID,'''') as AnaID, ISNULL(m.AnaName,'''') as AnaName, ISNULL(CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear), '''') AS MonthYear, SUM(ISNULL(A91.ConvertedAmount, 0)) as ConvertedAmount1, SUM(ISNULL(A92.ConvertedAmount, 0)) as ConvertedAmount2, SUM(ISNULL(A93.ConvertedAmount, 0)) as ConvertedAmount3
				FROM #model m
					LEFT JOIN AT9000 A9 ON m.AnaID = A9.Ana04ID
					LEFT JOIN AT9000 A91 ON m.AnaID = A91.Ana04ID AND A91.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A92 ON m.AnaID = A92.Ana04ID AND A92.TranMonth IN '+@sSQL2+'
					LEFT JOIN AT9000 A93 ON m.AnaID = A93.Ana04ID AND A93.TranMonth IN '+@sSQL3+'
					LEFT JOIN AT9000 A00T04 ON A00T04.TransactionTypeID = ''T04'' AND A00T04.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A00T24 ON A00T24.TransactionTypeID = ''T24'' AND A00T04.TranMonth IN '+@sSQL1+'
					LEFT JOIN AT9000 A00T042 ON A00T042.TransactionTypeID = ''T04'' AND A00T042.TranMonth IN '+@sSQL2+'
					LEFT JOIN AT9000 A00T242 ON A00T242.TransactionTypeID = ''T24'' AND A00T042.TranMonth IN '+@sSQL2+'
					LEFT JOIN AT9000 A00T043 ON A00T043.TransactionTypeID = ''T04'' AND A00T043.TranMonth IN '+@sSQL3+'
					LEFT JOIN AT9000 A00T243 ON A00T243.TransactionTypeID = ''T24'' AND A00T043.TranMonth IN '+@sSQL3+'
					WHERE A9.Ana07ID BETWEEN '''+@EmployeeIDFrom+''' AND '''+@EmployeeIDTo+'''
					GROUP BY m.AnaID, m.AnaName, CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear)
					ORDER BY CONVERT(varchar(50),A9.TranMonth) +''/''+CONVERT(varchar(50),A9.TranYear)'
			EXEC(@sSQL)
		END
	END
---------------END Tháng năm chu kỳ
	DROP TABLE #model
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
