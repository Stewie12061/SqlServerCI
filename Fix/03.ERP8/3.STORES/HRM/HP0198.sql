IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0198]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0198]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






--- Created by: Phương Thảo, date: 01/04/2016
--- Purpose: Quét dữ liệu bất thường khi làm nghiệp vụ quét thẻ chấm công
 ---- Modify by Phương Thảo on 14/06/2016 : Bỏ vòng lặp, cải tiến tốc độ. Bổ sung loại bất thường "Sai ca làm việc"
 ---- Modified by Kim Thư on 07/12/2016: Kiểm tra nếu DB có dùng table của ERP9 thì mới chạy store OOP2061



CREATE PROCEDURE [dbo].[HP0198]
				@DivisionID as nvarchar(50),
				@DepartmentID as nvarchar(50),
				@TranMonth as int,
				@TranYear as int,
				@FromDate as datetime,
				@ToDate as datetime = NULL,
				@UserID VARCHAR(50)

AS
SET NOCOUNT ON

DECLARE @SQL NVarchar(4000) = ''
DECLARE @Times Int, @i Int, @MaxDate Datetime



SELECT	@MaxDate = MAX(AbsentDate)
FROM	HT2408
WHERE	 TranYear = @TranYear AND TranMonth = @TranMonth


IF (Convert(Date,@ToDate) =  Convert(Date,DATEADD(mm,DATEDIFF(mm,0,@ToDate)+1,-1)))
	Select @ToDate = @MaxDate
	
IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS TAB WHERE TAB.Name like 'OOT%')	
	SET @SQL = '
	
		EXEC OOP2061 '''+@DivisionID+''','''+@UserID+''', '+STR(@TranMonth)+', '+STR(@TranYear)+', '''+Convert(NVarchar(10),@FromDate,101)+''','''+Convert(NVarchar(10),@ToDate,101)+'''
		'

-- Print @SQL
EXEC (@SQL)


SET NOCOUNT OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

