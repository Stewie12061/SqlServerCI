IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7916_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7916_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Cập nhật giá trị vào bảng In "Bảng Cân Đối Kế Toán"
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 19/08/2003 by Nguyen Van Nhan
---- Modified on 29/07/2010 by Hoàng Phước
---- Modified on 22/12/2011 by Nguyễn Bình Minh: Bổ sung @Amount3 - Số đầu kỳ
---- Modified on 25/05/2012 by Thiên Huỳnh: Bổ sung biến @ReportCode
---- Modified on 27/03/2013 by Bao Quynh: Them Amount4
---- Modified on 15/04/2015 by hoàng Vũ: Bổ sung kiểm tra hiển thị dấu âm dương trên báo cóo
---- Modified by on 28/09/2016 by Phương Thảo :  Bổ sung lấy số phát sinh nợ, co (Customize Meiko)
---- Modified by on 19/08/2020 by Huỳnh Thử:  Merge Code: MEKIO và MTE
-- <Example>
---- 
CREATE PROCEDURE [dbo].[AP7916_MK]
/************************************************************
 * Code formatted by SoftTree SQL Assistant © v5.1.40
 * Time: 22/12/2011 8:51:46 AM
 ************************************************************/

(
    @DivisionID AS NVARCHAR(50),
    @LineID AS NVARCHAR(50),
    @Amount1 AS DECIMAL(28, 8),
    @Amount2 AS DECIMAL(28, 8),
    @Amount3 AS DECIMAL(28, 8),
    @Amount4 AS DECIMAL(28, 8),
	@Amount5 AS DECIMAL(28, 8),
    @Amount6 AS DECIMAL(28, 8),
    @ReportCode AS NVARCHAR(50)=''
)			
AS

			DECLARE @TempLineID         AS NVARCHAR(50),
					@TempParrentLineID  AS NVARCHAR(50)
	
			--------- Cap nhat vao chinh chi tieu cua no.
			
			IF (Select DisplayedMark From AT7915 Where LineID = @LineID AND DivisionID = @DivisionID ) = 1
					
					UPDATE AT7915
					SET    Amount1 = -(ISNULL(Amount1, 0) + ISNULL(@Amount1, 0)),
						   Amount2 = -(ISNULL(Amount2, 0) + ISNULL(@Amount2, 0)),
						   Amount3 = -(ISNULL(Amount3, 0) + ISNULL(@Amount3, 0)),
						   Amount4 = -(ISNULL(Amount4, 0) + ISNULL(@Amount4, 0)),
						   Amount5 = -(ISNULL(Amount5, 0) + ISNULL(@Amount5, 0)),
						   Amount6 = -(ISNULL(Amount6, 0) + ISNULL(@Amount6, 0))
					WHERE  LineID = @LineID AND DivisionID = @DivisionID
					
			Else
					UPDATE AT7915
					SET    Amount1 = ISNULL(Amount1, 0) + ISNULL(@Amount1, 0),
						   Amount2 = ISNULL(Amount2, 0) + ISNULL(@Amount2, 0),
						   Amount3 = ISNULL(Amount3, 0) + ISNULL(@Amount3, 0),
						   Amount4 = ISNULL(Amount4, 0) + ISNULL(@Amount4, 0),
						   Amount5 = ISNULL(Amount5, 0) + ISNULL(@Amount5, 0),
						   Amount6 = ISNULL(Amount6, 0) + ISNULL(@Amount6, 0)
					WHERE  LineID = @LineID AND DivisionID = @DivisionID
					


			SET @TempLineID = @LineID
			SET @TempParrentLineID = (SELECT ISNULL(ParrentLineID, '') FROM AT7902 WHERE LineID = @TempLineID AND DivisionID = @DivisionID
										And ReportCode like Case when @ReportCode='' then '%' else @ReportCode end)

			WHILE @TempParrentLineID <> '' --- Neu con cha thi van tiep tuc
			BEGIN
				---Print ' Nhan @TempLineID +' +@TempLineID	
				IF (Select DisplayedMark From AT7915 Where LineID = @LineID AND DivisionID = @DivisionID ) = 1
					UPDATE AT7915
					SET    Amount1 = -(ISNULL(Amount1, 0) + ISNULL(@Amount1, 0)),
						   Amount2 = -(ISNULL(Amount2, 0) + ISNULL(@Amount2, 0)),
						   Amount3 = -(ISNULL(Amount3, 0) + ISNULL(@Amount3, 0)),
						   Amount4 = -(ISNULL(Amount4, 0) + ISNULL(@Amount4, 0)),
						   Amount5 = -(ISNULL(Amount5, 0) + ISNULL(@Amount5, 0)),
						   Amount6 = -(ISNULL(Amount6, 0) + ISNULL(@Amount6, 0))
					WHERE  LineID = @TempParrentLineID AND DivisionID = @DivisionID
					
				Else
					UPDATE AT7915
					SET    Amount1 = ISNULL(Amount1, 0) + ISNULL(@Amount1, 0),
						   Amount2 = ISNULL(Amount2, 0) + ISNULL(@Amount2, 0),
						   Amount3 = ISNULL(Amount3, 0) + ISNULL(@Amount3, 0),
						   Amount4 = ISNULL(Amount4, 0) + ISNULL(@Amount4, 0),
						   Amount5 = ISNULL(Amount5, 0) + ISNULL(@Amount5, 0),
						   Amount6 = ISNULL(Amount6, 0) + ISNULL(@Amount6, 0)
					WHERE  LineID = @TempParrentLineID AND DivisionID = @DivisionID

				SET @TempLineID = @TempParrentLineID		
				SET @TempParrentLineID = (SELECT ISNULL(ParrentLineID, '') FROM AT7902 WHERE LineID = @TempLineID AND DivisionID = @DivisionID
										And ReportCode like Case when @ReportCode='' then '%' else @ReportCode end)
			END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

