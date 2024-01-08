IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3082]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3082]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- In phiếu xuất kho/In phiếu giao hàng detail
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:Hoàng Vũ, Date 08-05-2019: Chuyển từ Script sql thường sang Store
-- <Example>
---- exec  POSP3082 @APK = '3E888F62-A5A8-4223-908C-07A11F396DE3'

CREATE PROCEDURE POSP3082 
(
	@DivisionID			NVARCHAR(50) = NULL,
	@APK				NVARCHAR(50),
	@UserID				NVARCHAR(50) = NULL
)
AS
BEGIN
		Select D.InventoryID, D.InventoryName, D.UnitID, D.UnitName, Sum(isnull(D.ShipQuantity, 0)) as ActualQuantity
		FROM POST0028 D WITH (NOLOCK)
		Where D.APKMaster = @APK and D.DeleteFlg = 0
		Group by D.InventoryID, D.InventoryName, D.UnitID, D.UnitName
END	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
