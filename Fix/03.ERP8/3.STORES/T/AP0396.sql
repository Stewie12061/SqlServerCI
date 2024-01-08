IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0396]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0396]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load thông tin màn hình Chọn dữ liệu dịch vụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 20/09/2019 by Kiều Nga 
--- exec AP0396 @DivisionID=N'NN',@UserID=N'ASOFTADMIN',@VoucherDate='2019-09-20 00:00:00',@ShopID=N'CH01',@VoucherTypeID=N'',@VoucherNo=N''
-- <Example>
---- 
CREATE PROCEDURE AP0396
( 
		@DivisionID AS NVARCHAR(50),
		@UserID AS NVARCHAR(50),
		@VoucherDate AS DATETIME,
		@ShopID AS NVARCHAR(50),
		@VoucherTypeID AS NVARCHAR(50),
		@VoucherNo AS NVARCHAR(50)
) 
AS 

DECLARE @SQL NVARCHAR(MAX) ='',
		@Where NVARCHAR(MAX) =''

SET @Where = @Where + ' WHERE P50.StatusID = 6 AND P50.DeleteFlg = 0 AND P50.DivisionID = '''+ @DivisionID + ''''

IF ISNULL(@VoucherNo,'') <> ''
SET @Where = @Where + ' AND P50.VoucherNo = '''+ @VoucherNo + ''''

IF ISNULL(@VoucherDate,'') <> ''
SET @Where = @Where + 'AND CONVERT(NVARCHAR(10),P50.VoucherDate,21) <= '''+CONVERT(NVARCHAR(10),@VoucherDate,21)+''''

SET @SQL ='SELECT  P50.APK, P50.APK as APKMaster, P50.DivisionID, P50.VoucherNo, P50.MemberID ,A02.MemberName , SUM(CASE WHEN P51.IsWarranty = 1 THEN 0 ELSE ISNULL(P51.Amount,0) END) AS TotalAmount
FROM POST2050 P50 WITH (NOLOCK)
LEFT JOIN POST2051 P51 WITH (NOLOCK)  ON P51.APKMaster = P50.APK
LEFT JOIN POST0011 A02 WITH (NOLOCK)  ON P50.MemberID = A02.MemberID
'
+ @Where +
' AND P50.APK NOT IN (SELECT InheritVoucherID FROM AT9000 AT90 WITH(NOLOCK) where InheritVoucherID is not null)
--AND P50.APK IN (SELECT D.APKMInherited FROM POST0027 M WITH(NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg and M.DeleteFlg = 0 where D.APKMInherited is not null and M.DeleteFlg = 0)
GROUP BY P50.APK, P50.APK, P50.DivisionID, P50.VoucherNo , P50.VoucherDate , P50.MemberID ,A02.MemberName
ORDER BY P50.MemberID'

Exec(@SQL)

print @SQL



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
