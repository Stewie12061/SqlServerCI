IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP0023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].POSP0023
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Store lấy danh sách mặt hàng tồn tại và trả về 2 table, 1 table những mặt hàng tồn tại, 1 table những mặt hàng không tồn tại.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Thành Luân on 04/11/2019

----Example: 
/*
*/
IF TYPE_ID(N'POSP0023Table') IS NOT NULL
BEGIN
	DROP TYPE POSP0023Table
END

CREATE TYPE POSP0023Table AS TABLE(
	InventoryID VARCHAR(50),
	Quantity INT,
	Description NVARCHAR(250)
);
GO
CREATE PROCEDURE POSP0023 (
	@DivisionID VARCHAR(50),
	@TVP POSP0023Table READONLY
)
AS
BEGIN
	
	DECLARE @Temp TABLE(
		DivisionID VARCHAR(50),
		InventoryID VARCHAR(50),
		InventoryName NVARCHAR(250),
		Quantity INT,
		InventoryTypeID NVARCHAR(50),
		UnitID NVARCHAR(50),
		UnitName NVARCHAR(50),
		Description NVARCHAR(250)
	)

	-- Get all rows that has existed inventory id.
	INSERT INTO @Temp
	SELECT A02.DivisionID, A02.InventoryID, 
		A02.InventoryName,
		T.Quantity,
		A02.InventoryTypeID,
		A02.UnitID,
		A04.UnitName,
		T.Description
	FROM @TVP AS T
	INNER JOIN AT1302 AS A02 WITH(NOLOCK) ON T.InventoryID = A02.InventoryID AND A02.DivisionID IN (@DivisionID, '@@@') AND A02.Disabled = 0
	LEFT JOIN AT1304 AS A04 WITH (NOLOCK) on  A02.UnitID = A04.UnitID and A04.Disabled = 0

	SELECT * FROM @Temp

	-- Get all rows that has non existed inventory id.
	SELECT T.InventoryID, T.Quantity, T.Description FROM @TVP T
	LEFT JOIN @Temp D ON T.InventoryID = D.InventoryID
	WHERE ISNULL(T.InventoryID, '') != '' AND D.InventoryID IS NULL
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
