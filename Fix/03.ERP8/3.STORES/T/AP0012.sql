IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0012]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Lay ty gia theo ngay
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 03/12/2003 by Nguyen Van Nhan
---- 
---- Modified on 19/09/2011 by Nguyen Binh Minh: Sửa quy tắc lấy tỷ giá
---- Modified on 08/01/2016 by Phương Thảo: Lấy tỷ giá Mua/ Bán theo TT200
---- Modified on 10/05/2017 by Bảo Thy: Sửa danh mục dùng chung
---- Modified on 08/08/2017 by Bảo Thy: bổ sung sửa danh mục dùng chung (AT1004)
---- Modified on 14/01/2019 by Kim Thư: Bổ sung WITH (NOLOCK) 
---- Modified on 19/07/2022 by Thành Sang: Bổ sung T.H Mode = 3 - Load chính xác tỷ giá thực tế của ngày được chọn
-- <Example>
---- 
CREATE PROCEDURE [dbo].[AP0012] 
(
    @DivisionID    AS NVARCHAR(50),
    @CurrencyID    NVARCHAR(50),
    @ExchangeDate  AS DATETIME,
	@BankID AS NVarchar(50) = '',
	@Mode AS Int = 0 -- 0: Tỷ giá thực tế, 1: Tỷ giá Mua, 2: Tỷ giá Bán, 3: Load đúng tỷ giá thực tế của @ExchangeDate
)
AS
DECLARE @ExchangeRate AS MONEY
		
-- Nguyên tắc lấy tỷ giá :
-- TH1: Nếu là nghiệp vụ khác 2 nghiệp vụ Mua/ Bán hàng thì lấy như sau: (lấy tỷ giá thực tế)
-- 	 + Nếu trong bảng tỷ giá có tỷ giá đúng ngày đó, thì lấy đúng ngày đó, nếu không có thì lấy ngày trước đó
--     -> để nhập tỷ giá từ ngày 20/1 -> 25/1, ngày 26/1 -> 31/1 chỉ cần nhập tỷ giá ngày 20/1 và nhập tỷ giá ngày 26/1
--   + Nếu trong bảng tỷ giá không có tỷ giá nào -> lấy tại bảng loại tiền
-- TH2: Nếu là nghiệp vụ Mua/Bán hàng thì lấy như sau: (lấy tỷ giá Mua/Bán)
--	+ Nếu có chọn Ngân hàng thì lấy trong bảng tỷ giá dòng dữ liệu của đúng loại tiền, ngân hàng và ngày hóa đơn (hoặc ngày trước đó gần nhất).
--	+ Nếu không chọn Ngân hàng/ Ngân hàng đã chọn không có dữ liệu tỷ giá thì lấy trong bảng tỷ giá dòng dữ liệu của đúng loại tiền, ngân hàng và ngày hóa đơn (hoặc ngày trước đó gần nhất) của NH mặc định. Nếu không 
---------- có dòng nào thì tìm tỷ giá thực tế (như TH1)

IF (@Mode = 0)
BEGIN 
	SELECT		TOP 1 @ExchangeRate = ExchangeRate
	FROM		AT1012 WITH (NOLOCK) 
	WHERE		CurrencyID = @CurrencyID
				AND DATEDIFF(dd, ExchangeDate, @ExchangeDate) >= 0
				AND DivisionID = @DivisionID
	ORDER BY	DATEDIFF(dd, ExchangeDate, @ExchangeDate)

	SET @ExchangeRate = COALESCE(@ExchangeRate, (SELECT ExchangeRate FROM AT1004 WITH (NOLOCK)  WHERE CurrencyID = @CurrencyID AND DivisionID IN (@DivisionID,'@@@')), 0)
	
END

IF (@Mode = 3)
BEGIN 
	SELECT		TOP 1 @ExchangeRate = ExchangeRate
	FROM		AT1012 WITH (NOLOCK) 
	WHERE		CurrencyID = @CurrencyID
				AND DATEDIFF(dd, ExchangeDate, @ExchangeDate) = 0
				AND DivisionID = @DivisionID
	ORDER BY	DATEDIFF(dd, ExchangeDate, @ExchangeDate)

	SET @ExchangeRate = COALESCE(@ExchangeRate, 0)
	
END

ELSE
BEGIN
	 IF EXISTS (SELECT TOP 1 1 FROM  AT1012 WITH(NOLOCK) WHERE	CurrencyID = @CurrencyID AND DATEDIFF(dd, ExchangeDate, @ExchangeDate) >= 0 AND BankID = @BankID) AND @BankID <> ''
	 BEGIN
	 
			SELECT		TOP 1 @ExchangeRate = CASE WHEN @Mode = 1 THEN BuyingExchangeRate ELSE SellingExchangeRate END
			FROM		AT1012 WITH (NOLOCK) 
			WHERE		CurrencyID = @CurrencyID
						AND DATEDIFF(dd, ExchangeDate, @ExchangeDate) >= 0
						AND DivisionID = @DivisionID
						AND BankID = @BankID
			ORDER BY	DATEDIFF(dd, ExchangeDate, @ExchangeDate)
			
			--SELECT @ExchangeRate
	END
	ELSE
	IF EXISTS (SELECT TOP 1 1 FROM  AT1012 WITH(NOLOCK) WHERE	CurrencyID = @CurrencyID AND DATEDIFF(dd, ExchangeDate, @ExchangeDate) >= 0 AND IsDefault = 1) AND @BankID = ''
	BEGIN
	
			SELECT		TOP 1 @ExchangeRate = CASE WHEN @Mode = 1 THEN BuyingExchangeRate ELSE SellingExchangeRate END
			FROM		AT1012 WITH (NOLOCK) 
			WHERE		CurrencyID = @CurrencyID
						AND DATEDIFF(dd, ExchangeDate, @ExchangeDate) >= 0
						AND DivisionID = @DivisionID
						AND IsDefault = 1
			ORDER BY	DATEDIFF(dd, ExchangeDate, @ExchangeDate)

			--SELECT @ExchangeRate
	END
	ELSE
	BEGIN
	
		SELECT		TOP 1 @ExchangeRate = ExchangeRate
		FROM		AT1012 WITH (NOLOCK) 
		WHERE		CurrencyID = @CurrencyID
					AND DATEDIFF(dd, ExchangeDate, @ExchangeDate) >= 0
					AND DivisionID = @DivisionID
		ORDER BY	DATEDIFF(dd, ExchangeDate, @ExchangeDate)

		SET @ExchangeRate = COALESCE(@ExchangeRate, (SELECT ExchangeRate FROM AT1004 WITH (NOLOCK)  WHERE CurrencyID = @CurrencyID AND DivisionID IN (@DivisionID,'@@@')), 0)
	
	END


END
SELECT @ExchangeRate AS ExchangeRate


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

