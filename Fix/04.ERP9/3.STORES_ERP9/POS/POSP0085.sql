IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP0085]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP0085]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form POSF0085 Kế thừa phiếu yêu cầu dịch vụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga, Date 18/09/2019
-- <Example>
/* 
EXEC POSP0085 'NN','','','', 0, '2018-09-01', '2019-12-01', '11/2017'',''08/2017' ,'NV01',1,20
*/
----
CREATE PROCEDURE POSP0085 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@ShopID  NVARCHAR(250),--Biến môi trường
        @VoucherNo  NVARCHAR(250),
		@MemberID  NVARCHAR(250),
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT	
) 
AS 


DECLARE @SQL NVARCHAR(MAX) ='',
		@Where NVARCHAR(MAX) =''

SET @Where = @Where + ' WHERE P50.StatusID = 6 AND P50.DeleteFlg = 0 AND P50.DivisionID = '''+ @DivisionID + ''''

IF ISNULL(@VoucherNo,'') <> ''
SET @Where = @Where + ' AND P50.VoucherNo = '''+ @VoucherNo + ''''

IF ISNULL(@MemberID,'') <> ''
SET @Where = @Where + ' AND P50.MemberID = '''+ @MemberID + ''''

IF @IsDate = 0 
	SET @Where = @Where + ' AND CONVERT(VARCHAR(10),P50.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	
IF @IsDate = 1 
	SET @Where = @Where + ' AND (CASE WHEN Month(P50.VoucherDate) <10 THEN ''0''+rtrim(ltrim(str(Month(P50.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(P50.VoucherDate)))) 
			ELSE rtrim(ltrim(str(Month(P50.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(P50.VoucherDate)))) END) in ('''+@Period +''')'

SET @SQL ='SELECT ROW_NUMBER() OVER (ORDER BY P50.MemberID) AS RowNum, count(*) OVER () AS TotalRow, P50.APK, P50.DivisionID, P50.VoucherNo , P50.VoucherDate , P50.MemberID ,P0011.MemberName, SUM(P51.Amount) - ISNULL(A.Amount,0) AS SumAmount,P50.ExportVoucherNo,P50.SerialNo,P50.WarrantyCard,P50.InventoryID,A302.InventoryName
FROM POST2050 P50 WITH (NOLOCK)
LEFT JOIN POST2051 P51 WITH (NOLOCK)  ON P51.APKMaster = P50.APK
LEFT JOIN POST0011 P0011 WITH (NOLOCK) ON P50.MemberID = P0011.MemberID
LEFT JOIN dbo.AT1302 AS A302 ON A302.InventoryID = P50.InventoryID
LEFT JOIN (select APKMInherited , SUM(Amount) as Amount from POST00802 where APKMInherited is not null AND DeleteFlg = 0 group by APKMInherited ) A ON A.APKMInherited = P50.APK
'
+ @Where +
'
GROUP BY P50.APK, P50.DivisionID, P50.VoucherNo , P50.VoucherDate , P50.MemberID ,P0011.MemberName,P50.ExportVoucherNo,P50.SerialNo,P50.WarrantyCard,P50.InventoryID,A302.InventoryName,ISNULL(A.Amount,0)
HAVING   SUM(P51.Amount) - ISNULL(A.Amount,0) > 0
ORDER BY P50.MemberID
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

Exec(@SQL)

print @SQL




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
