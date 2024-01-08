IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'DBO.CMNP0001') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE DBO.CMNP0001
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- @Summary>
---- Load Grid Form CRMF0001: Danh sách chức vụ phân quyền
-- @Param>
---- 
-- @Return>
---- 
-- @Reference>
---- 
-- @History>
----Created by: Thị Phượng, Date: 04/05/2017
-- @Example>
---- 
/*
	CMNP0001 @DivisionID='AS',@UserID='PHUONG',@VoucherTypeID='SO',@RollLevel=1

*/
CREATE PROCEDURE dbo.CMNP0001
(	
	@DivisionID VARCHAR(70),
	@UserID VARCHAR(70),
	@VoucherTypeID VARCHAR(50),
	@RollLevel VARCHAR(50)
)
AS
Declare @APKMaster VARCHAR(50) = (Select isnull(APK,'') From CIT1201 Where DivisionID = @DivisionID and VoucherTypeID =@VoucherTypeID)

SELECT DISTINCT  HT2.DutyID, HT2.DutyName,
(CASE WHEN M.DutyID IS NULL THEN 0 ELSE 1 END) IsPermision,
(CASE WHEN M.DutyID IS NOT NULL THEN 1 ELSE 0 END) IsLock Into #Temp01
FROM HT1102 HT2
FULL JOIN CIT1202 M ON M.DivisionID=HT2.DivisionID AND M.DutyID=HT2.DutyID AND  M.RollLevel = RollLevel AND M.APKMaster=@APKMaster
Where HT2.DivisionID =@DivisionID
Select Distinct x.DutyID , HT1.DutyName, (CASE WHEN M.DutyID IS NULL THEN 0 ELSE 1 END) IsPermision,
(CASE WHEN M.DutyID IS NOT NULL THEN 1 ELSE 0 END) IsLock  Into #Temp02 from 
(
Select EmployeeID, DutyID From AT1103 Where DepartmentID in (select NodeID From CIT1101 where NodeTypeID = 'DepartmentID')
Union all 
Select EmployeeID, DutyID From AT1103 Where TeamID in (select NodeID From CIT1101 where NodeTypeID = 'TeamID'))x
Left JOIn HT1102 HT1 On HT1.DutyID = x.DutyID 
FULL JOIN CIT1202 M ON M.DivisionID= @DivisionID AND M.DutyID=X.DutyID AND M.RollLevel=@RollLevel AND M.APKMaster=@APKMaster
Where HT1.DivisionID =@DivisionID
If Exists (Select Top 1 1  From #Temp02 WHERE DutyID is not null )
Begin 
	SELECT ROW_NUMBER() OVER (ORDER BY DutyID) AS RowNumber,COUNT(*) OVER () AS TotalRow, A.*
	FROM #Temp02 A
End
else 
Begin 
	SELECT ROW_NUMBER() OVER (ORDER BY DutyID) AS RowNumber,COUNT(*) OVER () AS TotalRow, A.*
	FROM #Temp01 A
End

--print (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
