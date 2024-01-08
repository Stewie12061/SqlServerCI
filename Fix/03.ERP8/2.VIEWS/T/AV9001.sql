IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV9001]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV9001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-------	 Created by Nguyen Van Nhan, Date 04/06/2004
------	Purpose: Chua so lieu phat sinh tong can phan bo
------  Edit by Nguyen Quoc Huy, Date 16/06/2004 
------ Modified by Kim Vũ: Sửa lỗi sai Ana02ID và Ana03ID

CREATE VIEW [dbo].[AV9001] as 
Select 	TranMonth, TranYear,DivisionID, DebitAccountID as AccountID, 
	CreditAccountID as CorAccountID , 
	Sum(isnull(ConvertedAmount,0)) as ConvertedAmount,
	'D' as D_C,
	'G06' as GroupID,
	TableID, Ana03ID, Ana02ID   ---,VoucherID,BatchID,TransactionID 

From AT9000
Where 	isnull(Ana01ID,'')  =''  and	
	TransactionTypeID not in ('T00','T98') and
	DebitAccountID in (Select AccountID From AT1005 Where GroupID ='G06') and
	IsAudit =0

Group by DebitAccountID, CreditAccountID, TranMonth, TranYear,DivisionID, TableID, Ana03ID, Ana02ID --,VoucherID, BatchID, TransactionID
Union all
Select 	TranMonth, TranYear,DivisionID, 
	CreditAccountID as AccountID, 
	DebitAccountID as CorAccountID, 
	Sum(isnull(ConvertedAmount,0)) as ConvertedAmount,
	'C' as D_C, 
	'G06' as GroupID,
	TableID, Ana03ID, Ana02ID ---, VoucherID, BatchID,TransactionID
From AT9000
Where 	isnull(Ana01ID,'')  =''  and	
	TransactionTypeID not in ('T00','T98') and
	CreditAccountID in (Select AccountID From AT1005 Where GroupID ='G06') and
	IsAudit =0
Group by DebitAccountID, CreditAccountID, TranMonth, TranYear,DivisionID ,TableID, Ana03ID, Ana02ID ---,VoucherID,BatchID,TransactionID
Union All
Select 	TranMonth, TranYear, DivisionID, DebitAccountID as AccountID, 
	CreditAccountID as CorAccountID , 
	Sum(isnull(ConvertedAmount,0)) as ConvertedAmount,
	'D' as D_C,
	'G07' as GroupID ,
	TableID, Ana03ID, Ana02ID --,VoucherID, BatchID, TransactionID

From AT9000
Where 	isnull(Ana01ID,'')  =''  and	
	TransactionTypeID not in ('T00','T98') and
	DebitAccountID in (Select AccountID From AT1005 Where GroupID ='G07') and
	IsAudit =0
Group by DebitAccountID, CreditAccountID, TranMonth, TranYear,DivisionID, TableID, Ana03ID, Ana02ID ---,VoucherID, BatchID,TransactionID

Union all
Select 	TranMonth, TranYear,DivisionID, 
	CreditAccountID as AccountID, 
	DebitAccountID as CorAccountID, 
	Sum(isnull(ConvertedAmount,0)) as ConvertedAmount,
	'C' as D_C, 
	'G07' as GroupID,
	TableID, Ana03ID, Ana02ID --,VoucherID,BatchID,TransactionID
From AT9000
Where 	isnull(Ana01ID,'')  =''  and	
	TransactionTypeID not in ('T00','T98') and
	CreditAccountID in (Select AccountID From AT1005 Where GroupID ='G07') and
	IsAudit =0
Group by DebitAccountID, CreditAccountID, TranMonth, TranYear,DivisionID , TableID, Ana03ID, Ana02ID --,VoucherID,BatchID,TransactionID
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
