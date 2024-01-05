IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2191]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2191]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----<Summary>
----Kiểm tra xóa hồ sơ bảo hiểm (HRMF2190)
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Phương Thảo, Date: 17/08/2023
---- <Example>
---	exec HRMP2191 @DivisionID=N'MT',@APK=N'',@APKList=N'29cad19c-4b4f-468d-9371-cb38607ccf06',@Mode=1 

CREATE PROCEDURE HRMP2191
		( @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
		  @APKList NVARCHAR(MAX) = '', 
		  @APK VARCHAR(50) = '',
		  @Mode tinyint                 --1: Xóa
		) 
AS 

DECLARE @sSQL NVARCHAR(MAX)	


IF @Mode = 1 ---Xóa
BEGIN
	SET @sSQL = N'
	
	CREATE TABLE #HRMP2191_Errors (APK Varchar(50),InsurFileID Varchar(50), MessageID Varchar(50))		

	SELECT APK,DivisionID,InsurFileID
	INTO #HRMP2191_HT2460
	FROM HT2460 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #HRMP2191_HT2460 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #HRMP2191_Errors (APK,InsurFileID,MessageID)
		SELECT 	APK,InsurFileID,''00ML000050''
		FROM #HRMP2191_HT2460
		WHERE DivisionID <> '''+@DivisionID+'''
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #HRMP2191_Errors)
	BEGIN
		DELETE T1 FROM HT2460 T1 INNER JOIN #HRMP2191_HT2460 T2 ON T1.APK = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #HRMP2191_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + InsurFileID 
						FROM #HRMP2191_Errors T2 WITH(NOLOCK) 
						WHERE  T1.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #HRMP2191_Errors T1
			ORDER BY MessageID
	END
	'
END

PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


