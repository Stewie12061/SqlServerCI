IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2181]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2181]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----<Summary>
----Kiểm tra xóa hợp đông lao động (HRMF2180)
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Phương Thảo, Date: 08/08/2023
---- <Example>
---	exec HRMP2181 @DivisionID=N'MT',@APK=N'',@APKList=N'29cad19c-4b4f-468d-9371-cb38607ccf06',@Mode=1 

CREATE PROCEDURE HRMP2181
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
	
	CREATE TABLE #HRMP2181_Errors (APK Varchar(50),ContractID Varchar(50), MessageID Varchar(50))		

	SELECT APK,DivisionID,ContractID
	INTO #HRMP2181_HT1360
	FROM HT1360 WITH (NOLOCK) WHERE ContractID IN ('''+@APKList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #HRMP2181_HT1360 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #HRMP2181_Errors (APK,ContractID,MessageID)
		SELECT 	APK,ContractID,''00ML000050''
		FROM #HRMP2181_HT1360
		WHERE DivisionID <> '''+@DivisionID+'''
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #HRMP2181_Errors)
	BEGIN
		DELETE T1 FROM HT1360 T1 INNER JOIN #HRMP2181_HT1360 T2 ON T1.APK = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #HRMP2181_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + ContractID 
						FROM #HRMP2181_Errors T2 WITH(NOLOCK) 
						WHERE  T1.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #HRMP2181_Errors T1
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


