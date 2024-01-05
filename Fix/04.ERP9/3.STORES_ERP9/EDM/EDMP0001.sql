IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP0001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP0001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load form màn hình EDMF0001
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 10/09/2018
----Modified by 
-- <Example>
---- 
/*-- <Example>
	EDMP0001 @DivisionID = 'BE', @UserID = 'ASOFTADMIN'
	
	EDMP0001 @DivisionID, @UserID
----*/

CREATE PROCEDURE EDMP0001
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50)
	 
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@SalesAnaTypeID VARCHAR(50)

SELECT @SalesAnaTypeID = SalesAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID
     
SET @sSQL = @sSQL + N'
	SELECT NULL AS APK,A.DivisionID,A.AnaID,Null as IsUsed, Null as AccountID,Null as ReceiptTypeID,Null AS ReceiptTypeName, NULL AS AccountName, A.AnaName AS AnaName FROM AT1011 A WITH (NOLOCK) 
	WHERE A.AnaTypeID ='''+@SalesAnaTypeID+''' AND A.DivisionID IN ('''+@DivisionID+''', ''@@@'')
	AND A.AnaID NOT IN (SELECT A.AnaID FROM EDMT0001 B  WITH (NOLOCK) INNER JOIN AT1011 A WITH (NOLOCK) ON A.AnaID = B.AnaRevenueID WHERE B.DivisionID IN ('''+@DivisionID+''',''@@@''))
	UNION 
	SELECT T1.APK,T1.DivisionID,T1.AnaRevenueID,T1.IsUsed,T1.AccountID,T1.ReceiptTypeID,T4.ReceiptTypeName,T2.AccountName,T3.AnaName 
	FROM EDMT0001 T1 WITH (NOLOCK) 
	LEFT JOIN AT1005 T2 WITH (NOLOCK) ON T1.AccountID = T2.AccountID AND T2.DivisionID IN (T1.DivisionID,''@@@'')
	LEFT JOIN AT1011 T3 WITH (NOLOCK) ON T3.AnaID =T1.AnaRevenueID AND T3.DivisionID IN (T1.DivisionID,''@@@'') 
	LEFT JOIN EDMT1050 T4 WITH (NOLOCK) ON T4.ReceiptTypeID =T1.ReceiptTypeID AND T4.DivisionID IN (T1.DivisionID,''@@@'') 
	WHERE T1.DivisionID ='''+@DivisionID+'''
'
EXEC (@sSQL)
--PRINT(@sSQL)


   

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
