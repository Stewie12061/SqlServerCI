IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu màn hình xem/sửa đơn đặt hàng sỉ/nội bộ POF2018, POF2019
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 27/06/2018
---- Modify by Tra Giang on 15/11/2018: Bổ sung trường địa chỉ, tên mặt hàng,bổ sung phân trang
-- <Example>
---- exec POP2021 'AT', 'ASOFTADMIN', '13CF35DB-682E-4E8B-98E9-043A68338332',1,25


CREATE PROCEDURE POP2021
( 
		@DivisionID NVARCHAR(50),
		@UserID NVARCHAR(50),
		@APK NVARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@TotalRow NVARCHAR(50),
		@Orderby NVARCHAR(MAX)=''
SET @TotalRow = ''
SET @Orderby='A.VoucherNo '
   
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'


SET @sSQL = N'
    SELECT   ROW_NUMBER() OVER (ORDER BY A.VoucherNo ) AS RowNum, COUNT(*) OVER () AS TotalRow ,A.*
		FROM 
		(SELECT DISTINCT
		P15.*, A02.ObjectName, A08.PaymentTermName, A01.PaymentName, A04.CurrencyName, A05.UserName AS EmployeeName, --O11.[Description] AS OrderStatusName,
	P16.InventoryTypeID, P16.InventoryID,A03.InventoryName, P16.UnitID, P16.OrderQuantity, P16.OrderPrice, P16.OriginalAmount, P16.ConvertedAmount, P16.Notes, P16.DepositAmount, 
	P16.DepositConAmount, P16.DepositNotes, P16.RequireDate, P16.ScheduleDate, P16.Ana01ID, P16.Ana02ID, P16.Ana03ID, P16.Ana04ID, P16.Ana05ID, P16.Ana06ID,
	P16.Ana07ID, P16.Ana08ID, P16.Ana09ID, P16.Ana10ID, A02.Address,
	A11.AnaName AS Ana01Name,
	A12.AnaName AS Ana02Name,
	A13.AnaName AS Ana03Name,
	A14.AnaName AS Ana04Name,
	A15.AnaName AS Ana05Name,
	A16.AnaName AS Ana06Name,
	A17.AnaName AS Ana07Name,
	A18.AnaName AS Ana08Name,
	A19.AnaName AS Ana09Name,
	A10.AnaName AS Ana10Name,
	(CASE WHEN P15.IsObjectConfirm = 0 THEN N''Chưa xác nhận'' ELSE 
		CASE WHEN P15.IsObjectConfirm = 1 THEN N''Đồng ý'' ELSE N''Từ chối'' END END +
	N'' - Ngày '' + CONVERT(NVARCHAR(10),P15.DateConfirm) + '' - '' + P15.NoteConfirm ) AS ObjectConfirm
FROM POT2015 P15 WITH (NOLOCK) 
LEFT JOIN POT2016 P16 WITH (NOLOCK) ON P16.DivisionID = P15.DivisionID AND P15.APK = P16.APK_Master
LEFT JOIN AT1405 A05 WITH (NOLOCK) ON A05.UserID = P15.EmployeeID
LEFT JOIN AT1208 A08 WITH (NOLOCK) ON A08.DivisionID = P15.DivisionID AND A08.PaymentTermID = P15.PaymentTermID
LEFT JOIN AT1205 A01 WITH (NOLOCK) ON A01.DivisionID = P15.DivisionID AND A01.PaymentID = P15.PaymentID
LEFT JOIN AT1004 A04 WITH (NOLOCK) ON A04.CurrencyID = P15.CurrencyID
LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.ObjectID = P15.ObjectID
LEFT JOIN AT1302 A03 WITH (NOLOCK) ON A03.InventoryID = P16.InventoryID
LEFT JOIN OT1101 O11 WITH (NOLOCK) ON O11.OrderStatus = P15.OrderStatus
LEFT JOIN AT1011 A11 WITH (NOLOCK) ON A11.AnaID = P16.Ana01ID AND A11.AnaTypeID = ''A01''
LEFT JOIN AT1011 A12 WITH (NOLOCK) ON A12.AnaID = P16.Ana01ID AND A12.AnaTypeID = ''A02''
LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID = P16.Ana01ID AND A13.AnaTypeID = ''A03''
LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID = P16.Ana01ID AND A14.AnaTypeID = ''A04''
LEFT JOIN AT1011 A15 WITH (NOLOCK) ON A15.AnaID = P16.Ana01ID AND A15.AnaTypeID = ''A05''
LEFT JOIN AT1011 A16 WITH (NOLOCK) ON A16.AnaID = P16.Ana01ID AND A16.AnaTypeID = ''A06''
LEFT JOIN AT1011 A17 WITH (NOLOCK) ON A17.AnaID = P16.Ana01ID AND A17.AnaTypeID = ''A07''
LEFT JOIN AT1011 A18 WITH (NOLOCK) ON A18.AnaID = P16.Ana01ID AND A18.AnaTypeID = ''A08''
LEFT JOIN AT1011 A19 WITH (NOLOCK) ON A19.AnaID = P16.Ana01ID AND A19.AnaTypeID = ''A09''
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaID = P16.Ana01ID AND A10.AnaTypeID = ''A10'')A
WHERE A.DivisionID = '''+@DivisionID+''' AND A.APK = '''+@APK+ '''
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '


--PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
