IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2167]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2167]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








----Created by: Trọng Kiên, date: 19/04/2021
----Update by: Hồng Thắm, date: 03/10/2023 - bổ sung lấy cột specification
---- Update by: Hồng Thắm, date: 22/11/2023 - Sắp xếp theo thứ tự tên nguyên liệu 
---- exec MP2167 @Divisionid=N'ANG',@Tranmonth=1,@Tranyear=2016,@APK=N''

CREATE PROCEDURE [dbo].[MP2167] 
				@DivisionID AS nvarchar(50),
				@APK AS nvarchar(4000)
AS

DECLARE @sSQL NVARCHAR(MAX) =''



SET @sSQL = N'SELECT O1.MaterialID, O1.MaterialName, O1.UnitName, O1.MaterialQuantity, O1.MDescription
	   , CASE WHEN ISNULL(O1.DS01ID, '''') <> '''' AND ISNULL(O1.DS02ID, '''') <> '''' AND ISNULL(O1.DS03ID, '''') <> '''' 
					THEN CONCAT (ISNULL(O1.S01ID, ''''), '' x '', ISNULL(O1.S02ID, ''''), '' x '', ISNULL(O1.S03ID, ''''))
			  WHEN ISNULL(O1.DS01ID, '''') <> '''' AND ISNULL(O1.DS02ID, '''') <> '''' AND ISNULL(O1.DS03ID, '''') = '''' 
					THEN CONCAT (ISNULL(O1.S01ID, ''''), '' x '', ISNULL(O1.S02ID, ''''))
			  ELSE '''' END AS Size
	   , CASE WHEN O1.IsChange = 0 THEN N''Không''
			  WHEN O1.IsChange = 1 THEN N''Có'' END AS IsChange
		, O1.Specification as Specification
	   
FROM OT2203 O1 WITH (NOLOCK)
LEFT JOIN OT2201 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK
WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + '''
ORDER BY ProductID, Orders'

EXEC (@sSQL)
PRINT (@sSQL)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
