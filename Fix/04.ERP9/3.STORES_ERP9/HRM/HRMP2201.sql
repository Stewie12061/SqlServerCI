IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2201]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2201]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----<Summary>
----Kiểm tra xóa kết quả thử việc (HRMF2200)
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Phương Thảo, Date: 18/10/2023
---- <Example>
---	exec HRMP2201 @DivisionID=N'MT',@APK=N'',@APKList=N'29cad19c-4b4f-468d-9371-cb38607ccf06',@Mode=1 

CREATE PROCEDURE HRMP2201
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
	
	CREATE TABLE #HRMP2201_Errors (APK Varchar(50),ResultNo Varchar(50), MessageID Varchar(50))		

	SELECT APK,DivisionID,ResultNo
	INTO #HRMP2201_HT0534
	FROM HT0534 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #HRMP2201_HT0534 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #HRMP2201_Errors (APK,ResultNo,MessageID)
		SELECT 	APK,ResultNo,''00ML000050''
		FROM #HRMP2201_HT0534
		WHERE DivisionID <> '''+@DivisionID+'''
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #HRMP2201_Errors)
	BEGIN
	  UPDATE OOT9000 SET DeleteFlag = 1 FROM OOT9000 OT90 INNER JOIN #HRMP2201_HT0534 T1 ON OT90.APK = T1.APK
		UPDATE HT0534  SET DeleteFlg = 1  FROM HT0534 HT34 INNER JOIN #HRMP2201_HT0534 T2 ON HT34.APK = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #HRMP2201_Errors T3 WITH (NOLOCK) WHERE HT34.APK = T3.APK)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + ResultNo 
						FROM #HRMP2201_Errors T2 WITH(NOLOCK) 
						WHERE  HT34.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #HRMP2201_Errors HT34
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


