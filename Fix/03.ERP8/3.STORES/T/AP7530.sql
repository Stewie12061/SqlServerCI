IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP7530]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7530]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Created by Nguyen Van Nhan, Date 06/06.
---  Purpose: In so mua hang, ban hang
---  Purpose: Trường hợp lọc theo ngày (From-To) thì kết quả hiển thị không chính xác.
---  Purpose: Lý do:
---  Purpose: Kết quả cộng chuổi để tạo ra biểu thức điều kiện thiếu dấu '->biểu thức điều kiện bị sai.
---- Modified on 18/01/2012 by Le Thi Thu Hien : Sua dieu kien loc theo ngay
---- Modified on 06/06/2013 by Le Thi Thu Hien : Bo sung Ana06ID --> Ana10ID
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Thy on 19/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.


CREATE PROCEDURE [dbo].[AP7530] 	
				@DivisionID nvarchar(50), 
				@GroupID AS nvarchar(50), 
				@IsDate AS tinyint,
				@FromDate Datetime, 
				@ToDate AS Datetime,
				@FromMonth AS int, 
				@FromYear AS int,
				@ToMonth AS int, 
				@ToYear AS int

 AS
Declare @sSQL AS nvarchar(4000),
		@Field AS nvarchar(4000),
		@sTime AS nvarchar(4000),
		@Join AS nvarchar(4000)
		
SET @Join =''
If @IsDate =1 
	--SET @sTime =' VoucherDate between '+Convert(nvarchar(10),@FromDate,21)+ ' and  '+Convert(nvarchar(10),@ToDate,21)+'  '
	SET @sTime =' CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) between '+ ''''+ Convert(nvarchar(10),@FromDate,101)+ ''''+' and  '+ ''''+ Convert(nvarchar(10),@ToDate,101)+''''+'  '
Else
	SET @sTime = ' (TranMonth + TranYear*100 between '+str(@FromMonth)+' + 100*'+str(@FromYear)+' and '+str(@ToMonth)+' + 100*'+str(@ToYear)+') '

If @GroupID = 'OB'
	SET @Field =' AT9000.ObjectID AS GroupID, AT1202.ObjectName AS GroupName,'

If @GroupID = 'A01'
	Begin
		SET @Field =' AT9000.Ana01ID AS GroupID,  V01.SelectionName AS GroupName, '
		SET @Join = ' LEFT JOIN AV6666 V01 on 	V01.SelectionID = AT9000.Ana01ID and
						V01.SelectionType =''A01'' and V01.DivisionID IN (AT9000.DivisionID,''@@@'') '
	End
If @GroupID = 'A02'
	Begin
		SET @Field =' AT9000.Ana02ID AS GroupID,  V02.SelectionName AS GroupName, '
		SET @Join = ' LEFT JOIN AV6666 V02 on 	V02.SelectionID = AT9000.Ana02ID and
							V02.SelectionType =''A02'' and V02.DivisionID IN (AT9000.DivisionID,''@@@'') '
	End
If @GroupID = 'A03'
	Begin
		SET @Field =' AT9000.Ana03ID AS GroupID,  V03.SelectionName AS GroupName, '
		SET @Join = ' LEFT JOIN AV6666 V03 on 	V03.SelectionID = AT9000.Ana03ID and
							V03.SelectionType =''A03'' and V03.DivisionID IN (AT9000.DivisionID,''@@@'') '
	End
If @GroupID = 'A04'
	begin
		SET @Field =' AT9000.Ana04ID AS GroupID,  V04.SelectionName AS GroupName, '
		SET @Join = ' LEFT JOIN AV6666 V04 on 	V04.SelectionID = AT9000.Ana04ID and
							V04.SelectionType =''A04'' and V04.DivisionID IN (AT9000.DivisionID,''@@@'') '
	End

