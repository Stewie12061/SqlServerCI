IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP3006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LMP3006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo tình hình vay vốn theo hợp đồng khế ước
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thành Luân on 27/04/2020
----Modify by:  Kiều Nga on 01/09/2020: load dữ liệu theo giải ngân
-- <Example> EXEC LMP3006 @DivisionID = 'CM', @DivisionIDList = NULL, @IsDate = 1, @FromDate = '2020-01-01', @ToDate = '2020-04-01', @PeriodIDList = NULL, @BankID = NULL, @UserID = NULL

CREATE PROCEDURE LMP3006
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@IsDate				TINYINT, --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME,
	@ToDate				DATETIME,
	@PeriodIDList		NVARCHAR(2000),
	@UserID				VARCHAR(50),
	@Contracts			NVARCHAR(MAX)
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

	IF COALESCE(@Contracts, '') != ''
	BEGIN
		SET @SqlWHERE = @SqlWhere + ' AND L2001.VoucherNo IN (''' + @Contracts +''')';
	END

	SET @Sql = @Sql + '
		DECLARE @Result TABLE (
			CreditFormID NVARCHAR(50),
			CreditFormName NVARCHAR(250),
			DivisionID NVARCHAR(50),
			DivisionName NVARCHAR(250),
			VoucherNo NVARCHAR(50),
			VoucherDate DATETIME,
			FromDate DATETIME,
			ToDate DATETIME,
			RatePercent DECIMAL(28, 8),
			ValueAmount DECIMAL(28, 8),
			ConvertedAmount DECIMAL(28, 8),
			RemainAmount DECIMAL(28, 8)
		);

		INSERT INTO @Result
		SELECT L1001.CreditFormID, 
			L1001.CreditFormName,
			L2001.DivisionID,
			A1101.DivisionName,
			L2021.VoucherNo,
			L2021.VoucherDate,
			L2021.FromDate,
			L2021.ToDate,
			L2021.RatePercent,
			L2021.ConvertedAmount AS ValueAmount,
			L2001.ConvertedAmount AS ConvertedAmount,
			(L2001.ConvertedAmount - L2021.ConvertedAmount) AS RemainAmount
		FROM LMT1001 AS L1001
		 INNER JOIN LMT2001 AS L2001 ON (L1001.DivisionID = L2001.DivisionID OR L1001.DivisionID = ''@@@'')
									AND L1001.CreditFormID = L2001.CreditFormID
		 INNER JOIN LMT2021 AS L2021 ON L2001.DivisionID = L2021.DivisionID AND L2001.VoucherID = L2021.CreditVoucherID
		 LEFT JOIN LMT2031 AS L2031 ON L2001.DivisionID = L2031.DivisionID AND L2001.VoucherID = L2031.CreditVoucherID
		 LEFT JOIN AT1101 AS A1101 ON L2001.DivisionID = A1101.DivisionID
		 --LEFT JOIN AT1016 AS A1016 ON L2001.DivisionID = A1016.DivisionID AND L2001.BankAccountID = A1016.BankAccountID
		WHERE (L1001.Disabled = 0 OR L1001.Disabled IS NULL) ' + @SqlWhere + '		
		ORDER BY L1001.CreditFormID, L1001.CreditFormName
		
		SELECT * FROM @Result

		SELECT A1101.DivisionID, A1101.DivisionName, A1101.Tel, A1101.Fax, A1101.Address
		FROM (SELECT DISTINCT DivisionID FROM @Result) AS Result
		LEFT JOIN AT1101 AS A1101 ON Result.DivisionID = A1101.DivisionID;';

	EXEC(@Sql)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
