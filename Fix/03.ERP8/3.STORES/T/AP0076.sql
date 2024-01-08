IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0076]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)   
DROP PROCEDURE [DBO].[AP0076]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tiểu Mai on 01/08/2016
---- Purpose: Import định mức hàng tồn kho an toàn
---- Modified by Tiểu Mai on 19/10/2016: Sửa lại import tồn kho chưa đúng
---- Modified by Phương Thảo on 26/05/2017: Sửa danh mục dùng chung

CREATE PROCEDURE [DBO].[AP0076]
( 
 @DivisionID AS NVARCHAR(50),
 @UserID AS NVARCHAR(50),
 @TranMonth AS INT,
 @TranYear AS INT,
 @XML AS XML
) 
AS 
BEGIN 
 BEGIN TRANSACTION
 BEGIN TRY

  SELECT 
   NEWID() AS APK,
   X.Data.query('InventoryNormID').value('.', 'NVARCHAR(50)') AS InventoryNormID,
   X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,
   X.Data.query('WareHouseID').value('.', 'NVARCHAR(50)') AS WareHouseID,
   X.Data.query('MinQuantity').value('.', 'decimal(28,8)') AS MinQuantity,
   X.Data.query('MaxQuantity').value('.', 'decimal(28,8)') AS MaxQuantity,  
   X.Data.query('ReOrderQuantity').value('.', 'decimal(28,8)') AS ReOrderQuantity,
   X.Data.query('FromDate').value('.', 'DATETIME') AS FromDate,  
   X.Data.query('ToDate').value('.', 'DATETIME') AS ToDate,
   X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes,
   X.Data.query('S01ID').value('.', 'NVARCHAR(50)') AS S01ID,
   X.Data.query('S02ID').value('.', 'NVARCHAR(50)') AS S02ID,
   X.Data.query('S03ID').value('.', 'NVARCHAR(50)') AS S03ID,
   X.Data.query('S04ID').value('.', 'NVARCHAR(50)') AS S04ID,
   X.Data.query('S05ID').value('.', 'NVARCHAR(50)') AS S05ID,
   X.Data.query('S06ID').value('.', 'NVARCHAR(50)') AS S06ID,
   X.Data.query('S07ID').value('.', 'NVARCHAR(50)') AS S07ID,
   X.Data.query('S08ID').value('.', 'NVARCHAR(50)') AS S08ID,
   X.Data.query('S09ID').value('.', 'NVARCHAR(50)') AS S09ID,
   X.Data.query('S10ID').value('.', 'NVARCHAR(50)') AS S10ID,
   X.Data.query('S11ID').value('.', 'NVARCHAR(50)') AS S11ID,
   X.Data.query('S12ID').value('.', 'NVARCHAR(50)') AS S12ID,
   X.Data.query('S13ID').value('.', 'NVARCHAR(50)') AS S13ID,
   X.Data.query('S14ID').value('.', 'NVARCHAR(50)') AS S14ID,
   X.Data.query('S15ID').value('.', 'NVARCHAR(50)') AS S15ID,
   X.Data.query('S16ID').value('.', 'NVARCHAR(50)') AS S16ID,
   X.Data.query('S17ID').value('.', 'NVARCHAR(50)') AS S17ID,
   X.Data.query('S18ID').value('.', 'NVARCHAR(50)') AS S18ID,
   X.Data.query('S19ID').value('.', 'NVARCHAR(50)') AS S19ID,
   X.Data.query('S20ID').value('.', 'NVARCHAR(50)') AS S20ID
   
 INTO #Data
 FROM @XML.nodes('//Data') AS X (Data)

SELECT AT1314.APK, #Data.APK AS APK2, #Data.MinQuantity, #Data.MaxQuantity, #Data.ReOrderQuantity, #Data.Notes, @UserID AS LastModifyUserID, GetDate() AS LastModifyDate, #Data.FromDate, #Data.ToDate
INTO #TEMP
FROM #Data
INNER JOIN AT1314 
ON AT1314.InventoryID = #Data.InventoryID 
AND AT1314.WareHouseID = #Data.WareHouseID
AND AT1314.FromDate > #Data.FromDate
AND AT1314.ToDate < #Data.ToDate 
WHERE DivisionID in (@DivisionID,'@@@')

--- Update value
 UPDATE  AT1314
 SET 
	MinQuantity	= #TEMP.MinQuantity,		
	MaxQuantity	= #TEMP.MaxQuantity,		
	ReOrderQuantity	= #TEMP.ReOrderQuantity,
	Notes = #TEMP.Notes,
	LastModifyUserID = #TEMP.LastModifyUserID,
	LastModifyDate = #TEMP.LastModifyDate,
	FromDate = #TEMP.FromDate,
	ToDate = #TEMP.ToDate 
FROM AT1314
INNER JOIN #TEMP ON AT1314.APK = #TEMP.APK

--SELECT * FROM #TEMP
 INSERT INTO AT1314(DivisionID, InventoryNormID, NormID, InventoryID, WareHouseID, MinQuantity, MaxQuantity, ReOrderQuantity, CreateDate, CreateUserID,
 LastModifyDate, LastModifyUserID, FromDate, ToDate, TranMonth, TranYear, Notes)
 SELECT @DivisionID, NEWID(), NEWID(), DATA.InventoryID, DATA.WareHouseID, DATA.MinQuantity, DATA.MaxQuantity, DATA.ReOrderQuantity, GETDATE(), @UserID,
 GETDATE(), @UserID, DATA.FromDate, DATA.ToDate, @TranMonth, @TranYear, DATA.Notes
 FROM #Data DATA
 LEFT JOIN AT1314 
 ON AT1314.InventoryID = DATA.InventoryID 
 AND AT1314.WareHouseID = DATA.WareHouseID
 AND AT1314.FromDate <= DATA.FromDate
 AND AT1314.ToDate >= DATA.ToDate 
 WHERE AT1314.InventoryNormID IS NULL
	   AND AT1314.NormID IS NULL 
	   
 INSERT INTO AT1314(DivisionID, InventoryNormID, NormID, InventoryID, WareHouseID, MinQuantity, MaxQuantity, ReOrderQuantity, CreateDate, CreateUserID,
 LastModifyDate, LastModifyUserID, FromDate, ToDate, TranMonth, TranYear, Notes)
 SELECT @DivisionID, NEWID(), NEWID(), DATA.InventoryID, DATA.WareHouseID, DATA.MinQuantity, DATA.MaxQuantity, DATA.ReOrderQuantity, GETDATE(), @UserID,
 GETDATE(), @UserID, DATA.FromDate, DATA.ToDate, @TranMonth, @TranYear, DATA.Notes
 FROM #Data DATA
 LEFT JOIN AT1314 
 ON AT1314.InventoryID = DATA.InventoryID 
 AND AT1314.WareHouseID = DATA.WareHouseID
 AND AT1314.FromDate >= DATA.FromDate
 AND AT1314.ToDate <= DATA.ToDate 
 WHERE AT1314.InventoryNormID IS NULL
	   AND AT1314.NormID IS NULL 	   


 COMMIT TRANSACTION
 END TRY
 BEGIN CATCH
  ROLLBACK TRANSACTION
 END CATCH
 
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON