IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2109]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2109]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Import tiến độ nhận hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Nhật Thanh on 06/03/2023
---- Modify by: Viết Toàn on 16/11/2023: Cho phép import 1 mặt hàng có nhiều địa chỉ nhận hàng
---- Modify by: Minh Dũng on 20/09/2023: Convert date time from DD/MM/YYYY to YYYY/MM/DD
-- <Example>
/*
    EXEC POP2109,0, 1
*/

 CREATE PROCEDURE POP2109
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
		@InventoryName VARCHAR(100),
		@VoucherNo VARCHAR(50),
		@VoucherDate DateTime,
		@POrderID VARCHAR(50),
		@EmployeeID VARCHAR(100),
		@Address VARCHAR(200),
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
		@Value01 DECIMAL(28,8),
		@Value02 DECIMAL(28,8),
		@Value03 DECIMAL(28,8),
		@Value04 DECIMAL(28,8),
		@Value05 DECIMAL(28,8),
		@Value06 DECIMAL(28,8),
		@Value07 DECIMAL(28,8),
		@Value08 DECIMAL(28,8),
		@Value09 DECIMAL(28,8),
		@Value10 DECIMAL(28,8),
		@Value11 DECIMAL(28,8),
		@Value12 DECIMAL(28,8),
		@Value13 DECIMAL(28,8),
		@Value14 DECIMAL(28,8),
		@Value15 DECIMAL(28,8),
		@Value16 DECIMAL(28,8),
		@Value17 DECIMAL(28,8),
		@Value18 DECIMAL(28,8),
		@Value19 DECIMAL(28,8),
		@Value20 DECIMAL(28,8),
		@Value21 DECIMAL(28,8),
		@Value22 DECIMAL(28,8),
		@Value23 DECIMAL(28,8),
		@Value24 DECIMAL(28,8),
		@Value25 DECIMAL(28,8),
		@Value26 DECIMAL(28,8),
		@Value27 DECIMAL(28,8),
		@Value28 DECIMAL(28,8),
		@Value29 DECIMAL(28,8),
		@Value30 DECIMAL(28,8),
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
		--CONVERT(DATETIME,X.Data.query('VoucherDate').value('.','DateTime'),101) AS VoucherDate,
		X.Data.query('VoucherDate').value('.','VARCHAR(50)') AS VoucherDate,
		X.Data.query('POrderID').value('.','VARCHAR(50)') AS POrderID,
		X.Data.query('ObjectID').value('.','VARCHAR(200)') AS ObjectID,
		X.Data.query('Address').value('.','NVARCHAR(200)') AS Address,
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
		X.Data.query('InventoryName').value('.', 'NVARCHAR(50)') AS InventoryName,
		X.Data.query('UnitID').value('.','VARCHAR(50)') AS UnitID,
		X.Data.query('OrderQuantity').value('.', 'DECIMAL(28,8)') AS OrderQuantity,
		X.Data.query('Date01').value('.', 'VARCHAR(20)') AS Date01,
		X.Data.query('Date02').value('.', 'VARCHAR(20)') AS Date02,
		X.Data.query('Date03').value('.', 'VARCHAR(20)') AS Date03,
		X.Data.query('Date04').value('.', 'VARCHAR(20)') AS Date04,
		X.Data.query('Date05').value('.', 'VARCHAR(20)') AS Date05,
		X.Data.query('Date06').value('.', 'VARCHAR(20)') AS Date06,
		X.Data.query('Date07').value('.', 'VARCHAR(20)') AS Date07,
		X.Data.query('Date08').value('.', 'VARCHAR(20)') AS Date08,
		X.Data.query('Date09').value('.', 'VARCHAR(20)') AS Date09,
		X.Data.query('Date10').value('.', 'VARCHAR(20)') AS Date10,
		X.Data.query('Date11').value('.', 'VARCHAR(20)') AS Date11,
		X.Data.query('Date12').value('.', 'VARCHAR(20)') AS Date12,
		X.Data.query('Date13').value('.', 'VARCHAR(20)') AS Date13,
		X.Data.query('Date14').value('.', 'VARCHAR(20)') AS Date14,
		X.Data.query('Date15').value('.', 'VARCHAR(20)') AS Date15,
		X.Data.query('Date16').value('.', 'VARCHAR(20)') AS Date16,
		X.Data.query('Date17').value('.', 'VARCHAR(20)') AS Date17,
		X.Data.query('Date18').value('.', 'VARCHAR(20)') AS Date18,
		X.Data.query('Date19').value('.', 'VARCHAR(20)') AS Date19,
		X.Data.query('Date20').value('.', 'VARCHAR(20)') AS Date20,
		X.Data.query('Date21').value('.', 'VARCHAR(20)') AS Date21,
		X.Data.query('Date22').value('.', 'VARCHAR(20)') AS Date22,
		X.Data.query('Date23').value('.', 'VARCHAR(20)') AS Date23,
		X.Data.query('Date24').value('.', 'VARCHAR(20)') AS Date24,
		X.Data.query('Date25').value('.', 'VARCHAR(20)') AS Date25,
		X.Data.query('Date26').value('.', 'VARCHAR(20)') AS Date26,
		X.Data.query('Date27').value('.', 'VARCHAR(20)') AS Date27,
		X.Data.query('Date28').value('.', 'VARCHAR(20)') AS Date28,
		X.Data.query('Date29').value('.', 'VARCHAR(20)') AS Date29,
		X.Data.query('Date30').value('.', 'VARCHAR(20)') AS Date30,
		X.Data.query('Value01').value('.', 'VARCHAR(20)') AS Value01,
		X.Data.query('Value02').value('.', 'VARCHAR(20)') AS Value02,
		X.Data.query('Value03').value('.', 'VARCHAR(20)') AS Value03,
		X.Data.query('Value04').value('.', 'VARCHAR(20)') AS Value04,
		X.Data.query('Value05').value('.', 'VARCHAR(20)') AS Value05,
		X.Data.query('Value06').value('.', 'VARCHAR(20)') AS Value06,
		X.Data.query('Value07').value('.', 'VARCHAR(20)') AS Value07,
		X.Data.query('Value08').value('.', 'VARCHAR(20)') AS Value08,
		X.Data.query('Value09').value('.', 'VARCHAR(20)') AS Value09,
		X.Data.query('Value10').value('.', 'VARCHAR(20)') AS Value10,
		X.Data.query('Value11').value('.', 'VARCHAR(20)') AS Value11,
		X.Data.query('Value12').value('.', 'VARCHAR(20)') AS Value12,
		X.Data.query('Value13').value('.', 'VARCHAR(20)') AS Value13,
		X.Data.query('Value14').value('.', 'VARCHAR(20)') AS Value14,
		X.Data.query('Value15').value('.', 'VARCHAR(20)') AS Value15,
		X.Data.query('Value16').value('.', 'VARCHAR(20)') AS Value16,
		X.Data.query('Value17').value('.', 'VARCHAR(20)') AS Value17,
		X.Data.query('Value18').value('.', 'VARCHAR(20)') AS Value18,
		X.Data.query('Value19').value('.', 'VARCHAR(20)') AS Value19,
		X.Data.query('Value20').value('.', 'VARCHAR(20)') AS Value20,
		X.Data.query('Value21').value('.', 'VARCHAR(20)') AS Value21,
		X.Data.query('Value22').value('.', 'VARCHAR(20)') AS Value22,
		X.Data.query('Value23').value('.', 'VARCHAR(20)') AS Value23,
		X.Data.query('Value24').value('.', 'VARCHAR(20)') AS Value24,
		X.Data.query('Value25').value('.', 'VARCHAR(20)') AS Value25,
		X.Data.query('Value26').value('.', 'VARCHAR(20)') AS Value26,
		X.Data.query('Value27').value('.', 'VARCHAR(20)') AS Value27,
		X.Data.query('Value28').value('.', 'VARCHAR(20)') AS Value28,
		X.Data.query('Value29').value('.', 'VARCHAR(20)') AS Value29,
		X.Data.query('Value30').value('.', 'VARCHAR(20)') AS Value30,
		NewID() as APK, @UserID as UserID,
		@TransactionKey AS TransactionKey,
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS ErrorColumn,
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS ErrorMessage
INTO #POP2109_TEMP
FROM @XML.nodes('//Data') AS X (Data)

