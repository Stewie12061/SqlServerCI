IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1709_SK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1709_SK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Created by Kiều Nga on 22/12/2022: Đổ nguồn Combo Chứng từ (customize SIKICO)
---- Modified by ... on ...
/**********************************************
** Edited by: 
***********************************************/

--EXEC AP1709_SK @DivisionID=N'KVC',@TranMonth=9,@TranYear=2018,@D_C=N'C'

CREATE PROCEDURE [dbo].[AP1709_SK] 
    @DivisionID AS NVARCHAR(50),
    @TranMonth AS INT,
    @TranYear AS INT, 
    @D_C AS NVARCHAR(50)
AS


SELECT T02.VoucherID, T02.VoucherNo, T02.VoucherDate, T02.VDescription, T02.AccountID, 
	  T02.TranMonth, T02.TranYear, T02.DivisionID, T02.ConvertedAmount, T02.Ana01ID, T02.Ana02ID, T02.Ana03ID, T02.Ana04ID, 
	  T02.Ana05ID, T02.Ana06ID, T02.Ana07ID, T02.Ana08ID, T02.Ana09ID, T02.Ana10ID, T02.D_C
      FROM AV1702 T02 WITH (NOLOCK)
	  Left Join AV1701_SK T01 on T01.DivisionID = T02.DivisionID And T01.VoucherID = T02.VoucherID
      WHERE T02.TranMonth + T02.TranYear * 100 <= @TranMonth + @TranYear * 100 
      AND T02.DivisionID in (@DivisionID, '@@@')
      AND T02.D_C = @D_C
	  AND T01.VoucherID = T02.VoucherID
	  Group By T02.VoucherID, T02.VoucherNo, T02.VoucherDate, T02.VDescription, T02.AccountID, 
	  T02.TranMonth, T02.TranYear, T02.DivisionID, T02.ConvertedAmount, T02.Ana01ID, T02.Ana02ID, T02.Ana03ID, T02.Ana04ID, 
	  T02.Ana05ID, T02.Ana06ID, T02.Ana07ID, T02.Ana08ID, T02.Ana09ID, T02.Ana10ID, T02.D_C
      ORDER BY VoucherDate



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
