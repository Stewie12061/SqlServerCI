IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP10013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP10013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn mặt hàng để khai báo định nghĩa tiêu chuẩn cho mặt hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Le Hoang on 26/04/2021
----Modified by ... on ... 
/*
	exec QCP10013 @DivisionID=N'VNP',  @TxtSearch=N'',@UserID=N'',@PageNumber=N'1',@PageSize=N'25', @APK = N''
*/

 CREATE PROCEDURE [dbo].[QCP10013] (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)	
	

	SET @sWhere = ''
	SET @TotalRow = ''

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'COUNT(*) OVER ()'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (QCT2001.InventoryID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1302.InventoryName LIKE N''%'+@TxtSearch+'%'' 
								OR QCT2001.BatchNo LIKE N''%'+@TxtSearch+'%'')'

		SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY QCT2001.BatchNo + '' - '' + AT1302.InventoryName) AS RowNum, '+@TotalRow+' AS TotalRow, 
			QCT2001.APK, QCT2001.InventoryID, AT1302.InventoryName, QCT2001.BatchNo,  QCT2001.BatchNo + '' - '' + AT1302.InventoryName AS BatchInventory,
			QCT2000.VoucherNo, CONVERT(NVARCHAR(50),QCT2000.VoucherDate,103) AS VoucherDate, QCT2000.ShiftID ShiftName, QCT2000.MachineID AS MachineName, QCT2001.DivisionID
		FROM QCT2001 QCT2001 WITH(NOLOCK) 
		JOIN QCT2000 QCT2000 WITH(NOLOCK) ON QCT2001.APKMaster = QCT2000.APK  
		LEFT JOIN AT1302 AT1302 WITH(NOLOCK) ON AT1302.InventoryID = QCT2001.InventoryID 
		WHERE QCT2001.DeleteFlg = 0 AND QCT2000.DeleteFlg = 0 ' + @sWhere + '
		ORDER BY BatchInventory
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
		
EXEC (@sSQL)
PRINT (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