SELECT 
[Row],DivisionID,TranMonth,TranYear,
VoucherNo,CASE WHEN ISNULL(VoucherDate,'')='' then null else convert(datetime,VoucherDate,103) end as VoucherDate,
POrderID,ObjectID,Address,InventoryID,InventoryName,UnitID,OrderQuantity,
CASE WHEN ISNULL(Date01,'')='' then null else convert(datetime,Date01,103) end as Date01,
CASE WHEN ISNULL(Date02,'')='' then null else convert(datetime,Date02,103) end as Date02,
CASE WHEN ISNULL(Date03,'')='' then null else convert(datetime,Date03,103) end as Date03,
CASE WHEN ISNULL(Date04,'')='' then null else convert(datetime,Date04,103) end as Date04,
CASE WHEN ISNULL(Date05,'')='' then null else convert(datetime,Date05,103) end as Date05,
CASE WHEN ISNULL(Date06,'')='' then null else convert(datetime,Date06,103) end as Date06,
CASE WHEN ISNULL(Date07,'')='' then null else convert(datetime,Date07,103) end as Date07,
CASE WHEN ISNULL(Date08,'')='' then null else convert(datetime,Date08,103) end as Date08,
CASE WHEN ISNULL(Date09,'')='' then null else convert(datetime,Date09,103) end as Date09,
CASE WHEN ISNULL(Date10,'')='' then null else convert(datetime,Date10,103) end as Date10,
CASE WHEN ISNULL(Date11,'')='' then null else convert(datetime,Date11,103) end as Date11,
CASE WHEN ISNULL(Date12,'')='' then null else convert(datetime,Date12,103) end as Date12,
CASE WHEN ISNULL(Date13,'')='' then null else convert(datetime,Date13,103) end as Date13,
CASE WHEN ISNULL(Date14,'')='' then null else convert(datetime,Date14,103) end as Date14,
CASE WHEN ISNULL(Date15,'')='' then null else convert(datetime,Date15,103) end as Date15,
CASE WHEN ISNULL(Date16,'')='' then null else convert(datetime,Date16,103) end as Date16,
CASE WHEN ISNULL(Date17,'')='' then null else convert(datetime,Date17,103) end as Date17,
CASE WHEN ISNULL(Date18,'')='' then null else convert(datetime,Date18,103) end as Date18,
CASE WHEN ISNULL(Date19,'')='' then null else convert(datetime,Date19,103) end as Date19,
CASE WHEN ISNULL(Date20,'')='' then null else convert(datetime,Date20,103) end as Date20,
CASE WHEN ISNULL(Date21,'')='' then null else convert(datetime,Date21,103) end as Date21,
CASE WHEN ISNULL(Date22,'')='' then null else convert(datetime,Date22,103) end as Date22,
CASE WHEN ISNULL(Date23,'')='' then null else convert(datetime,Date23,103) end as Date23,
CASE WHEN ISNULL(Date24,'')='' then null else convert(datetime,Date24,103) end as Date24,
CASE WHEN ISNULL(Date25,'')='' then null else convert(datetime,Date25,103) end as Date25,
CASE WHEN ISNULL(Date26,'')='' then null else convert(datetime,Date26,103) end as Date26,
CASE WHEN ISNULL(Date27,'')='' then null else convert(datetime,Date27,103) end as Date27,
CASE WHEN ISNULL(Date28,'')='' then null else convert(datetime,Date28,103) end as Date28,
CASE WHEN ISNULL(Date29,'')='' then null else convert(datetime,Date29,103) end as Date29,
CASE WHEN ISNULL(Date30,'')='' then null else convert(datetime,Date30,103) end as Date30,
CASE WHEN ISNULL(Value01,'')='' then 0 else Value01 end as Value01,
CASE WHEN ISNULL(Value02,'')='' then 0 else Value02 end as Value02,
CASE WHEN ISNULL(Value03,'')='' then 0 else Value03 end as Value03,
CASE WHEN ISNULL(Value04,'')='' then 0 else Value04 end as Value04,
CASE WHEN ISNULL(Value05,'')='' then 0 else Value05 end as Value05,
CASE WHEN ISNULL(Value06,'')='' then 0 else Value06 end as Value06,
CASE WHEN ISNULL(Value07,'')='' then 0 else Value07 end as Value07,
CASE WHEN ISNULL(Value08,'')='' then 0 else Value08 end as Value08,
CASE WHEN ISNULL(Value09,'')='' then 0 else Value09 end as Value09,
CASE WHEN ISNULL(Value10,'')='' then 0 else Value10 end as Value10,
CASE WHEN ISNULL(Value11,'')='' then 0 else Value11 end as Value11,
CASE WHEN ISNULL(Value12,'')='' then 0 else Value12 end as Value12,
CASE WHEN ISNULL(Value13,'')='' then 0 else Value13 end as Value13,
CASE WHEN ISNULL(Value14,'')='' then 0 else Value14 end as Value14,
CASE WHEN ISNULL(Value15,'')='' then 0 else Value15 end as Value15,
CASE WHEN ISNULL(Value16,'')='' then 0 else Value16 end as Value16,
CASE WHEN ISNULL(Value17,'')='' then 0 else Value17 end as Value17,
CASE WHEN ISNULL(Value18,'')='' then 0 else Value18 end as Value18,
CASE WHEN ISNULL(Value19,'')='' then 0 else Value19 end as Value19,
CASE WHEN ISNULL(Value20,'')='' then 0 else Value20 end as Value20,
CASE WHEN ISNULL(Value21,'')='' then 0 else Value21 end as Value21,
CASE WHEN ISNULL(Value22,'')='' then 0 else Value22 end as Value22,
CASE WHEN ISNULL(Value23,'')='' then 0 else Value23 end as Value23,
CASE WHEN ISNULL(Value24,'')='' then 0 else Value24 end as Value24,
CASE WHEN ISNULL(Value25,'')='' then 0 else Value25 end as Value25,
CASE WHEN ISNULL(Value26,'')='' then 0 else Value26 end as Value26,
CASE WHEN ISNULL(Value27,'')='' then 0 else Value27 end as Value27,
CASE WHEN ISNULL(Value28,'')='' then 0 else Value28 end as Value28,
CASE WHEN ISNULL(Value29,'')='' then 0 else Value29 end as Value29,
CASE WHEN ISNULL(Value30,'')='' then 0 else Value30 end as Value30, 
APK, UserID,@TransactionKey AS TransactionKey, @TransactionID TransactionID, ErrorColumn, ErrorMessage
INTO #POP2109 
FROM #POP2109_TEMP
--Date01,Date02,Date03,Date04,Date05,Date06,Date07,Date08,Date09,Date10,Date11,Date12,Date13,Date14,Date15,
--			Date16,Date17,Date18,Date19,Date20,Date21,Date22,Date23,Date24,Date25,Date26,Date27,Date28,Date29,Date30,
SELECT NEWID() APK, DivisionID, VoucherNo, POrderID, ObjectID
INTO #TEMP_APK
FROM #POP2109
GROUP BY DivisionID, VoucherNo, POrderID, ObjectID

