IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load form xem thông tin thu chi thực tế
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - FN\ Nghiệp vụ \ Kết quả thu chi thực tế\ Xem chi tiết phiếu
-- <History>
----Created by: Bảo Anh, Date: 02/11/2018
----Modified on 02/03/2019 by Như Hàn: Lấy thêm trường ngày tạo, người tạo, ngày chỉnh sửa, người chỉnh sửa
-- <Example>
---- 
/*-- <Example>
	FNP2011 @DivisionID = 'AS', @APK = '557C7835-7D69-48FB-8DAE-466E4D8D71D3',@LanguageID = 'vi-VN',@IsViewDetail=1,@PageNumber=1,@PageSize=20
----*/

CREATE PROCEDURE FNP2011
( 
	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @IsViewDetail TINYINT = 0,	--- 0: màn hình edit, 1: màn hình view
	 @PageNumber INT,
     @PageSize INT
)
AS 
     
DECLARE @sSQL NVARCHAR (MAX),
		@TotalRow VARCHAR(50)

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = N'
SELECT 	'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY F11.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
		F10.VoucherTypeID, F10.VoucherNo, F10.VoucherDate, F10.[Description], F10.PaymentTypeID,
		CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN F99.[Description] ELSE F99.DescriptionE END AS PaymentTypeName,
		F10.APKPlanNo, F00.VoucherNo AS PlanVoucherNo, F00.PriorityID, F20.PriorityName, F00.PayMentPlanDate AS PlanVoucherDate,
		F10.CurrencyID, F10.ExchangeRate, F11.*,
		A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
		A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, ISNULL(A10.AnaName,AnaNameList) AS Ana10Name,
		F10.CreateUserID,
		F10.CreateDate,
		F10.LastModifyUserID,
		F10.LastModifyDate
FROM FNT2010 F10 WITH (NOLOCK)
INNER JOIN FNT2011 F11 WITH (NOLOCK) ON F10.DivisionID = F11.DivisionID AND F10.APK = F11.APKMaster
LEFT JOIN FNT0099 F99 WITH (NOLOCK) ON F10.PaymentTypeID = F99.ID AND F99.CodeMaster = ''TransactionType''
LEFT JOIN FNT2000 F00 WITH (NOLOCK) ON F10.DivisionID = F00.DivisionID AND F10.APKPlanNo = F00.APK
LEFT JOIN FNT2001 F01 WITH (NOLOCK) ON F10.DivisionID = F01.DivisionID AND F00.APK = F01.APKMaster
LEFT JOIN FNT1020 F20 WITH (NOLOCK) ON F00.PriorityID = F20.PriorityID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON F11.Ana01ID = A01.AnaID AND A01.AnaTypeID = ''A01''
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON F11.Ana02ID = A02.AnaID AND A02.AnaTypeID = ''A02''
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON F11.Ana03ID = A03.AnaID AND A03.AnaTypeID = ''A03''
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON F11.Ana04ID = A04.AnaID AND A04.AnaTypeID = ''A04''
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON F11.Ana05ID = A05.AnaID AND A05.AnaTypeID = ''A05''
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON F11.Ana06ID = A06.AnaID AND A06.AnaTypeID = ''A06''
LEFT JOIN AT1011 A07 WITH (NOLOCK) ON F11.Ana07ID = A07.AnaID AND A07.AnaTypeID = ''A07''
LEFT JOIN AT1011 A08 WITH (NOLOCK) ON F11.Ana08ID = A08.AnaID AND A08.AnaTypeID = ''A08''
LEFT JOIN AT1011 A09 WITH (NOLOCK) ON F11.Ana09ID = A09.AnaID AND A09.AnaTypeID = ''A09''
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON F11.Ana10ID = A10.AnaID AND A10.AnaTypeID = ''A10''
LEFT JOIN (
		SELECT DISTINCT C2.APKMaster, 
		SUBSTRING(
		(
		SELECT '','' + T1.AnaName
		FROM FNT2008_AIC C1 WITH (NOLOCK)
		LEFT JOIN AT1011 T1 WITH (NOLOCK) ON C1.Ana10ID = T1.AnaID AND T1.AnaTypeID = ''A10''
		WHERE C1.APKMaster = C2.APKMaster
		ORDER BY C1.APKMaster
		FOR XML PATH ('''')
		), 2, 1000) AnaNameList
		FROM FNT2008_AIC C2
		) B ON B.APKMaster = F01.APK
WHERE F10.DivisionID = ''' + @DivisionID + ''' AND F10.APK = ''' + @APK + '''
ORDER BY F11.Orders'

IF @IsViewDetail = 1
	BEGIN
		SET @sSQL = @sSQL+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
---PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
