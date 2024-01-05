IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP1001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP1001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load form xem thông tin định mức chi phí   
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - FN \ Danh mục \ Định mức chi phí\ Xem thông tin dịnh mức chi phí 
-- <History>
----Created by: Hồng Thảo , Date: 17/08/2018
-- <Example>
---- 
/*-- <Example>
	FNP1001 @DivisionID = 'AS', @UserID = 'ASOFTADMIN', @APK = 'BED174F3-10BE-4167-8685-539A0E37B109',@LanguageID = 'vi-VN'
	
	FNP1001 @DivisionID, @UserID, @APK,@LanguageID
----*/

CREATE PROCEDURE FNP1001
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''
     
SET @sSQL = @sSQL + N'
	SELECT T01.APK,T01.DivisionID,T01.NormID,T01.NormName,T01.AreaID,'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T02.Description' ELSE 'T02.DescriptionE' END+' AS AreaName,
	T01.CityID,T03.AnaName AS CityName,T01.CurrencyID,T04.CurrencyName,T01.Description,
	T01.IsCommon,'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T07.Description' ELSE 'T07.DescriptionE' END+' AS CommonName,
	T01.Disabled,'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T08.Description' ELSE 'T08.DescriptionE' END+' AS DisabledName,
	T01.CreateUserID,T05.FullName AS CreateUserName,T01.CreateDate,T01.LastModifyUserID,T06.FullName AS LastModifyUserName, T01.LastModifyDate
    FROM FNT1000 T01 WITH (NOLOCK)
    LEFT JOIN FNT0099 T02 WITH (NOLOCK) ON T01.AreaID = T02.ID AND T02.CodeMaster = ''Area'' 
	LEFT JOIN AT1015 T03 WITH (NOLOCK) ON T03.DivisionID IN (T01.DivisionID, ''@@@'') AND T03.AnaID = T01.CityID AND T03.AnaTypeID = ''O01''
	LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T04.DivisionID IN (T01.DivisionID, ''@@@'') AND T04.CurrencyID = T01.CurrencyID
	LEFT JOIN AT1103 T05 WITH (NOLOCK) ON T05.DivisionID = T01.DivisionID AND T05.EmployeeID = T01.CreateUserID
	LEFT JOIN AT1103 T06 WITH (NOLOCK) ON T06.DivisionID = T01.DivisionID AND T06.EmployeeID = T01.LastModifyUserID
	LEFT JOIN CIT0099 T07 WITH (NOLOCK) ON T01.AreaID = T07.ID AND T07.CodeMaster = ''Disabled''
	LEFT JOIN CIT0099 T08 WITH (NOLOCK) ON T01.AreaID = T08.ID AND T08.CodeMaster = ''Disabled''
	WHERE T01.APK = '''+@APK+''' 
'
EXEC (@sSQL)
--PRINT(@sSQL)

   

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