UPDATE P SET P.APK = T.APK
FROM #POP2109 P
LEFT JOIN #TEMP_APK T ON P.DivisionID = T.DivisionID and  P.VoucherNo = T.VoucherNo and  P.POrderID = T.POrderID and  P.ObjectID = T.ObjectID

--SELECT * FROM #POP2109

------------------------------ KIỂM TRA DỮ LIỆU ------------------------------------------------
SET @Cur = CURSOR SCROLL KEYSET FOR 
SELECT [Row],DivisionID,TranMonth,TranYear,VoucherNo,VoucherDate,POrderID,ObjectID,Address,InventoryID,InventoryName,UnitID,OrderQuantity,
Date01,Date02,Date03,Date04,Date05,Date06,Date07,Date08,Date09,Date10,Date11,Date12,Date13,Date14,Date15,
			Date16,Date17,Date18,Date19,Date20,Date21,Date22,Date23,Date24,Date25,Date26,Date27,Date28,Date29,Date30,
Value01,Value02,Value03,Value04,Value05,Value06,Value07,Value08,Value09,Value10,Value11,Value12,Value13,Value14,Value15,
			Value16,Value17,Value18,Value19,Value20,Value21,Value22,Value23,Value24,Value25,Value26,Value27,Value28,Value29,Value30,
