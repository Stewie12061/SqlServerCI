IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22704]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22704]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xử lý tồn kho khi kết chuyển - kế thừa từ store AP9998
-- <Param>
----
-- <Return>
----
-- <History>
---- Created by: Hoài Bảo on 20/07/2022
---- Modified by: Hoài Bảo on 02/12/2022 - Bổ sung insert người cập nhật, ngày cập nhật, lịch sử
---- Modified by: Hoài Bảo on 20/02/2023 - WareHouseID truyền vào theo danh sách
---- Modified by ... on ...

-- <Example>

CREATE PROCEDURE [dbo].[WMP22704]
(
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@WareHouseID NVARCHAR(50),
	@TranMonth INT, 
	@TranYear INT,
	@NextMonth INT, 
	@NextYear INT
)
AS

DECLARE
	@PeriodMonthBegin INT,
	@PeriodYearBegin INT


---- Move View AV2222 qua để lọc dữ liệu
SELECT (CASE WHEN DE.DivisionID IS NULL THEN CE.DivisionID ELSE DE.DivisionID END) AS DivisionID,
	 (CASE WHEN DE.TranMonth IS NULL THEN CE.TranMonth ELSE DE.TranMonth END) AS TranMonth,
	 (CASE WHEN DE.TranYear IS NULL THEN CE.TranYear ELSE DE.TranYear END) AS TranYear,
	 (CASE WHEN DE.WareHouseID IS NULL THEN CE.WareHouseID ELSE DE.WareHouseID END) AS WareHouseID,
	 (CASE WHEN DE.InventoryID IS NULL THEN CE.InventoryID ELSE DE.InventoryID END) AS InventoryID,
	 (CASE WHEN DE.InventoryAccountID IS NULL THEN CE.InventoryAccountID ELSE DE.InventoryAccountID END) AS InventoryAccountID,
	 BeginQuantity, 
	 BeginAmount, 
	 DebitQuantity, 
	 DebitAmount,
	 InDebitQuantity,
	 InDebitAmount,	
	 CE.Quantity AS CreditQuantity,
	 CE.Amount AS CreditAmount,
	 CE.InQuantity AS InCreditQuantity,
	 CE.InAmount AS InCreditAmount	
	
INTO #Temp FROM
--Nhap + So du
(SELECT  (CASE WHEN BE.DivisionID IS NULL THEN DE.DivisionID ELSE BE.DivisionID END) AS DivisionID,
	(CASE WHEN BE.TranMonth IS NULL THEN DE.TranMonth ELSE BE.TranMonth END) AS TranMonth,
	(CASE WHEN BE.TranYear IS NULL THEN DE.TranYear ELSE BE.TranYear END) AS TranYear,
	(CASE WHEN BE.WareHouseID IS NULL THEN DE.WareHouseID ELSE BE.WareHouseID END) AS WareHouseID,
	(CASE WHEN BE.InventoryID IS NULL THEN DE.InventoryID ELSE BE.InventoryID END) AS InventoryID,
	(CASE WHEN BE.InventoryAccountID IS NULL THEN DE.InventoryAccountID ELSE BE.InventoryAccountID END) AS InventoryAccountID,
	BE.Quantity AS BeginQuantity, 
	BE.Amount AS BeginAmount, 
	DE.Quantity AS DebitQuantity, 
	DE.Amount AS DebitAmount,
	DE.InQuantity AS InDebitQuantity,
	DE.InAmount AS InDebitAmount
FROM
--So du dau
(SELECT T16.DivisionID,T16.TranMonth,T16.TranYear,T16.WareHouseID,T17.InventoryID,T17.DebitAccountID AS InventoryAccountID,
	  ISNULL(SUM(ISNULL(T17.ActualQuantity,0)),0) AS Quantity, 
	  ISNULL(SUM(ISNULL(T17.ConvertedAmount,0)),0) AS Amount 
FROM AT2016 T16 INNER JOIN AT2017 T17 ON T16.VoucherID = T17.VoucherID AND T16.DivisionID = T17.DivisionID
WHERE T16.TranMonth IN (@TranMonth,@NextMonth) AND T16.TranYear IN (@TranYear, @NextYear) 
AND (T16.WareHouseID IN (SELECT Value FROM dbo.StringSplit(@WareHouseID, ',')) OR T16.WareHouseID IS NULL)
GROUP BY T16.DivisionID,T16.TranMonth,T16.TranYear,WareHouseID,InventoryID,DebitAccountID) AS BE

FULL JOIN
--Nhap kho
(SELECT T16.DivisionID,T16.TranMonth,T16.TranYear,T16.WareHouseID,T17.InventoryID,T17.DebitAccountID AS InventoryAccountID,
	  ISNULL(SUM(ISNULL(T17.ActualQuantity,0)),0) AS Quantity, 
	  ISNULL(SUM(ISNULL(T17.ConvertedAmount,0)),0) AS Amount,
	  ISNULL(SUM(CASE WHEN T16.KindVoucherID = 3 THEN ISNULL(T17.ActualQuantity,0) ELSE 0 END),0) AS InQuantity, 
	  ISNULL(SUM(CASE WHEN T16.KindVoucherID = 3 THEN ISNULL(T17.ConvertedAmount,0) ELSE 0 END),0) AS InAmount  
FROM AT2006 T16 INNER JOIN AT2007 T17 ON T16.VoucherID = T17.VoucherID AND T16.DivisionID = T17.DivisionID
WHERE KindVoucherID IN (1,3,5,7,9,15,17) AND ISNULL(T16.TableID,'') <> 'AT0114' AND  T16.TranMonth IN (@TranMonth,@NextMonth) AND T16.TranYear IN (@TranYear, @NextYear) 
	  AND (T16.WareHouseID IN (SELECT Value FROM dbo.StringSplit(@WareHouseID, ',')) OR T16.WareHouseID IS NULL)
GROUP BY T16.DivisionID,T16.TranMonth,T16.TranYear,WareHouseID,InventoryID,DebitAccountID) AS DE

ON 
BE.DivisionID = DE.DivisionID
AND BE.TranMonth = DE.TranMonth
AND BE.TranYear = DE.TranYear
AND BE.WareHouseID = DE.WareHouseID
AND BE.InventoryID = DE.InventoryID
AND BE.InventoryAccountID = DE.InventoryAccountID
) AS DE

FULL JOIN
--Xuat kho
(SELECT T16.DivisionID,T16.TranMonth,T16.TranYear,(CASE WHEN KindVoucherID = 3 THEN T16.WareHouseID2 ELSE T16.WareHouseID END) AS WareHouseID,T17.InventoryID,T17.CreditAccountID AS InventoryAccountID,
	  ISNULL(SUM(ISNULL(T17.ActualQuantity,0)),0) AS Quantity,
	  ISNULL(SUM(ISNULL(T17.ConvertedAmount,0)),0) AS Amount,
	  ISNULL(SUM(CASE WHEN T16.KindVoucherID = 3 THEN ISNULL(T17.ActualQuantity,0) ELSE 0 END),0) AS InQuantity,
	  ISNULL(SUM(CASE WHEN T16.KindVoucherID = 3 THEN ISNULL(T17.ConvertedAmount,0) ELSE 0 END),0) AS InAmount
FROM AT2006 T16 INNER JOIN AT2007 T17 ON T16.VoucherID = T17.VoucherID AND T16.DivisionID = T17.DivisionID
WHERE KindVoucherID IN (2,3,4,6,8,10,14,20) AND  T16.TranMonth IN (@TranMonth,@NextMonth) AND T16.TranYear IN (@TranYear, @NextYear)
	  AND ((CASE WHEN KindVoucherID = 3 THEN T16.WareHouseID2 ELSE T16.WareHouseID END) IN (SELECT Value FROM dbo.StringSplit(@WareHouseID, ',')) 
	  OR (CASE WHEN KindVoucherID = 3 THEN T16.WareHouseID2 ELSE T16.WareHouseID END) IS NULL)
GROUP BY T16.DivisionID,T16.TranMonth,T16.TranYear,(CASE WHEN KindVoucherID = 3 THEN T16.WareHouseID2 ELSE T16.WareHouseID END),InventoryID,CreditAccountID) AS CE
ON
DE.DivisionID = CE.DivisionID
AND DE.TranMonth = CE.TranMonth
AND DE.TranYear = CE.TranYear
AND DE.WareHouseID = CE.WareHouseID
AND DE.InventoryID = CE.InventoryID
AND DE.InventoryAccountID = CE.InventoryAccountID
--- END View AV2222

