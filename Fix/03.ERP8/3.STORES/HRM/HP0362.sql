IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0362]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0362]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
GO
/****** Object:  StoredProcedure [dbo].[HP1903]    Script Date: 15/7/2015 9:16:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/***************************************************************
'* Edited by : [SOF] [ThanhThinh] [30/07/2010]
   Edited by : [Huỳnh Thử] -- Fix lỗi chạy tool run all Fix
'**************************************************************/
CREATE PROCEDURE [dbo].[HP0362]	
	@TranYear INT,
	@TranMonth INT ,		
	@EmployeeId varchar(50) = NULL
AS
BEGIN
	--TRUY VẤN TẤT CẢ NHÂN VIÊN CÓ TRẠNG THÁI CHO PHÉP GỞI MAIL QUA LƯƠNG. 			

	UPDATE TD
	SET TD.[Status] = 2
	FROM HT0358 TD
	WHERE TD.EmployeeID = @EmployeeId
		AND TD.TranMonth = @TranMonth
		AND TD.TranYear = @TranYear

END