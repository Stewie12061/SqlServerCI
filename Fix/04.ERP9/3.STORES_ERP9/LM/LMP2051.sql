IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2051]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Edit Form LMF2052 Cập nhật hợp đồng bảo lãnh (Tab Phí)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Tiểu Mai on 10/10/2017:
----Modify on 29/01/2019 by Như Hàn: Bổ sung số lần gia hạn, load TK ngân hàng
-- <Example>
/*  
 EXEC LMP2051 'AS','ABCD',1,0,1,8
 EXEC LMP2051 'AS','ABCD',1,1,1,8
 EXEC LMP2051 'AS','ABCD',1,2,1,8
*/
---- LMT2051
CREATE PROCEDURE LMP2051 ( 
        @DivisionID NVARCHAR(50),
		@VoucherID NVARCHAR(50),
		@IsViewDetail TINYINT,	--- 0: màn hình edit, 1: màn hình view
		@Type TINYINT,			--- 0: Load master và Thông tin bổ sung, 1: Detail(Phí), 2: Detai(HĐ vay)
		@PageNumber INT,
        @PageSize INT		
) 
AS

DECLARE @ProjectAnaTypeID varchar(50),
		@ContractAnaTypeID varchar(50),
		@CostAnaTypeID varchar(50),
		@sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sSQL2 NVARCHAR (MAX),
		@TotalRow VARCHAR(50)

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SELECT	@ProjectAnaTypeID = ISNULL(ProjectAnaTypeID,''),
		@ContractAnaTypeID = ISNULL(ContractAnaTypeID,''),
		@CostAnaTypeID = ISNULL(CostAnaTypeID,'')
FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID

IF @Type = 0
	BEGIN
		SET @sSQL = '
		SELECT		T02.*, L11.VoucherNo as LimitVoucherNo, L01.CreditFormName, A02.BankName as BankName, A02.BankAccountNo , A03.AnaName as ProjectName, A04.AnaName as PurchaseContractName,
					A06.ObjectName, L99.Description as StatusName, L11.OriginalLimitTotal AS InheritLimitOAmount, L11.FromDate AS InheritLimitFromDate, L11.ToDate AS InheritLimitToDate
					, 0 As NumberRenewals, T04.CurrencyName
		FROM		LMT2051 T02 WITH (NOLOCK)
		LEFT JOIN	LMT1010 L11 WITH (NOLOCK) ON T02.DivisionID  = L11.DivisionID AND T02.LimitVoucherID = L11.VoucherID
		LEFT JOIN	LMT1001 L01 WITH (NOLOCK) ON T02.CreditFormID = L01.CreditFormID
		LEFT JOIN	AT1016 A02 WITH (NOLOCK) ON A02.BankID  = T02.BankID AND A02.BankAccountID  = T02.BankAccountID
		LEFT JOIN	AT1011 A03 WITH (NOLOCK) ON A03.AnaID = T02.ProjectID AND A03.AnaTypeID = (Select ProjectAnaTypeID From AT0000 WITH (NOLOCK) Where DefDivisionID = '''+@DivisionID+''')
		LEFT JOIN	AT1011 A04 WITH (NOLOCK) ON A04.AnaID = T02.PurchaseContractID AND A04.AnaTypeID = (Select ContractAnaTypeID From AT0000 WITH (NOLOCK) Where DefDivisionID = '''+@DivisionID+''')
		LEFT JOIN	AT1020 A05 WITH (NOLOCK) ON A04.AnaID = A05.ContractNo 
		LEFT JOIN	AT1202 A06 WITH (NOLOCK) ON A05.ObjectID = A06.ObjectID
		LEFT JOIN	LMT0099 L99 WITH (NOLOCK) ON L99.OrderNo = T02.Status AND CodeMaster = ''LMT00000021''
		LEFT JOIN	AT1004 T04 WITH (NOLOCK) ON T02.CurrencyID = T04.CurrencyID
		WHERE		T02.DivisionID = ''' + @DivisionID + '''
		AND	T02.VoucherID = ''' + @VoucherID + ''''		
	END
ELSE IF @Type = 1
	BEGIN
		IF(@IsViewDetail = 1)
		BEGIN
			SET @sSQL1 = N'
			SELECT		ROW_NUMBER() OVER (ORDER BY T02.Orders) AS RowNum, '+@TotalRow+N' AS TotalRow,
						T02.*, A01.AnaName as CostTypeName, Case when CostID = 0 then N''Phí bảo lãnh'' else N''Phí khác'' end AS CostDescription
			FROM		LMT2052 T02 WITH (NOLOCK)
			LEFT JOIN	AT1011 A01 WITH (NOLOCK) ON T02.CostTypeID = A01.AnaID And A01.AnaTypeID = ''' + @CostAnaTypeID + '''
			WHERE		T02.DivisionID = ''' + @DivisionID + '''
			AND	T02.VoucherID = ''' + @VoucherID + '''
			ORDER BY	T02.Orders'	
		END
		ELSE
		BEGIN
			SET @sSQL1 = N'			SELECT		
						T02.*, A01.AnaName as CostTypeName, Case when CostID = 0 then N''Phí bảo lãnh'' else N''Phí khác'' end AS CostDescription
			FROM		LMT2052 T02 WITH (NOLOCK)
			LEFT JOIN	AT1011 A01 WITH (NOLOCK) ON T02.CostTypeID = A01.AnaID And A01.AnaTypeID = ''' + @CostAnaTypeID + '''
			WHERE		T02.DivisionID = ''' + @DivisionID + '''
			AND	T02.VoucherID = ''' + @VoucherID + '''
			ORDER BY	T02.Orders'	
		END
	END
ELSE IF @Type = 2
	BEGIN
		IF(@IsViewDetail = 1)
		BEGIN
			SET @sSQL2 = '
			SELECT ROW_NUMBER() OVER (ORDER BY T21.VoucherNo) AS RowNum, '+@TotalRow+N' AS TotalRow,
				T21.VoucherNo AS ContractNo, 
				T53.OriginalAmount, T53.ConvertedAmount,
				T21.OriginalAmount -ISNULL(T51.OriginalAmount,0) AS LimitAmount,  T21.ConvertedAmount -ISNULL(T51.ConvertedAmount,0) AS LimitCAmount
			FROM LMT2053 T53 WITH (NOLOCK)
			INNER JOIN LMT2001 T21 WITH (NOLOCK) ON T53.ContractID = T21.VoucherID AND T53.DivisionID = T21.DivisionID
			LEFT JOIN 
			(SELECT T1.ContractID, SUM(ISNULL(T1.OriginalAmount,0)) AS OriginalAmount, SUM(ISNULL(T1.ConvertedAmount,0)) AS ConvertedAmount 
			FROM LMT2053 T1 WITH (NOLOCK)			
			WHERE T1.VoucherID <> '''+@VoucherID+'''
			GROUP BY T1.ContractID ) T51 ON T21.VoucherID = T51.ContractID
			WHERE T21.DivisionID = ''' + @DivisionID + ''' AND  T53.VoucherID = '''+@VoucherID+'''
			ORDER BY T21.VoucherNo
			'		
		END
		ELSE
		BEGIN
			SET @sSQL2 = '
			SELECT	T21.VoucherNo AS ContractNo, 
					T53.OriginalAmount, T53.ConvertedAmount, T21.OriginalAmount -ISNULL(T51.OriginalAmount,0) AS LimitAmount,  
					T21.ConvertedAmount -ISNULL(T51.ConvertedAmount,0) AS LimitCAmount
			FROM LMT2053 T53  WITH (NOLOCK)
			INNER JOIN LMT2001 T21 WITH (NOLOCK) ON T53.ContractID = T21.VoucherID AND T53.DivisionID = T21.DivisionID
			LEFT JOIN 
			(SELECT T1.ContractID, SUM(ISNULL(T1.OriginalAmount,0)) AS OriginalAmount, SUM(ISNULL(T1.ConvertedAmount,0)) AS ConvertedAmount 
			FROM LMT2053 T1 WITH (NOLOCK)			
			WHERE T1.VoucherID <> '''+@VoucherID+'''
			GROUP BY T1.ContractID ) T51 ON T21.VoucherID = T51.ContractID
			WHERE T21.DivisionID = ''' + @DivisionID + ''' AND  T53.VoucherID = '''+@VoucherID+'''
			ORDER BY T21.VoucherNo'		
		END
	END
ELSE IF @Type = 3
	BEGIN
	SET @sSQL1 = '
		SELECT	'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY T51.VoucherDate) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
		T51.VoucherID, T51.VoucherNo, T52.VoucherNo As VoucherNoEdit, T51.VoucherDate, T51.ConvertedAmount, T51.FromDate, T51.ToDate, 
		T51.Description, T04.CurrencyName
		FROM LMT2051 T51 WITH (NOLOCK)
		INNER JOIN LMT2051 T52 WITH (NOLOCK) ON T51.VoucherID = T52.OldGuaranteeVoucherID AND T52.IsType = 1
		LEFT JOIN	AT1004 T04 WITH (NOLOCK) ON T51.CurrencyID = T04.CurrencyID
		WHERE T51.IsType = 2 AND T51.DivisionID = ''' + @DivisionID + ''' AND T51.NewGuaranteeVoucherID = '''+@VoucherID+''' 
		ORDER BY T51.VoucherDate '
		
	END

IF @IsViewDetail = 1
BEGIN
	SET @sSQL1 = @sSQL1+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2

EXEC (@sSQL)
EXEC (@sSQL1)
EXEC (@sSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

