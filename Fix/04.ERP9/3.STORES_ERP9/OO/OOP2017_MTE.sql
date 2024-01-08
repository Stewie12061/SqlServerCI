IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2017_MTE]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2017_MTE]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Tính Thời gian làm thêm giờ theo ca làm việc
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Lương Mỹ on 24/03/2020: Tạo mới
----Modified by Bảo Toàn on 06/06/2020: Chuyển cách xử lý thành Function, để dùng chung cho sự kiện load OOP2033
-- <Notes>
---- Dành riêng cho MTE
/*-- <Example>
dbo.OOP2017_MTE @DivisionID = 'MA',                  -- varchar(50)
            @UserID = '000005',                      -- varchar(50)
            @FromDate = '2020-03-24 8:00:00', -- datetime
            @ToDate = '2020-03-24 16:55:00',   -- datetime
            @ShiftID = 'CA01'                 -- varchar(50)

----*/

CREATE PROCEDURE OOP2017_MTE
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @FromDate DATETIME,
  @ToDate DATETIME,
  @ShiftID VARCHAR(50) = ''
) 
AS 

SELECT dbo.GetTotalOTWithShift(@DivisionID,@UserID, @FromDate, @ToDate, @ShiftID) TotalTime




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