SELECT TOP 1  @PeriodMonthBegin = TranMonth, @PeriodYearBegin = TranYear FROM WT9999 WITH (NOLOCK) WHERE DivisionID = @DivisionID
ORDER BY TranYear, TranMonth ASC
		
--Insert du lieu co phat sinh nhung khong ghi nhan vao bang AT2008
INSERT INTO AT2008 (DivisionID, TranMonth, TranYear, WareHouseID, InventoryID, InventoryAccountID, 
			BeginQuantity, BeginAmount, 
			DebitQuantity, DebitAmount,
			InDebitQuantity, InDebitAmount,
			CreditQuantity, CreditAmount,
			InCreditQuantity, InCreditAmount,
			EndQuantity, EndAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
			 )
SELECT V.DivisionID, V.TranMonth, V.TranYear, V.WareHouseID, V.InventoryID, V.InventoryAccountID,
	ISNULL(V.BeginQuantity,0), ISNULL(V.BeginAmount,0), 
	ISNULL(V.DebitQuantity,0), ISNULL(V.DebitAmount,0),
	ISNULL(V.InDebitQuantity,0), ISNULL(V.InDebitAmount,0),
	ISNULL(V.CreditQuantity,0), ISNULL(V.CreditAmount,0),
	ISNULL(V.InCreditQuantity,0), ISNULL(V.InCreditAmount,0),
	ISNULL(V.BeginQuantity,0) + ISNULL(V.DebitQuantity,0) - ISNULL(V.CreditQuantity,0),
	ISNULL(V.BeginAmount,0) + ISNULL(V.DebitAmount,0) - ISNULL(V.CreditAmount,0),
	@UserID, GETDATE(), @UserID, GETDATE()
FROM AT2008 A RIGHT JOIN  #Temp V
ON 	A.DivisionID = V.DivisionID AND
	A.WareHouseID = V.WareHouseID AND
	A.InventoryID = V.InventoryID AND
	A.InventoryAccountID = V.InventoryAccountID AND
	A.TranMonth = V.TranMonth AND
	A.TranYear = V.TranYear
WHERE A.DivisionID IS NULL AND
	A.WareHouseID IS NULL AND
	A.InventoryID IS NULL AND
	A.InventoryAccountID IS NULL AND
	V.InventoryAccountID IS NOT NULL AND
	A.TranMonth IS NULL AND
	A.TranYear IS NULL AND
	V.DivisionID = @DivisionID AND
	V.TranMonth = @TranMonth AND
	V.TranYear = @TranYear

--Xoa Du lieu rac
DELETE AT2008
FROM AT2008 A LEFT JOIN #Temp V
ON 	A.DivisionID = V.DivisionID AND
	A.WareHouseID = V.WareHouseID AND
	A.InventoryID = V.InventoryID AND
	A.InventoryAccountID = V.InventoryAccountID 
WHERE 	V.DivisionID IS NULL AND
	V.WareHouseID IS NULL AND
	V.InventoryID IS NULL AND
	V.InventoryAccountID IS NULL AND
	V.TranMonth + V.TranYear*12 <= @TranMonth + @TranYear*12 AND
	A.TranMonth + A.TranYear*12 <= @TranMonth + @TranYear*12

