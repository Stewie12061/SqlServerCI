IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----<Summary>
---- Kiểm tra trước khi sửa thiết lập xét duyệt
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Như Hàn, Date: 01/11/2018
---- Modified by ... on ...:
----<Example>
/*
	EXEC SP0050 'AS', 2, 11, 2018, ''
	
*/
CREATE PROCEDURE [dbo].[SP0050] 	
(
	@DivisionID NVARCHAR(50),
	@Mode		TINYINT, --0 sửa, 1 xóa, 2 Đổ nguồn
	@TranMonth INT,
	@TranYear INT,
	@AbsentType	NVARCHAR(500)
)
AS

DECLARE @Status INT, @Message NVARCHAR(50)

CREATE TABLE #Errors (Status TINYINT, Message VARCHAR(50), AbsentType VARCHAR(50))
--INSERT INTO #Errors (Status,Message, AbsentType)

IF @AbsentType = 'NS' -- Ngân sách
BEGIN
	IF EXISTS (SELECT Top 1 1 FROM AT9090 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear)
	BEGIN
		INSERT INTO #Errors (Status,Message, AbsentType)
		VALUES (1, 'OOFML000070', 'NS' )
		Goto EndMess
	END
END

IF @AbsentType = 'KHTC' -- Kế hoạch thu chi
BEGIN
	IF EXISTS (SELECT Top 1 1 FROM AT9090 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear)
	BEGIN
		INSERT INTO #Errors (Status,Message, AbsentType)
		VALUES (1, 'OOFML000070', 'KHTC' )
		Goto EndMess
	END
END

EndMess:
IF @Mode = 2 
	SELECT ID, ID1, OrderNo, Description, DescriptionE, Disabled, #Errors.Status FROM OOT0099 WITH (NOLOCK)
	LEFT JOIN #Errors ON #Errors.AbsentType = OOT0099.ID
	WHERE CodeMaster = 'Applying' AND Disabled = 0
ELSE
	SELECT Status,Message From #Errors

DROP TABLE #Errors
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

