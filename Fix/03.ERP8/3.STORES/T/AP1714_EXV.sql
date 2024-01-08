IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1714_EXV]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1714_EXV]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---Created by: Nguyen Thi kieu Nga  
---Purpose: Phuc vu bao cao phan bo  (Copy customize AP1714_EXV cho EXV)
---Date: 10/10/2022  
/**********************************************  
** Edited by: [GS] [Cẩm Loan] [29/07/2010]  
***********************************************/   

CREATE PROCEDURE [dbo].[AP1714_EXV]  @DivisionID nvarchar(50),  

    @FromMonth as int,  
    @FromYear as int,  
    @ToMonth as int,  
    @ToYear as int,  
    @GroupType as tinyint , ---  0 la khong nhom  
        ----  1 theo tai khoan chi phi  phan bo  
        ---- 2 theo tai khoan chi phi tra truoc  
    @D_C as nvarchar(50)     --C: Doanh thu, D: Chi phi   
    ---@Condition  tinyint,  
   --- @IsFail tinyint   

 AS  

Declare   
   @FromPeriod as int,  
   @ToPeriod as int,  
   @sSQL as nvarchar(4000),  
   @GroupID as nvarchar(250) ,
   @Select NVARCHAR(4000) = ''

set  @FromPeriod =@FromMonth+@FromYear*100  

set @ToPeriod=@ToMonth+@ToYear*100  

Set @GroupID = ''  

IF @D_C = 'C'  

BEGIN  

	If @GroupType = 0   
		Set @GroupID =''''' as GroupID,  ''''  as GroupName '  

	If @GroupType = 1    
	BEGIN
		Set @GroupID =' AT1703.CreditAccountID as GroupID,  T05.AccountName  as GroupName '  
	END 

	If @GroupType = 2   
	BEGIN 
		Set @GroupID =' AT1703.DebitAccountID as GroupID, AT1005.AccountName   as GroupName  '  
	END
  
END  

ELSE  

BEGIN  

	If @GroupType = 0   
		Set @GroupID =''''' as GroupID,  ''''  as GroupName '  

	If @GroupType = 1    
	BEGIN
		Set @GroupID =' AT1703.DebitAccountID as GroupID,  AT1005.AccountName  as GroupName '  
	END
	If @GroupType = 2   
	BEGIN
		Set @GroupID =' AT1703.CreditAccountID as GroupID, T05.AccountName   as GroupName  '  
	END
  
END  

