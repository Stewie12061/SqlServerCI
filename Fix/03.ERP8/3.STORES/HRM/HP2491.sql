IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2491]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2491]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary> Store day du lieu khi quet tu dong may cham cong
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Trương Ngọc Phương Thảo on 29/01/2016
---- Modified by 
-- <Example>
---- 
CREATE PROCEDURE HP2491	
(
	@UserID varchar(20),
	@DivisionID varchar(20),
	@ScanDate Datetime,
	@TranMonth Int,
	@TranYear Int 
)
AS
SET NOCOUNT ON

DECLARE @Day int

SET @Day = Day(@ScanDate)

--- Xet du lieu loi thi khong cham cong
EXEC HP0197 @DivisionID, N'%', @TranMonth, @TranYear, @ScanDate, @ScanDate

--- Cham cong
exec HP2430 @DivisionID,@TranMonth,@TranYear,@ScanDate,@ScanDate,N'%',@UserID,N'%'

--- Ket chuyen sang cham cong ngay
exec HP2436 @DivisionID,N'%',N'%',@TranMonth,@TranYear,@ScanDate,@ScanDate,@UserID


IF (Convert(Date,@ScanDate) =  Convert(Date,DATEADD(mm,DATEDIFF(mm,0,@ScanDate)+1,-1)))
--- Ket chuyen sang cham cong thang
	exec HP2402 @DivisionID,N'%',N'%',N'%',N'%',@TranMonth,@TranYear,@UserID,'P01',@ScanDate,@ScanDate

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

