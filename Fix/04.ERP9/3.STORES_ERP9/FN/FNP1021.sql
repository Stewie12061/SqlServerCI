IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP1021]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[FNP1021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin mức độ ưu tiên FNF1021, FNF1022
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 02/11/2018
--- Modify by Như Hàn on 19/01/2019: Sửa lại điều kiện where theo đơn vị
-- <Example>

/*-- <Example>
	FNP1021 @DivisionID='AS',@UserID='ASOFTADMIN',@APK ='DAF414E6-68E3-42D2-8B69-D27DD6D9C603', @LanguageID ='vi-VN'


	FNP1021 @DivisionID,@UserID,@APK, @LanguageID
	----*/

CREATE PROCEDURE FNP1021
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APK VARCHAR(50),
	@LanguageID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)
 

SET @sSQL = '
	SELECT T1.APK,T1.DivisionID,T1.PriorityID,T1.PriorityName,T1.PlanTypeID,T2.AnaName AS PlanTypeName, T1.Notes,
	T1.IsCommon,'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.Description' ELSE 'T3.DescriptionE' END+' AS CommonName,
	T1.Disabled,'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T4.Description' ELSE 'T4.DescriptionE' END+' AS DisabledName,
	T1.CreateUserID,T5.FullName AS CreateUserName,T1.CreateDate,T1.LastModifyUserID,T6.FullName AS LastModifyUserName,T1.LastModifyDate
	FROM FNT1020 T1 WITH (NOLOCK)
    LEFT JOIN AT1011 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T2.AnaID = T1.PlanTypeID AND T2.AnaTypeID = ''A06''
	LEFT JOIN AT0099 T3 ON T3.ID = T1.IsCommon AND T3.CodeMaster = ''AT00000004''
	LEFT JOIN AT0099 T4 ON T4.ID = T1.IsCommon AND T4.CodeMaster = ''AT00000004''
	LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.EmployeeID = T1.CreateUserID
	LEFT JOIN AT1103 T6 WITH (NOLOCK) ON T6.DivisionID = T1.DivisionID AND T6.EmployeeID = T1.LastModifyUserID
	WHERE T1.DivisionID IN ( '''+@DivisionID +''',''@@@'') AND T1.APK ='''+ @APK +'''
'

EXEC (@sSQL)
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


