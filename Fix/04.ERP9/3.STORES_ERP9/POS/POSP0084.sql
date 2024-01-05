IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP0084]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP0084]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form POSF0085 Kế thừa phiếu yêu cầu dịch vụ (Phiếu xuất POS)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga, Date 19/09/2019
-- <Example>
/* 
EXEC POSP0084 'NN','CH01','DV/2019/09/0003','', 0, '2019-09-01', '2019-09-01', '11/2017'',''08/2017' ,'NV01',1,20
*/
----
CREATE PROCEDURE POSP0084 ( 
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

SET @SQL ='SELECT ROW_NUMBER() OVER (ORDER BY P50.MemberID) AS RowNum, count(*) OVER () AS TotalRow, P50.APK, P51.APK as APKDetail ,P50.DivisionID, P50.VoucherNo ,P50.MemberID AS ObjectID ,P0011.MemberName as ObjectName, P50.VoucherDate ,P51.ServiceID as  InventoryID,A03.InventoryName as InventoryName, A03.UnitID,A04.UnitName,P51.UnitPrice,P51.ActualQuantity as Quantity, SUM(CASE WHEN P51.IsWarranty = 1 THEN 0 ELSE ISNULL(P51.Amount,0) END) AS Amount
FROM POST2050 P50 WITH (NOLOCK)
LEFT JOIN POST2051 P51 WITH (NOLOCK)  ON P51.APKMaster = P50.APK
INNER JOIN AT1302 A03 WITH (NOLOCK)  ON P51.ServiceID = A03.InventoryID AND IsStocked = 1 
LEFT JOIN POST0011 P0011 WITH (NOLOCK) ON P50.MemberID = P0011.MemberID
Left join AT1304 A04 WITH (NOLOCK) ON  A03.UnitID = A04.UnitID and A04.Disabled = 0

'
+ @Where +
' AND P50.APK NOT IN (SELECT APKMInherited FROM POST0028 PT28 WITH(NOLOCK) LEFT JOIN POST0027 PT27 WITH(NOLOCK) ON PT27.APK = PT28.APKMaster where APKMInherited is not null AND PT27.DeleteFlg = 0)
GROUP BY P50.APK,P51.APK,P50.DivisionID, P50.VoucherNo ,P50.MemberID ,P0011.MemberName, P50.VoucherDate ,P51.UnitPrice,P51.ServiceID,A03.InventoryName, A03.UnitID,A04.UnitName,P51.UnitPrice,P51.ActualQuantity
ORDER BY P50.VoucherNo,P50.MemberID
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

Exec(@SQL)

print @SQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
