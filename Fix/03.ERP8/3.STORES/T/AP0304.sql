IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0304]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0304]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by: Kim Thư on 28/05/2019: Kiểm tra nếu phiếu giải trừ và phiếu được giải trừ thuộc kỳ kế toán đã khóa sổ thì ko cho giải trừ
---- Example: EXEC AP0304 @DivisionID = 'ANG', @UserID='ASOFTADMIN', @TranMonth=5, @TranYear=2019, @lstDebitVoucherID=N'AVd393e13c-6967-46b2-b53f-dcbd1b0bd7af', 
----		@lstCreditVoucherID='AH1e30104e-f0a9-46ab-b9e3-062450c0381b'',''AH4be9eb37-f89e-4270-bbcc-af63ea7ff3d5'',''AH16f6ca70-a4e6-4727-91a0-9ec516dac3f0'


CREATE PROCEDURE [dbo].[AP0304]    
					@DivisionID varchar(50),
					@UserID varchar(50),
				    @TranMonth int,
	  			    @TranYear int,
				    @lstDebitVoucherID varchar(MAX),
					@lstCreditVoucherID varchar(MAX)
AS

DECLARE @sSQL NVARCHAR(MAX)
CREATE TABLE #TEMP (TranMonth INT, TranYear INT, IsClosing INT)

SET @sSQL='
			INSERT INTO #TEMP (TranMonth, TranYear, IsClosing)
			SELECT DISTINCT AT9000.TranMonth, AT9000.TranYear, AT9999.Closing
			FROM AT9000 WITH (NOLOCK) INNER JOIN AT9999 WITH (NOLOCK) ON AT9999.DivisionID = AT9000.DivisionID AND AT9999.TranMonth = AT9000.TranMonth AND AT9999.TranYear = AT9000.TranYear
			WHERE VoucherID IN ('''+@lstDebitVoucherID+''') OR VoucherID IN ('''+@lstCreditVoucherID+''')
'
EXEC (@sSQL)

IF EXISTS (SELECT TOP 1 1 FROM #TEMP WHERE IsClosing=1)
	SELECT 1 AS Status, 'AFML000542' as Message
ELSE 
	SELECT 0 AS Status, '' as Message

 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO