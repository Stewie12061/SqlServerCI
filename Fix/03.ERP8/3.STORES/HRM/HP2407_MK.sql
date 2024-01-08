IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2407_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2407_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---Created by: Dang Le Bao Quynh; Date 05/10/2007
---purpose: Xoa quet the 

/********************************************
'* Edited by: [GS] [Mỹ Tuyền] [30/07/2010]
'********************************************/
--- Modify on 18/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ

CREATE PROCEDURE [dbo].[HP2407_MK] @DivisionID nvarchar(50),
				@DepartmentID nvarchar(50),
				@EmployeeID nvarchar(50),
				@TransactionID nvarchar(50),
				@TranMonth int,
				@TranYear int,
				@FromDate datetime,
				@ToDate datetime
 AS

DECLARE	@sSQL001 Nvarchar(4000),
		@TableHT2407 Varchar(50),		
		@TableHT2400 Varchar(50),		
		@sTranMonth Varchar(2)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2407 = 'HT2407M'+@sTranMonth+Convert(Varchar(4),@TranYear),
			@TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2407 = 'HT2407',
			@TableHT2400 = 'HT2400'
END

SET @sSQL001 = N'
Delete T00 
From '+@TableHT2407+' T00 inner join '+@TableHT2400+' T01 on T00.EmployeeID = T01.EmployeeID 
and T00.TranMonth = T01.Tranmonth  
and T00.TranYear = T01.TranYear
and T00.DivisionID = T01.DivisionID 
Where  T00.DivisionID = '''+@DivisionID+''' and 
	T01.DepartmentID like '''+@DepartmentID+''' and
	T00.EmployeeID like '''+@EmployeeID+''' and
	T00.TransactionID like '''+@TransactionID+''' and
	T00.TranMonth = '+STR(@TranMonth)+' and
	T00.TranYear = '+STR(@TranYear)+' and
	T00.AbsentDate between '''+Convert(Varchar(20),@FromDate,101)+''' And '''+Convert(Varchar(20),@ToDate,101)+'''
'
--Print @sSQL001
EXEC (@sSQL001)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