APK, UserID,TransactionKey, TransactionID, ErrorColumn, ErrorMessage
FROM #POP2109
WHERE TransactionID = @TransactionID
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row,@DivisionID,@TranMonth,@TranYear,@VoucherNo,@VoucherDate,@POrderID,@ObjectID,@Address,@InventoryID,@InventoryName,@UnitID,@OrderQuantity,
@Date01,@Date02,@Date03,@Date04,@Date05,@Date06,@Date07,@Date08,@Date09,@Date10,@Date11,@Date12,@Date13,@Date14,@Date15,
			@Date16,@Date17,@Date18,@Date19,@Date20,@Date21,@Date22,@Date23,@Date24,@Date25,@Date26,@Date27,@Date28,@Date29,@Date30,
@Value01,@Value02,@Value03,@Value04,@Value05,@Value06,@Value07,@Value08,@Value09,@Value10,@Value11,@Value12,@Value13,@Value14,@Value15,
			@Value16,@Value17,@Value18,@Value19,@Value20,@Value21,@Value22,@Value23,@Value24,@Value25,@Value26,@Value27,@Value28,@Value29,@Value30,
@APK, @UserID, @TransactionKey,@TransactionID, @ErrorColumn, @ErrorMessage

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ErrorColumn = ''
	SET @ErrorMessage = ''
	UPDATE #POP2109 SET ErrorMessage = '',
							ErrorColumn = ''
		WHERE [Row] = @Row
	IF EXISTS (SELECT TOP 1 1 FROM #POP2109 WHERE InventoryID = @InventoryID AND VoucherNo = VoucherNo AND [Address] = @Address AND TransactionKey = @TransactionKey HAVING COUNT(1) > 1)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'
											) + CONVERT(VARCHAR,@Row) + '-CFML000058,'
		SET @ErrorColumn = @ErrorColumn + 'InventoryID,'				
		SET @ErrorFlag = 1
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #POP2109 P INNER JOIN AT1202 A ON P.DivisionID = A.DivisionID and P.ObjectID = A.ObjectID
	  WHERE P.ObjectID = @ObjectID AND TransactionKey = @TransactionKey)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'
											) + CONVERT(VARCHAR,@Row) + '-00ML000142,'
		SET @ErrorColumn = @ErrorColumn + 'ObjectID,'				
		SET @ErrorFlag = 1
	END

	-- Kiểm tra tồn tại đơn hàng mua
	IF NOT EXISTS (SELECT TOP 1 1 FROM #POP2109 P 
	LEFT JOIN OT3001 O31 ON P.POrderID = O31.VoucherNo
	  WHERE P.VoucherNo = @VoucherNo AND TransactionKey = @TransactionKey)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'
											) + CONVERT(VARCHAR,@Row) + '-POFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'InventoryID,'				
		SET @ErrorFlag = 1
	END

	-- Kiểm tra mã hàng tồn tại trong đơn hàng mua kế thừa
	IF NOT EXISTS (SELECT TOP 1 1 FROM #POP2109 P 
	LEFT JOIN OT3001 O31 ON P.POrderID = O31.VoucherNo
	INNER JOIN OT3002 O32 on P.DivisionID = O32.DivisionID and P.POrderID = O31.VoucherNo and P.InventoryID = O32.InventoryID and P.OrderQuantity = O32.OrderQuantity
	  WHERE P.VoucherNo = @VoucherNo AND P.InventoryID = @InventoryID AND TransactionKey = @TransactionKey)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'
											) + CONVERT(VARCHAR,@Row) + '-POFML000013,'
		SET @ErrorColumn = @ErrorColumn + 'POrderID,'				
		SET @ErrorFlag = 1
	END

	-- Kiểm tra số lượng vượt số lượng
	IF @OrderQuantity
	  <(@Value01+@Value02+@Value03+@Value04+@Value05+@Value06+@Value07+@Value08+@Value09+@Value10+@Value11+@Value12+@Value13+@Value14+@Value15+
				@Value16+@Value17+@Value18+@Value19+@Value20+@Value21+@Value22+@Value23+@Value24+@Value25+@Value26+@Value27+@Value28+@Value29+@Value30)		
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'OrderQuantity'
												) + CONVERT(VARCHAR,@Row) + '-POFML000015,'
			SET @ErrorColumn = @ErrorColumn + 'OrderQuantity,'				
			SET @ErrorFlag = 1
		END

		-- Kiểm tra số lượng nhỏ hơn số lượng
	--IF (SELECT TOP 1 CASE
	--			WHEN (O32.OrderQuantity - A3.ActualQuantity) IS NULL
	--				THEN O32.OrderQuantity 
	--			ELSE (O32.OrderQuantity - A3.ActualQuantity) 
	--			END AS RemainedAmount 
	--			FROM #POP2109 P
	--			LEFT JOIN OT3001 O31 ON P.POrderID = O31.VoucherNo
	--			INNER JOIN OT3002 O32 on P.DivisionID = O32.DivisionID and P.POrderID = O31.VoucherNo AND O32.InventoryID = P.InventoryID
	--			LEFT JOIN (
	--			SELECT A3.InventoryID, A3.OTransactionID AS InheritTransactionID, A3.ActualQuantity
	--			FROM AT2007 A3 WITH(NOLOCK) 
	--				LEFT JOIN AT2006 A4 WITH(NOLOCK) ON A4.VoucherID = A3.VoucherID
	--			WHERE A4.KindVoucherID IN (2,4,6)
	--		) AS A3 on O32.InventoryID = A3.InventoryID AND O32.TransactionID = A3.InheritTransactionID
	--  WHERE P.VoucherNo = @VoucherNo AND P.InventoryID = @InventoryID AND TransactionKey = @TransactionKey)
	IF @OrderQuantity
	  >(@Value01+@Value02+@Value03+@Value04+@Value05+@Value06+@Value07+@Value08+@Value09+@Value10+@Value11+@Value12+@Value13+@Value14+@Value15+
				@Value16+@Value17+@Value18+@Value19+@Value20+@Value21+@Value22+@Value23+@Value24+@Value25+@Value26+@Value27+@Value28+@Value29+@Value30)		
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'OrderQuantity'
												) + CONVERT(VARCHAR,@Row) + '-POFML000016,'
			SET @ErrorColumn = @ErrorColumn + 'OrderQuantity,'				
			SET @ErrorFlag = 1
		END
	IF @ErrorColumn <> ''
	BEGIN
		--select LEFT(@ErrorMessage, LEN(@ErrorMessage) -1), LEFT(@ErrorColumn, LEN(@ErrorColumn) -1),@Row
		UPDATE #POP2109 SET ErrorMessage = LEFT(@ErrorMessage, LEN(@ErrorMessage) -1),
							ErrorColumn = LEFT(@ErrorColumn, LEN(@ErrorColumn) -1)
		WHERE [Row] = @Row

	END


	FETCH NEXT FROM @Cur INTO @Row,@DivisionID,@TranMonth,@TranYear,@VoucherNo,@VoucherDate,@POrderID,@ObjectID,@Address,@InventoryID,@InventoryName,@UnitID,@OrderQuantity,
	@Date01,@Date02,@Date03,@Date04,@Date05,@Date06,@Date07,@Date08,@Date09,@Date10,@Date11,@Date12,@Date13,@Date14,@Date15,
				@Date16,@Date17,@Date18,@Date19,@Date20,@Date21,@Date22,@Date23,@Date24,@Date25,@Date26,@Date27,@Date28,@Date29,@Date30,
	@Value01,@Value02,@Value03,@Value04,@Value05,@Value06,@Value07,@Value08,@Value09,@Value10,@Value11,@Value12,@Value13,@Value14,@Value15,
				@Value16,@Value17,@Value18,@Value19,@Value20,@Value21,@Value22,@Value23,@Value24,@Value25,@Value26,@Value27,@Value28,@Value29,@Value30,
	@APK, @UserID, @TransactionKey,@TransactionID, @ErrorColumn, @ErrorMessage
