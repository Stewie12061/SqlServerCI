IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[OP0169]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OP0169]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
 ---- 
 ---- Do nguon luoi Danh muc tien san xuat
 -- <Param>
 ---- @Mode = 0: Them moi, @Mode = 1: Sua
 -- <Return>
 ---- 
 -- <Reference>
 ---- OP/Danh muc/ Tien do san xuat/Them, xem, sua - OF0169
 -- <History> 
----- Created by: Trương Ngọc Phương Thảo on 04/05/2017
----- Modify on 
/*-- <Example>
EXEC OP0169 'MK', '', 1
----*/

CREATE PROCEDURE [dbo].[OP0169]
				@DivisionID as nvarchar(50),				
				@ProgressID as nvarchar(50),				
				@Mode as Int = 0

AS
SET NOCOUNT ON

Declare @SQL NVarchar(4000) = ''

SET @SQL = N'
SELECT	T1.TransactionID, T1.StepID, T2.StepName, T1.Days, T1.Colors
FROM	OT0169 T1
LEFT JOIN OT0167 T2 ON T1.DivisionID = T2.DivisionID AND T1.StepID = T2.StepID
WHERE	T1.ProgressID = '''+@ProgressID+''' AND T1.DivisionID = '''+@DivisionID+''' 
ORDER BY T1.OrderNo, T1.TransactionID, T1.StepID
'

EXEC (@SQL)


--IF(@Mode = 0) -- Them moi
--BEGIN
--	SELECT	TypeID AS StepID, UserName AS StepName,  UserNameE AS StepNameE, null AS Days
--	FROM	OT0005
--	WHERE	DivisionID = @DivisionID AND TypeID LIKE 'ST%' AND IsUsed = 1
--END
--ELSE
--IF(@Mode = 1) -- Sua
--BEGIN
--	SELECT	T1.StepID, T2.UserName AS StepName,  T2.UserNameE AS StepNameE, T1.Days
--	FROM	OT0169 T1
--	LEFT JOIN OT0005 T2 ON T1.DivisionID = T2.DivisionID AND T1.StepID = T2.TypeID
--	WHERE	T1.ProgressID = @ProgressID AND T1.DivisionID = @DivisionID 
--			AND T2.TypeID LIKE 'ST%' and T2.IsUsed = 1
--END


SET NOCOUNT OFF



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

