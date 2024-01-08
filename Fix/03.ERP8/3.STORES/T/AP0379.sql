IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP0379]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0379]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Cap nhat trang thai DebitNote
-- <Param>
---- @Mode = 0: Grid 1, = 1: Grid2
-- <Return>
---- 
-- <Reference> ASOFT-T/
---- Ban hang/ Hoa don ban hang/Ke thua DebitNote (Customize Panalpina - CustomerIndex = 83)
-- <History>
---- Create on 20/09/2017 by Trương Ngọc Phương Thảo
---- Modified on  by  : 
-- <Example>
---- EXEC AP0379 'mk', 'asoftadmin','aaa',0
CREATE PROCEDURE AP0379
(
	@DivisionID varchar(50),
	@UserID varchar(50),			
	@VoucherID varchar(50),
	@Mode Int = 0 -- 0: Luu phieu ban hang, 1: Xoa phieu ban hang
)
AS
SET NOCOUNT ON

DECLARE @sSQL01 NVarchar(4000)


SET @sSQL01 = 
'
UPDATE AT0300
SET	Status = '+CASE WHEN @Mode = 0 THEN '1' ELSE '0' END +'
WHERE EXISTS (	SELECT TOP 1 1 
				FROM AT9000 
				WHERE  VoucherID = '''+@VoucherID+''' AND
				Convert(Varchar(50),AT0300.TransactionID) = AT9000.InheritTransactionID AND AT9000.InheritTableID = ''AT0300'')

'
--PRINT @sSQL01
EXEC (@sSQL01)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

