IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2109]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2109]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Import tiến độ giao hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Viết Toàn 	on 06/03/2023
---- Modified by: Văn Tài 	on 12/06/2023: [2023/06/IS/0020] Lỗi store IMPORT.
---- Modified by: Hoàng Lâm on 21/09/2023: [2023/09/IS/0090] Cho phép Import được Tiến độ giao hàng khi nơi giao có 2 địa chỉ nhận
---- Modified by: Viết Toàn on 16/11/2023: [2023/11/TA/0178] Bổ sung cho phép import tiến độ giao hàng khi cùng một mặt hàng có 2 địa chỉ giao
-- <Example>
/*
    EXEC SOP2109,0, 1
*/

 CREATE PROCEDURE SOP2109
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,   
     @Mode TINYINT, --0 chưa hết dữ liệu, 1: hết dữ liệu
     @ImportTransTypeID NVARCHAR(250),
     @TransactionKey NVARCHAR(50),
     @XML XML
)
AS

DECLARE @Cur CURSOR,
		@Row INT,
		@TransactionID UNIQUEIDENTIFIER,
		@APK UNIQUEIDENTIFIER,
		@ObjectID VARCHAR(50),
		@InventoryID VARCHAR(50),
		@VoucherNo VARCHAR(50),
		@VoucherDate DateTime,
		@ShipStartDate DateTime,
		@SOrderID VARCHAR(50),
		@Address NVARCHAR(200),
		@UnitID VARCHAR(50),
		@OrderQuantity DECIMAL(28,8),
		@Date01 DATETIME,
		@Date02 DATETIME,
		@Date03 DATETIME,
		@Date04 DATETIME,
		@Date05 DATETIME,
		@Date06 DATETIME,
		@Date07 DATETIME,
		@Date08 DATETIME,
		@Date09 DATETIME,
		@Date10 DATETIME,
		@Date11 DATETIME,
		@Date12 DATETIME,
		@Date13 DATETIME,
		@Date14 DATETIME,
		@Date15 DATETIME,
		@Date16 DATETIME,
		@Date17 DATETIME,
		@Date18 DATETIME,
		@Date19 DATETIME,
		@Date20 DATETIME,
		@Date21 DATETIME,
		@Date22 DATETIME,
		@Date23 DATETIME,
		@Date24 DATETIME,
		@Date25 DATETIME,
		@Date26 DATETIME,
		@Date27 DATETIME,
		@Date28 DATETIME,
		@Date29 DATETIME,
		@Date30 DATETIME,
		@Quantity01 DECIMAL(28,8),
		@Quantity02 DECIMAL(28,8),
		@Quantity03 DECIMAL(28,8),
		@Quantity04 DECIMAL(28,8),
		@Quantity05 DECIMAL(28,8),
		@Quantity06 DECIMAL(28,8),
		@Quantity07 DECIMAL(28,8),
		@Quantity08 DECIMAL(28,8),
		@Quantity09 DECIMAL(28,8),
		@Quantity10 DECIMAL(28,8),
		@Quantity11 DECIMAL(28,8),
		@Quantity12 DECIMAL(28,8),
		@Quantity13 DECIMAL(28,8),
		@Quantity14 DECIMAL(28,8),
		@Quantity15 DECIMAL(28,8),
		@Quantity16 DECIMAL(28,8),
		@Quantity17 DECIMAL(28,8),
		@Quantity18 DECIMAL(28,8),
		@Quantity19 DECIMAL(28,8),
		@Quantity20 DECIMAL(28,8),
		@Quantity21 DECIMAL(28,8),
		@Quantity22 DECIMAL(28,8),
		@Quantity23 DECIMAL(28,8),
		@Quantity24 DECIMAL(28,8),
		@Quantity25 DECIMAL(28,8),
		@Quantity26 DECIMAL(28,8),
		@Quantity27 DECIMAL(28,8),
		@Quantity28 DECIMAL(28,8),
		@Quantity29 DECIMAL(28,8),
		@Quantity30 DECIMAL(28,8),
		@ErrorFlag TINYINT = 0,
		@ErrorColumn NVARCHAR(MAX)='',
		@ErrorMessage NVARCHAR(MAX)='',
		@Level INT,
		@EndMonth INT=0,
		@Date DATETIME

