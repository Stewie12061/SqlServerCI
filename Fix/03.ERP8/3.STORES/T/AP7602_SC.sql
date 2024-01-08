IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7602_SC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7602_SC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
------ Cong vao cac chi tieu; truong hop In bang ket qua kinh doanh phÇn Lçi, L·i
----- Created by Nguyen Van Nhan, Date 12.09.2003
----  Modified by on 24/08/2016 by Hoàng vũ : Customer cho secoin gọi ngầm xử lý báo cáo phân tích chỉ số tài chính

/**********************************************
** Edited by: [GS] [Cẩm Loan] [30/07/2010]
** Edited by: [GS] [Hoàng vũ] [2015-04-15]
***********************************************/

CREATE PROCEDURE [dbo].[AP7602_SC]
	@DivisionID AS nvarchar(50),
	@IsDate TINYINT, --0:Thang; 1:Quy; 2:Nam
	@PeriodID varchar(50),		
	@ReportCode AS nvarchar(50),
	@LineCode AS nvarchar(50),
	@Amount1 AS decimal(28,8),
	@Amount2 AS decimal(28,8),
	@Amount3 AS decimal(28,8),
	@AccuSign AS nvarchar(5),
	@OriginalAccumulator AS nvarchar(100)
AS
Set nocount on
		DECLARE 	@CurrentAccumulator AS nvarchar(100),
					@CurrentAccuSign AS nvarchar(50),
					@strAccumulators AS nvarchar(4000),
					@TempLineCode as nvarchar(100),
					@TempParrentID as nvarchar(100),
					@TempSign as nvarchar(5),
					@OldSign  nvarchar(5),
					@Sign  nvarchar(5),
					@Bug as nvarchar(4000)	
		Declare @CustomerName INT
		CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
		INSERT #CustomerName EXEC AP4444
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

		IF @CustomerName IN (43, 161) --Secoin, INNOTEK
		Begin

					Set  @OldSign = ltrim(rtrim(@AccuSign))

					IF @AccuSign  = '+'	---- lan dau tien phai cong vao dong chinh no
					Begin	
							If (Select DisplayedMark From AT7604_SC Where LineCode = @LineCode  and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID) = 1	
								UPDATE 	AT7604_SC
								SET		Amount1 = -(Isnull(Amount1,0) + isnull(@Amount1,0)),
										Amount2 =  -(Isnull(Amount2,0) + isnull(@Amount2,0)),
										Amount3 = -(Isnull(Amount3,0) + isnull(@Amount3,0))
								WHERE	LineCode = @LineCode
										and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID
							Else
								UPDATE 	AT7604_SC
								SET		Amount1 = Isnull(Amount1,0) + isnull(@Amount1,0),
										Amount2 =  Isnull(Amount2,0) + isnull(@Amount2,0),
										Amount3 = Isnull(Amount3,0) + isnull(@Amount3,0)
								WHERE	LineCode = @LineCode
										and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID
					End	
					ELSE
					Begin
							If (Select DisplayedMark From AT7604_SC Where LineCode = @LineCode  and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID) = 1	
								UPDATE 	AT7604_SC
								SET		Amount1 = -(Amount1 - @Amount1),
										Amount2 = -(Amount2 - @Amount2),
										Amount3 = -(Amount3 - @Amount3)
								WHERE	LineCode = @LineCode
										and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID
							Else
								UPDATE 	AT7604_SC
								SET		Amount1 = Amount1 - @Amount1,
										Amount2 = Amount2 - @Amount2,
										Amount3 = Amount3 - @Amount3
								WHERE	LineCode = @LineCode
										and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID
					End
					----- Duyet den cap cha

					SELECT 	@CurrentAccumulator = Accumulator,
							@TempSign  = AccuSign			
					FROM		AT7604_SC
					WHERE	LineCode = @LineCode
							and DivisionID = @DivisionID  and IsDate = @IsDate and PeriodID = @PeriodID
		
					Set @TempLineCode  =   isnull(@CurrentAccumulator,'')	

  		
					Set @Bug = @Bug+@LineCode+'  +'

					WHILE @TempLineCode <>''
						Begin
				
							 --if @TempLineCode in ('60' )
								--Print ' @TempSign  '+ @TempSign +' '+str(isnull(@Amount2,0))
							--if @LineCode ='04' 
								--Print 'A:  '+@TempLineCode+' dau '+@TempSign
 
							if @OldSign<> @TempSign  Set @Sign = '-' Else   Set @Sign = '+'
							--Print @OldSign+ @TempSign
							Set @OldSign = @Sign

							Set @Bug =@Bug+@TempLineCode+' '+@Sign
							IF @Sign = '+'	---- lan dau tien phai cong vao dong chinh no
							Begin
								If (Select DisplayedMark From AT7604_SC Where LineCode = @LineCode  and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID) = 1	
									UPDATE 	AT7604_SC
										SET		
											Amount1 = -(isnull(Amount1,0) + isnull(@Amount1,0)),
											Amount2 = -(isnull(Amount2,0) + isnull(@Amount2,0)),
											Amount3 = -(isnull(Amount3,0) + isnull(@Amount3,0))
									WHERE	LineCode = @TempLineCode
											and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID
								Else
										UPDATE 	AT7604_SC
										SET		Amount1 = isnull(Amount1,0) + isnull(@Amount1,0),
											Amount2 = isnull(Amount2,0) + isnull(@Amount2,0),
											Amount3 = isnull(Amount3,0) + isnull(@Amount3,0)
									WHERE	LineCode = @TempLineCode
											and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID
							End
							ELSE
							Begin
								If (Select DisplayedMark From AT7604_SC Where LineCode = @LineCode  and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID) = 1	
										UPDATE 	AT7604_SC
										SET		Amount1 = -(isnull(Amount1,0) - isnull(@Amount1,0)),
												Amount2 = -(isnull(Amount2,0) - isnull(@Amount2,0)),
												Amount3 = -(isnull(Amount3,0) - isnull(@Amount3,0))
										WHERE	LineCode = @TempLineCode
												and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID
								Else
												UPDATE 	AT7604_SC
										SET		Amount1 = isnull(Amount1,0) - isnull(@Amount1,0),
												Amount2 = isnull(Amount2,0) - isnull(@Amount2,0),
												Amount3 = isnull(Amount3,0) - isnull(@Amount3,0)
										WHERE	LineCode = @TempLineCode
												and DivisionID = @DivisionID and IsDate = @IsDate and PeriodID = @PeriodID
							End
							Set @TempParrentID=''		
				
							Select  	@TempParrentID = Accumulator,
								@TempSign = ltrim(rtrim(AccuSign))
							From 	AT7604_SC 
							Where LineCode = @TempLineCode	
								  and DivisionID = @DivisionID	and IsDate = @IsDate and PeriodID = @PeriodID			
					  
							Set 	@TempLineCode = isnull(@TempParrentID,'')
				
						End
			End

Set nocount off
GO

