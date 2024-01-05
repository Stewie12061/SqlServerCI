IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP1011]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP1011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Edit Form LMF1011 Cập nhật hợp đồng hạn mức
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 25/06/2017 by Bảo Anh
----Modify by Tiểu Mai on 28/09/2017: Bổ sung CreditTypeID, CreditTypeName
----Modify by Như Hàn on 09/01/2019: Bổ sung IsAppendixofcontract, ContractNo, RelatedToTypeID
----Modify by Đình Hoà on 14/09/2020: Fix lỗi load ngân hàng
-- <Example>
/*  
 EXEC LMP1011 N'AS',N'0f05ddbe-b723-435c-bec1-1c6dc013abbe',1,1,8
*/
----
CREATE PROCEDURE LMP1011 ( 
        @DivisionID NVARCHAR(50),
		@VoucherID NVARCHAR(50),
		@IsViewDetail TINYINT,	--- 0: màn hình edit, 1: màn hình view
		@PageNumber INT,
        @PageSize INT
) 
AS
   
DECLARE @sSQL NVARCHAR (MAX),
		@TotalRow NVARCHAR(50)

SET @TotalRow = N''
IF  @PageNumber = 1 SET @TotalRow = N'COUNT(*) OVER ()' ELSE SET @TotalRow = N'NULL'
  
SET @sSQL = N'   
SELECT		ROW_NUMBER() OVER (ORDER BY T11.Orders) AS RowNum, '+@TotalRow+' AS TotalRow,
			T10.DivisionID, T10.VoucherID, T10.VoucherTypeID, T10.VoucherNo, T10.VoucherDate, T10.FromDate, T10.ToDate,
			T10.BankID, T10.BankAccountID, T10.CurrencyID, T10.ExchangeRate, T10.OriginalLimitTotal, T10.ConvertedLimitTotal, T10.Description,
			T11.APK, T11.Orders, T11.CreditFormID, T11.OriginalLimitAmount, T11.ConvertedLimitAmount, T11.Notes,
			T01.CreditFormName, T16.BankName, T03.FullName as CreateUserName, T031.FullName as LastModifyUserName,
			T01.CreditTypeID, 
			CASE WHEN T01.CreditTypeID = 0 THEN N'''+N'Vay tín dụng'+''' ELSE CASE WHEN T01.CreditTypeID = 1 THEN N'''+N'Bảo lãnh'+''' ELSE N'''+N'Bảo lãnh L/C'+''' END END AS CreditTypeName,
			CASE WHEN ISNULL(T10.IsAppendixofcontract,0) = 1 THEN N'''+N'Là phụ lục hợp đồng'+''' ELSE '''' END AS IsAppenConCaption, 
			T10.ContractNo
			,T10.RelatedToTypeID
			,T04.CurrencyName
			,T10.CreateUserID
			,T10.CreateDate
			,T10.LastModifyUserID
			,T10.LastModifyDate
FROM		LMT1010 T10 WITH (NOLOCK)
LEFT JOIN	LMT1011 T11 WITH (NOLOCK) ON T10.DivisionID = T11.DivisionID And T10.VoucherID = T11.VoucherID
LEFT JOIN	LMT1001 T01 WITH (NOLOCK) ON T11.CreditFormID = T01.CreditFormID
LEFT JOIN 
	(Select Distinct AT1202.ObjectID as BankID, AT1202.ObjectName as BankName
	From AT1202 WITH (NOLOCK)
	Where AT1202.DivisionID in (''@@@'',''' + @DivisionID + ''') And AT1202.Disabled = 0) T16 ON T10.BankID = T16.BankID
LEFT JOIN	AT1103 T03 WITH (NOLOCK) ON T10.CreateUserID = T03.EmployeeID
LEFT JOIN	AT1103 T031 WITH (NOLOCK) ON T10.LastModifyUserID = T031.EmployeeID
LEFT JOIN	AT1004 T04 WITH (NOLOCK) ON T10.CurrencyID = T04.CurrencyID
WHERE		T10.DivisionID = ''' + @DivisionID + '''
AND			T10.VoucherID = ''' + @VoucherID + '''
ORDER BY T11.Orders'


IF @IsViewDetail = 1
BEGIN
	SET @sSQL = @sSQL+N'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END

--print @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

