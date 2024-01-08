IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lưu kế thừa OOP2004: Lưu kế thừa
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trần Quốc Tuấn, Date: 08/12/2015
-- <Example>
---- 
/*
   OOP2004 'CTY','ASOFTADMIN',8,2015,'160872B6-3A98-41C7-B8E8-B70A22F221C9','160872B6-3A98-41C7-B8E8-B70A22F221C9'
*/
CREATE PROCEDURE OOP2004
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@OldAPK VARCHAR(50),
	@NewAPK VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR (MAX) = ''

INSERT INTO OOT2000(DivisionID, APKMaster, EmployeeID, D01, D02, D03, D04, D05,
            D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16,D17, D18, D19,
            D20, D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31, Note)
SELECT @DivisionID,@NewAPK, EmployeeID, D01, D02, D03, D04, D05,
            D06, D07, D08, D09, D10, D11, D12, D13, D14, D15, D16,D17, D18, D19,
            D20, D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31, Note
FROM OOT2000
WHERE DivisionID=@DivisionID
AND APKMaster=@OldAPK


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
