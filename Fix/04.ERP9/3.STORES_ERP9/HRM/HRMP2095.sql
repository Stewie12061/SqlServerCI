IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2095]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2095]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Đổ nguồn combo đề YCDT/KHDTDK
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 19/09/2017
---- <Example>
---- EXEC [HRMP2095] @DivisionID='AS',@UserID='ASOFTADMIN',@InheritID1='TR0001',@InheritID2='B1FF6B1A-8572-4F56-9149-E7F3FA9B0884'
---- 

CREATE PROCEDURE [dbo].[HRMP2095]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@InheritID1 AS NVARCHAR(1000),
	@InheritID2 AS NVARCHAR(1000)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

--Lấy dữ liệu kế hoạch đào tạo định kỳ		
EXEC [HRMP2098] @DivisionID,@UserID

SET @sSQL = '
SELECT TB.DepartmentID, AT1102.DepartmentName, TB.TrainingFieldID, HRMT1040.TrainingFieldName, FromDate, ToDate, 
TrainingPlanID AS ID, TransactionID AS InheritID, ''HRMT2071'' AS InheritTableID, DATEPART(QUARTER, FromDate) AS TranQuarter, DATEPART(YEAR, FromDate) AS TranYear
FROM HRMT2071_Temp TB
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = TB.DepartmentID  
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = TB.TrainingFieldID
WHERE DATEPART(YEAR, GETDATE())*100 + DATEPART(QUARTER, GETDATE()) = DATEPART(YEAR, FromDate)*100 + DATEPART(QUARTER, FromDate)
AND TB.TransactionID IN (''' + @InheritID2 + ''')
UNION ALL
SELECT HRMT2080.DepartmentID, AT1102.DepartmentName, HRMT2080.TrainingFieldID, HRMT1040.TrainingFieldName, TrainingFromDate AS FromDate, TrainingToDate AS ToDate, 
TrainingRequestID AS ID, TrainingRequestID AS InheritID, ''HRMT2080'' AS InheritTableID, NULL AS TranQuarter, NULL AS TranYear
FROM HRMT2080 WITH (NOLOCK)
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2080.DepartmentID
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2080.TrainingFieldID
WHERE HRMT2080.TrainingRequestID IN (''' + @InheritID1 + ''')'


--PRINT @sSQL
EXEC (@sSQL)	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
