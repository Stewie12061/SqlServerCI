IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load form edit detail các bươc của tiep pham ba bươc
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trà Giang
----Create date: 02/10/2018
--- Modify 
/*

EXEC NMP2052 'BS','1BBEB994-C57D-43D1-B17C-40A383907946','',1
*/
 CREATE PROCEDURE NMP2052
(
 	 @DivisionID VARCHAR(50),
     @APK NVARCHAR(50),
	 @UserID NVARCHAR(250),
	 @Mode NVARCHAR(50)

)
AS
DECLARE @sSQL01 NVARCHAR (MAX)='',
		@sWhere NVARCHAR(MAX)
	  
	-- Tab bước 1A
  IF @Mode=1
  SET @sSQL01 = N'
  select N52.VoucherDate,N52.MaterialsID,A02.InventoryName,N52.ActualQuantity,N52.SupplierID,A12.ObjectName,N52.VoucherNo,N52.QuarantineVoucherNo,
	N52.PackagingType,N52.Feel,N52.ResultsTest
	from  NMT2052 N52 WITH (NOLOCK)  inner join AT1302 A02 WITH (NOLOCK) on N52.MaterialsID=A02.InventoryID
	 inner join AT1202 A12 WITH (NOlOCK) on N52.SupplierID=A12.ObjectID
	 inner join NMT2050 N50 WITH (NOLOCK) on N50.APK=N52.APKMaster  
  where N52.DeleteFlg = 0 and N50.DivisionID='''+@DivisionID+''' and N52.APKMaster = '''+@APK+''''
	ELSE
	-- Tab bước 1B
	IF @Mode=2
	  SET @sSQL01 = N'
 	select N53.VoucherDate, N53.MaterialsID,A02.InventoryName,N53.ActualQuantity,N53.SupplierID,A12.ObjectName,N53.Address,N53.BrandName,N53.PackagingType,N53.ExpiryDate,
	N53.VoucherNo,N53.StorageConditions,N53.Notes
	from NMT2053 N53 WITH (NOLOCK) inner join NMT2050 N50 WITH (NOLOCK) on N53.APKMaster=N50.APK 
	inner join AT1302 A02 WITH (NOLOCK) on N53.MaterialsID=A02.InventoryID
	inner join AT1202 A12 WITH (NOlOCK) on N53.SupplierID=A12.ObjectID
  where N53.DeleteFlg = 0 and N50.DivisionID='''+@DivisionID+''' and N53.APKMaster = '''+@APK+''''
	ELSE
	-- Tab bước 2
	IF @Mode=3
	SET @sSQL01 =N'
	select N54.MealID,N16.MealName, N54.DishID,N15.DishName,N54.MaterialsID,A02.InventoryName,
	N54.Mass, N54.ProcessingTime,N54.CookingTime,N54.DeliveryTime,N54.BeginEatTime,N54.Feel,N54.StorageConditions
	from NMT2054 N54 WITH (NOLOCK)
		left  join NMT1050 N15  WITH (NOLOCK) on N15.DishID=N54.DishID
		left  join NMT1060 N16 WITH (NOLOCK) on N16.MealID= N54.MealID
		left  join AT1302 A02 WITH (NOLOCK) on N54.MaterialsID=A02.InventoryID
		 where N54.DeleteFlg = 0 and N50.DivisionID='''+@DivisionID+''' and N54.APKMaster = '''+@APK+''''
	ELSE
	-- Tab bước 3
	SET @sSQL01=N'
		
		select N55.MealID, N16.MealName  ,N55.DishID, N15.DishName,N55.SaveTime,N55.CancelTime,N55.Description
		from NMT2055 N55 WITH (NOLOCK) 		left  join NMT1050 N15  WITH (NOLOCK) on N15.DishID=N55.DishID
		left  join NMT1060 N16 WITH (NOLOCK) on N16.MealID= N55.MealID
		 where N55.DeleteFlg = 0 and N50.DivisionID='''+@DivisionID+''' and N55.APKMaster = '''+@APK+''''


EXEC (@sSQL01)
--print @sSQL01


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
