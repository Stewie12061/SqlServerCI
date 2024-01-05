IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP1021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP1021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Master định nghĩa tiêu chuẩn (màn hình xem chi tiết/ màn hình cập nhật)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Thanh Thi on 15/10/2020
-- <Example> EXEC QCP1021 @DivisionID = 'VNP', @UserID = '', @APK = 'E2557D99-3051-4CED-94F2-2F996E800774'

CREATE PROCEDURE [dbo].[QCP1021]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
		SELECT T1.APK, T1.DivisionID, T1.InventoryID, T2.InventoryName, T1.Notes, T1.Notes01, T1.Notes02, T1.Notes03
				, T1.Disabled, T1.IsCommon, T1.CreateDate, T1.CreateUserID, T1.LastModifyDate
				, T1.LastModifyUserID, T1.UpdateDate
		FROM QCT1020 T1  WITH (NOLOCK)
		LEFT JOIN AT1302 T2 WITH (NOLOCK) ON T2.InventoryID = T1.InventoryID 
		WHERE T1.APK = @APK
		


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

