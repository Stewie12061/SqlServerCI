IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP3004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP3004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo theo dõi lãi vay
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thành Luân on 24/02/2020
----Modify by: Kiều Nga on 08/10/2020: Fix lỗi lấy sai dữ liệu phải trả
-- <Example> EXEC LMP3004 @DivisionID = 'CM', @DivisionIDList = NULL, @IsDate = 1, @FromDate = '2020-01-01', @ToDate = '2020-04-01', @PeriodIDList = NULL, @BankID = NULL, @UserID = NULL

CREATE PROCEDURE LMP3004 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@BankID				NVARCHAR(MAX),
	@UserID				VARCHAR(50)
)
AS
BEGIN
	
	DECLARE @Sql NVARCHAR(MAX) = '';
	DECLARE @SqlWhere NVARCHAR(MAX) = '';

	IF COALESCE(@DivisionIDList, '') != ''
	BEGIN
		SET @SqlWHERE = @SqlWhere + ' AND L2001.DivisionID IN (''' + @DivisionIDList +''')';
	END
	ELSE
	BEGIN
		SET @SqlWHERE = @SqlWhere + ' AND L2001.DivisionID =  N'''+@DivisionID+'''';
	END

	IF @IsDate = 1
	BEGIN
		SET @SqlWhere = @SqlWhere + ' AND CONVERT(VARCHAR, L2001.VoucherDate, 112) BETWEEN ''' + CONVERT(VARCHAR, @FromDate,112)+''' AND ''' + CONVERT(VARCHAR, @ToDate,112) + ''''
	END
	ELSE
	BEGIN
		SET @SqlWhere = @SqlWhere + ' AND (CASE WHEN L2001.TranMonth < 10 then ''0''+rtrim(ltrim(str(L2001.TranMonth)))+''/''+ltrim(Rtrim(str(L2001.TranYear))) 
											ELSE rtrim(ltrim(str(L2001.TranMonth)))+''/''+ltrim(Rtrim(str(L2001.TranYear))) End) IN ('''+@PeriodIDList+''')'
	END

	SET @Sql = @Sql + '
		DECLARE @Result TABLE (
			CreditFormID NVARCHAR(50),
			CreditFormName NVARCHAR(250),
			BankAccountID NVARCHAR(50),
			BankName NVARCHAR(250),
			DivisionID NVARCHAR(50),
			SumPay DECIMAL(28, 8),
			SumPaid DECIMAL(28, 8),
			RemainPay DECIMAL(28, 8)
		);

		INSERT INTO @Result
		SELECT L1001.CreditFormID, L1001.CreditFormName,
			A1016.BankAccountID, A1016.BankName,
			L2001.DivisionID,
			SUM(L2021.OriginalAmount) AS SumPay,
			SUM(P.ActualOriginalAmount) AS SumPaid,
			(SUM(L2021.OriginalAmount) - SUM(P.ActualOriginalAmount)) AS RemainPay
		FROM LMT1001 AS L1001
		 INNER JOIN LMT2001 AS L2001 ON (L1001.DivisionID = L2001.DivisionID OR L1001.DivisionID = ''@@@'')
									AND L1001.CreditFormID = L2001.CreditFormID
		 INNER JOIN LMT2021 AS L2021 ON L2001.DivisionID = L2021.DivisionID AND L2001.VoucherID = L2021.CreditVoucherID
		 --INNER JOIN LMT2031 AS L2031 ON L2001.DivisionID = L2031.DivisionID AND L2001.VoucherID = L2031.CreditVoucherID
		 LEFT JOIN (SELECT DisburseVoucherID,SUM(ActualOriginalAmount) as ActualOriginalAmount from LMT2031
					GROUP BY DisburseVoucherID) as P ON P.DisburseVoucherID = L2021.VoucherID
		 LEFT JOIN AT1016 AS A1016 ON L2001.DivisionID = A1016.DivisionID AND L2001.BankAccountID = A1016.BankAccountID
		WHERE (L1001.Disabled = 0 OR L1001.Disabled IS NULL) ' + @SqlWhere + '
		GROUP BY L1001.CreditFormID, L1001.CreditFormName, A1016.BankAccountID, A1016.BankName, L2001.DivisionID
		ORDER BY L1001.CreditFormID, L1001.CreditFormName
		
		SELECT A1101.DivisionID, A1101.DivisionName, A1101.Tel, A1101.Fax, A1101.Address
		FROM (SELECT DISTINCT DivisionID FROM @Result) AS Result
		LEFT JOIN AT1101 AS A1101 ON Result.DivisionID = A1101.DivisionID;
		
		SELECT * FROM @Result';

	EXEC(@Sql)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO