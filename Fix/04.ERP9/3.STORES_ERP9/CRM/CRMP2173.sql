IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2173]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2173]
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
----Modified by: Hoài Bảo, Date 21/06/2022 - Cập nhật điều kiện kiểm tra theo ngày, theo kỳ
-- <Example>
/* 
EXEC CRMP2173 'NN','','','', 0, '2018-09-01', '2019-12-01', '11/2017'',''08/2017' ,'NV01',1,20
*/
----
CREATE PROCEDURE CRMP2173 ( 
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
		@Where NVARCHAR(MAX) ='',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
SET @Where = @Where + ' WHERE P50.StatusID = 6 AND P50.DeleteFlg = 0 AND P50.DivisionID = '''+ @DivisionID + ''''

IF ISNULL(@VoucherNo,'') <> ''
SET @Where = @Where + ' AND P50.VoucherNo = '''+ @VoucherNo + ''''

IF ISNULL(@MemberID,'') <> ''
SET @Where = @Where + ' AND P50.MemberID = '''+ @MemberID + ''''

IF @IsDate = 0
BEGIN
	--SET @Where = @Where + ' AND CONVERT(VARCHAR(10),P50.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
	BEGIN
		SET @Where = @Where + ' AND (P50.VoucherDate >= ''' + @FromDateText + ''')'
	END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
	BEGIN
		SET @Where = @Where + ' AND (P50.VoucherDate <= ''' + @ToDateText + ''')'
	END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
	BEGIN
		SET @Where = @Where + ' AND (P50.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
	END
END
	
IF @IsDate = 1 
	--SET @Where = @Where + ' AND (CASE WHEN Month(P50.VoucherDate) <10 THEN ''0''+rtrim(ltrim(str(Month(P50.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(P50.VoucherDate)))) 
	--		ELSE rtrim(ltrim(str(Month(P50.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(P50.VoucherDate)))) END) in ('''+@Period +''')'
	IF(ISNULL(@Period,'') != '')
		SET @Where = @Where + ' AND (SELECT FORMAT(P50.VoucherDate, ''MM/yyyy'')) IN ( ''' + @Period + ''') '

SET @SQL ='SELECT ROW_NUMBER() OVER (ORDER BY P50.MemberID) AS RowNum, count(*) OVER () AS TotalRow, P50.APK, P50.DivisionID, P50.VoucherNo , P50.VoucherDate , P50.MemberID ,P0011.MemberName, SUM(P51.Amount) - ISNULL(A.Amount,0) AS SumAmount,P50.ExportVoucherNo,P50.SerialNo,P50.WarrantyCard,P50.InventoryID,A302.InventoryName
FROM CRMT2170 P50 WITH (NOLOCK)
LEFT JOIN CRMT2171 P51 WITH (NOLOCK)  ON P51.APKMaster = P50.APK
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


PRINT (@SQL)
EXEC (@SQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