END
------------------------------ /Xử lý dữ liệu ------------------------------------------------
IF @Mode = 1 -- nếu dữ liệu truyền xuống đã hết
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM #POP2109 WHERE TransactionKey = @TransactionKey AND ErrorColumn <> '') --- nếu không có lỗi
	BEGIN
		-- Insert vào OT3003
		INSERT INTO OT3003(APK,DivisionID,POrderID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,VoucherNo,VoucherDate,ObjectID)
		SELECT P.APK, P.DivisionID,O.POrderID,@UserID,GETDATE(),UserID,GETDATE(),P.VoucherNo,VoucherDate,P.ObjectID
		FROM #POP2109 P
		LEFT JOIN OT3001 O on P.POrderID = O.VoucherNo
		GROUP BY P.APK,P.DivisionID,O.POrderID, P.VoucherNo,VoucherDate,P.ObjectID, P.UserID
		
		DECLARE @i int = 1
		WHILE @i<=30
		BEGIN
			-- Insert vào OT3003_MT
			DECLARE @sSQL nvarchar(max)
			SET @sSQL = '
			INSERT INTO OT3003_MT(APK,DivisionID,POrderID,Date,Address,Quantity,InheritVoucherID,InheritTransactionID,DeleteFlg,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
			SELECT NEWID(),P.DivisionID, O.POrderID, MAX(Date' + format(@i,'00') + '), P.Address,  ''Quantity' + format(@i,'00') + ''', '''', P.APK, 0, P.UserID, GETDATE(), P.UserID, GETDATE()
			FROM #POP2109 P
			LEFT JOIN OT3001 O on P.POrderID = O.VoucherNo
			GROUP BY P.DivisionID,O.POrderID, P.Address,P.APK,P.UserID
			HAVING MAX(Date' + format(@i,'00') + ') is not null
			'
			--print @sSQL
			exec(@sSQL)

			-- Update OT3002
			DECLARE @sSQL1 nvarchar(max)
			SET @sSQL1 = '
				UPDATE O32 SET O32.Quantity01 = P.Value01,
							 O32.Quantity02 = P.Value02,
							 O32.Quantity03 = P.Value03,
							 O32.Quantity04 = P.Value04,
							 O32.Quantity05 = P.Value05,
							 O32.Quantity06 = P.Value06,
							 O32.Quantity07 = P.Value07,
							 O32.Quantity08 = P.Value08,
							 O32.Quantity09 = P.Value09,
							 O32.Quantity10 = P.Value10,
							 O32.Quantity11 = P.Value11,
							 O32.Quantity12 = P.Value12,
							 O32.Quantity13 = P.Value13,
							 O32.Quantity14 = P.Value14,
							 O32.Quantity15 = P.Value15,
							 O32.Quantity16 = P.Value16,
							 O32.Quantity17 = P.Value17,
							 O32.Quantity18 = P.Value18,
							 O32.Quantity19 = P.Value19,
							 O32.Quantity20 = P.Value20,
							 O32.Quantity21 = P.Value21,
							 O32.Quantity22 = P.Value22,
							 O32.Quantity23 = P.Value23,
							 O32.Quantity24 = P.Value24,
							 O32.Quantity25 = P.Value25,
							 O32.Quantity26 = P.Value26,
							 O32.Quantity27 = P.Value27,
							 O32.Quantity28 = P.Value28,
							 O32.Quantity29 = P.Value29,
							 O32.Quantity30 = P.Value30
				FROM OT3002 O32
				LEFT JOIN OT3001 O31 ON O32.POrderID = O31.POrderID
				INNER JOIN #POP2109 P on P.DivisionID = O32.DivisionID and P.POrderID = O31.VoucherNo and P.InventoryID = O32.InventoryID and P.OrderQuantity = O32.OrderQuantity
			'
			print @sSQL1
			exec(@sSQL1)
			Set @i = @i + 1
		END
	END
END

EndMessage:;
SELECT [Row], ErrorColumn, ErrorMessage FROM #POP2109 
WHERE TransactionKey = @TransactionKey AND TransactionID = @TransactionID AND ErrorColumn <> ''
ORDER BY [Row]

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