SET @TransactionID = NEWID()
SET @EndMonth=(SELECT Day(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,DATEFROMPARTS(@TranYear, @TranMonth, 1))+1,0))))


BEGIN

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------
											
SELECT	X.Data.query('OrderNo').value('.','INT') AS [Row],
		X.Data.query('DivisionID').value('.','NVARCHAR(50)') AS DivisionID,
		CONVERT(INT,LEFT(X.Data.query('Period').value('.','VARCHAR(10)'),2)) AS TranMonth,
		CONVERT(INT,RIGHT(X.Data.query('Period').value('.','VARCHAR(10)'),4)) AS TranYear,
		X.Data.query('VoucherNo').value('.','NVARCHAR(50)') AS VoucherNo,
		CONVERT(DATETIME,X.Data.query('VoucherDate').value('.','nvarchar(20)'),103) AS VoucherDate,
		CONVERT(DATETIME,X.Data.query('ShipStartDate').value('.','nvarchar(20)'),103) AS ShipStartDate,
		--CASE WHEN ISNULL(X.Data.query('ShipStartDate').value('.','varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('ShipStartDate').value('.','varchar(20)'),101) END AS ShipStartDate,
		X.Data.query('SOrderID').value('.','VARCHAR(50)') AS SOrderID,
		X.Data.query('ObjectID').value('.','VARCHAR(50)') AS ObjectID,
		X.Data.query('Address').value('.','NVARCHAR(250)') AS Address,
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
		X.Data.query('UnitID').value('.','VARCHAR(50)') AS UnitID,
		X.Data.query('OrderQuantity').value('.', 'DECIMAL(28,8)') AS OrderQuantity,
		CASE WHEN ISNULL(X.Data.query('Date01').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date01').value('.', 'varchar(20)'), 103) END AS Date01,
		CASE WHEN ISNULL(X.Data.query('Date02').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date02').value('.', 'varchar(20)'), 103) END AS Date02,
		CASE WHEN ISNULL(X.Data.query('Date03').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date03').value('.', 'varchar(20)'), 103) END AS Date03,
		CASE WHEN ISNULL(X.Data.query('Date04').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date04').value('.', 'varchar(20)'), 103) END AS Date04,
		CASE WHEN ISNULL(X.Data.query('Date05').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date05').value('.', 'varchar(20)'), 103) END AS Date05,
		CASE WHEN ISNULL(X.Data.query('Date06').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date06').value('.', 'varchar(20)'), 103) END AS Date06,
		CASE WHEN ISNULL(X.Data.query('Date07').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date07').value('.', 'varchar(20)'), 103) END AS Date07,
		CASE WHEN ISNULL(X.Data.query('Date08').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date08').value('.', 'varchar(20)'), 103) END AS Date08,
		CASE WHEN ISNULL(X.Data.query('Date09').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date09').value('.', 'varchar(20)'), 103) END AS Date09,
		CASE WHEN ISNULL(X.Data.query('Date10').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date10').value('.', 'varchar(20)'), 103) END AS Date10,
		CASE WHEN ISNULL(X.Data.query('Date11').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date11').value('.', 'varchar(20)'), 103) END AS Date11,
		CASE WHEN ISNULL(X.Data.query('Date12').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date12').value('.', 'varchar(20)'), 103) END AS Date12,
		CASE WHEN ISNULL(X.Data.query('Date13').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date13').value('.', 'varchar(20)'), 103) END AS Date13,
		CASE WHEN ISNULL(X.Data.query('Date14').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date14').value('.', 'varchar(20)'), 103) END AS Date14,
		CASE WHEN ISNULL(X.Data.query('Date15').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date15').value('.', 'varchar(20)'), 103) END AS Date15,
		CASE WHEN ISNULL(X.Data.query('Date16').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date16').value('.', 'varchar(20)'), 103) END AS Date16,
		CASE WHEN ISNULL(X.Data.query('Date17').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date17').value('.', 'varchar(20)'), 103) END AS Date17,
		CASE WHEN ISNULL(X.Data.query('Date18').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date18').value('.', 'varchar(20)'), 103) END AS Date18,
		CASE WHEN ISNULL(X.Data.query('Date19').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date19').value('.', 'varchar(20)'), 103) END AS Date19,
		CASE WHEN ISNULL(X.Data.query('Date20').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date20').value('.', 'varchar(20)'), 103) END AS Date20,
		CASE WHEN ISNULL(X.Data.query('Date21').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date21').value('.', 'varchar(20)'), 103) END AS Date21,
		CASE WHEN ISNULL(X.Data.query('Date22').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date22').value('.', 'varchar(20)'), 103) END AS Date22,
		CASE WHEN ISNULL(X.Data.query('Date23').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date23').value('.', 'varchar(20)'), 103) END AS Date23,
		CASE WHEN ISNULL(X.Data.query('Date24').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date24').value('.', 'varchar(20)'), 103) END AS Date24,
		CASE WHEN ISNULL(X.Data.query('Date25').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date25').value('.', 'varchar(20)'), 103) END AS Date25,
		CASE WHEN ISNULL(X.Data.query('Date26').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date26').value('.', 'varchar(20)'), 103) END AS Date26,
		CASE WHEN ISNULL(X.Data.query('Date27').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date27').value('.', 'varchar(20)'), 103) END AS Date27,
		CASE WHEN ISNULL(X.Data.query('Date28').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date28').value('.', 'varchar(20)'), 103) END AS Date28,
		CASE WHEN ISNULL(X.Data.query('Date29').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date29').value('.', 'varchar(20)'), 103) END AS Date29,
		CASE WHEN ISNULL(X.Data.query('Date30').value('.', 'varchar(20)'), '') = '' THEN NULL ELSE CONVERT(DATETIME,X.Data.query('Date30').value('.', 'varchar(20)'), 103) END AS Date30,
		CASE WHEN ISNULL(X.Data.query('Quantity01').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity01').value('.', 'varchar(20)') AS DECIMAL(28,8)) END AS Quantity01,
		CASE WHEN ISNULL(X.Data.query('Quantity02').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity02').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity02,
		CASE WHEN ISNULL(X.Data.query('Quantity03').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity03').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity03,
		CASE WHEN ISNULL(X.Data.query('Quantity04').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity04').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity04,
		CASE WHEN ISNULL(X.Data.query('Quantity05').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity05').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity05,
		CASE WHEN ISNULL(X.Data.query('Quantity06').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity06').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity06,
		CASE WHEN ISNULL(X.Data.query('Quantity07').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity07').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity07,
		CASE WHEN ISNULL(X.Data.query('Quantity08').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity08').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity08,
		CASE WHEN ISNULL(X.Data.query('Quantity09').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity09').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity09,
		CASE WHEN ISNULL(X.Data.query('Quantity10').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity10').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity10,
		CASE WHEN ISNULL(X.Data.query('Quantity11').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity11').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity11,
		CASE WHEN ISNULL(X.Data.query('Quantity12').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity12').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity12,
		CASE WHEN ISNULL(X.Data.query('Quantity13').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity13').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity13,
		CASE WHEN ISNULL(X.Data.query('Quantity14').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity14').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity14,
		CASE WHEN ISNULL(X.Data.query('Quantity15').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity15').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity15,
		CASE WHEN ISNULL(X.Data.query('Quantity16').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity16').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity16,
		CASE WHEN ISNULL(X.Data.query('Quantity17').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity17').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity17,
		CASE WHEN ISNULL(X.Data.query('Quantity18').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity18').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity18,
		CASE WHEN ISNULL(X.Data.query('Quantity19').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity19').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity19,
		CASE WHEN ISNULL(X.Data.query('Quantity20').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity20').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity20,
		CASE WHEN ISNULL(X.Data.query('Quantity21').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity21').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity21,
		CASE WHEN ISNULL(X.Data.query('Quantity22').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity22').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity22,
		CASE WHEN ISNULL(X.Data.query('Quantity23').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity23').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity23,
		CASE WHEN ISNULL(X.Data.query('Quantity24').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity24').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity24,
		CASE WHEN ISNULL(X.Data.query('Quantity25').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity25').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity25,
		CASE WHEN ISNULL(X.Data.query('Quantity26').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity26').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity26,
		CASE WHEN ISNULL(X.Data.query('Quantity27').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity27').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity27,
		CASE WHEN ISNULL(X.Data.query('Quantity28').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity28').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity28,
		CASE WHEN ISNULL(X.Data.query('Quantity29').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity29').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity29,
		CASE WHEN ISNULL(X.Data.query('Quantity30').value('.', 'varchar(20)'), '') = 0 THEN 0 ELSE CAST(X.Data.query('Quantity30').value('.', 'varchar(20)') AS DECIMAl(28,8)) END AS Quantity30,
		NewID() as APK, @UserID as UserID,
		@TransactionKey AS TransactionKey,
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS ErrorColumn,
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS ErrorMessage
INTO #SOP2109_TEMP
FROM @XML.nodes('//Data') AS X (Data)

SELECT 
[Row],DivisionID,TranMonth,TranYear,VoucherNo,VoucherDate,ShipStartDate,SOrderID,ObjectID,Address,InventoryID,UnitID,OrderQuantity,
Date01,Date02,Date03,Date04,Date05,Date06,Date07,Date08,Date09,Date10,Date11,Date12,Date13,Date14,Date15,
Date16,Date17,Date18,Date19,Date20,Date21,Date22,Date23,Date24,Date25,Date26,Date27,Date28,Date29,Date30,
Quantity01,Quantity02,Quantity03,Quantity04,Quantity05,Quantity06,Quantity07,Quantity08,Quantity09,Quantity10,Quantity11,Quantity12,Quantity13,Quantity14,Quantity15,
Quantity16,Quantity17,Quantity18,Quantity19,Quantity20,Quantity21,Quantity22,Quantity23,Quantity24,Quantity25,Quantity26,Quantity27,Quantity28,Quantity29,Quantity30,
APK, UserID,@TransactionKey AS TransactionKey, @TransactionID TransactionID, ErrorColumn, ErrorMessage
INTO #SOP2109 
FROM #SOP2109_TEMP
----Date01,Date02,Date03,Date04,Date05,Date06,Date07,Date08,Date09,Date10,Date11,Date12,Date13,Date14,Date15,
----			Date16,Date17,Date18,Date19,Date20,Date21,Date22,Date23,Date24,Date25,Date26,Date27,Date28,Date29,Date30,
SELECT NEWID() APK, DivisionID, VoucherNo, SOrderID, ObjectID
INTO #TEMP_APK
FROM #SOP2109
GROUP BY DivisionID, VoucherNo, SOrderID, ObjectID

--UPDATE S SET S.APK = T.APK
--FROM #SOP2109 S
--LEFT JOIN #TEMP_APK T ON S.DivisionID = T.DivisionID and  S.VoucherNo = T.VoucherNo and  S.SOrderID = T.SOrderID and  S.ObjectID = T.ObjectID

-------------------------------- KIỂM TRA DỮ LIỆU ------------------------------------------------
SET @Cur = CURSOR SCROLL KEYSET FOR 
SELECT [Row],DivisionID,TranMonth,TranYear,VoucherNo,VoucherDate,ShipStartDate,SOrderID,ObjectID,Address,InventoryID,UnitID,OrderQuantity,
Date01,Date02,Date03,Date04,Date05,Date06,Date07,Date08,Date09,Date10,Date11,Date12,Date13,Date14,Date15,
			Date16,Date17,Date18,Date19,Date20,Date21,Date22,Date23,Date24,Date25,Date26,Date27,Date28,Date29,Date30,
Quantity01,Quantity02,Quantity03,Quantity04,Quantity05,Quantity06,Quantity07,Quantity08,Quantity09,Quantity10,Quantity11,Quantity12,Quantity13,Quantity14,Quantity15,
			Quantity16,Quantity17,Quantity18,Quantity19,Quantity20,Quantity21,Quantity22,Quantity23,Quantity24,Quantity25,Quantity26,Quantity27,Quantity28,Quantity29,Quantity30,
APK, UserID,TransactionKey, TransactionID, ErrorColumn, ErrorMessage
FROM #SOP2109
WHERE TransactionID = @TransactionID
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row,@DivisionID,@TranMonth,@TranYear,@VoucherNo,@VoucherDate,@ShipStartDate,@SOrderID,@ObjectID,@Address,@InventoryID,@UnitID,@OrderQuantity,
@Date01,@Date02,@Date03,@Date04,@Date05,@Date06,@Date07,@Date08,@Date09,@Date10,@Date11,@Date12,@Date13,@Date14,@Date15,
			@Date16,@Date17,@Date18,@Date19,@Date20,@Date21,@Date22,@Date23,@Date24,@Date25,@Date26,@Date27,@Date28,@Date29,@Date30,
@Quantity01,@Quantity02,@Quantity03,@Quantity04,@Quantity05,@Quantity06,@Quantity07,@Quantity08,@Quantity09,@Quantity10,@Quantity11,@Quantity12,@Quantity13,@Quantity14,@Quantity15,
			@Quantity16,@Quantity17,@Quantity18,@Quantity19,@Quantity20,@Quantity21,@Quantity22,@Quantity23,@Quantity24,@Quantity25,@Quantity26,@Quantity27,@Quantity28,@Quantity29,@Quantity30,
@APK, @UserID, @TransactionKey,@TransactionID, @ErrorColumn, @ErrorMessage

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ErrorColumn = ''
	SET @ErrorMessage = ''
	UPDATE #SOP2109 SET ErrorMessage = '',
							ErrorColumn = ''
		WHERE [Row] = @Row


	-- Đơn hàng bán đã tồn tại ở tiến độ giao hàng khác.
	IF EXISTS (SELECT TOP 1 1 FROM #SOP2109 S 
	INNER JOIN OT2001 O21 ON O21.DivisionID = s.DivisionID
							AND S.SOrderID = O21.VoucherNo							
	INNER JOIN OT2003_MT O23 ON O23.DivisionID = s.DivisionID
								AND O23.SOrderID = CONVERT(VARCHAR(50),O21.APK))
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SOrderID'
											) + CONVERT(VARCHAR,@Row) + '-SOFML000053,'
		SET @ErrorColumn = @ErrorColumn + 'SOrderID,'				
		SET @ErrorFlag = 1
	END
	

	----- Kiểm tra trùng mã mặt hàng ---
	IF EXISTS (SELECT TOP 1 1 FROM #SOP2109 WHERE InventoryID = @InventoryID AND VoucherNo = @VoucherNo AND [Address] = @Address AND TransactionKey = @TransactionKey HAVING COUNT(InventoryID) > 1)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'
											) + CONVERT(VARCHAR,@Row) + '-CFML000058,'
		SET @ErrorColumn = @ErrorColumn + 'InventoryID,'				
		SET @ErrorFlag = 1
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2109 S INNER JOIN AT1202 A ON A.DivisionID IN (S.DivisionID, '@@@') and S.ObjectID = A.ObjectID
	  WHERE S.ObjectID = @ObjectID AND TransactionKey = @TransactionKey)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ObjectID'
											) + CONVERT(VARCHAR,@Row) + '-00ML000142,'
		SET @ErrorColumn = @ErrorColumn + 'ObjectID,'				
		SET @ErrorFlag = 1
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2109 S 
	LEFT JOIN OT2001 O21 ON S.SOrderID = O21.VoucherNo
	  WHERE S.VoucherNo = @VoucherNo AND TransactionKey = @TransactionKey)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'VoucherNo'
											) + CONVERT(VARCHAR,@Row) + '-SOFML000038,'
		SET @ErrorColumn = @ErrorColumn + 'VoucherNo,'				
		SET @ErrorFlag = 1
	END

	-- Kiểm tra mã hàng tồn tại trong đơn hàng bán kế thừa
	IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2109 S 
	LEFT JOIN OT2001 O21 ON S.SOrderID = O21.VoucherNo
	INNER JOIN OT2002 O22 on S.DivisionID = O22.DivisionID 
								AND S.SOrderID = O21.VoucherNo 
								AND S.InventoryID = O22.InventoryID 
								--and S.OrderQuantity = O22.OrderQuantity
	  WHERE S.VoucherNo = @VoucherNo AND S.InventoryID = @InventoryID AND TransactionKey = @TransactionKey)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SOrderID'
											) + CONVERT(VARCHAR,@Row) + '-SOFML000037,'
		SET @ErrorColumn = @ErrorColumn + 'SOrderID,'				
		SET @ErrorFlag = 1
	END

	---- Kiểm tra số lượng vượt số lượng
	IF @OrderQuantity
	  <(@Quantity01+@Quantity02+@Quantity03+@Quantity04+@Quantity05+@Quantity06+@Quantity07+@Quantity08+@Quantity09+@Quantity10+@Quantity11+@Quantity12+@Quantity13+@Quantity14+@Quantity15+
				@Quantity16+@Quantity17+@Quantity18+@Quantity19+@Quantity20+@Quantity21+@Quantity22+@Quantity23+@Quantity24+@Quantity25+@Quantity26+@Quantity27+@Quantity28+@Quantity29+@Quantity30)		
	AND (SELECT COUNT(*) FROM #SOP2109 WHERE InventoryID = @InventoryID AND [Address] != @Address) = 0
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'OrderQuantity'
												) + CONVERT(VARCHAR,@Row) + '-SOFML000039,'
			SET @ErrorColumn = @ErrorColumn + 'OrderQuantity,'				
			SET @ErrorFlag = 1
		END

		-- Kiểm tra số lượng nhỏ hơn số lượng
	IF @OrderQuantity
	  >(@Quantity01+@Quantity02+@Quantity03+@Quantity04+@Quantity05+@Quantity06+@Quantity07+@Quantity08+@Quantity09+@Quantity10+@Quantity11+@Quantity12+@Quantity13+@Quantity14+@Quantity15+
				@Quantity16+@Quantity17+@Quantity18+@Quantity19+@Quantity20+@Quantity21+@Quantity22+@Quantity23+@Quantity24+@Quantity25+@Quantity26+@Quantity27+@Quantity28+@Quantity29+@Quantity30)
	AND (SELECT COUNT(*) FROM #SOP2109 WHERE InventoryID = @InventoryID AND [Address] != @Address) = 0
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'OrderQuantity'
											) + CONVERT(VARCHAR,@Row) + '-SOFML000040,'
		SET @ErrorColumn = @ErrorColumn + 'OrderQuantity,'				
		SET @ErrorFlag = 1

		print(@Quantity01+@Quantity02+@Quantity03+@Quantity04+@Quantity05+@Quantity06+@Quantity07+@Quantity08+@Quantity09+@Quantity10+@Quantity11+@Quantity12+@Quantity13+@Quantity14+@Quantity15+
			@Quantity16+@Quantity17+@Quantity18+@Quantity19+@Quantity20+@Quantity21+@Quantity22+@Quantity23+@Quantity24+@Quantity25+@Quantity26+@Quantity27+@Quantity28+@Quantity29+@Quantity30)
	END


	IF @ErrorColumn <> ''
	BEGIN
		--select LEFT(@ErrorMessage, LEN(@ErrorMessage) -1), LEFT(@ErrorColumn, LEN(@ErrorColumn) -1),@Row
		UPDATE #SOP2109 SET ErrorMessage = LEFT(@ErrorMessage, LEN(@ErrorMessage) -1),
							ErrorColumn = LEFT(@ErrorColumn, LEN(@ErrorColumn) -1)
		WHERE [Row] = @Row

	END


	FETCH NEXT FROM @Cur INTO @Row,@DivisionID,@TranMonth,@TranYear,@VoucherNo,@VoucherDate,@ShipStartDate,@SOrderID,@ObjectID,@Address,@InventoryID,@UnitID,@OrderQuantity,
	@Date01,@Date02,@Date03,@Date04,@Date05,@Date06,@Date07,@Date08,@Date09,@Date10,@Date11,@Date12,@Date13,@Date14,@Date15,
				@Date16,@Date17,@Date18,@Date19,@Date20,@Date21,@Date22,@Date23,@Date24,@Date25,@Date26,@Date27,@Date28,@Date29,@Date30,
	@Quantity01,@Quantity02,@Quantity03,@Quantity04,@Quantity05,@Quantity06,@Quantity07,@Quantity08,@Quantity09,@Quantity10,@Quantity11,@Quantity12,@Quantity13,@Quantity14,@Quantity15,
				@Quantity16,@Quantity17,@Quantity18,@Quantity19,@Quantity20,@Quantity21,@Quantity22,@Quantity23,@Quantity24,@Quantity25,@Quantity26,@Quantity27,@Quantity28,@Quantity29,@Quantity30,
	@APK, @UserID, @TransactionKey,@TransactionID, @ErrorColumn, @ErrorMessage

	--print('abc')
END

-------------------------------- /Xử lý dữ liệu ------------------------------------------------
IF @Mode = 1 -- nếu dữ liệu truyền xuống đã hết
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2109 WHERE TransactionKey = @TransactionKey AND ErrorColumn <> '') --- nếu không có lỗi
	BEGIN	
		-- Insert vào OT2003
		INSERT INTO OT2003(APK,DivisionID,SOrderID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,VoucherNo,VoucherDate,ShipStartDate,ObjectID)
		SELECT MIN(S.APK), S.DivisionID,O.SOrderID,@UserID,GETDATE(),UserID,GETDATE(),S.VoucherNo,VoucherDate,S.ShipStartDate,S.ObjectID
		FROM #SOP2109 S
		LEFT JOIN OT2001 O on S.SOrderID = O.VoucherNo
		GROUP BY S.DivisionID, O.SOrderID, S.VoucherNo,VoucherDate,S.ShipStartDate,S.ObjectID, S.UserID
		
		DECLARE @i int = 1
		WHILE @i<=30
		BEGIN
			-- Insert vào OT2003_MT
			DECLARE @sSQL nvarchar(max)
			SET @sSQL = '
			INSERT INTO OT2003_MT(APK,DivisionID,SOrderID,Date,Address,Quantity,InheritVoucherID,InheritTransactionID,DeleteFlg,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
			SELECT NEWID(),S.DivisionID, O.SOrderID, MAX(Date' + format(@i,'00') + '), S.Address,  ''Quantity' + format(@i,'00') + ''', '''', S.APK, 0, S.UserID, GETDATE(), S.UserID, GETDATE()
			FROM #SOP2109 S
			LEFT JOIN OT2001 O on S.SOrderID = O.VoucherNo
			GROUP BY S.DivisionID,O.SOrderID,S.Address,S.APK,S.UserID
			HAVING MAX(Date' + format(@i,'00') + ') is not null
			'
			--print @sSQL
			exec(@sSQL)

			-- Update OT2002
			DECLARE @sSQL1 nvarchar(max)
			SET @sSQL1 = '
				UPDATE O22 SET O22.Quantity'+format(@i,'00')+' = S.Quantity'+format(@i,'00')+'
							 --O22.Quantity02 = S.Quantity02,
							 --O22.Quantity03 = S.Quantity03,
							 --O22.Quantity04 = S.Quantity04,
							 --O22.Quantity05 = S.Quantity05,
							 --O22.Quantity06 = S.Quantity06,
							 --O22.Quantity07 = S.Quantity07,
							 --O22.Quantity08 = S.Quantity08,
							 --O22.Quantity09 = S.Quantity09,
							 --O22.Quantity10 = S.Quantity10,
							 --O22.Quantity11 = S.Quantity11,
							 --O22.Quantity12 = S.Quantity12,
							 --O22.Quantity13 = S.Quantity13,
							 --O22.Quantity14 = S.Quantity14,
							 --O22.Quantity15 = S.Quantity15,
							 --O22.Quantity16 = S.Quantity16,
							 --O22.Quantity17 = S.Quantity17,
							 --O22.Quantity18 = S.Quantity18,
							 --O22.Quantity19 = S.Quantity19,
							 --O22.Quantity20 = S.Quantity20,
							 --O22.Quantity21 = S.Quantity21,
							 --O22.Quantity22 = S.Quantity22,
							 --O22.Quantity23 = S.Quantity23,
							 --O22.Quantity24 = S.Quantity24,
							 --O22.Quantity25 = S.Quantity25,
							 --O22.Quantity26 = S.Quantity26,
							 --O22.Quantity27 = S.Quantity27,
							 --O22.Quantity28 = S.Quantity28,
							 --O22.Quantity29 = S.Quantity29,
							 --O22.Quantity30 = S.Quantity30
				FROM OT2002 O22
				LEFT JOIN OT2001 O21 ON O22.SOrderID = O21.SOrderID
				INNER JOIN #SOP2109 S on S.DivisionID = O22.DivisionID and S.SOrderID = O21.VoucherNo and S.InventoryID = O22.InventoryID and S.OrderQuantity = O22.OrderQuantity
				WHERE ISNULL(S.Quantity'+format(@i,'00')+', 0) != 0
			'
			
			print @sSQL1
			exec(@sSQL1)
			Set @i = @i + 1
		END
	END
END

EndMessage:;
SELECT [Row], ErrorColumn, ErrorMessage FROM #SOP2109 
WHERE TransactionKey = @TransactionKey AND TransactionID = @TransactionID AND ErrorColumn <> ''
ORDER BY [Row]

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO