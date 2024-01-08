IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMP0021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMP0021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----- Created by Khanh Van on 17/01/2014
----- Purpose: Kết chuyển Bút toán tổng hợp từ Phí hoa hồng/Phí bản quyền.
----- Modified on 26/09/2022 by Văn Tài: Xử lý tính hoa hồng theo nhóm hàng.
----- Modified on 05/11/2022 by Văn Tài: Bổ sung Type kiểm tra ở 2 màn hình Tính chi phí và Báo cáo.
----- Modified on 05/11/2022 by Văn Tài: Bổ sung tính toán làm tròn khi kết chuyển.
----- EXD, EFM, EXDExchangeRate, Other.
----- Modified on 01/12/2022 by Nhật Quang: Thay đổi các mã TK, đối tượng: Nợ, Có cho EXEDY

--Exec CMP00121 'STH', 6, 2013,	'123', '123', 'abc'	

--- <remarks>
---	1. Phí bản quyền
---		TK có: 335100
---		TK nợ: 627880
---		Ana02ID: CP.00011
---		EXD: JP0100010
---		EXDExchangeRate: JP0100010 
---		Other: JP0100010 
---		EFM: TH0100016 
--- 2. Phí hoa hồng
---		TK có: 335100
---		TK nợ: 641720
---		Ana02ID: CP.00011
---		CreditObjectID/DebitObjectID: JP0100010
--- </remarks>
					
CREATE PROCEDURE [dbo].[CMP0021] 	
				 @DivisionID AS VARCHAR(50),   	
				 @UserID AS VARCHAR(50),
				 @TranMonth AS INT, 			
				 @TranYear AS INT,			
				 @Mode AS INT = 0, -- 1: Kết chuyển, 2: Hủy bỏ Kết chuyển.
				 @TransferType AS INT = 0, -- 1: Kết chuyển Hoa hồng, 2: Kết chuyển Bản quyền.,
				 @ActionCheck AS INT = 0 -- 1: Tính hoa hồng/bản quyền, 2: Kết chuyển Bản quyền.
AS
BEGIN
	DECLARE 
	@sSQL0 NVARCHAR(4000),
	@sSQL1 NVARCHAR(4000),
	@sSQL2 NVARCHAR(4000),
	@sSQL3 NVARCHAR(4000),

	-- Thông tin kết chuyển bút toán tổng hợp.
	@GMasterCompany VARCHAR(50),
	@GVoucherID VARCHAR(50),
	@GVoucherNo VARCHAR(50),
	@GDescription NVARCHAR(250),
	@GCreditObjectID VARCHAR(50),
	@GDebitObjectID VARCHAR(50),
	@GCreditAccountID VARCHAR(50),
	@GDebitAccountID VARCHAR(50),
	@GAna02ID VARCHAR(50),
	@ExchangeRateDecimal INT = (SELECT TOP 1 ExchangeRateDecimal FROM AT1004 AT04 WITH (NOLOCK) WHERE AT04.DivisionID IN ('@@@', @DivisionID) AND AT04.CurrencyID = 'VND')

	DECLARE @CustomerIndex INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))
	
	CREATE TABLE #Message_CMP0021 ([Status] TINYINT, MessageID VARCHAR(50), [Param] VARCHAR(MAX))

	--- Thực hiện kết chuyển.
	IF (@Mode = 1)
	BEGIN

		 -- Kiểm tra dữ liệu
		BEGIN

			IF (@TransferType = 1)
			BEGIN
				-- Nếu Module T đóng kỳ kế toán. => thì không cho phép kết chuyển.
				IF (EXISTS(SELECT TOP 1 1
					FROM AT9999 WITH (NOLOCK)
					WHERE DivisionID = @DivisionID
						AND TranYear = @TranYear
						AND TranMonth = @TranMonth
						AND ISNULL(Closing, 0) = 1
					))
				BEGIN
					-- {0} đã khóa sổ. Bạn mở khóa sổ trước khi Sửa / Xóa
					INSERT INTO #Message_CMP0021 ([Status], MessageID, Param)
					SELECT 1
						, '00ML000051'
						, 'Phân hệ T'

					GOTO FINISH;
				END

				SET @GVoucherID = (SELECT TOP 1 GVoucherID 
									FROM CMT0013 WITH (NOLOCK)
									WHERE DivisionID = @DivisionID
										AND TranYear = @TranYear
										AND TranMonth = @TranMonth
								  )

				-- Kiểm tra tồn tại bút toán kết chuyển trước đó.
				IF(ISNULL(@GVoucherID, '') <> '')
				BEGIN
			
					IF(EXISTS(SELECT TOP 1 1 
								FROM AT9000 WITH (NOLOCK)
								WHERE DivisionID = @DivisionID
										AND TranYear = @TranYear
										AND TranMonth = @TranMonth
										AND TransactionTypeID = 'T99'
										AND VoucherID = @GVoucherID
						))
					BEGIN

						IF(ISNULL(@ActionCheck, 0) = 1)
						BEGIN
							--- Đã kết chuyển bút toán trước đó, bạn không thể thực hiện kết chuyển được nữa.
							INSERT INTO #Message_CMP0021 ([Status], MessageID, Param)
							SELECT 1
								, 'CMFML000040'
								, NULL

							GOTO FINISH;
						END
						ELSE
						BEGIN
							--- Đã kết chuyển bút toán trước đó, bạn không thể thực hiện kết chuyển được nữa.
							INSERT INTO #Message_CMP0021 ([Status], MessageID, Param)
							SELECT 1
								, 'CMFML000039'
								, NULL

							GOTO FINISH;
						END

					END
				END

			END

		END

		-- Phí hoa hồng
		IF (@TransferType = 1)
		BEGIN

			-- Chứng từ tăng tự động.
			EXEC AP0000 @DivisionID, @GVoucherNo OUTPUT, 'AT9000' , 'PTH' , @TranYear, @TranMonth, 15, 3, 0, '-'
			SET @GDescription = N'Chi phí hoa hồng ' + CONVERT(VARCHAR(2), @TranMonth) + '/' + CONVERT(VARCHAR(4), @TranYear)

			SET @GCreditAccountID = '335100'
			SET @GDebitAccountID = '641720'
			SET @GCreditObjectID = 'JP0100010'
			SET	@GDebitObjectID = 'JP0100010'
			SET @GAna02ID = '01EXD'
			SET @GVoucherID = NEWID()

			INSERT INTO AT9000
			(
				APK,
				DivisionID,
				VoucherID,
				BatchID,
				TransactionID,
				TableID,
				TranMonth,
				TranYear,
				TransactionTypeID,
				VoucherTypeID,
				VoucherNo,
				CurrencyID,
				ExchangeRate,
				CreditObjectID,
				ObjectID,
				CreditAccountID,
				DebitAccountID,
				OriginalAmount,
				ConvertedAmount,
				VoucherDate,
				Orders,
				EmployeeID,
				CreateUserID,
				CreateDate,
				CurrencyIDCN,
				ExchangeRateCN,
				OriginalAmountCN,
				VDescription,
				BDescription,
				TDescription,
				InheritTableID
			)
			SELECT 
				NEWID(),
				DivisionID,
				@GVoucherID,
				NEWID(),
				NEWID(),
				'AT9000',
				TranMonth,
				TranYear,
				'T99',
				'PTH',
				@GVoucherNo,
				'VND',
				1.0,
				@GCreditObjectID,
				@GDebitObjectID,
				@GCreditAccountID,
				@GDebitAccountID,
				ROUND(SUM(CT13.ComAmount), ISNULL(@ExchangeRateDecimal, 0)),
				ROUND(SUM(CT13.ComAmount), ISNULL(@ExchangeRateDecimal, 0)),
				CONVERT(DATE, GETDATE()),
				1,
				@UserID,
				@UserID,
				GETDATE(),
				'VND',
				1,
				SUM(CT13.ComAmount),
				@GDescription,
				@GDescription,
				@GDescription,
				'CMT0013'
			FROM CMT0013 CT13 WITH (NOLOCK)
			WHERE CT13.DivisionID = @DivisionID
					AND CT13.TranYear = @TranYear
					AND CT13.TranMonth = @TranMonth
					AND ISNULL(CT13.IsRoyalty, 0) = 0
			GROUP BY CT13.DivisionID,
						CT13.TranYear,
						CT13.TranMonth

			--- Update kết quả tính với voucher id liên quan.
			UPDATE CT13
			SET GVoucherID = @GVoucherID
			FROM CMT0013 CT13
			WHERE CT13.DivisionID = @DivisionID
					AND CT13.TranYear = @TranYear
					AND CT13.TranMonth = @TranMonth
					AND ISNULL(CT13.IsRoyalty, 0) = 0

		END

		-- Tính phí bản quyền.
		IF (@TransferType = 2)
		BEGIN
			
			-- EXD
			BEGIN
			
				-- Chứng từ tăng tự động.
				EXEC AP0000 @DivisionID, @GVoucherNo OUTPUT, 'AT9000' , 'PTH' , @TranYear, @TranMonth, 15, 3, 0, '-'

				SET @GMasterCompany = 'EXD'

				SET @GDescription = N'Chi phí bản quyền cho công ty ' + @GMasterCompany + ' '  + CONVERT(VARCHAR(2), @TranMonth) + '/' + CONVERT(VARCHAR(4), @TranYear)

				SET @GCreditAccountID = '335100'
				SET @GDebitAccountID = '627880'
				SET @GCreditObjectID = 'JP0100010'
				SET	@GDebitObjectID = 'JP0100010'
				SET @GAna02ID = 'CP.00011'
				SET @GVoucherID = NEWID()

				INSERT INTO AT9000
				(
					Orders,
					APK,
					DivisionID,
					VoucherID,
					BatchID,
					TransactionID,
					TableID,
					TranMonth,
					TranYear,
					TransactionTypeID,
					VoucherTypeID,
					VoucherNo,
					CurrencyID,
					ExchangeRate,
					CreditObjectID,
					ObjectID,
					CreditAccountID,
					DebitAccountID,
					OriginalAmount,
					ConvertedAmount,
					VoucherDate,
					EmployeeID,
					CreateUserID,
					CreateDate,
					CurrencyIDCN,
					ExchangeRateCN,
					OriginalAmountCN,
					VDescription,
					BDescription,
					TDescription,
					ProductID,
					InheritTableID
				)
				SELECT 
					ROW_NUMBER() OVER(ORDER BY CT13.DivisionID, CT13.TranYear, CT13.TranMonth),
					NEWID(),
					DivisionID,
					@GVoucherID,
					NEWID(),
					NEWID(),
					'AT9000',
					TranMonth,
					TranYear,
					'T99',
					'PTH',
					@GVoucherNo,
					'VND',
					1.0,
					@GCreditObjectID,
					@GDebitObjectID,
					@GCreditAccountID,
					@GDebitAccountID,
					ROUND(SUM(CT13.ComAmount), ISNULL(@ExchangeRateDecimal, 0)),
					ROUND(SUM(CT13.ComAmount), ISNULL(@ExchangeRateDecimal, 0)),
					CONVERT(DATE, GETDATE()),
					@UserID,
					@UserID,
					GETDATE(),
					'VND',
					1,
					SUM(CT13.ComAmount),
					@GDescription,
					@GDescription,
					@GDescription,
					CT13.InventoryID,
					'CMT0013'
				FROM CMT0013 CT13 WITH (NOLOCK)
				WHERE CT13.DivisionID = @DivisionID
						AND CT13.TranYear = @TranYear
						AND CT13.TranMonth = @TranMonth
						AND ISNULL(CT13.IsRoyalty, 0) = 1
						AND CT13.SaleManID = @GMasterCompany
				GROUP BY CT13.DivisionID,
							CT13.TranYear,
							CT13.TranMonth,
							CT13.SaleManID,
							CT13.InventoryID,
							CT13.IsRoyalty

				--- Update kết quả tính với voucher id liên quan.
				UPDATE CT13
				SET GVoucherID = @GVoucherID
				FROM CMT0013 CT13
				WHERE CT13.DivisionID = @DivisionID
						AND CT13.TranYear = @TranYear
						AND CT13.TranMonth = @TranMonth
						AND ISNULL(CT13.IsRoyalty, 0) = 1
						AND CT13.SaleManID = @GMasterCompany

			END

			-- EFM
			BEGIN
			
				-- Chứng từ tăng tự động.
				EXEC AP0000 @DivisionID, @GVoucherNo OUTPUT, 'AT9000' , 'PTH' , @TranYear, @TranMonth, 15, 3, 0, '-'
				SET @GMasterCompany = 'EFM'

				SET @GDescription = N'Chi phí bản quyền cho công ty ' + @GMasterCompany + ' '  + CONVERT(VARCHAR(2), @TranMonth) + '/' + CONVERT(VARCHAR(4), @TranYear)

				SET @GCreditAccountID = '335100'
				SET @GDebitAccountID = '627880'
				SET @GCreditObjectID = 'TH0100016'
				SET	@GDebitObjectID = 'TH0100016'
				SET @GAna02ID = 'CP.00011'
				SET @GVoucherID = NEWID()

				INSERT INTO AT9000
				(
					Orders,
					APK,
					DivisionID,
					VoucherID,
					BatchID,
					TransactionID,
					TableID,
					TranMonth,
					TranYear,
					TransactionTypeID,
					VoucherTypeID,
					VoucherNo,
					CurrencyID,
					ExchangeRate,
					CreditObjectID,
					ObjectID,
					CreditAccountID,
					DebitAccountID,
					OriginalAmount,
					ConvertedAmount,
					VoucherDate,
					EmployeeID,
					CreateUserID,
					CreateDate,
					CurrencyIDCN,
					ExchangeRateCN,
					OriginalAmountCN,
					VDescription,
					BDescription,
					TDescription,
					ProductID,
					InheritTableID
				)
				SELECT 
					ROW_NUMBER() OVER(ORDER BY CT13.DivisionID, CT13.TranYear, CT13.TranMonth),
					NEWID(),
					DivisionID,
					@GVoucherID,
					NEWID(),
					NEWID(),
					'AT9000',
					TranMonth,
					TranYear,
					'T99',
					'PTH',
					@GVoucherNo,
					'VND',
					1.0,
					@GCreditObjectID,
					@GDebitObjectID,
					@GCreditAccountID,
					@GDebitAccountID,
					ROUND(SUM(CT13.ComAmount), ISNULL(@ExchangeRateDecimal, 0)),
					ROUND(SUM(CT13.ComAmount), ISNULL(@ExchangeRateDecimal, 0)),
					CONVERT(DATE, GETDATE()),
					@UserID,
					@UserID,
					GETDATE(),
					'VND',
					1,
					SUM(CT13.ComAmount),
					@GDescription,
					@GDescription,
					@GDescription,
					CT13.InventoryID,
					'CMT0013'
				FROM CMT0013 CT13 WITH (NOLOCK)
				WHERE CT13.DivisionID = @DivisionID
						AND CT13.TranYear = @TranYear
						AND CT13.TranMonth = @TranMonth
						AND ISNULL(CT13.IsRoyalty, 0) = 1
						AND CT13.SaleManID = @GMasterCompany
				GROUP BY CT13.DivisionID,
							CT13.TranYear,
							CT13.TranMonth,
							CT13.SaleManID,
							CT13.InventoryID,
							CT13.IsRoyalty

				--- Update kết quả tính với voucher id liên quan.
				UPDATE CT13
				SET GVoucherID = @GVoucherID
				FROM CMT0013 CT13
				WHERE CT13.DivisionID = @DivisionID
						AND CT13.TranYear = @TranYear
						AND CT13.TranMonth = @TranMonth
						AND ISNULL(CT13.IsRoyalty, 0) = 1
						AND CT13.SaleManID = @GMasterCompany

			END

			-- EXDExchangeRate
			BEGIN
			
				-- Chứng từ tăng tự động.
				EXEC AP0000 @DivisionID, @GVoucherNo OUTPUT, 'AT9000' , 'PTH' , @TranYear, @TranMonth, 15, 3, 0, '-'
				SET @GMasterCompany = 'EXDExchangeRate'

				SET @GDescription = N'Chi phí bản quyền cho công ty ' + @GMasterCompany + ' '  + CONVERT(VARCHAR(2), @TranMonth) + '/' + CONVERT(VARCHAR(4), @TranYear)

				SET @GCreditAccountID = '335100'
				SET @GDebitAccountID = '627880'
				SET @GCreditObjectID = 'JP0100010'
				SET	@GDebitObjectID = 'JP0100010'
				SET @GAna02ID = 'CP.00011'
				SET @GVoucherID = NEWID()

				INSERT INTO AT9000
				(
					Orders,
					APK,
					DivisionID,
					VoucherID,
					BatchID,
					TransactionID,
					TableID,
					TranMonth,
					TranYear,
					TransactionTypeID,
					VoucherTypeID,
					VoucherNo,
					CurrencyID,
					ExchangeRate,
					CreditObjectID,
					ObjectID,
					CreditAccountID,
					DebitAccountID,
					OriginalAmount,
					ConvertedAmount,
					VoucherDate,
					EmployeeID,
					CreateUserID,
					CreateDate,
					CurrencyIDCN,
					ExchangeRateCN,
					OriginalAmountCN,
					VDescription,
					BDescription,
					TDescription,
					ProductID,
					InheritTableID
				)
				SELECT 
					ROW_NUMBER() OVER(ORDER BY CT13.DivisionID, CT13.TranYear, CT13.TranMonth),
					NEWID(),
					DivisionID,
					@GVoucherID,
					NEWID(),
					NEWID(),
					'AT9000',
					TranMonth,
					TranYear,
					'T99',
					'PTH',
					@GVoucherNo,
					'VND',
					1.0,
					@GCreditObjectID,
					@GDebitObjectID,
					@GCreditAccountID,
					@GDebitAccountID,
					ROUND(SUM(CT13.ComAmount), ISNULL(@ExchangeRateDecimal, 0)),
					ROUND(SUM(CT13.ComAmount), ISNULL(@ExchangeRateDecimal, 0)),
					CONVERT(DATE, GETDATE()),
					@UserID,
					@UserID,
					GETDATE(),
					'VND',
					1,
					SUM(CT13.ComAmount),
					@GDescription,
					@GDescription,
					@GDescription,
					CT13.InventoryID,
					'CMT0013'
				FROM CMT0013 CT13 WITH (NOLOCK)
				WHERE CT13.DivisionID = @DivisionID
						AND CT13.TranYear = @TranYear
						AND CT13.TranMonth = @TranMonth
						AND ISNULL(CT13.IsRoyalty, 0) = 1
						AND CT13.SaleManID = @GMasterCompany
				GROUP BY CT13.DivisionID,
							CT13.TranYear,
							CT13.TranMonth,
							CT13.SaleManID,
							CT13.InventoryID,
							CT13.IsRoyalty

				--- Update kết quả tính với voucher id liên quan.
				UPDATE CT13
				SET GVoucherID = @GVoucherID
				FROM CMT0013 CT13
				WHERE CT13.DivisionID = @DivisionID
						AND CT13.TranYear = @TranYear
						AND CT13.TranMonth = @TranMonth
						AND ISNULL(CT13.IsRoyalty, 0) = 1
						AND CT13.SaleManID = @GMasterCompany

			END

			-- Other
			BEGIN
				
				-- Chứng từ tăng tự động.
				EXEC AP0000 @DivisionID, @GVoucherNo OUTPUT, 'AT9000' , 'PTH' , @TranYear, @TranMonth, 15, 3, 0, '-'
				SET @GMasterCompany = 'Other'

				SET @GDescription = N'Chi phí bản quyền cho công ty ' + @GMasterCompany + ' '  + CONVERT(VARCHAR(2), @TranMonth) + '/' + CONVERT(VARCHAR(4), @TranYear)

				SET @GCreditAccountID = '335100'
				SET @GDebitAccountID = '627880'
				SET @GCreditObjectID = 'JP0100010'
				SET	@GDebitObjectID = 'JP0100010'
				SET @GAna02ID = 'CP.00011'
				SET @GVoucherID = NEWID()

				INSERT INTO AT9000
				(
					Orders,
					APK,
					DivisionID,
					VoucherID,
					BatchID,
					TransactionID,
					TableID,
					TranMonth,
					TranYear,
					TransactionTypeID,
					VoucherTypeID,
					VoucherNo,
					CurrencyID,
					ExchangeRate,
					CreditObjectID,
					ObjectID,
					CreditAccountID,
					DebitAccountID,
					OriginalAmount,
					ConvertedAmount,
					VoucherDate,
					EmployeeID,
					CreateUserID,
					CreateDate,
					CurrencyIDCN,
					ExchangeRateCN,
					OriginalAmountCN,
					VDescription,
					BDescription,
					TDescription,
					ProductID,
					InheritTableID
				)
				SELECT 
					ROW_NUMBER() OVER(ORDER BY CT13.DivisionID, CT13.TranYear, CT13.TranMonth),
					NEWID(),
					DivisionID,
					@GVoucherID,
					NEWID(),
					NEWID(),
					'AT9000',
					TranMonth,
					TranYear,
					'T99',
					'PTH',
					@GVoucherNo,
					'VND',
					1.0,
					@GCreditObjectID,
					@GDebitObjectID,
					@GCreditAccountID,
					@GDebitAccountID,
					ROUND(SUM(CT13.ComAmount), ISNULL(@ExchangeRateDecimal, 0)),
					ROUND(SUM(CT13.ComAmount), ISNULL(@ExchangeRateDecimal, 0)),
					CONVERT(DATE, GETDATE()),
					@UserID,
					@UserID,
					GETDATE(),
					'VND',
					1,
					SUM(CT13.ComAmount),
					@GDescription,
					@GDescription,
					@GDescription,
					CT13.InventoryID,
					'CMT0013'
				FROM CMT0013 CT13 WITH (NOLOCK)
				WHERE CT13.DivisionID = @DivisionID
						AND CT13.TranYear = @TranYear
						AND CT13.TranMonth = @TranMonth
						AND ISNULL(CT13.IsRoyalty, 0) = 1
						AND CT13.SaleManID = @GMasterCompany
				GROUP BY CT13.DivisionID,
							CT13.TranYear,
							CT13.TranMonth,
							CT13.SaleManID,
							CT13.InventoryID,
							CT13.IsRoyalty

				--- Update kết quả tính với voucher id liên quan.
				UPDATE CT13
				SET GVoucherID = @GVoucherID
				FROM CMT0013 CT13
				WHERE CT13.DivisionID = @DivisionID
						AND CT13.TranYear = @TranYear
						AND CT13.TranMonth = @TranMonth
						AND ISNULL(CT13.IsRoyalty, 0) = 1
						AND CT13.SaleManID = @GMasterCompany

			END

		END

	END

	IF (@Mode = 2)
	BEGIN

		 -- Kiểm tra dữ liệu
		BEGIN

			-- Nếu Module T đóng kỳ kế toán. => thì không cho phép kết chuyển.
			IF (EXISTS(SELECT TOP 1 1
				FROM AT9999 WITH (NOLOCK)
				WHERE DivisionID = @DivisionID
					AND TranYear = @TranYear
					AND TranMonth = @TranMonth
					AND ISNULL(Closing, 0) = 1
				))
			BEGIN
				-- {0} đã khóa sổ. Bạn mở khóa sổ trước khi Sửa / Xóa
				INSERT INTO #Message_CMP0021 ([Status], MessageID, Param)
				SELECT 1
					, '00ML000051'
					, 'Phân hệ T'

				GOTO FINISH;
			END

			-- Kiểm tra đã kết chuyển tính tập hợp chi phí.
			
		END

		-- Xóa dữ liệu
		BEGIN

			-- Phí hoa hồng
			IF (@TransferType = 1)
			BEGIN
				
				SET @GVoucherID = (SELECT TOP 1 GVoucherID 
								FROM CMT0013 CT13 WITH (NOLOCK)
								WHERE DivisionID = @DivisionID
									AND TranYear = @TranYear
									AND TranMonth = @TranMonth
									AND ISNULL(IsRoyalty, 0) = 0
									)

				DELETE FROM AT9000 
				WHERE DivisionID = @DivisionID
						AND TranYear = @TranYear
						AND TranMonth = @TranMonth
						AND TransactionTypeID = 'T99'
						AND VoucherID = @GVoucherID

				--- Update kết quả tính với voucher id liên quan.
				UPDATE CT13
				SET GVoucherID = NULL
				FROM CMT0013 CT13
				WHERE CT13.DivisionID = @DivisionID
						AND CT13.TranYear = @TranYear
						AND CT13.TranMonth = @TranMonth
						AND ISNULL(CT13.IsRoyalty, 0) = 0
						AND CT13.GVoucherID = @GVoucherID
			END

			-- Phí bản quyền
			IF (@TransferType = 2)
			BEGIN

				-- 'EXD'
				BEGIN
					SET @GMasterCompany = 'EXD'
				
					SET @GVoucherID = (SELECT TOP 1 GVoucherID 
									FROM CMT0013 CT13 WITH (NOLOCK)
									WHERE DivisionID = @DivisionID
										AND TranYear = @TranYear
										AND TranMonth = @TranMonth
										AND SaleManID = @GMasterCompany
										AND ISNULL(IsRoyalty, 0) = 1
										)

					DELETE FROM AT9000 
					WHERE DivisionID = @DivisionID
							AND TranYear = @TranYear
							AND TranMonth = @TranMonth
							AND TransactionTypeID = 'T99'
							AND VoucherID = @GVoucherID

					--- Update kết quả tính với voucher id liên quan.
					UPDATE CT13
					SET GVoucherID = NULL
					FROM CMT0013 CT13
					WHERE CT13.DivisionID = @DivisionID
							AND CT13.TranYear = @TranYear
							AND CT13.TranMonth = @TranMonth
							AND ISNULL(CT13.IsRoyalty, 0) = 1
							AND SaleManID = @GMasterCompany
							AND CT13.GVoucherID = @GVoucherID
				END

				-- 'EFM'
				BEGIN
					SET @GMasterCompany = 'EFM'
				
					SET @GVoucherID = (SELECT TOP 1 GVoucherID 
									FROM CMT0013 CT13 WITH (NOLOCK)
									WHERE DivisionID = @DivisionID
										AND TranYear = @TranYear
										AND TranMonth = @TranMonth
										AND SaleManID = @GMasterCompany
										AND ISNULL(IsRoyalty, 0) = 1
										)

					DELETE FROM AT9000 
					WHERE DivisionID = @DivisionID
							AND TranYear = @TranYear
							AND TranMonth = @TranMonth
							AND TransactionTypeID = 'T99'
							AND VoucherID = @GVoucherID

					--- Update kết quả tính với voucher id liên quan.
					UPDATE CT13
					SET GVoucherID = NULL
					FROM CMT0013 CT13
					WHERE CT13.DivisionID = @DivisionID
							AND CT13.TranYear = @TranYear
							AND CT13.TranMonth = @TranMonth
							AND ISNULL(CT13.IsRoyalty, 0) = 1
							AND SaleManID = @GMasterCompany
							AND CT13.GVoucherID = @GVoucherID
				END

				-- 'EXDExchangeRate'
				BEGIN
					SET @GMasterCompany = 'EXDExchangeRate'
				
					SET @GVoucherID = (SELECT TOP 1 GVoucherID 
									FROM CMT0013 CT13 WITH (NOLOCK)
									WHERE DivisionID = @DivisionID
										AND TranYear = @TranYear
										AND TranMonth = @TranMonth
										AND SaleManID = @GMasterCompany
										AND ISNULL(IsRoyalty, 0) = 1
										)

					DELETE FROM AT9000 
					WHERE DivisionID = @DivisionID
							AND TranYear = @TranYear
							AND TranMonth = @TranMonth
							AND TransactionTypeID = 'T99'
							AND VoucherID = @GVoucherID

					--- Update kết quả tính với voucher id liên quan.
					UPDATE CT13
					SET GVoucherID = NULL
					FROM CMT0013 CT13
					WHERE CT13.DivisionID = @DivisionID
							AND CT13.TranYear = @TranYear
							AND CT13.TranMonth = @TranMonth
							AND ISNULL(CT13.IsRoyalty, 0) = 1
							AND SaleManID = @GMasterCompany
							AND CT13.GVoucherID = @GVoucherID
				END

				-- 'Other'
				BEGIN
					SET @GMasterCompany = 'Other'
				
					SET @GVoucherID = (SELECT TOP 1 GVoucherID 
									FROM CMT0013 CT13 WITH (NOLOCK)
									WHERE DivisionID = @DivisionID
										AND TranYear = @TranYear
										AND TranMonth = @TranMonth
										AND SaleManID = @GMasterCompany
										AND ISNULL(IsRoyalty, 0) = 1
										)

					DELETE FROM AT9000 
					WHERE DivisionID = @DivisionID
							AND TranYear = @TranYear
							AND TranMonth = @TranMonth
							AND TransactionTypeID = 'T99'
							AND VoucherID = @GVoucherID

					--- Update kết quả tính với voucher id liên quan.
					UPDATE CT13
					SET GVoucherID = NULL
					FROM CMT0013 CT13
					WHERE CT13.DivisionID = @DivisionID
							AND CT13.TranYear = @TranYear
							AND CT13.TranMonth = @TranMonth
							AND ISNULL(CT13.IsRoyalty, 0) = 1
							AND SaleManID = @GMasterCompany
							AND CT13.GVoucherID = @GVoucherID
				END

			END

		END

	END

	FINISH:
	SELECT * 
	FROM #Message_CMP0021

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO