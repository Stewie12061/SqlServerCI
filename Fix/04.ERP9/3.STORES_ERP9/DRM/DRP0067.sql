IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[DRP0067]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[DRP0067]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load dữ liệu màn hình nhập dữ liệu từ Excel AS0067
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 28/09/2011 by 
---- 
---- Modified on 28/09/2011 by 
-- <Example>
---- DRP0067 'XR','ASOFTADMIN',10,2014,'SalaryFile',0,'XML'
CREATE PROCEDURE DRP0067
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@ImportTransTypeID NVARCHAR(250),
	@Mode TINYINT, --0 chưa hết dữ liệu, 1: hết dữ liệu
	@TransactionKey NVARCHAR(50),
	@XML XML
) 
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sParamDef NVARCHAR(2000)
	SET @sParamDef = N'@DivisionID NVARCHAR(50), @UserID NVARCHAR(50), @TranMonth INT, @TranYear INT, @Mode TINYINT,
					   @ImportTransTypeID NVARCHAR(250), @ImportTemplateID NVARCHAR(250) = NULL, @TransactionKey NVARCHAR(50), @XML XML'
	SET @sSQL = (SELECT TOP 1 ExecSQL FROM A00065 WHERE ImportTransTypeID = @ImportTransTypeID)

	EXECUTE sp_executesql @sSQL, @sParamDef, @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear,
						  @Mode = @Mode, @ImportTransTypeID = @ImportTransTypeID, @TransactionKey = @TransactionKey, @XML = @XML



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
