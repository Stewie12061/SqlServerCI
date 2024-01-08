IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2161]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2161]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Xử lý tính huê hồng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga, Date: 23/11/2020
----Modify by: Kiều Nga, Date: 08/12/2020 : Fix lỗi tính huê hồng khi lập phiếu thu tiền qua ngân hàng
----Modify by: Kiều Nga, Date: 09/12/2020 : [2020/12/IS/0150] Xử lý chốt chặn tính huê hồng dự án theo từng tháng
----Modify by: Kiều Nga, Date: 10/03/2021 : Fix lỗi làm tròn số 
----Modify by: Kiều Nga, Date: 29/03/2021 : Bổ sung kiểm tra công việc hoàn thành trước 
----Modify by: Kiều Nga, Date: 05/04/2021 : Fix lỗi tính huê hồng tháng đầu tiên của đợt thanh toán

/*-- <Example>
		exec HRMP2161 @DivisionID=N'CBD',@UserID=N'ASOFTADMIN',@TranMonth=2,@TranYear=2016
----*/

CREATE PROCEDURE [dbo].[HRMP2161]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT
)
AS 
DECLARE @TableCur CURSOR,
		@EmployeeID NVARCHAR(50),
		@ContractID NVARCHAR(MAX),
		@ContractNo NVARCHAR(50),
		@SOrderID NVARCHAR(MAX),
		@VoucherNo NVARCHAR(50),
		@ObjectID NVARCHAR(50),
		@InventoryID NVARCHAR(50),
		@PaymentAmount Decimal (28,8),
		@Amount Decimal (28,8),
		@BonusRate01 Decimal (28,8),
		@BonusRate02 Decimal (28,8),
		@BonusRate03 Decimal (28,8),
		@BonusRate04 Decimal (28,8),
		@BonusRate Decimal (28,8),
		@RevenueAmount Decimal (28,8),
		@Ana08ID NVARCHAR(50),
		@FromDate DateTime,
		@ToDate DateTime,
		@VATPercent Decimal(28,8),
		@TableCur2 CURSOR,
		@TaskSampleID NVARCHAR(50),
		@Count INT = 0,
		@CountTaskBlock INT = 0 ,-- Số lượng công việc chốt chặn
		@CountMonth INT = 0, -- Số lượng tháng
		@CountTT INT = 0, -- Số lượng tháng chưa tính huê hồng
		@PreMonth INT =0,
		@CurrentYear INT =0

--- Xóa dữ liệu huê hồng trong kỳ
Delete from HRMT2160 where TranMonth =@TranMonth and TranYear = @TranYear

--- Tính huê hồng từ hợp đồng ----------------------------------
SELECT *
INTO #HRMP2161
FROM(
	SELECT T2.ContractID,T5.EmployeeID,T3.ContractDetailID,T2.ContractNo,T2.ObjectID,T1.InventoryID,ISNULL(T3.PaymentAmount,0) as PaymentAmount,
	ISNULL(T6.BonusRate01,0) as BonusRate01,0 as BonusRate02,0 as BonusRate03,0 as BonusRate04,ISNULL(T6.BonusRate01,0) as BonusRate,T4.Ana08ID
	,T3.FromDate,T3.ToDate,T1.VATPercent
	FROM AT1031 T1 WITH (NOLOCK) 
	INNER JOIN AT1020 T2 WITH (NOLOCK) ON T1.ContractID = T2.ContractID
	INNER JOIN AT1021 T3 WITH (NOLOCK) ON T1.ContractID = T3.ContractID
	INNER JOIN AT9000 T4 WITH (NOLOCK) ON T3.ContractDetailID = T4.ContractDetailID AND T4.ConvertedAmount = T3.PaymentAmount AND TransactionTypeID IN ('T01','T21') 
	INNER JOIN AT1103 T5 WITH (NOLOCK) ON T1.Ana04ID = T5.EmployeeID
	INNER JOIN OT1302 T6 WITH (NOLOCK) ON T2.PriceListID = T6.ID AND T1.InventoryID = T6.InventoryID
     WHERE ((@TranYear = YEAR(T3.FromDate) AND @TranMonth >= MONTH(T3.FromDate)) OR @TranYear > YEAR(T3.FromDate))
	 AND ((@TranYear = YEAR(T3.ToDate) AND @TranMonth <= MONTH(T3.ToDate)) OR @TranYear < YEAR(T3.ToDate))

Union all
	SELECT T2.ContractID,T5.EmployeeID,T3.ContractDetailID,T2.ContractNo,T2.ObjectID,T1.InventoryID,ISNULL(T3.PaymentAmount,0) as PaymentAmount,
	 0 as BonusRate01,ISNULL(T6.BonusRate02,0) as BonusRate02,0 as BonusRate03,0 as BonusRate04,ISNULL(T6.BonusRate02,0) as BonusRate,T4.Ana08ID
	,T3.FromDate,T3.ToDate,T1.VATPercent
	FROM AT1031 T1 WITH (NOLOCK)
	INNER JOIN AT1020 T2 WITH (NOLOCK) ON T1.ContractID = T2.ContractID
	INNER JOIN AT1021 T3 WITH (NOLOCK) ON T1.ContractID = T3.ContractID
	INNER JOIN AT9000 T4 WITH (NOLOCK) ON T3.ContractDetailID = T4.ContractDetailID AND T4.ConvertedAmount = T3.PaymentAmount AND TransactionTypeID IN ('T01','T21')
	INNER JOIN AT1103 T5 WITH (NOLOCK) ON T1.Ana05ID = T5.EmployeeID
	INNER JOIN OT1302 T6 WITH (NOLOCK) ON T2.PriceListID = T6.ID AND T1.InventoryID = T6.InventoryID
     WHERE ((@TranYear = YEAR(T3.FromDate) AND @TranMonth >= MONTH(T3.FromDate)) OR @TranYear > YEAR(T3.FromDate))
	 AND ((@TranYear = YEAR(T3.ToDate) AND @TranMonth <= MONTH(T3.ToDate)) OR @TranYear < YEAR(T3.ToDate))
Union all
	SELECT T2.ContractID,T5.EmployeeID,T3.ContractDetailID,T2.ContractNo,T2.ObjectID,T1.InventoryID,ISNULL(T3.PaymentAmount,0) as PaymentAmount,
	0 as BonusRate01, 0 as BonusRate02,ISNULL(T6.BonusRate03,0) as BonusRate03,0 as BonusRate04,ISNULL(T6.BonusRate03,0) as BonusRate,T4.Ana08ID
	,T3.FromDate,T3.ToDate,T1.VATPercent
	FROM AT1031 T1 WITH (NOLOCK)
	INNER JOIN AT1020 T2 WITH (NOLOCK) ON T1.ContractID = T2.ContractID
	INNER JOIN AT1021 T3 WITH (NOLOCK) ON T1.ContractID = T3.ContractID
	INNER JOIN AT9000 T4 WITH (NOLOCK) ON T3.ContractDetailID = T4.ContractDetailID AND T4.ConvertedAmount = T3.PaymentAmount AND TransactionTypeID IN ('T01','T21')
	INNER JOIN AT1103 T5 WITH (NOLOCK) ON T1.Ana06ID = T5.EmployeeID
	INNER JOIN OT1302 T6 WITH (NOLOCK) ON T2.PriceListID = T6.ID AND T1.InventoryID = T6.InventoryID
     WHERE ((@TranYear = YEAR(T3.FromDate) AND @TranMonth >= MONTH(T3.FromDate)) OR @TranYear > YEAR(T3.FromDate))
	 AND ((@TranYear = YEAR(T3.ToDate) AND @TranMonth <= MONTH(T3.ToDate)) OR @TranYear < YEAR(T3.ToDate))
Union all
	SELECT T2.ContractID,T5.EmployeeID,T3.ContractDetailID,T2.ContractNo,T2.ObjectID,T1.InventoryID,ISNULL(T3.PaymentAmount,0) as PaymentAmount,
	0 as BonusRate01, 0 as BonusRate02,0 as BonusRate03,ISNULL(T6.BonusRate04,0) as BonusRate04,ISNULL(T6.BonusRate04,0) as BonusRate,T4.Ana08ID
	,T3.FromDate,T3.ToDate,T1.VATPercent
	FROM AT1031 T1 WITH (NOLOCK)
	INNER JOIN AT1020 T2 WITH (NOLOCK) ON T1.ContractID = T2.ContractID
	INNER JOIN AT1021 T3 WITH (NOLOCK) ON T1.ContractID = T3.ContractID
	INNER JOIN AT9000 T4 WITH (NOLOCK) ON T3.ContractDetailID = T4.ContractDetailID AND T4.ConvertedAmount = T3.PaymentAmount AND TransactionTypeID IN ('T01','T21')
	INNER JOIN AT1103 T5 WITH (NOLOCK) ON T1.Ana07ID = T5.EmployeeID
	INNER JOIN OT1302 T6 WITH (NOLOCK) ON T2.PriceListID = T6.ID AND T1.InventoryID = T6.InventoryID
     WHERE ((@TranYear = YEAR(T3.FromDate) AND @TranMonth >= MONTH(T3.FromDate)) OR @TranYear > YEAR(T3.FromDate))
	 AND ((@TranYear = YEAR(T3.ToDate) AND @TranMonth <= MONTH(T3.ToDate)) OR @TranYear < YEAR(T3.ToDate))
	)A

	--select * from #HRMP2161

SET @TableCur = CURSOR SCROLL KEYSET FOR
SELECT T1.EmployeeID,T1.ContractID,T1.ContractNo,T1.ObjectID,T1.InventoryID,T1.PaymentAmount,T1.BonusRate01
,T1.BonusRate02,T1.BonusRate03,T1.BonusRate04,T1.BonusRate,T1.Ana08ID,T1.FromDate,T1.ToDate,T1.VATPercent
FROM #HRMP2161 T1 WITH (NOLOCK)

-- Bảng tạm cv chốt chặn
SELECT T1.*,T3.ContractID INTO #HRMP2162
FROM OOT2110 T1 WITH (NOLOCK)
INNER JOIN OOT1060 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.TaskSampleID = T2.TaskSampleID AND T2.TaskBlockTypeID = 2
INNER JOIN OOT2100 T3 WITH (NOLOCK) ON T1.ProjectID = T3.ProjectID
WHERE T1.StatusID <> 'TTCV0004'

 

--- Kiểm tra công việc chốt chặn và insert vào bảng HRMT2160 ---
OPEN @TableCur
FETCH NEXT FROM @TableCur INTO @EmployeeID,@ContractID,@ContractNo,@ObjectID,@InventoryID,@PaymentAmount,@BonusRate01
,@BonusRate02,@BonusRate03,@BonusRate04,@BonusRate,@Ana08ID,@FromDate,@ToDate,@VATPercent
WHILE @@FETCH_STATUS = 0
BEGIN
	--- Tính số lượng tháng chưa tính huê hồng ---
	DECLARE @CountPreMonth INT = 0, -- Số lượng công việc hoàn thành ở kỳ trước
			@CountCurrentMonth INT = 0, -- Số lượng công việc hoàn thành ở kỳ hiện tại
			@CountTaskBlock1 INT = 0,
			@CountPreMonth1 INT = 0,
			@CountCurrentMonth1 INT = 0,
			@Check INT =0,
			@Check2 INT = 1 -- check kỳ hiện tại

	SET @CountTT =0
	SET @PreMonth = @TranMonth - 1 
	SET @CurrentYear = @TranYear
	
	-- Nếu kỳ tính huê hồng bằng kỳ thanh toán đầu tiên trong hợp đồng
	SET @Check = (CASE WHEN @TranMonth = MONTH(@FromDate) AND @TranYear = YEAR(@FromDate) THEN 1 ELSE 0 END)

	IF @PreMonth = 0
	BEGIN
		SET  @PreMonth = @PreMonth + 12
		SET  @CurrentYear = @CurrentYear - 1 
	END

	print @ContractNo

	WHILE ((@CurrentYear = YEAR(@FromDate) AND @PreMonth >= MONTH(@FromDate)) OR @CurrentYear > YEAR(@FromDate) OR @Check = 1)
	BEGIN    
			print @PreMonth
			print @CurrentYear

			--- Kiểm tra huê hồng kỳ trước chưa tính (dựa vào thời gian thực hiện của cv chốt chặn kỳ trước) ---
	        IF(@Check = 0)
			BEGIN
				SET @CountPreMonth  = 0
				SET @CountCurrentMonth = 0

				SET @CountTaskBlock = (SELECT COUNT(*) FROM (SELECT TaskSampleID FROM #HRMP2162 WITH (NOLOCK)
													WHERE MONTH(PlanEndDate) = @PreMonth AND YEAR(PlanEndDate) = @CurrentYear AND ContractID = @ContractID
													GROUP BY TaskSampleID) T)

	     		SET @TableCur2 = CURSOR SCROLL KEYSET FOR
				SELECT TaskSampleID FROM #HRMP2162 WITH (NOLOCK)
				WHERE MONTH(PlanEndDate) = @PreMonth AND YEAR(PlanEndDate) = @CurrentYear AND ContractID = @ContractID
				GROUP BY TaskSampleID

				OPEN @TableCur2
				FETCH NEXT FROM @TableCur2 INTO @TaskSampleID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					-- Kiểm tra các công việc hoàn thành ở kỳ trước => @Count++
					IF EXISTS (SELECT TOP 1 1 FROM OOT2100 T1 WITH (NOLOCK)
								INNER JOIN OOT2110 T2 WITH (NOLOCK) ON T1.ProjectID = T2.ProjectID
								WHERE T2.TaskSampleID = @TaskSampleID AND T1.ContractID = @ContractID AND T2.StatusID = 'TTCV0003'
									  AND MONTH(T2.ActualEndDate) = @PreMonth AND YEAR(T2.ActualEndDate) = @CurrentYear
									  AND MONTH(T2.PlanEndDate) = @PreMonth AND YEAR(T2.PlanEndDate) = @CurrentYear)
					BEGIN
						SET @CountPreMonth = @CountPreMonth + 1
					END

					-- Kiểm tra các công việc hoàn thành ở kỳ hiện tại => @Count++
					IF EXISTS (SELECT TOP 1 1 FROM OOT2100 T1 WITH (NOLOCK)
								INNER JOIN OOT2110 T2 WITH (NOLOCK) ON T1.ProjectID = T2.ProjectID
								WHERE T2.TaskSampleID = @TaskSampleID AND T1.ContractID = @ContractID AND T2.StatusID = 'TTCV0003'
									  AND MONTH(T2.ActualEndDate) = @TranMonth AND YEAR(T2.ActualEndDate) = @TranYear
									  AND MONTH(T2.PlanEndDate) = @PreMonth AND YEAR(T2.PlanEndDate) = @CurrentYear)
					BEGIN
						SET @CountCurrentMonth = @CountCurrentMonth + 1
					END
					FETCH NEXT FROM @TableCur2 INTO @TaskSampleID
				END
				CLOSE @TableCur2

				----- Nếu hoàn thành hết cv chốt chặn kỳ trước (công việc hoàn thành ở kỳ trước + công việc hoàn thành ở kỳ hiện tại) => @CountTT++
				IF (@CountPreMonth + @CountCurrentMonth = @CountTaskBlock) AND @CountTaskBlock > 0 AND @CountCurrentMonth >0
				BEGIN
					 SET @CountTT = @CountTT + 1
				END
			END
			--------------------------------------------------

			--PRINT @CountTT

			--- Kiểm tra tính huê hồng kỳ hiện tại (dựa vào thời gian thực hiện của cv chốt chặn kỳ hiện tại)---
			SET @CountPreMonth1  = 0
			SET @CountCurrentMonth1 = 0

			SET @CountTaskBlock1 = (SELECT COUNT(*) FROM (SELECT TaskSampleID FROM #HRMP2162 WITH (NOLOCK)
												 WHERE MONTH(PlanEndDate) = @TranMonth AND YEAR(PlanEndDate) = @TranYear AND ContractID = @ContractID
												 GROUP BY TaskSampleID) T)
			
	     	SET @TableCur2 = CURSOR SCROLL KEYSET FOR
			SELECT TaskSampleID FROM #HRMP2162 WITH (NOLOCK)
			WHERE MONTH(PlanEndDate) = @TranMonth AND YEAR(PlanEndDate) = @TranYear AND ContractID = @ContractID
			GROUP BY TaskSampleID

			-- Kiểm tra các công việc hoàn thành ở kỳ trước => @Count++
			OPEN @TableCur2
			FETCH NEXT FROM @TableCur2 INTO @TaskSampleID
			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM OOT2100 T1 WITH (NOLOCK)
							INNER JOIN OOT2110 T2 WITH (NOLOCK) ON T1.ProjectID = T2.ProjectID
							WHERE T2.TaskSampleID = @TaskSampleID AND T1.ContractID = @ContractID AND T2.StatusID = 'TTCV0003'
								  AND MONTH(T2.ActualEndDate) = @PreMonth AND YEAR(T2.ActualEndDate) = @CurrentYear
								  AND MONTH(T2.PlanEndDate) = @TranMonth AND YEAR(T2.PlanEndDate) = @TranYear)
				BEGIN
					SET @CountPreMonth1 = @CountPreMonth1 + 1
				END

				FETCH NEXT FROM @TableCur2 INTO @TaskSampleID
			END
			CLOSE @TableCur2

			-- Kiểm tra các công việc hoàn thành ở kỳ hiện tại => @Count++
			IF(@Check2 = 1)
			BEGIN
				OPEN @TableCur2
				FETCH NEXT FROM @TableCur2 INTO @TaskSampleID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF EXISTS (SELECT TOP 1 1 FROM OOT2100 T1 WITH (NOLOCK)
								INNER JOIN OOT2110 T2 WITH (NOLOCK) ON T1.ProjectID = T2.ProjectID
								WHERE T2.TaskSampleID = @TaskSampleID AND T1.ContractID = @ContractID AND T2.StatusID = 'TTCV0003'
									  AND MONTH(T2.ActualEndDate) = @TranMonth AND YEAR(T2.ActualEndDate) = @TranYear
									  AND MONTH(T2.PlanEndDate) = @TranMonth AND YEAR(T2.PlanEndDate) = @TranYear)
					BEGIN
						SET @CountCurrentMonth1 = @CountCurrentMonth1 + 1
					END
					FETCH NEXT FROM @TableCur2 INTO @TaskSampleID
				END
				CLOSE @TableCur2
			END 

			----- Nếu hoàn thành hết cv chốt chặn kỳ hiện tại (công việc hoàn thành ở kỳ trước + công việc hoàn thành ở kỳ hiện tại) => @CountTT++
			IF (@CountPreMonth1 + @CountCurrentMonth1 = @CountTaskBlock1) AND @CountTaskBlock1 > 0
			BEGIN
			     SET @CountTT = @CountTT + 1
			END
			------------------------------------------------------
			--PRINT @CountTT

			SET @Check =0 SET @Check2 = 0
			SET @PreMonth = @PreMonth - 1
			IF @PreMonth = 0 AND @CurrentYear > YEAR(@FromDate)
			BEGIN
				SET  @PreMonth = @PreMonth + 12
				SET  @CurrentYear = @CurrentYear - 1 
			END
	END 
	-----------------------------------------------

	-- Nếu số lượng tháng chưa tính huê hồng >0 => Tính huê hồng
	IF @CountTT > 0
	BEGIN
	   -- Tính số tháng theo đợt thanh toán ở hợp đồng
	   IF(YEAR(@ToDate) = YEAR(@FromDate))
			SET @CountMonth = MONTH(@ToDate) - MONTH(@FromDate) + 1
	   ELSE
	        SET @CountMonth = (YEAR(@ToDate) - YEAR(@FromDate))*12 + (MONTH(@ToDate) - MONTH(@FromDate) + 1)
	   
	   -- Nếu chọn trả góp ở phiếu thu/ thu qua ngân hàng
	   IF @Ana08ID ='TRAGOP' 
	   BEGIN
			SET @PaymentAmount = (@PaymentAmount / @CountMonth / (1+@VATPercent/100)) * @CountTT
			SET @Amount = @PaymentAmount * 0.9 
			SET @RevenueAmount = @Amount * (@BonusRate/100)
	   END
	   ELSE
	   BEGIN
			SET @PaymentAmount = (@PaymentAmount / @CountMonth / (1+@VATPercent/100)) * @CountTT
			SET @Amount = @PaymentAmount
			SET @RevenueAmount = @Amount * (@BonusRate/100)
	   END

	   INSERT INTO HRMT2160 (APK,DivisionID,TranMonth,TranYear,EmployeeID,ObjectID,InventoryID,VoucherNo,PayAmount,Amount,BonusRate01,BonusRate02,BonusRate03,BonusRate04
	   ,RevenueAmount,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
	   VALUES (NEWID(),@DivisionID,@TranMonth,@TranYear,@EmployeeID,@ObjectID,@InventoryID,@ContractNo,@PaymentAmount,@Amount,@BonusRate01,@BonusRate02,@BonusRate03,@BonusRate04
	   ,@RevenueAmount,@UserID,GETDATE(),@UserID,GETDATE())
	END
		  
	FETCH NEXT FROM @TableCur INTO @EmployeeID,@ContractID,@ContractNo,@ObjectID,@InventoryID,@PaymentAmount
	,@BonusRate01,@BonusRate02,@BonusRate03,@BonusRate04,@BonusRate,@Ana08ID,@FromDate,@ToDate,@VATPercent
END	
CLOSE @TableCur
----------------------------------------------------------------

--- Tính huê hồng từ đơn hàng ----------------------------------
SELECT *
INTO #HRMP2161B
FROM(
SELECT T2.SOrderID,T5.EmployeeID,T2.VoucherNo,T2.ObjectID,T1.InventoryID,ISNULL(T1.ConvertedAmount,0) as PaymentAmount,
	ISNULL(T6.BonusRate01,0) as BonusRate01,0 as BonusRate02,0 as BonusRate03,0 as BonusRate04,ISNULL(T6.BonusRate01,0) as BonusRate
	,T4.Ana08ID,T1.VATPercent
FROM OT2002 T1 WITH (NOLOCK)
INNER JOIN OT2001 T2 WITH (NOLOCK) ON T1.SOrderID = T2.SOrderID
INNER JOIN AT9000 T4 WITH (NOLOCK) ON T1.SOrderID = T4.OrderID  AND TransactionTypeID IN ('T01','T21')
INNER JOIN AT1103 T5 WITH (NOLOCK) ON T1.Ana04ID = T5.EmployeeID
INNER JOIN OT1302 T6 WITH (NOLOCK) ON T2.PriceListID = T6.ID AND T1.InventoryID = T6.InventoryID
WHERE T4.TranMonth = @TranMonth AND T4.TranYear = @TranYear 

UNION ALL
SELECT T2.SOrderID,T5.EmployeeID,T2.VoucherNo,T2.ObjectID,T1.InventoryID,ISNULL(T1.ConvertedAmount,0) as PaymentAmount,
	0 as BonusRate01,ISNULL(T6.BonusRate02,0) as BonusRate02,0 as BonusRate03,0 as BonusRate04,ISNULL(T6.BonusRate02,0) as BonusRate
	,T4.Ana08ID,T1.VATPercent
FROM OT2002 T1 WITH (NOLOCK)
INNER JOIN OT2001 T2 WITH (NOLOCK) ON T1.SOrderID = T2.SOrderID
INNER JOIN AT9000 T4 WITH (NOLOCK) ON T1.SOrderID = T4.OrderID AND TransactionTypeID IN ('T01','T21')
INNER JOIN AT1103 T5 WITH (NOLOCK) ON T1.Ana05ID = T5.EmployeeID
INNER JOIN OT1302 T6 WITH (NOLOCK) ON T2.PriceListID = T6.ID AND T1.InventoryID = T6.InventoryID
WHERE T4.TranMonth = @TranMonth AND T4.TranYear = @TranYear 

UNION ALL
SELECT T2.SOrderID,T5.EmployeeID,T2.VoucherNo,T2.ObjectID,T1.InventoryID,ISNULL(T1.ConvertedAmount,0) as PaymentAmount,
	0 as BonusRate01,0 as BonusRate02,ISNULL(T6.BonusRate03,0) as BonusRate03,0 as BonusRate04,ISNULL(T6.BonusRate03,0) as BonusRate
	,T4.Ana08ID,T1.VATPercent
FROM OT2002 T1 WITH (NOLOCK)
INNER JOIN OT2001 T2 WITH (NOLOCK) ON T1.SOrderID = T2.SOrderID
INNER JOIN AT9000 T4 WITH (NOLOCK) ON T1.SOrderID = T4.OrderID AND TransactionTypeID IN ('T01','T21')
INNER JOIN AT1103 T5 WITH (NOLOCK) ON T1.Ana06ID = T5.EmployeeID
INNER JOIN OT1302 T6 WITH (NOLOCK) ON T2.PriceListID = T6.ID AND T1.InventoryID = T6.InventoryID
WHERE T4.TranMonth = @TranMonth AND T4.TranYear = @TranYear 

UNION ALL
SELECT T2.SOrderID,T5.EmployeeID,T2.VoucherNo,T2.ObjectID,T1.InventoryID,ISNULL(T1.ConvertedAmount,0) as PaymentAmount,
	0 as BonusRate01,0 as BonusRate02,0 as BonusRate03,ISNULL(T6.BonusRate04,0) as BonusRate04,ISNULL(T6.BonusRate04,0) as BonusRate
	,T4.Ana08ID,T1.VATPercent
FROM OT2002 T1 WITH (NOLOCK)
INNER JOIN OT2001 T2 WITH (NOLOCK) ON T1.SOrderID = T2.SOrderID
INNER JOIN AT9000 T4 WITH (NOLOCK) ON T1.SOrderID = T4.OrderID AND TransactionTypeID IN ('T01','T21')
INNER JOIN AT1103 T5 WITH (NOLOCK) ON T1.Ana07ID = T5.EmployeeID
INNER JOIN OT1302 T6 WITH (NOLOCK) ON T2.PriceListID = T6.ID AND T1.InventoryID = T6.InventoryID
WHERE T4.TranMonth = @TranMonth AND T4.TranYear = @TranYear 
) B

SET @TableCur = CURSOR SCROLL KEYSET FOR
SELECT T1.EmployeeID,T1.SOrderID,T1.VoucherNo,T1.ObjectID,T1.InventoryID,T1.PaymentAmount,T1.BonusRate01
,T1.BonusRate02,T1.BonusRate03,T1.BonusRate04,T1.BonusRate,T1.Ana08ID,T1.VATPercent
FROM #HRMP2161B T1 WITH (NOLOCK)

--- Kiểm tra công việc chốt chặn và insert vào bảng HRMT2160 ---
OPEN @TableCur
FETCH NEXT FROM @TableCur INTO @EmployeeID,@SOrderID,@VoucherNo,@ObjectID,@InventoryID,@PaymentAmount
,@BonusRate01,@BonusRate02,@BonusRate03,@BonusRate04,@BonusRate,@Ana08ID,@VATPercent
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @Count =0
	SET @CountTaskBlock = (SELECT COUNT(*) FROM (SELECT T1.TaskSampleID FROM OOT2110 T1 WITH (NOLOCK)
												 INNER JOIN OOT1060 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.TaskSampleID = T2.TaskSampleID AND T2.TaskBlockTypeID = 1
												 WHERE MONTH(T1.PlanEndDate) = @TranMonth AND YEAR(T1.PlanEndDate) = @TranYear AND T1.APKSaleOrderID = @SOrderID
												 GROUP BY T1.TaskSampleID) T)

	SET @TableCur2 = CURSOR SCROLL KEYSET FOR
	SELECT T1.TaskSampleID FROM OOT2110 T1 WITH (NOLOCK)
	INNER JOIN OOT1060 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.TaskSampleID = T2.TaskSampleID AND T2.TaskBlockTypeID = 1
	WHERE MONTH(T1.PlanEndDate) = @TranMonth AND YEAR(T1.PlanEndDate) = @TranYear AND T1.APKSaleOrderID = @SOrderID
	GROUP BY T1.TaskSampleID

	OPEN @TableCur2
	FETCH NEXT FROM @TableCur2 INTO @TaskSampleID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM OOT2110 T2 WITH (NOLOCK)
					WHERE T2.TaskSampleID = @TaskSampleID AND T2.APKSaleOrderID = @SOrderID AND T2.StatusID = 'TTCV0003'
						  AND Month(T2.PlanEndDate) = @TranMonth AND Year(T2.PlanEndDate) = @TranYear)
		BEGIN
			SET @Count = @Count + 1
		END
		FETCH NEXT FROM @TableCur2 INTO @TaskSampleID
	END
	CLOSE @TableCur2

	-- Nếu hoàn thành hết cv chốt chặn thì tính huê hồng 
	IF  @Count = @CountTaskBlock AND EXISTS (SELECT TOP 1 1 FROM OT2002 T1 WITH (NOLOCK)
											   INNER JOIN AT9000 T2 WITH (NOLOCK) ON T1.SOrderID = T2.OrderID AND T2.TransactionTypeID IN ('T01','T21')
											   WHERE T1.SOrderID = @SOrderID
											   GROUP BY T2.OrderID,T2.ConvertedAmount
											   HAVING ROUND(SUM(T1.ConvertedAmount + ISNULL(T1.VATConvertedAmount,0)),0) = T2.ConvertedAmount) 
	BEGIN
	   -- Nếu chọn trả góp ở phiếu thu/ thu qua ngân hàng
	   IF @Ana08ID ='TRAGOP'
	   BEGIN
			SET @PaymentAmount = @PaymentAmount
			SET @Amount = @PaymentAmount * 0.9 
			SET @RevenueAmount = @Amount * (@BonusRate/100)
	   END
	   ELSE
	   BEGIN
			SET @PaymentAmount = @PaymentAmount
			SET @Amount = @PaymentAmount
			SET @RevenueAmount = @Amount * (@BonusRate/100)
	   END

	   INSERT INTO HRMT2160 (APK,DivisionID,TranMonth,TranYear,EmployeeID,ObjectID,InventoryID,VoucherNo,PayAmount,Amount,BonusRate01,BonusRate02,BonusRate03,BonusRate04
	   ,RevenueAmount,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
	   VALUES (NEWID(),@DivisionID,@TranMonth,@TranYear,@EmployeeID,@ObjectID,@InventoryID,@VoucherNo,@PaymentAmount,@Amount,@BonusRate01,@BonusRate02,@BonusRate03,@BonusRate04
	   ,@RevenueAmount,@UserID,GETDATE(),@UserID,GETDATE())

	END
		  
	FETCH NEXT FROM @TableCur INTO @EmployeeID,@SOrderID,@VoucherNo,@ObjectID,@InventoryID,@PaymentAmount
,@BonusRate01,@BonusRate02,@BonusRate03,@BonusRate04,@BonusRate,@Ana08ID,@VATPercent
END	
CLOSE @TableCur
----------------------------------------------------------------






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
