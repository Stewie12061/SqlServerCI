IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OX2202]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[OX2202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xóa dữ liệu kế thừa lưu vết riêng cho ANGEL (CustomizeIndex = 57)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Tiểu Mai on 10/12/2016
---- Modified by ... on ...
-- <Example>
----


CREATE TRIGGER [dbo].[OX2202] ON [dbo].[OT2202] 
FOR DELETE
AS
DECLARE @CustomerIndex INT 
SELECT @CustomerIndex = CustomerName From CustomerIndex

IF @CustomerIndex = 57 ------ ANGEL
BEGIN
	DELETE OT2202_AG
	FROM OT2202_AG 
	INNER JOIN Deleted Del ON Del.DivisionID = OT2202_AG.DivisionID AND Del.EstimateID = OT2202_AG.VoucherID
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON

