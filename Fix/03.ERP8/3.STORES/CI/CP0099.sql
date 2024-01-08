IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0099]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CP0099]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh sách mã phân tích theo đối tượng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Khả Vi on 13/11/2017
---- Modified by on
-- <Example>
---- 
/*
* [CP0099] @DivisionID = 'TG', @UserID = 'ASOFTADMIN', @ObjectID = '0000000001', @AnaTypeID = 'O03'
* 
* 
  [CP0099] @DivisionID, @UserID, @ObjectID, @AnaTypeID
*/
CREATE PROCEDURE [CP0099]
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50), 
	@ObjectID VARCHAR(50),
	@AnaTypeID VARCHAR(50)
)
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@AnaID NVARCHAR (MAX) 

SET @AnaID = (SELECT TOP 1 CT0145.AnaID FROM CT0145 
			INNER JOIN AT1011 ON AT1011.DivisionID IN (@DivisionID, '@@@') AND CT0145.AnaID = AT1011.AnaID AND CT0145.TypeID = AT1011.AnaTypeID
            WHERE CT0145.ObjectID = @ObjectID AND CT0145.DivisionID = @DivisionID)

IF ISNULL(@AnaID, '') <> ''
	BEGIN
		SET @sSQL = N'
		SELECT CT0145.TypeID AS AnaTypeID, CT0145.AnaID, AT1011.AnaName
		FROM CT0145 WITH (NOLOCK)
		INNER JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND CT0145.ObjectID = AT1202.ObjectID
		INNER JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID IN ('''+@DivisionID+''', ''@@@'')  AND CT0145.AnaID = AT1011.AnaID AND CT0145.TypeID = AT1011.AnaTypeID
		WHERE CT0145.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND CT0145.ObjectID = '''+@ObjectID+'''
	'
		--PRINT(@sSQL)
		EXEC (@sSQL)
	END
ELSE
	BEGIN
		EXEC [AP0082] @DivisionID 
	END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
