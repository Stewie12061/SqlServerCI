IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load tab thông tin thưục đơn tổng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>	
---- 
---- 
-- <History>
----Created by:Trà Giang 11/09/2018
-- <Example>
---- 
/*-- <Example>
	NMP2002 @DivisionID = 'VS', @UserID = '', @APK = '827A4AFD-A63B-4C24-85A0-51E8E6B224B8',@Type='2'
	NMP2002 'BS', 'ASOFTADMIN', 'ed58d3c5-f28b-4f56-b68b-5f84ecaa65b1', '1'
----*/
CREATE PROCEDURE NMP2002
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @Type VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

		IF @Type=1
		BEGIN
		SET @sSQL = N'

  select N00.APK, N00.VoucherNo, N00.VoucherDate,N00.AnaID,A11.AnaName,N00.Description,N00.MenuTypeID,N20.MenuTypeName,N00 .BeginDate, N00.FinishDate,N00.CreateUserID, A03.FullName as Name,N00.LastModifyUserID,A03.FullName as LastModifyUserName
  from NMT2000 N00 WITH (NOLOCK) 
  left  join AT1011 A11 WITH (NOLOCK) on A11.AnaID=N00.AnaID 
   INNER JOIN AT0000  WITH (NOLOCK)  ON A11.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A11.AnaTypeID = AT0000.SchoolAnaTypeID
  left join NMT1020 N20 WITH (NOLOCK) on N20.MenuTypeID= N00.MenuTypeID
  Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = N00.CreateUserID
  where N00.DeleteFlg = 0 and N00.APK = '''+@APK+'''
  group by N00.APK, N00.VoucherNo, N00.VoucherDate,N00.AnaID,N00.Description,N00.MenuTypeID,N00.BeginDate, N00.FinishDate,A11.AnaName,N20.MenuTypeName,N00.CreateUserID,N00.LastModifyUserID,A03.FullName'

		END
		ELSE
		BEGIN

SET @sSQL = N'

  select  N01.Day,N01.Week,N01.MealID,N60.MealName,N01.DishID, N50.DishName
  from NMT2000 N00 WITH (NOLOCK) inner join NMT2001 N01 WITH (NOLOCK) on N00.APK=N01.APKMaster
   inner join NMT1050 N50 WITH (NOLOCK) on  N50.DishID= N01.DishID 
   inner join  NMT1060 N60 WITH (NOLOCK) on  N60.MealID= N01.MealID
  where N00.DeleteFlg = 0 and N00.APK = '''+@APK+'''
  group by N01.Day,N01.Week,N01.MealID,N01.DishID,N00.VoucherNo, N00.VoucherDate,N00.AnaID,N00.Description,N00.MenuTypeID,N00.BeginDate, N00.FinishDate, N50.DishName, N60.MealName'
  END
 EXEC (@sSQL)
 --PRINT @sSQL




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
