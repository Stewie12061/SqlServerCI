IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0397]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0397]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load chi tiết thông tin màn hình Chọn dữ liệu dịch vụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 20/09/2019 by Kiều Nga
---- Modified by Đức Duy on 22/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
--- exec AP0397 @DivisionID=N'NN',@UserID=N'ASOFTADMIN',@APKMaster=N'0073F52C-D751-4D4F-B290-A40D0C8D0B25'
-- <Example>
---- 
CREATE PROCEDURE AP0397
( 
		@DivisionID AS NVARCHAR(50),
		@UserID AS NVARCHAR(50),
		@APKMaster AS NVARCHAR(50)
) 
AS 
DECLARE @SQL NVARCHAR(MAX) =''

SET @SQL ='SELECT P51.ServiceID,P51.ServiceName,P51.UnitID,P51.UnitName,P51.ActualQuantity,P51.UnitPrice, CASE WHEN IsWarranty = 1 THEN 0 ELSE ISNULL(P51.Amount,0) END AS InventoryAmount
FROM POST2051 P51 WITH (NOLOCK)
LEFT JOIN POST2050 P50 WITH (NOLOCK)  ON P51.APKMaster = P50.APK
LEFT JOIN AT1202 A02 WITH (NOLOCK)  ON A02.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND P50.MemberID = A02.ObjectID
WHERE DeleteFlg = 0 AND P50.DivisionID = '''+ @DivisionID + ''' AND P50.APK = '''+ @APKMaster + '''
ORDER BY P50.MemberID'

exec (@SQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



