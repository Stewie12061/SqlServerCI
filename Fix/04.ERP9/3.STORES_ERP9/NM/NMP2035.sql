IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2035]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2035]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn phiếu điều tra
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>/
----Created by: trà Giang on 11/09/2018
-- <Example>
/*
    EXEC NMP2035 'BS', 'a',null,1,25,''
*/

 CREATE PROCEDURE NMP2035 (
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
	SET @OrderBy = 'N.InvestigateVoucherNo, N.InvestigateVoucherDate'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
									AND (N.InvestigateVoucherNo LIKE N''%'+@TxtSearch+'%'' 
									OR N.InvestigateVoucherDate LIKE N''%'+@TxtSearch+'%''
									OR N.TotalStudent LIKE N''%'+@TxtSearch+'%''  
									OR N.Description LIKE N''%'+@TxtSearch+'%'')'

	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, N.APK
							, N.DivisionID,  N.InvestigateVoucherNo, N.InvestigateVoucherDate, N.MarketVoucherNo,N.MenuVoucherNo,N.Description,N.TotalStudent
							,N.RealityStudent,N2.ActualQuantity,N2.RealityQuantity,N2.UnitPrice,N2.MaterialsID, A02.InventoryName
						
				FROM NMT2030 N WITH (NOLOCK) 
				LEFT JOIN NMT2032 N2 WITH (NOLOCK) ON N.APK= N2.APKMaster
				LEFT JOIN AT1302 A02 WITH (NOLOCK) ON N2.MaterialsID = A02.InventoryID  
				WHERE N.DivisionID  IN ('''+@DivisionID+''' ,''@@@'') and N.DeleteFlg=0 
				  '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
			

EXEC (@sSQL)
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