If @GroupID = 'A05'
	Begin
		SET @Field =' AT9000.Ana05ID AS GroupID,  V05.SelectionName AS GroupName, '
		SET @Join = ' LEFT JOIN AV6666 V05 on 	V05.SelectionID = AT9000.Ana05ID and
							V05.SelectionType =''A05'' and V05.DivisionID IN (AT9000.DivisionID,''@@@'') '
	END
If @GroupID = 'A06'
	Begin
		SET @Field =' AT9000.Ana06ID AS GroupID,  V06.SelectionName AS GroupName, '
		SET @Join = ' LEFT JOIN AV6666 V06 on 	V06.SelectionID = AT9000.Ana06ID and
							V06.SelectionType =''A06'' and V06.DivisionID IN (AT9000.DivisionID,''@@@'') '
	END
If @GroupID = 'A07'
	Begin
		SET @Field =' AT9000.Ana07ID AS GroupID,  V07.SelectionName AS GroupName, '
		SET @Join = ' LEFT JOIN AV6666 V07 on 	V07.SelectionID = AT9000.Ana07ID and
							V07.SelectionType =''A07'' and V07.DivisionID IN (AT9000.DivisionID,''@@@'') '
	END
If @GroupID = 'A08'
	Begin
		SET @Field =' AT9000.Ana08ID AS GroupID,  V08.SelectionName AS GroupName, '
		SET @Join = ' LEFT JOIN AV6666 V08 on 	V08.SelectionID = AT9000.Ana05ID and
							V08.SelectionType =''A08'' and V08.DivisionID IN (AT9000.DivisionID,''@@@'') '
	END
If @GroupID = 'A09'
	Begin
		SET @Field =' AT9000.Ana09ID AS GroupID,  V09.SelectionName AS GroupName, '
		SET @Join = ' LEFT JOIN AV6666 V09 on 	V09.SelectionID = AT9000.Ana09ID and
							V09.SelectionType =''A09'' and V09.DivisionID IN (AT9000.DivisionID,''@@@'') '
	END
If @GroupID = 'A10'
	Begin
		SET @Field =' AT9000.Ana10ID AS GroupID,  V10.SelectionName AS GroupName, '
		SET @Join = ' LEFT JOIN AV6666 V10 on 	V10.SelectionID = AT9000.Ana10ID and
							V10.SelectionType =''A10'' and V10.DivisionID IN (AT9000.DivisionID,''@@@'') '
	End

SET @sSQL='
SELECT	AT9000.DivisionID, 
		Case when TransactionTypeID in (''T03'', ''T13'') then  ''011'' else ''021'' end AS TransactionTypeID,
		VoucherDate,
		' +@Field+' 
		VoucherNo,
		VDescription,
		BDescription,
		TDescription,
		Voucherid,
		AT9000.ObjectID,
		Quantity,
		AT9000.OriginalAmount,
		ConvertedAmount,
		AT9000.UnitPrice,
		AT9000.Ana01ID,
		AT9000.Ana02ID,
		AT9000.Ana03ID,
		AT9000.Ana04ID,
		AT9000.Ana05ID,
		AT9000.Ana06ID,
		AT9000.Ana07ID,
		AT9000.Ana08ID,
		AT9000.Ana09ID,
		AT9000.Ana10ID,
		AT9000.InventoryID,
		InventoryName,
		ObjectName
FROM	AT9000  WITH (NOLOCK)	
LEFT JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN At1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
		'+ @Join+ '  

Where	AT9000.DivisionID = '''+@DivisionID+'''  and
		AT9000.TransactionTypeID in (''T13'', ''T03'', ''T04'', ''T14'') '

SET @sSQL=@sSQL+' And '+@sTime

 --print @sSQL

IF NOT EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME = 'AV7530' AND XTYPE ='V')
     EXEC ('  CREATE VIEW AV7530 AS ' + @sSQL)
ELSE
     EXEC ('  ALTER VIEW AV7530  AS ' + @sSQL)
    

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

