IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2031]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Edit Form LMF2031 Cập nhật chứng từ thanh toán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 15/07/2017 by Bảo Anh
----Modify on 26/04/2019 by Như Hàn: Bổ sung nguồn thanh toán
----Modify on
-- <Example>
/*  
 EXEC LMP2031 'AS','ABCD',0,1,8,0
*/
----
CREATE PROCEDURE LMP2031 ( 
        @DivisionID VARCHAR(50),
		@VoucherID VARCHAR(50),
		@IsViewDetail TINYINT,	--- 0: màn hình edit, 1: màn hình view
		@PageNumber INT,
        @PageSize INT,
		@Mode INT	-- 0: Master, 1: Detail
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@TotalRow VARCHAR(50),
		@CostAnaTypeID varchar(50)
 
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
  
SELECT @CostAnaTypeID = ISNULL(CostAnaTypeID,'') FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID 
 
IF(@Mode = 0)   
BEGIN 
	SET @sSQL = N'
		SELECT 	DISTINCT 
				T31.DivisionID, T31.VoucherID,  T31.VoucherTypeID, T31.VoucherNo, T31.VoucherDate,
				T31.TranMonth, T31.TranYear, T31.BankAccountID, T31.CreditVoucherID, T31.DisburseVoucherID,
				T31.CurrencyID, T31.ExchangeRate, T31.AfterRatePercent, T31.Description,
				T21.VoucherNo as DisburseVoucherNo, T01.VoucherNo as CreditVoucherNo,
				A11.AnaName as CostTypeName, T99.Description as PaymentTypeName
				,T31.CreateUserID
				,T31.CreateDate
				,T31.LastModifyUserID
				,T31.LastModifyDate
		FROM LMT2031 T31 WITH (NOLOCK)
		LEFT JOIN LMT2021 T21 WITH (NOLOCK) ON T31.DivisionID = T21.DivisionID And T31.DisburseVoucherID = T21.VoucherID
		LEFT JOIN LMT2001 T01 WITH (NOLOCK) ON T01.DivisionID = T31.DivisionID And T01.VoucherID = T31.CreditVoucherID
		LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T31.CostTypeID = A11.AnaID And A11.AnaTypeID = ''' + @CostAnaTypeID + '''
		LEFT JOIN LMT0099 T99 WITH (NOLOCK) ON T31.PaymentType = T99.OrderNo And T99.CodeMaster = ''LMT00000010''
		WHERE T31.DivisionID = ''' + @DivisionID + ''' And T31.VoucherID = ''' + @VoucherID + '''
		'
END
ELSE
BEGIN
	SET @sSQL = N'
		SELECT 	'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY T31.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
				T31.*, T21.VoucherNo as DisburseVoucherNo, T01.VoucherNo as CreditVoucherNo,
				A11.AnaName as CostTypeName, T99.Description as PaymentTypeName, T30.Descriptions PaymentSourceName
		FROM LMT2031 T31 WITH (NOLOCK)
		LEFT JOIN LMT2021 T21 WITH (NOLOCK) ON T31.DivisionID = T21.DivisionID And T31.DisburseVoucherID = T21.VoucherID
		LEFT JOIN LMT2001 T01 WITH (NOLOCK) ON T01.DivisionID = T31.DivisionID And T01.VoucherID = T31.CreditVoucherID
		LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T31.CostTypeID = A11.AnaID And A11.AnaTypeID = ''' + @CostAnaTypeID + '''
		LEFT JOIN LMT0099 T99 WITH (NOLOCK) ON T31.PaymentType = T99.OrderNo And T99.CodeMaster = ''LMT00000010''
		LEFT JOIN LMT1030 T30 WITH (NOLOCK) ON  T31.Paymentsource = T30.Paymentsource
		WHERE T31.DivisionID = ''' + @DivisionID + ''' And T31.VoucherID = ''' + @VoucherID + '''
		ORDER BY T31.Orders'

	IF @IsViewDetail = 1
	BEGIN
		SET @sSQL = @sSQL+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
END
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

