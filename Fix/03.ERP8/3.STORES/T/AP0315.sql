SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO



---- Created by Nguyen Thi Ngoc Minh
--- Date 21/09/2004.
---- purpose: Tra ra view len form In bao cao cong no theo tuoi no
---- Modified on 13/02/2012 by Le Thi Thu Hien : Bo sung them JOIN DivisionID
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [28/07/2010]
'* Edited by : [GS] [Cẩm Loan] [28/12/2010] [thêm điều kiện select]
'* Edited by : [Huỳnh Thử] [14/11/2019] [thêm điều kiện phân quyền]
'**************************************************************/
--EXEC AP0315 'AS', 'a'
ALTER PROCEDURE [dbo].[AP0315]  
		@DivisionID AS nvarchar(50),	
		@ReportCode AS nvarchar(50),
		@ConditionAC AS nvarchar(MAX),
		@IsUsedConditionAC AS nvarchar(50)
AS


Declare @sSQL AS nvarchar(4000),
		@IsReceivable AS tinyint,
		@AccountSQL AS nvarchar(MAX),
		@Selection01ID AS nvarchar(50),
		@Selection02ID AS nvarchar(50),
		@Selection03ID AS nvarchar(50),
		@Selection01Name AS nvarchar(250),
		@Selection02Name AS nvarchar(250),
		@Selection03Name AS nvarchar(250)

--------------Lay thong tin tu ma bao cao truyen vao------------
SELECT TOP 1 @IsReceivable = IsReceivable,
		@Selection01ID = isnull(Selection01ID,''),
		@Selection02ID = isnull(Selection02ID,''),
		@Selection03ID = isnull(Selection03ID,'')
FROM AT4710
WHERE ReportCode = @ReportCode and DivisionID = @DivisionID


---------------Lay ten cac tieu thuc--------------
If @Selection01ID != ''
   BEGIN
  	Set @Selection01Name = (Select top 1 Description From AT6000 Where Code = @Selection01ID and DivisionID = @DivisionID)
   End
   

If @Selection02ID != ''
   Begin
	Set @Selection02Name = (Select top 1 Description From AT6000 Where Code = @Selection02ID and DivisionID = @DivisionID)
   End

If @Selection03ID != ''	
   Begin
	Set @Selection03Name = (Select top 1 Description From AT6000 Where Code = @Selection03ID and DivisionID = @DivisionID)
   End
   
  
------------Tao cau SQL lay tai khoan-----------
If @IsReceivable = 1
	Set @AccountSQL = '	SELECT DISTINCT AccountID, AccountName 
						FROM		AT1005 
						WHERE  Disabled = 0 and GroupID = ''''G03''''
						AND (AccountID in ('+ CASE WHEN @ConditionAC = '' THEN ('''''''''') ELSE @ConditionAC END  +') OR '+@IsUsedConditionAC+')
					    AND DivisionID  in ('''''+@DivisionID+''''', ''''@@@'''')
						ORDER BY AccountID'
Else
	Set @AccountSQL = '	SELECT DISTINCT AccountID, AccountName 
						FROM		AT1005 
						WHERE	Disabled = 0 and GroupID = ''''G04''''
						AND (AccountID in ('+ CASE WHEN @ConditionAC = '' THEN ('''''''''') ELSE @ConditionAC END  +') OR '+@IsUsedConditionAC+')
					    AND DivisionID  in ('''''+@DivisionID+''''', ''''@@@'''')
						ORDER BY AccountID'

---------Tao view----------
Set @sSQL = 'Select ' + (Case when @Selection01Name is null then 'null' else 'N''' + LOWER(@Selection01Name) + '''' end) + ' AS Selection01, 
		 ' + (Case when @Selection02Name is null then 'null' else 'N''' + LOWER(@Selection02Name) + ''''  end) + ' AS Selection02,
		 ' + (Case when @Selection03Name is null then 'null' else 'N''' + LOWER(@Selection03Name) + ''''   end) + ' AS Selection03,
		''' + @AccountSQL + ''' AS AccountSQL, ''' + @DivisionID + ''' AS DivisionID'

		PRINT @AccountSQL
print @sSQL
IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0325]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV0325 	---CREATED BY AP0315
		AS ' + @sSQL)
ELSE
	EXEC ('  ALTER VIEW AV0325   	---CREATED BY AP0315
			AS ' + @sSQL)
				



GO

