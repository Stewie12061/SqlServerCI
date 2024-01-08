IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMV9999]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[LMV9999]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Create on 27/06/2017 by Bảo Anh

CREATE VIEW [dbo].[LMV9999] as
Select (Case When  TranMonth <10 then '0'+rtrim(ltrim(str(TranMonth)))+'/'+ltrim(Rtrim(str(TranYear))) 
	Else rtrim(ltrim(str(TranMonth)))+'/'+ltrim(Rtrim(str(TranYear))) End) as MonthYear,
	
	CASE WHEN ISNULL(AT1101.StartDate,'01/01/1900') = '01/01/1900' THEN
		('0'+ ltrim(rtrim(Case when TranMonth %3 = 0 then TranMonth/3  Else TranMonth/3+1  End))+'/'+ltrim(Rtrim(str(TranYear)))
		)
	else
		(case when TranMonth >= Month(AT1101.StartDate) then '0' + ltrim((TranMonth - Month(AT1101.StartDate))/3+1) + '/' + ltrim(TranYear)
		else '0' + ltrim((TranMonth + PeriodNum - Month(AT1101.StartDate))/3+1) + '/' + ltrim(TranYear-1)
		end)
	end as [Quarter],
	
	TranMonth,
	TranYear,
	LMT9999.DivisionID, LMT9999.BeginDate, LMT9999.EndDate, LMT9999.Closing
From LMT9999
Inner join AT1101 On LMT9999.DivisionID = AT1101.DivisionID And AT1101.[Disabled] = 0
Where LMT9999.Disabled <> 1

Union ALL
Select (Case When  TranMOnth <10 then '0'+rtrim(ltrim(str(TranMonth)))+'/'+ltrim(Rtrim(str(TranYear))) 
	Else rtrim(ltrim(str(TranMonth)))+'/'+ltrim(Rtrim(str(TranYear))) End) as MonthYear,

	CASE WHEN ISNULL(AT1101.StartDate,'01/01/1900') = '01/01/1900' THEN
		('0'+ ltrim(rtrim(Case when TranMonth %3 = 0 then TranMonth/3  Else TranMonth/3+1  End))+'/'+ltrim(Rtrim(str(TranYear)))
		)
	else
		(case when TranMonth >= Month(AT1101.StartDate) then '0' + ltrim((TranMonth - Month(AT1101.StartDate))/3+1) + '/' + ltrim(TranYear)
		else '0' + ltrim((TranMonth + PeriodNum - Month(AT1101.StartDate))/3+1) + '/' + ltrim(TranYear-1)
		end)
	end as [Quarter],

	TranMonth,
	TranYear,
	'%' as DivisionID, LMT9999.BeginDate, LMT9999.EndDate, LMT9999.Closing
From LMT9999
Inner join AT1101 On LMT9999.DivisionID = AT1101.DivisionID And AT1101.[Disabled] = 0
Where LMT9999.DivisionID = (Select Top 1 DivisionID From LMT9999)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

