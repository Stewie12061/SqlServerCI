IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20411]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20411]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load danh sách CampaignType theo CustomerIndex
---- Created by Anh Đô on 12/12/2022
-- <Example> 
CREATE PROCEDURE CRMP20411 
(
	@DivisionID	VARCHAR(50)
)

AS
BEGIN
	DECLARE @CustomerIndex INT
		   ,@sSql		   NVARCHAR(MAX)
		   ,@CodeMaster	   VARCHAR(25)

	SELECT @CustomerIndex = CustomerName FROM CustomerIndex

	IF @CustomerIndex = 130
		SET @CodeMaster = 'CRMT00000032'
	ELSE IF @CustomerIndex IN (-1, 92)
		SET @CodeMaster = 'CRMT00000011'
	
	SET @sSql = 'SELECT CodeMaster, ID, Description, DescriptionE
	FROM CRMT0099 WITH (NOLOCK)
	WHERE ISNULL(Disabled, 0) = 0 AND CodeMaster = '''+ @CodeMaster +''''

	--PRINT(@sSQL)
	EXEC(@sSql)
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
