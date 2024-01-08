IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0406]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0406]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Lưu dữ liệu thiết lập phương pháp tính phép cho nhân viên (ERP 9.0)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tiểu Mai on 12/12/2016
---- Modified by Tiểu Mai on 17/04/2017: Thay đổi cách thực hiện, cải tiến tốc độ
---- Modified by Văn Tài  on 15/07/2022: Xử lý bảng tạm theo quy tắc
-- <Example>
---- 
/*-- <Example>
	EXEC HP0406 @DivisionID='ANG',@MethodVacationID=NULL,
----*/

CREATE PROCEDURE HP0406
( 
	 @DivisionID VARCHAR(50),
	 @MethodVacationID NVARCHAR(50), --- NULL: Lưới chưa thiết lập
	 @ListEmpLoaMonthID XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX)

-- Xu li du lieu xml
CREATE TABLE #HP0406 (EmpLoaMonthID VARCHAR(50))


INSERT INTO #HP0406
SELECT X.Data.query('EmpLoaMonthID').value('.', 'NVARCHAR(50)') AS EmpLoaMonthID
FROM @ListEmpLoaMonthID.nodes('//Data') AS X (Data)

UPDATE HT2803 
SET MethodVacationID = NULL
FROM HT2803 
WHERE MethodVacationID = @MethodVacationID

UPDATE HT2803 
SET MethodVacationID = @MethodVacationID
FROM HT2803 
INNER JOIN #HP0406 t1 ON t1.EmpLoaMonthID = HT2803.EmpLoaMonthID	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
