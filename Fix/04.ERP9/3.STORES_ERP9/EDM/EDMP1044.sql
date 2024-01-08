IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP1044]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP1044]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra tồn tại Ngày trong Năm học
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa , Date: 17/02/2019
---- Modified by on 
-- <Example>
---- 
/*-- <Example>
	EDMP1044 @DivisionID = 'BE', @DateFrom='2017-05-01', @DateTo ='2017-08-31'
	
	EDMP1044 @DivisionID, @DateFrom, @DateTo

----*/

CREATE PROCEDURE EDMP1044
( 
	 @DivisionID VARCHAR(50),
	 @DateFrom Datetime,
	 @DateTo Datetime
)
AS 

DECLARE @sSQL NVARCHAR (MAX) = N''
set @sSQL =  @sSQL + N'SELECT TOP 1 1 FROM EDMT1040  WITH (NOLOCK) WHERE ''' + CONVERT(VARCHAR(10), @DateFrom, 112)  + ''' BETWEEN DateFrom AND DateTo AND DivisionID = '''+@DivisionID+'''
UNION ALL
SELECT TOP 1 1 FROM EDMT1040  WITH (NOLOCK) WHERE ''' + CONVERT(VARCHAR(10), @DateTo, 112)+ ''' BETWEEN DateFrom AND DateTo AND DivisionID = '''+@DivisionID+''' '


EXEC (@sSQL)
--PRINT(@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

