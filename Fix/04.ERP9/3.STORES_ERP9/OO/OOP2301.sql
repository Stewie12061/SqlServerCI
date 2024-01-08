IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2301]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2301]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load form TMF0010 - Danh mục thiết lập thời gian làm việc
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao Thị Phượng on 17/03/2017
-- <Example>
/*
    EXEC OOP2301 'KY', '','' ,'', 'NV01', 1, 10 
*/

CREATE PROCEDURE [dbo].[OOP2301] ( 
   @APK VARCHAR(50)
   ) 
AS

SELECT * FROM OOT2300 WHERE APK = @APK

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
