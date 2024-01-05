IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Thay đổi tỷ giá mới nhất theo loại tiền
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Trọng Kiên	Create on: 07/07/2020
---- Update by: Tấn Thành Update on: 27/07/2020: Thay đổi cách lấy tỷ giá module BEM => Xét tỷ giá lần lượt theo Ngày - Kỳ (AT1012), Nếu không có thì lấy tỷ giá bên CI (AT1004)


Create PROCEDURE [dbo].[BEMP2017]
(
    @DivisionID VARCHAR(50)
)
AS

--SET @sSQL = '
--        -- Lấy ra loại tiền được update mới nhất từ bảng AT1012 cho vào bảng tạm #tempBEMT2017
--            SELECT A1.CurrencyID, MAX(ExchangeDate) AS ExchangeDate
--            INTO #tempBEMT2017
--            FROM AT1012 A1
--            WHERE A1.DivisionID IN ('''+ @DivisionID + ''',''@@@'')
--            GROUP BY A1.CurrencyID
--            ORDER BY   DESC

--            -- Dựa vào loại tiền và ngày mới nhất từ bảng #tempBEMT2017, tiếp tục JOIN với chính bảng AT1012 để lấy ra thêm Tỷ giá tương ứng cho vào bảng tạm #tempBEMT20171
--            SELECT A2.CurrencyID, A2.ExchangeRate, A2.ExchangeDate
--            INTO #tempBEMT20171
--            FROM AT1012 A2
--                INNER JOIN #tempBEMT2017 B1 ON B1.CurrencyID = A2.CurrencyID AND B1.ExchangeDate = A2.ExchangeDate
--            WHERE A2.DivisionID IN ('''+ @DivisionID + ''',''@@@'')

--            -- Cuối cùng JOIN #tempBEMT20171 với bảng AT1004 để cập nhật lại Tỷ giá mới nhất 
--            SELECT A3.CurrencyID, A3.CurrencyName, ISNULL(B2.ExchangeRate, A3.ExchangeRate) AS ExchangeRate
--            FROM AT1004 A3
--                LEFT JOIN #tempBEMT20171 B2 ON B2.CurrencyID = A3.CurrencyID AND A3.LastModifyDate < B2.ExchangeDate
--            WHERE A3.[Disabled] = 0 AND A3.DivisionID IN ('''+ @DivisionID + ''',''@@@'') '


--EXEC (@sSQL)
--PRINT (@sSQL)

DECLARE @CUR CURSOR,
		@APK_CUR VARCHAR(50),
		@CurrencyID_CUR VARCHAR(50),
		@CurrencyName_CUR NVARCHAR(200),
		@ExchangeRate_CUR DECIMAL(28,8),
		@DivisionID_CUR VARCHAR(50)
DECLARE @TableTemp AS Table (
	CurrencyID VARCHAR(50),
	CurrencyName NVARCHAR(200),
	ExchangeRate DECIMAL(28,8)
)
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT
	A1.CurrencyID, A1.CurrencyName, A1.ExchangeRate, A1.DivisionID
FROM AT1004 A1 WITH(NOLOCK) 
WHERE A1.DivisionID = @DivisionID AND ISNULL(A1.[Disabled],0) = 0
OPEN @CUR
	FETCH NEXT FROM @CUR INTO @CurrencyID_CUR, @CurrencyName_CUR, @ExchangeRate_CUR, @DivisionID_CUR
	WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @ExchangeRate DECIMAL(28,8) = NULL
			IF(EXISTS (
				SELECT TOP 1 1 
				FROM AT1012 A WITH (NOLOCK)
				WHERE A.DivisionID = @DivisionID_CUR AND A.CurrencyID = @CurrencyID_CUR AND FORMAT(ExchangeDate,'yyyy-MM-dd 00:00:00:000') = FORMAT(GETDATE(),'yyyy-MM-dd 00:00:00:000'))) 
				BEGIN
				-- Trường hợp ngày cập nhật tỷ giá bảng AT1012 bằng với ngày hiện tại, thì lấy tỷ giá theo ngày bảng AT1012
					SELECT TOP 1 @ExchangeRate = ExchangeRate 
					FROM AT1012 A WITH (NOLOCK)
					WHERE A.DivisionID = @DivisionID_CUR AND A.CurrencyID = @CurrencyID_CUR  AND DAY(A.ExchangeDate) = DAY(GETDATE()) AND MONTH(A.ExchangeDate) = MONTH(GETDATE()) AND YEAR(A.ExchangeDate) = YEAR(GETDATE())
					-- PRINT('Lấy theo đúng ngày AT1012')
					INSERT INTO @TableTemp (CurrencyID, CurrencyName, ExchangeRate) VALUES (@CurrencyID_CUR, @CurrencyName_CUR, @ExchangeRate)
				END
			ELSE IF (EXISTS(
				SELECT TOP 1 1 
				FROM AT1012 A WITH (NOLOCK)
				WHERE A.DivisionID = @DivisionID_CUR AND A.CurrencyID = @CurrencyID_CUR  AND A.TranMonth = MONTH(GETDATE()) AND A.TranYear = YEAR(GETDATE()))) 
					BEGIN
						-- Trường hợp Kỳ (Tháng & Năm) của bảng AT1012 bằng với Tháng & Năm của ngày hiện tại thì lấy tỷ giá theo kỳ AT1012

						SELECT TOP 1 @ExchangeRate = ExchangeRate 
							FROM AT1012 A WITH (NOLOCK)
						WHERE A.DivisionID = @DivisionID_CUR AND A.CurrencyID = @CurrencyID_CUR  AND A.TranMonth = MONTH(GETDATE()) AND A.TranYear = YEAR(GETDATE())
						ORDER BY ExchangeDate DESC
						-- PRINT('Lấy theo đúng kỳ AT1012')
						INSERT INTO @TableTemp (CurrencyID, CurrencyName, ExchangeRate) VALUES (@CurrencyID_CUR, @CurrencyName_CUR, @ExchangeRate)
					END
			ELSE 
				BEGIN
				-- Trường hợp Ngày, Kỳ bảng AT1012 không trùng với ngày hiện tại thì lấy tỷ giá theo CI (AT1004)
					SELECT  @ExchangeRate = ExchangeRate 
					FROM AT1004 A WITH (NOLOCK)
					WHERE A.DivisionID = @DivisionID_CUR AND A.CurrencyID = @CurrencyID_CUR
					-- PRINT('Lấy theo CI')
					INSERT INTO @TableTemp (CurrencyID, CurrencyName, ExchangeRate) VALUES (@CurrencyID_CUR, @CurrencyName_CUR, @ExchangeRate) 
				END
			FETCH NEXT FROM @CUR INTO  @CurrencyID_CUR, @CurrencyName_CUR, @ExchangeRate_CUR, @DivisionID_CUR
		END
CLOSE @CUR
SELECT *FROM  @TableTemp





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO