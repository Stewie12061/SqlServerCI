IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load tab thông tin thực đơn ngày detaill 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>	
---- 
---- 
-- <History>
----Created by:Trà Giang 11/09/2018
----Modify by: 
-- <Example>
---- 
/*-- <Example>
	NMP2012 @DivisionID = 'BE', @UserID = '', @APK = '4AEDB4CB-A08D-4C45-B7DD-95E01E10BA4E'

----*/
CREATE PROCEDURE NMP2012
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
	SELECT T1.APK, T1.APKMaster, T1.DivisionID, T1.MenuDate, T1.DishID, T1.MealID
	FROM NMT2011 T1 WITH (NOLOCK) 
	WHERE T1.DeleteFlg = 0 AND T1.APKMaster = '''+@APK+'''
	ORDER BY T1.MenuDate ASC

	'

 EXEC (@sSQL)
 --PRINT @sSQL


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
