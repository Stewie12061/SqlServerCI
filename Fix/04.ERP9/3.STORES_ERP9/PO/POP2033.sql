IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Created BY Như Hàn
---- Created date 07/12/2018
---- Purpose: Thông tin tồn kho của mặt hàng
/********************************************
EXEC POP2033 'AIC', ''
EXEC POP2033 @DivisionID, @InventoryID

'********************************************/
---- Modified by .. on .. 

CREATE PROCEDURE [dbo].[POP2033]
    @DivisionID AS NVARCHAR(50), 
    @InventoryID AS NVARCHAR(50)

AS


SELECT
SUM(AT2008.EndQuantity) AS EndQuantity, 
AT2008.DivisionID
FROM AT2008 WITH(NOLOCK)
WHERE AT2008.DivisionID = @DivisionID
	AND AT2008.InventoryID LIKE @InventoryID
GROUP BY AT2008.DivisionID

		
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
