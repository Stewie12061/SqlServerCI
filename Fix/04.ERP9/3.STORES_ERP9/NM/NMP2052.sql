IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load form edit thông tin chung và thong tin bưa an cau TP3B
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

EXEC NMP2052 'BS','1BBEB994-C57D-43D1-B17C-40A383907946',''
*/
 CREATE PROCEDURE NMP2052
(
 	 @DivisionID VARCHAR(50),
     @APK NVARCHAR(50),
	 @UserID NVARCHAR(250)

)
AS
DECLARE @sSQL01 NVARCHAR (MAX)='',
		@sWhere NVARCHAR(MAX)
	  
SET @sSQL01=  N'
		select	N50.DivisionID,  N50.VoucherNo, N50.VoucherDate, N50.MarketVoucherNo, N50.TranMonth, N50.TranYear, N50.CreateUserID,
		N50.CreateDate, N50.LastModifyUserID, N50.LastModifyDate, N51.MealID,N16.MealName,N51.DishID, N15.DishName
		from NMT2050 N50 WITH (NOLOCK) inner join  NMT2051 N51 WITH (NOLOCK) on N50.APK=N51.APKMaster
		left  join NMT1050 N15  WITH (NOLOCK) on N15.DishID=N51.DishID
		left  join NMT1060 N16 WITH (NOLOCK) on N16.MealID= N51.MealID
		  where N50.DeleteFlg = 0 and N50.DivisionID='''+@DivisionID+''' and N50.APK = '''+@APK+'''
		  group by N50.VoucherNo, N50.VoucherDate, N50.MarketVoucherNo,  N51.MealID,N16.MealName,N51.DishID, N15.DishName,N50.DivisionID, 
		  N50.TranMonth, N50.TranYear, N50.CreateUserID,
		N50.CreateDate, N50.LastModifyUserID, N50.LastModifyDate  '
	
EXEC (@sSQL01)
--print @sSQL01


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
