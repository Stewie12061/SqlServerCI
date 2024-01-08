IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP0012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP0012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Form HRMF0010: Thiết lập hệ thống module tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi on 13/12/2017
-- <Example>
---- 
/*-- <Example>
	HRMP0010 @DivisionID='AS'

	
----*/

CREATE PROCEDURE HRMP0012
( 
	 @DivisionID VARCHAR(50)
)
AS 

DECLARE @sSQL NVARCHAR(MAX), 
		@sSQL1 NVARCHAR(MAX), 
		@VoucherTypeID VARCHAR(50)

SELECT HRMT0010.DivisionID, HRMT0010.VoucherTypeID, HRMT0010.GroupID
INTO #Temp
FROM HRMT0010 WITH (NOLOCK)
WHERE DivisionID = @DivisionID

SELECT * 
INTO #Temp_VoucherType
FROM (SELECT DivisionID, VoucherTypeID, GroupID FROM #Temp) P 
PIVOT (MAX(VoucherTypeID) FOR GroupID IN ([01], [02], [03], [04], [05], [06])) AS PIV

SELECT * FROM #Temp_VoucherType

DROP TABLE #Temp
DROP TABLE #Temp_VoucherType

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
