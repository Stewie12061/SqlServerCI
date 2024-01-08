IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2113_NKC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP2113_NKC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu Details phiếu Dự toán.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Dũng on 14/11/2023 : NKC Bổ sung lấy data.
----Update by: Đức Tuyên on 08/12/2023 : Chuyển đổi store CRMP2113 (customize NKC) => CRMP2113_NKC.
-- <Example>
----    EXEC CRMP2113_NKC 'MT','2977ed14-c8b7-478f-abf8-ede2ff241a94','b964c015-c496-494b-8cb8-33818d32a7ca','DT'
----
CREATE PROCEDURE CRMP2113_NKC
( 
	@DivisionID nvarchar(50),
	@APK nvarchar(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = '',
	@Mode INT = 0, ---- 0 Edit, 1 view
	@PageNumber INT = 1,
	@PageSize INT = 25
) 
AS 

DECLARE @sSQL NVARCHAR (MAX) ='',
		@sSQL1 NVARCHAR (MAX) ='',
		@sSQL2 NVARCHAR (MAX) ='',
		@sWhere NVARCHAR(MAX) ='',
		@TotalRow VARCHAR(50) ='',
		@OrderBy NVARCHAR(500) ='',
		@query_HIPC AS NVARCHAR(MAX)='',
		@query_NKC AS NVARCHAR(MAX)= ''

DECLARE @CustomerName INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex)

BEGIN

IF @CustomerName = 166 -- NKC
BEGIN
	SET @query_NKC = '
		, CRMT2114.UnitPriceAverage
	'
END

SET @TotalRow = ' COUNT(*) OVER ()' 

	SET @Swhere = @Swhere + ' AND CONVERT(VARCHAR(50),CRMT2115.APKMaster)= '''+@APKMaster+''''

	SET @sSQL = N'
		SELECT ROW_NUMBER() OVER (ORDER BY CRMT2115.InventoryName) AS RowNum, '+@TotalRow+' AS TotalRow
		, CRMT2115.DivisionID
		, CRMT2115.InventoryID
		, CRMT2115.InventoryName
		, CRMT2115.InventoryTypeID
		, CRMT2115.MCP01
		, CRMT2115.MCP02
		, CRMT2115.MCP03
		, CRMT2115.MCP04
		, CRMT2115.MCP05
		, CRMT2115.MCP06
		, CRMT2115.MCP07
		, CRMT2115.COS01
		, CRMT2115.COS02
		, CRMT2115.COS03
		, CRMT2115.COS04
		, CRMT2115.COS05
		, CRMT2115.COS06
		, CRMT2115.COS07
		, CRMT2115.COS08
		, CRMT2115.COS09
		, CRMT2115.COS10
		, CRMT2115.COS11
		, CRMT2115.COS12
		, CRMT2115.COS13
		, CRMT2115.COS14
		, CRMT2115.COS15
		, CRMT2115.COS16
		, CRMT2115.COS17
		, CRMT2115.COS18
		, CRMT2115.COS19
		, CRMT2115.COS20
		, CRMT2115.COS21
		, CRMT2115.COS22
		, CRMT2115.COS23
		, CRMT2115.COS24
		, CRMT2115.COS25
		, CRMT2115.COS26
		, CRMT2115.COS27
		, CRMT2115.COS28
		, CRMT2115.COS29
		, CRMT2115.COS30

		FROM CRMT2115 WITH(NOLOCK)
		WHERE CRMT2115.DivisionID = '''+@DivisionID+''' '+@Swhere+''

END

EXEC (@sSQL +@sSQL1 +@sSQL2)
print @sSQL
print @sSQL1
print @sSQL2




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