--Set @sSQL='   
--SELECT DISTINCT	AT1703.DivisionID, AT1703.JobID, AT1703.JobName, '+CASE WHEN (@D_C = 'C' AND @GroupType = 1) OR (@D_C = 'D' AND @GroupType = 2)  THEN ' AT1704.DebitAccountID,' ELSE
Set @sSQL='   
SELECT DISTINCT	AT1703.DivisionID, AT1703.JobID, AT1703.JobName,AT1703.CreditAccountID,AT1703.DebitAccountID,
AT1703.SerialNo,AT1703.Ana01ID,	   AT1011.AnaName as AnaName01ID,AT1703.Ana02ID,(select TOP 1 AT9000.DParameter01 from AT9000 where  VoucherID = AT1703.VoucherID and ISNULL(DParameter01,'''') <> '''') as DParameter01 ,AT1703.Ana03ID,AT1703.ObjectID,  
AT1202.ObjectName,  AT1703.ConvertedAmount, AT1703.Periods,AT1703.DepMonths,AT1703.UseStatus, AT1703.Description,AT1703.VoucherNo, AT1703.VoucherID,  
AT1703.BeginMonth,  AT1703.BeginYear,    

Case When IsNull(AT1703.Periods,0)=0 then 0   
Else   
AT1703.ConvertedAmount/AT1703.Periods  End as DepreciatedPeriods, 
 
AccuDepAmount = ISNULL(AT1703.DepValue,0) + isnull((Select sum (isnull(DepAmount,0)) from AT1704    
       Where AT1704.DivisionID like '''+@DivisionID+'''  and   
      AT1703.JobID = AT1704.JobID and  
          AT1704.TranMonth+AT1704.Tranyear*100<= '+cast(@ToPeriod as varchar(10))+'   
   and  AT1703.D_C =  '''+@D_C+ '''),0),  

		--CASE WHEN '+STR(@GroupType)+' = 1 THEN SUM (DepAmount) 
		--	 WHEN '+STR(@GroupType)+' = 2 THEN (Select sum (DepAmount) from AT1704  
		--		Where AT1704.DivisionID like '''+@DivisionID+'''  and   
		--		AT1703.JobID=AT1704.JobID and  
		--		AT1704.TranMonth+ AT1704.Tranyear*100 between  '+cast(@FromPeriod as varchar(10))+'   and '+cast(@ToPeriod as varchar(10))+'   
		--		and  AT1703.D_C =  '''+@D_C+ ''' ) 
		--END AS DepAmount,

		(Select sum (DepAmount) from AT1704  
		Where AT1704.DivisionID like '''+@DivisionID+'''  and   
		AT1703.JobID=AT1704.JobID and  
		AT1704.TranMonth+ AT1704.Tranyear*100 between  '+cast(@FromPeriod as varchar(10))+'   and '+cast(@ToPeriod as varchar(10))+'   
		and  AT1703.D_C =  '''+@D_C+ ''' ) AS DepAmount,

DepreciatedMonths= ISNULL(AT1703.DepMonths,0) + (select count(*) from (select distinct DivisionID, JobID, TranMonth, TranYear from AT1704  
  Where AT1704.DivisionID = '''+ @DivisionID +''' and AT1704.TranMonth + AT1704.TranYear*100 <= '+cast(@ToPeriod as varchar(10))+'  and                   
   isnull(AT1704.DepAmount, 0) >1  and  AT1703.D_C =  '''+@D_C+ '''   
) A where A.DivisionID = AT1703.DivisionID AND A.JobID = AT1703.JobID),
AT1703.InvoiceNo,
AT1703.CreateDate as ApportionDate,
 '+ @GroupID +'  

From  AT1703 WITH(NOLOCK)
  LEFT JOIN AT1704 WITH(NOLOCK) ON  AT1704.DivisionID =  AT1703.DivisionID AND AT1704.JobID =  AT1703.JobID
  left join AT1005 WITH(NOLOCK) on AT1005.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1005.AccountID =  AT1703.DebitAccountID  
  left join AT1005  T05 WITH(NOLOCK) on  T05.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T05.AccountID =  AT1703.CreditAccountID  
  left join AT1102 WITH(NOLOCK) on  AT1102.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1102.DepartmentID = AT1703.Ana02ID
  left Join AT1011 WITH(NOLOCK) on AT1011.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1011.AnaID = AT1703.Ana01ID
 -- left Join AT9000 WITH(NOLOCK) on AT9000.VoucherID = AT1703.VoucherID
  lEFT JOIN AT1202 WITH(NOLOCK) on AT1202.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1202.ObjectID = AT1703.ObjectID 
  
Where  AT1703.DivisionID like  '''+@DivisionID+'''  and  AT1703.D_C =  '''+@D_C+ ''' 
  --and AT1703.BeginMonth+AT1703.BeginYear*100    <='+cast(@ToPeriod as varchar(10))+'
  --and  AT1704.TranMonth+ AT1704.Tranyear*100 between  '+cast(@FromPeriod as varchar(10))+'   and '+cast(@ToPeriod as varchar(10))+'

  AND ((AT1704.TranMonth+ AT1704.Tranyear*100 between '+cast(@FromPeriod as varchar(10))+'   and '+cast(@ToPeriod as varchar(10))+' ) OR ( AT1703.BeginMonth+AT1703.BeginYear*100 >='+cast(@ToPeriod as varchar(10))+'))
  AND AT1703.TranMonth+AT1703.TranYear*100 <= '+cast(@ToPeriod as varchar(10))+' 
 
GROUP BY AT1703.DivisionID, AT1703.JobID,AT1703.JobName,AT1703.SerialNo,AT1703.CreditAccountID,AT1703.DebitAccountID,
  AT1703.Ana01ID, AT1011.AnaName ,  
  AT1703.Ana02ID,  AT1703.Ana03ID,AT1703.ObjectID, AT1202.ObjectName,  AT1703.ConvertedAmount, AT1703.Periods,  AT1703.DepMonths,  
  AT1703.UseStatus, AT1703.Description, AT1703.VoucherNo,  AT1703.VoucherID,  AT1703.BeginMonth,  AT1703.BeginYear,AT1703.D_C, AT1703.DepValue, AT1005.AccountName,
  T05.AccountName, AT1703.InvoiceNo,AT1703.CreateDate
'  

--PRINT @Select
Print @sSQL  

If  Exists (Select 1 From sysObjects Where Name ='AV1714')  

 DROP VIEW AV1714  

EXEC ('Create view AV1714  --Tao boi AP1714_EXV  
   as '+@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
