IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7926]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7926]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-------- Created by Nguyen Minh Thuy
-------- Date 11/10/2006.
-------- Purpose: Cap that vao bang In "bang can doi ke toan" theo  ma phan tich (Thang/Quy/Nam)
/********************************************
'* Edited by: [GS] [Hoàng Phước] [29/07/2010]
'********************************************/
----- Modified on 31/03/2016 by Phương Thảo: Bổ sung số đầu năm

CREATE PROCEDURE [dbo].[AP7926] 
		@LineID AS nvarchar(50),
		@PeriodNumber int,
		@DivisionID AS nvarchar(50)			
AS

DECLARE @TempLineID as nvarchar(50),
		@TempParrentLineID as nvarchar(50),
		@Index int,
		@sSQL nvarchar (MAX)
	Set @TempLineID = @LineID
	Set @TempParrentLineID= (Select top 1 ltrim(isnull(ParrentLineID,'')) From AT7902 Where LineID = @TempLineID AND DivisionID = @DivisionID)
	
	While	isnull(@TempParrentLineID, '') <> ''   --- Neu con cha thi van tiep thu
		Begin
			Set  @Index = 1  
			---Print ' Nhan @TempLineID +' +@TempLineID
			While @Index<=@PeriodNumber
			Begin
				Set @sSQL = N'
				UPDATE 	AT7925
				SET		Amount' + ltrim(@Index) + ' = Isnull( Amount' + ltrim(@Index) + ',0) + 
						(Select isnull(sum(isnull(Amount' + ltrim(@Index) + ' ,0)),0) From AT7925 Where LineID
						In (Select LineID From AT7902 Where LineID = ''' + @LineID + ''' AND DivisionID = ''' + @DivisionID + ''')
						AND DivisionID = ''' + @DivisionID + ''') 
				WHERE	LineID = ''' + @TempParrentLineID + ''' AND DivisionID = ''' + @DivisionID + ''''
				Exec(@sSQL)
				Set @Index = @Index + 1
			End

			Set @sSQL = N'
				UPDATE 	AT7925
				SET		BeginYear = Isnull( BeginYear,0) + 
						(Select isnull(sum(isnull(BeginYear ,0)),0) From AT7925 Where LineID
						In (Select LineID From AT7902 Where LineID = ''' + @LineID + ''' AND DivisionID = ''' + @DivisionID + ''')
						AND DivisionID = ''' + @DivisionID + ''') 
				WHERE	LineID = ''' + @TempParrentLineID + ''' AND DivisionID = ''' + @DivisionID + ''''
				Exec(@sSQL)

			Set	@TempLineID = @TempParrentLineID		
			Set @TempParrentLineID = (Select top 1 ltrim(isnull(ParrentLineID,'')) From AT7902 Where LineID = @TempLineID AND DivisionID = @DivisionID)		

		End

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