--Cap Nhat Ton Kho khai báo đầu kỳ
IF (@PeriodMonthBegin = @TranMonth AND @PeriodYearBegin = @TranYear)
BEGIN
	UPDATE A
	SET 
		A.BeginQuantity = ISNULL(V.BeginQuantity,0),
		A.BeginAmount = ISNULL(V.BeginAmount,0),
		A.LastModifyUserID = @UserID,
		A.LastModifyDate = GETDATE()
	FROM AT2008 A WITH (NOLOCK) LEFT JOIN #Temp V
	ON 	A.DivisionID = V.DivisionID AND
		A.WareHouseID = V.WareHouseID AND
		A.InventoryID = V.InventoryID AND
		A.InventoryAccountID = V.InventoryAccountID AND
		A.TranMonth = V.TranMonth AND
		A.TranYear = V.TranYear
	WHERE
		A.DivisionID = @DivisionID AND
		A.TranMonth = @TranMonth AND
		A.TranYear = @TranYear AND
	A.WareHouseID IN (SELECT Value FROM dbo.StringSplit(@WareHouseID, ','))
END

--Cap Nhat Ton Kho Tong Hop cho kỳ hiện tại
UPDATE A 
SET
	A.DebitQuantity = ISNULL(V.DebitQuantity,0),
	A.DebitAmount = ISNULL(V.DebitAmount,0),
	A.InDebitQuantity = ISNULL(V.InDebitQuantity,0),
	A.InDebitAmount = ISNULL(V.InDebitAmount,0),
	A.CreditQuantity = ISNULL(V.CreditQuantity,0),
	A.CreditAmount = ISNULL(V.CreditAmount,0),
	A.InCreditQuantity = ISNULL(V.InCreditQuantity,0),
	A.InCreditAmount = ISNULL(V.InCreditAmount,0),
	A.EndQuantity = ISNULL(A.BeginQuantity,0) + ISNULL(V.DebitQuantity,0) - ISNULL(V.CreditQuantity,0),
	A.EndAmount = ISNULL(A.BeginAmount,0) + ISNULL(V.DebitAmount,0) - ISNULL(V.CreditAmount,0),
	A.LastModifyUserID = @UserID,
	A.LastModifyDate = GETDATE()
FROM AT2008 A WITH (NOLOCK) LEFT JOIN #Temp V
ON 	A.DivisionID = V.DivisionID AND
	A.WareHouseID = V.WareHouseID AND
	A.InventoryID = V.InventoryID AND
	A.InventoryAccountID = V.InventoryAccountID AND
	A.TranMonth = V.TranMonth AND
	A.TranYear = V.TranYear
WHERE 
	A.DivisionID = @DivisionID AND
	A.TranMonth = @TranMonth AND
	A.TranYear = @TranYear AND
	A.WareHouseID IN (SELECT Value FROM dbo.StringSplit(@WareHouseID, ','))

------------------------------------------------------------------------------------
--Bổ sung cập nhật số liệu nhập xuất của kỳ kế tiếp đến thời điểm hiện tại nếu kỳ kế tiếp đã từng mở sổ
IF EXISTS (SELECT TOP 1 1 FROM AT2008 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TranMonth = @NextMonth AND TranYear = @NextYear)
BEGIN 
	UPDATE A SET
		A.DebitQuantity = ISNULL(V.DebitQuantity,0),
		A.DebitAmount = ISNULL(V.DebitAmount,0),
		A.InDebitQuantity = ISNULL(V.InDebitQuantity,0),
		A.InDebitAmount = ISNULL(V.InDebitAmount,0),
		A.CreditQuantity = ISNULL(V.CreditQuantity,0),
		A.CreditAmount = ISNULL(V.CreditAmount,0),
		A.InCreditQuantity = ISNULL(V.InCreditQuantity,0),
		A.InCreditAmount = ISNULL(V.InCreditAmount,0),
		A.EndQuantity = ISNULL(A.BeginQuantity,0) + ISNULL(V.DebitQuantity,0) - ISNULL(V.CreditQuantity,0),
		A.EndAmount = ISNULL(A.BeginAmount,0) + ISNULL(V.DebitAmount,0) - ISNULL(V.CreditAmount,0),
		A.LastModifyUserID = @UserID,
		A.LastModifyDate = GETDATE()
	FROM AT2008 A WITH (NOLOCK) LEFT JOIN #Temp V
	ON 	A.DivisionID = V.DivisionID AND
		A.WareHouseID = V.WareHouseID AND
		A.InventoryID = V.InventoryID AND
		A.InventoryAccountID = V.InventoryAccountID AND
		A.TranMonth = V.TranMonth AND
		A.TranYear = V.TranYear
	WHERE
		A.DivisionID = @DivisionID AND
		A.TranMonth = @NextMonth AND
		A.TranYear = @NextYear AND
		A.WareHouseID IN (SELECT Value FROM dbo.StringSplit(@WareHouseID, ','))

	UPDATE  AT2008 
	SET  BeginQuantity = T08.EndQuantity,
		BeginAmount = T08.EndAmount,
		EndQuantity =T08.EndQuantity + AT2008.DebitQuantity - AT2008.CreditQuantity,
		EndAmount = T08.EndAmount + AT2008.DebitAmount - AT2008.CreditAmount,
		LastModifyUserID = @UserID, LastModifyDate = GETDATE()   
	FROM AT2008 WITH (NOLOCK)
		INNER JOIN (SELECT InventoryID, WareHouseID, InventoryAccountID, EndQuantity, EndAmount FROM AT2008 WITH (NOLOCK) 
					WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND WareHouseID IN (SELECT Value FROM dbo.StringSplit(@WareHouseID, ','))) T08
					ON AT2008.InventoryID = T08.InventoryID AND AT2008.WareHouseID = T08.WareHouseID AND AT2008.InventoryAccountID = T08.InventoryAccountID
	WHERE AT2008.TranMonth = @NextMonth AND
	AT2008.TranYear = @NextYear AND
	AT2008.DivisionID = @DivisionID
