IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2151_HIPC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2151_HIPC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----<Summary>
---- Load detail kế thừa dự trù từ dự toán
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
---- Create by : Nhật Quang on 15/02/2034
---- Update by : Đức Tuyên on 07/04/2023 bổ sung trường lưu số lượng cũ có tính hoa hụt
---- <Example>
---	EXEC MP2151 @DivisionID=N'HIP',@APK=N''




CREATE PROCEDURE [dbo].[MP2151_HIPC] (
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50)
	)
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)

	SET @sSQL = 'SELECT 
				  CONVERT(NVARCHAR(40),C4.APK) AS APK
				, C4.DivisionID
				, CONVERT(NVARCHAR(40),C4.APKMaster) AS APKMaster
				, C4.CreateUserID
				, C4.CreateDate
				, C4.LastModifyUserID
				, C4.LastModifyDate
				, C4.TranMonth
				, C4.Tranyear
				, C4.DeleteFlg
				, C4.KindSuppliers
				, C4.MaterialID
				, C4.UnitID
				, ISNULL(C4.QuantityLoss, 0) AS Quantity
				, ISNULL(C4.QuantityLoss, 0) AS QuantityOriginal
				, C4.UnitPrice
				, C4.Amount
				, C4.APKMaster_9000
				, C4.ApproveLevel
				, C4.ApprovingLevel
				, C4.Status
				, C4.S01ID
				, C4.S02ID
				, C4.S03ID
				, C4.S04ID
				, C4.S05ID
				, C4.S06ID
				, C4.S07ID
				, C4.S08ID
				, C4.S09ID
				, C4.S10ID
				, C4.S11ID
				, C4.S12ID
				, C4.S13ID
				, C4.S14ID
				, C4.S15ID
				, C4.S16ID
				, C4.S17ID
				, C4.S18ID
				, C4.S19ID
				, C4.S20ID
				, C4.PhaseOrder
				, C4.DisplayName
				, C4.QuantityRunWave
				, C4.UnitSizeID
				, C4.PhaseID
				, C4.Size
				, C4.Cut
				, C4.Child
				, C4.PrintTypeID
				, C4.RunPaperID
				, C4.RunWavePaper
				, C4.SplitSheets
				, C4.MoldID
				, C4.MoldStatusID
				, C4.MoldDate
				, C4.Gsm
				, C4.Sheets
				, C4.Ram
				, C4.Kg
				, C4.M2
				, C4.AmountLoss
				, C4.PercentLoss
				, C4.GluingTypeID
				, C4.NoteDetail
				, C4.OriginalInventoryID
				, C4.NormsType
				, C4.NormsTypeID
				, C4.LossAmount
				, C4.LossValue
				, C4.SetupTime
				, C4.OriginalQuantity
				, C4.MaterialInventoryID
				, C10.ObjectID
				, P11.MemberName AS ObjectName
				, C10.VoucherNo
				, C10.InventoryID
				, A02.InventoryName
				, A02.UnitID
				, C4.OrderNo
				 FROM CRMT2114 C4 WITH (NOLOCK)
				 LEFT JOIN CRMT2110 C10 WITH (NOLOCK) ON C10.DivisionID = C4.DivisionID AND C10.APK = C4.APKMaster
				 --LEFT JOIN CRMT2111 C11 WITH (NOLOCK) ON C11.DivisionID = C4.DivisionID AND C11.APKMaster = C4.APKMaster
				 LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = C4.MaterialID
				 LEFT JOIN POST0011 P11 WITH (NOLOCK) ON P11.DivisionID = C4.DivisionID AND P11.MemberID = C10.ObjectID
				 WHERE C4.APKMaster = '''+@APK+''' AND C4.DivisionID = '''+@DivisionID+'''
						AND NormsTypeID = ''0'' 
				 ORDER BY C4.OrderNo '

	PRINT (@sSQL)
	EXEC (@sSQL)
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
