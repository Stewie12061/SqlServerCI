IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2165]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2165]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







----Created by: Trọng Kiên, date: 19/04/2021
---- exec MP2165 @Divisionid=N'ANG',@Tranmonth=1,@Tranyear=2016,@APK=N''

CREATE PROCEDURE [dbo].[MP2165] 
				@DivisionID AS nvarchar(50),
				@APK AS nvarchar(4000)
AS

DECLARE @sSQL NVARCHAR(MAX) =''



SET @sSQL = N'SELECT O1.MaterialID, O1.MaterialName, O1.UnitName, O1.WareHouseName, O1.SafeQuantity, O1.MaterialQuantity
	   , O1.IntendedPickingQuantity, O1.PickingQuantity, O1.SuggestQuantity, O1.EndQuantity
	   , CASE WHEN ISNULL(O1.S01ID, '''') <> '''' AND ISNULL(O1.S02ID, '''') <> '''' AND ISNULL(O1.S03ID, '''') <> '''' 
					THEN CONCAT (ISNULL(O1.S01ID, ''''), '' x '', ISNULL(O1.S02ID, ''''), '' x '', ISNULL(O1.S03ID, ''''))
			  ELSE '''' END AS Size
	   
FROM OT2205 O1 WITH (NOLOCK)
LEFT JOIN OT2201 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK
WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + ''''


EXEC (@sSQL)
PRINT (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