END  
 
INSERT AT2008 (InventoryID,WarehouseID,TranMonth,TranYear,DivisionID, BeginQuantity, BeginAmount, EndQuantity, EndAmount, 
			   DebitQuantity, DebitAmount, CreditQuantity, CreditAmount,InDebitQuantity, InDebitAmount, InCreditQuantity,InCreditAmount,
			   InventoryAccountID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT T08.InventoryID,T08.WareHouseID,@NextMonth,@NextYear,@DivisionID, 
	   T08.EndQuantity, T08.EndAmount, T08.EndQuantity, T08.EndAmount,  
	   0,0,0,0,0,0,0,0, T08.InventoryAccountID, @UserID, GETDATE(), @UserID, GETDATE()
FROM AT2008 T08 WITH (NOLOCK)
WHERE T08.DivisionID = @DivisionID AND T08.TranMonth = @TranMonth AND T08.TranYear = @TranYear AND T08.WareHouseID IN (SELECT Value FROM dbo.StringSplit(@WareHouseID, ','))
	  AND ISNULL((SELECT TOP 1 1 FROM AT2008 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TranMonth = @NextMonth AND TranYear = @NextYear
	  AND InventoryID = T08.InventoryID AND WareHouseID = T08.WareHouseID AND InventoryAccountID = T08.InventoryAccountID), 0) = 0

-- Insert Người theo dõi mặc định
INSERT INTO WMT9020 (APK, DivisionID, APKMaster, TableID, FollowerID01, FollowerName01, TypeFollow, RelatedToTypeID, CreateDate, CreateUserID)
SELECT DISTINCT NEWID(), A08.DivisionID, A08.APK, 'AT2008', A08.CreateUserID, AT1103.FullName, 0, 0, GETDATE(), @UserID
FROM AT2008 A08
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = A08.CreateUserID
WHERE NOT EXISTS (SELECT TOP 1 1 FROM WMT9020 WM20 WHERE WM20.DivisionID = A08.DivisionID AND WM20.APKMaster = A08.APK)
-- Insert lịch sử mô tả
INSERT INTO WMT00003 (APK, DivisionID, [Description], RelatedToID, RelatedToTypeID, CreateDate, CreateUserID, StatusID, ScreenID, TableID)
SELECT DISTINCT NEWID(), A08.DivisionID, '''A00.AddNew'' <br/>', A08.APK, 47, GETDATE(), @UserID, 1, 'WMF2271', 'AT2008'
FROM AT2008 A08
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = A08.CreateUserID
WHERE NOT EXISTS (SELECT TOP 1 1 FROM WMT00003 WM03 WHERE WM03.DivisionID = A08.DivisionID AND WM03.RelatedToID = A08.APK)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO