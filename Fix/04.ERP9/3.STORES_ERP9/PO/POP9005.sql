IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP9005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP9005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load dữ liệu màn hình chọn thông tin vận chuyển.
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Đức Tuyên Date 22/11/2022
-- <Example>

 CREATE PROCEDURE [dbo].[POP9005] 
 (
	 @DivisionID NVARCHAR(250),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),

	 @POrderID VARCHAR(250) = NULL, -- Mã đơn hàng

	 @PageNumber INT,
	 @PageSize INT
)
AS

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX) ='',
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50)

SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'O37.QuantityContainer'

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
IF ISNULL(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
								AND (O37.VoucherNo LIKE N''%'+@TxtSearch+'%'' 
									OR O37.InvoiceNo LIKE N''%'+@TxtSearch+'%'' 
									OR O37.BillOfLadingNo LIKE N''%'+@TxtSearch+'%'' 
									OR O37.QuantityContainer LIKE N''%'+@TxtSearch+'%'')'
SET @sSQL = 'SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
					, O37.DivisionID
					, O37.VoucherNo
					, O37.InvoiceNo
					, O37.BillOfLadingNo
					, O37.QuantityContainer
					, O37.POrderID
			FROM OT3007 O37 WITH (NOLOCK)
			WHERE O37.DivisionID in ('''+@DivisionID+''', ''@@@'') 
					AND O37.POrderID = '''+@POrderID+''' '+@sWhere+'
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '


--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
