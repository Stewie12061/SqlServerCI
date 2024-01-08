IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2211]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2211]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----<Summary>
----Kiểm tra xóa hồ sơ nhân viên (HRMF2210)
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Phương Thảo, Date: 14/11/2023
---- <Example>
---	exec HRMP2211 @DivisionID=N'BBA-SI',@TableID=N'HRMT2210',@APK=NULL,@APKList=N'9dd6814e-eab4-4c29-946c-80cedeffb5e9',@Mode=1,@IsDisable=0,@UserID=N'ADMIN'

CREATE PROCEDURE HRMP2211
		( @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
		  @APKList NVARCHAR(MAX) = '', 
		  @APK VARCHAR(50) = '',
		  @TableID VARCHAR(50) =N'HRMT2210',
		  @IsDisable tinyint  ,
		  @UserID VARCHAR(50) ,
		  @Mode tinyint                 --1: Xóa
		) 
AS 

DECLARE @sSQL NVARCHAR(MAX)	


IF @Mode = 1 ---Xóa
BEGIN
	SET @sSQL = N'
	
	CREATE TABLE #HRMP2211_Errors (APK Varchar(50),EmployeeID Varchar(50), MessageID Varchar(50))		

	SELECT APK,DivisionID,EmployeeID
	INTO #HRMP2211_HT1400
	FROM HT1400 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #HRMP2211_HT1400 WHERE DivisionID <> '''+@DivisionID+''')
	BEGIN 
		INSERT INTO #HRMP2211_Errors (APK,EmployeeID,MessageID)
		SELECT 	APK,EmployeeID,''00ML000050''
		FROM #HRMP2211_HT1400
		WHERE DivisionID <> '''+@DivisionID+'''
	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #HRMP2211_Errors)
	BEGIN
	 
		UPDATE HT1400  SET DeleteFlg = 1  FROM HT1400 HT14 INNER JOIN #HRMP2211_HT1400 T2 ON HT14.APK = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #HRMP2211_Errors T3 WITH (NOLOCK) WHERE HT14.APK = T3.APK)
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + EmployeeID 
						FROM #HRMP2211_Errors T2 WITH(NOLOCK) 
						WHERE  HT14.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #HRMP2211_Errors HT14
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


