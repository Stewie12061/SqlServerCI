IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1091]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1091]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----<Summary>
----Kiểm tra xóa chấm công ngày/tháng (HRMF1090)
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Phương Thảo, Date: 14/12/2023
---- <Example>
---	exec HRMP1091 @DivisionID=N'BBA-SI',@TableID=N'HRMT1090',@APK=NULL,@APKList=N'4ac3c287-143b-4c5f-80c1-b283503ec89d',@Mode=1,@IsDisable=0,@UserID=N'ADMIN'

CREATE PROCEDURE HRMP1091
		( @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
		  @APKList NVARCHAR(MAX) = '', 
		  @APK VARCHAR(50) = '',
		  @TableID VARCHAR(50) =N'HRMT1090',
		  @IsDisable tinyint  ,
		  @UserID VARCHAR(50) ,
		  @Mode tinyint                 --1: Xóa
		) 
AS 

DECLARE @sSQL NVARCHAR(MAX)	


IF @Mode = 1 ---Xóa
BEGIN
	SET @sSQL = N'
	
	CREATE TABLE #HRMP1091_Errors (APK Varchar(50),AbsentTypeID Varchar(50), MessageID Varchar(50))		

	SELECT APK,DivisionID,AbsentTypeID
	INTO #HRMP1091_HT1013
	FROM HT1013 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #HRMP1091_HT1013 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #HRMP1091_Errors (APK,AbsentTypeID,MessageID)
		SELECT 	APK,AbsentTypeID,''00ML000050''
		FROM #HRMP1091_HT1013
		WHERE DivisionID <> '''+@DivisionID+'''
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #HRMP1091_Errors)
	BEGIN
	 
		UPDATE HT1013  SET DeleteFlg = 1  FROM HT1013 HT13 INNER JOIN #HRMP1091_HT1013 T2 ON HT13.APK = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #HRMP1091_Errors T3 WITH (NOLOCK) WHERE HT13.APK = T3.APK)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + AbsentTypeID 
						FROM #HRMP1091_Errors T2 WITH(NOLOCK) 
						WHERE  HT13.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #HRMP1091_Errors HT13
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
