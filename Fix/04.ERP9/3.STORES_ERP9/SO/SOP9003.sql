IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP9003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP9003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load dữ liệu màn hình chọn bộ định mức (bộ kít)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 04/05/2023 by Nhật Thanh
-- <Example>
---- EXEC SOP9003 @DivisionID=N'BBA-SI',@PromotionID=N'CKKM/02/2023/001'

CREATE PROCEDURE SOP9003
( 
	@DivisionID NVARCHAR(50),
	@PromotionID NVARCHAR(50)
)
AS
	SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY KITID) AS RowNum, COUNT(*) OVER () AS TotalRow,@DivisionID DivisionID, KITID, MDescription KITName, CIT1222.InventoryGiftID, CIT1222.InventoryGiftName
	FROM CIT1222
	LEFT JOIN CIT1221 ON CIT1221.APK = CIT1222.APKMaster
	INNER JOIN AT1326 ON CIT1222.Target = AT1326.KITID
	WHERE CIT1221.PromoteID = @PromotionID
	GROUP BY KITID,MDescription, CIT1222.InventoryGiftID, CIT1222.InventoryGiftName
	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
