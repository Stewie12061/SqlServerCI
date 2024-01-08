SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load dữ liệu màn hình Cảnh báo nhân viên tới hạn gia hạn hợp đồng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 28/12/2015 by Phương Thảo
----  Modify on  04/03/2016 by Phương Thảo: Chỉnh sửa store, nếu là ADMIN thì thấy tất cả và chỉ phân quyền cho KH Meiko
---- Modified by Tiểu Mai on 01/08/2016: Fix bug chưa lấy được hợp đồng gần nhất
---- Modified by Huỳnh Thử on 14/01/2020: Tạo View để chứa những nhân viên có trong danh sách thông báo
-- <Example>
---- EXEC HP03293 @DivisionID='CTY',@UserID= '008004'
--- exec HP03293 'CTY','008004'
ALTER PROCEDURE HP03293
( 
		@DivisionID VARCHAR(50),
		@UserID VARCHAR(50)
		
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
        @sWhere NVARCHAR(MAX),
        @Manager VARCHAR(50),
        @DutyID VARCHAR(50),
        @StrDutyID VARCHAR(2000),		
		@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
   
   	   
SET @Manager=(SELECT DutyID FROM HT1403 WHERE EmployeeID=@UserID)

SELECT @DutyID =  DutyID FROM HT1102 WHERE ManagerDutyID = @Manager

 --SELECT @Manager, @DutyID
SET @StrDutyID = ''''+ISNULL(@DutyID,'')+''''

 WHILE (ISNULL(@DutyID,'') <> '')
	BEGIN		
		IF NOT EXISTS (SELECT TOP 1 1 FROM HT1102 WHERE ManagerDutyID = @DutyID)
			SET @DutyID = ''
		ELSE
		BEGIN
			SELECT @DutyID =  isnull(DutyID,'') FROM HT1102 WHERE ManagerDutyID = @DutyID
			SELECT @StrDutyID = @StrDutyID + CASE WHEN @StrDutyID = '' THEN ''''+@DutyID+'''' ELSE ','+ ''''+@DutyID+'''' END
			--SELECT @StrDutyID
		END	
				
	END
	
	SELECT @StrDutyID = '('+@StrDutyID+')'
	
SET @sSQL = N'	
SELECT A.EmployeeID,A.ContractTypeID,datediff(day,getdate(),dateadd(month,Months,B.SignDate)) AS [Day]
FROM HT1360 A WITH (NOLOCK) 
LEFT JOIN (SELECT DivisionID, EmployeeID, MAX(SignDate) AS SignDate FROM HT1360 WITH (NOLOCK)
 GROUP BY DivisionID, EmployeeID ) B ON A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND Isnull(B.SignDate,'''') = Isnull(A.SignDate,'''')
INNER JOIN HV1400 on HV1400.EmployeeID = A.EmployeeID And HV1400.DivisionID = A.DivisionID And EmployeeStatus  in(1,2)
LEFT JOIN HT1105 WITH (NOLOCK) on A.ContractTypeID= HT1105.ContractTypeID And A.DivisionID= HT1105.DivisionID
LEFT JOIN  HT0000 DEF  WITH (NOLOCK) on Def.DivisionID = A.DivisionID
WHERE  A.DivisionID = '''+@DivisionID+'''
    And Months <> 0
 and  IsNull(A.IsAppendix,'''') <>1
    And (
(HV1400.EmployeeStatus = 1 AND datediff(day,getdate(),dateadd(month,Months, B.SignDate)) <= def.IsWarningContract )
OR (HV1400.EmployeeStatus = 2 AND datediff(day,getdate(),dateadd(month,Months,B.SignDate)) <= def.WarningContractCandidate)
    )'+ CASE WHEN @CustomerName = 50 AND @UserID <> 'ASOFTADMIN' THEN '
    AND A.EmployeeID IN (SELECT EmployeeID FROM HT1403 WITH (NOLOCK) WHERE DutyID IN ( '+@StrDutyID+'))
' ELSE '' END


--PRINT @sSQL

IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ThongBaoGiaHan]') AND TYPE IN (N'V'))
DROP VIEW ThongBaoGiaHan

EXEC  ( ' CREATE VIEW ThongBaoGiaHan AS ' + @sSQL)
EXEC  (@sSQL)


GO

