IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load khuyến mãi cho màn hình lập đơn hàng bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 12/05/2022 by Hoài Bảo
---- Modified on 21/06/2022 by Hoài Bảo - Bổ sung PromoteName cho Khuyến mãi theo mặt hàng
---- Modified on 10/04/2023 by Tấn Lộc  - Bổ sung trường hợp tại các màn hình CTKM không có chọn Đối tượng cụ thể thì kiểm tra Đối tượng truyền vào (Tại các màn hình đơn hàng, báo giá,...) có thuộc "Loại đối tượng" của Các CTKM không
---- Modified on 22/05/2023 by Thanh Lượng  - Merge code Gree
---- Modified on 26/05/2023 by Nhật Thanh - Bổ sung chương trình khuyến mãi: 3 cho dùng ví tích lũy; 4 không cho dùng ví tích lũy
---- Modified on 26/12/2023 by Hoàng Long - [2023/12/TA/0176] - Cập nhật xử lý CTKM theo đối tượng
-- <Example>
---- EXEC SOP20008 N'DTI', N'AKZONOBEL', '2022-05-12 00:00:00'

CREATE PROCEDURE SOP20008
( 
	@DivisionID NVARCHAR(50),
	@ObjectID NVARCHAR(50),
	@VoucherDate DATETIME
)
AS

	SELECT DISTINCT A1.PromoteID + N'|1|' + (SELECT TOP 1 CONVERT(VARCHAR(50), AT0109.APK) FROM AT0109 WITH (NOLOCK) WHERE AT0109.PromoteID = A1.PromoteID ORDER BY PromoteID) AS PromoteID, A1.PromoteName, N'1' AS Type, N'Khuyến mãi theo giá trị hóa đơn' AS TypeName, A1.FromDate, A1.ToDate
	FROM AT0109 A1 WITH (NOLOCK)
	WHERE
		CONVERT(DATETIME,@VoucherDate, 101) BETWEEN CONVERT(DATETIME,FromDate,101) AND CONVERT(DATETIME,ISNULL(ToDate, '9999-01-01'),101)
		AND DivisionID = @DivisionID
		AND [Disabled] = 0
		AND @ObjectID IN (SELECT Value FROM dbo.StringSplit(ObjectID, ','))
	UNION ALL
	SELECT PromoteID + N'|2|' + CONVERT(VARCHAR(50),APK) AS PromoteID, PromoteName, N'2' AS Type, N'Khuyến mãi theo mặt hàng' AS TypeName, FromDate, ToDate
	FROM AT1329
	WHERE
		CONVERT(DATETIME,@VoucherDate, 101) BETWEEN CONVERT(DATETIME,FromDate,101) AND CONVERT(DATETIME,ISNULL (ToDate, '9999-01-01'),101)
		AND DivisionID = @DivisionID
		AND [Disabled] = 0 
		AND @ObjectID IN (SELECT Value FROM dbo.StringSplit(ObjectID, ','))
	UNION ALL
	SELECT PromoteID + CASE WHEN ISNULL(IsDiscountWallet,0) = 0 THEN N'|3|' ELSE N'|4|' END + CONVERT(VARCHAR(50),APK) AS PromoteID, PromoteName, CASE WHEN ISNULL(IsDiscountWallet,0) = 0 THEN N'3' ELSE N'4' END AS Type, N'Chương trình khuyến mãi' AS TypeName, FromDate, ToDate
	FROM CIT1220
	WHERE
		CONVERT(DATETIME,@VoucherDate, 101) BETWEEN CONVERT(DATETIME,FromDate,101) AND CONVERT(DATETIME,ISNULL (ToDate, '9999-01-01'),101)
		AND DivisionID = @DivisionID
		AND [Disabled] = 0 
		AND (((SELECT TOP 1 O01ID FROM AT1202 WHERE OBJECTID = @ObjectID) IN (SELECT Value FROM dbo.StringSplit(OID, ','))
			OR (SELECT TOP 1 O02ID FROM AT1202 WHERE OBJECTID = @ObjectID) IN (SELECT Value FROM dbo.StringSplit(OID, ','))
			OR (SELECT TOP 1 O03ID FROM AT1202 WHERE OBJECTID = @ObjectID) IN (SELECT Value FROM dbo.StringSplit(OID, ','))
			OR (SELECT TOP 1 O04ID FROM AT1202 WHERE OBJECTID = @ObjectID) IN (SELECT Value FROM dbo.StringSplit(OID, ','))
			OR (SELECT TOP 1 O05ID FROM AT1202 WHERE OBJECTID = @ObjectID) IN (SELECT Value FROM dbo.StringSplit(OID, ',')))
		OR ((SELECT TOP 1 ObjectID FROM AT1202 WHERE OBJECTID = @ObjectID) IN (SELECT Value FROM dbo.StringSplit(ObjectID, ','))))



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
