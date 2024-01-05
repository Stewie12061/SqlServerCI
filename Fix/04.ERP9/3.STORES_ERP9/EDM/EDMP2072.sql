IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2072]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2072]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Tab thông tin EDMF2072: master điều chuyển giáo viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 15/11/2018
-- <Example>
---- 
--	EDMP2072 @DivisionID='VS', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @APK=N'68371935-5A41-495B-912A-AA85F0A17673'

CREATE PROCEDURE [dbo].[EDMP2072]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX), @sWhere NVARCHAR(4000), @Param NVARCHAR(1000)
DECLARE @AttendanceDate DATETIME, @dStartMonth DATETIME, @dEndMonth DATETIME

--IF @LanguageID = 'vi-VN' SET @cLan = '' ELSE SET @cLan = 'E'

SET @sSQL = N'
SELECT A.DivisionID, A.APK, A.VoucherNo, A.DecisionDate, A.PromoterID, H1.FullName AS PromoterName
	, A.DivisionIDTo, C.DivisionName AS DivisionNameTo
	, A.DeciderID, H2.FullName AS DeciderName
	, A.Description, A.CreateUserID, A.CreateDate, A.LastModifyUserID, A.LastModifyDate, A.DeleteFlg
FROM EDMT2070 AS A WITH(NOLOCK) 
	LEFT JOIN (SELECT DivisionID, DivisionName FROM AT1101 WITH(NOLOCK) WHERE Disabled = 0) C ON A.DivisionIDTo = C.DivisionID
	LEFT JOIN AT1103 H1 WITH(NOLOCK) ON H1.EmployeeID = A.PromoterID
	LEFT JOIN AT1103 H2 WITH(NOLOCK) ON H2.EmployeeID = A.DeciderID
WHERE A.APK = @APK

'

SET @Param = '@DivisionID VARCHAR(50), @APK VARCHAR(50)'

EXEC sp_executesql @sSQL, @Param, @DivisionID, @APK


--PRINT @sSQL
--EXEC (@sSQL)

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

