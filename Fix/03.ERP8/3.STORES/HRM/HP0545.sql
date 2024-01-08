IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0545]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0545]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- 
-- <Param>
---- Load dữ liệu tính lương thời vụ
-- <Return>
---- 
-- <Reference> HRM/Nghiep vu/ Tinh luong (PLUGIN NQH)
---- Bang phan ca
-- <History>
---- Modified Văn Tài on 16/12/2020: Tách chuỗi tránh TH quá số ký tự có thể chứa
---- Modified Văn Tài on 28/12/2020: Bổ sung cờ Đã tổng hợp.
-- <Example>
---- EXEC HP0545 'NQH', 12, 2020, 'A000000','E000000','P05', 'aaa', 'bbbb'
CREATE PROCEDURE HP0545	
(
	@DivisionID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@FromTeamID NVARCHAR(50),
	@ToTeamID nvarchar(50)
)
AS
DECLARE @SQL VARCHAR(MAX) = ''


SET @SQL = '
		SELECT  HT37.APK
			  , HT37.DivisionID
			  , HT37.EmployeeID
			  , HT37.EmployeeName
			  , HT37.TranMonth
			  , HT37.TranYear
			  , HT37.TeamID
			  , HT37.SectionID
			  , HT37.CheckInTime
			  , HT37.CheckOutTime
			  , HT37.BaseTimeAmount
			  , HT37.NightTimeAmount
			  , HT37.OTTimeAmount
			  , HT37.Date
			  , HT37.BaseSalary
			  , HT37.NightShiftSalary
			  , HT37.OTSalary
			  , HT37.EatingFee
			  , HT37.HeavyAllowance
			  , HT37.ServiceSalary
			  , HT37.TotalSalary
			  , ISNULL(HT37.IsCalculated, 0) AS IsCalculated
		FROM [HT0537] HT37
		WHERE  HT37.DivisionID = ''' + @DivisionID + '''
			  AND HT37.TranMonth = ' + STR(@TranMonth) + '
			  AND HT37.TranYear= ' + STR(@TranYear) + '			  
			  AND HT37.TeamID between ''' + @FromTeamID + ''' AND ''' + @ToTeamID + '''            
'

PRINT @SQL
EXEC (@SQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
