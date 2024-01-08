IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2026]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2026]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Load edit/view kế hoạch mua hàng dữ trữ (ATTOM) (Customize ATTOM)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 16/07/2018
---- Modify  by Tra Giang on 23/10/2018: bổ sung phân trang
-- <Example>
---- exec POP2026 'AT', 'ASOFTADMIN', '0C477CBF-404F-481E-B32F-01C2C2101000',@PageNumber=1,@PageSize=25
--exec POP2026 @DivisionID=N'AT',@UserID=N'ASOFTADMIN',@APK=N'cd30907e-9cdf-4f61-a5a8-f81b9af81ffb',@PageNumber=1,@PageSize=25
CREATE PROCEDURE POP2026
( 
		@DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@APK VARCHAR(50),
	    @PageNumber INT,
	    @PageSize INT
		
) 
AS 
DECLARE @BeginQuantity DECIMAL(28,8),
		@ExpectQuantity DECIMAL(28,8),
		@PQuantity DECIMAL(28,8),
		@OrderQuantity DECIMAL(28,8),
		@Notes NVARCHAR(250) = '',
		@sSQL NVARCHAR(MAX),
	    @TotalRow NVARCHAR(50) = N'',
		@OrderBy NVARCHAR(500) = N''

		 SET @OrderBy = 'P17.VoucherNo'
		 
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sSQL = '
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
P17.*, P18.InventoryID, P18.UnitID, P18.ObjectID, P18.ID_LeadtimeMOQ, P18.AVGQuantity, P18.OrderQuantity, P18.ExpectDate,
P18.Notes, P18.Ana01ID, P18.Ana02ID, P18.Ana03ID, P18.Ana04ID, P18.Ana05ID, P18.Ana06ID, P18.Ana07ID, P18.Ana08ID, P18.Ana09ID, P18.Ana10ID,
A01.InventoryTypeName, P13.[Description] AS LeadtimeName, A05.UserName AS EmployeeName, A02.InventoryName, A12.ObjectName
FROM POT2017 P17 WITH (NOLOCK)
LEFT JOIN POT2018 P18 WITH (NOLOCK)	ON P18.DivisionID = P17.DivisionID AND P17.APK = P18.APK_Master
LEFT JOIN POT2013 p13 WITH (NOLOCK) ON p13.LeadTimeID = P17.LeadTimeID AND p13.DivisionID = P17.DivisionID
LEFT JOIN AT1405 A05 WITH (NOLOCK) ON A05.DivisionID = P17.DivisionID AND A05.UserID = P17.CreateUserID
LEFT JOIN AT1301 A01 WITH (NOLOCK) ON A01.InventoryTypeID = P17.InventoryTypeID
LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = P18.InventoryID
LEFT JOIN AT1202 A12 WITH (NOLOCK) ON A12.ObjectID = P18.ObjectID
WHERE P18.DivisionID = '''+@DivisionID+''' AND P17.APK = '''+@APK+'''
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


EXEC (@sSQL)
 print @sSQL


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
