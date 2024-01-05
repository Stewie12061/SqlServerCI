IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load from tiep pham ba buoc theo so ke cho
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

EXEC NMP2052 'BS','G1/06/2018/0001',''
*/
 CREATE PROCEDURE NMP2052
(
 	 @DivisionID VARCHAR(50),
     @MarketVoucherNo NVARCHAR(50),
	 @UserID NVARCHAR(250)
	 
)
AS
DECLARE @sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sSQL03 NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)
	SET @sWhere = ''


	IF Isnull(@MarketVoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N20.MarketVoucherNo,'''') = ''%'+@MarketVoucherNo+'%'' '

	

			SET @sSQL01 = '	select N23.MaterialsID,A02.InventoryName, N23.ActualQuantity,N21.DishID,N50.DishName, N21.MealID, N60.MealName
					 from NMT2020 N20 WITH (NOLOCK) inner join NMT2023 N23 WITH (NOLOCK) on N20.APK= N23.APKMaster
					 inner join NMT2021 N21 WITH (NOLOCK) on N20.APK= N21.APKMaster
					 inner join AT1302 A02  WITH (NOLOCK) on N23.MaterialsID= A02.InventoryID and  A02.DivisionID IN (N21.DivisionID, ''@@@'')
					inner join NMT1050 N50  WITH (NOLOCK) on N50.DishID= N21.DishID and  N50.DivisionID IN (N21.DivisionID, ''@@@'')
					inner join NMT1060 N60  WITH (NOLOCK) on N60.MealID= N21.MealID and  N60.DivisionID IN (N21.DivisionID, ''@@@'')
							  where N20.DeleteFlg = 0 and N20.DivisionID='''+@DivisionID+''' and N20.MarketVoucherNo = '''+@MarketVoucherNo+''''



EXEC (@sSQL01)
--print @sSQL01



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
