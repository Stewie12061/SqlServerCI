IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7907_TIENTIEN]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7907_TIENTIEN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



----- Created by Nguyen Van Nhan,
------ Date 24/09/2008
------ Purpose: Xu ly so lieu phan lien quan den TSCD cua bang thuyet minh tai chinh
---- Modified on 31/01/2012 by Le Thi Thu Hien : Bo sung lay ToCorAccountID
---- Modified by on 11/10/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified on 31/03/2021 by Huỳnh Thử: Tách Store TienTien -- Xuất Execl nhiều divisionID

CREATE PROCEDURE [dbo].[AP7907_TIENTIEN]
       @DivisionID AS nvarchar(50) ,
       @TranYear AS int ,
       @ReportCode AS nvarchar(50) ,
       @GroupID AS nvarchar(50) ,
       @TitleID AS nvarchar(50) ,
       @OperatorID AS nvarchar(50) ,
       @IsCol01 AS tinyint ,
       @IsCol02 AS tinyint ,
       @IsCol03 AS tinyint ,
       @IsCol04 AS tinyint ,
       @IsCol05 AS tinyint ,
       @IsCol06 AS tinyint ,
       @IsCol07 AS tinyint ,
       @IsCol08 AS tinyint ,
       @IsCol09 AS tinyint ,
       @IsCol10 AS TINYINT,
       @StrDivisionID AS NVARCHAR(4000) = ''
AS
DECLARE
        @FromAccountID AS nvarchar(50) ,
        @ToAccountID AS nvarchar(50) ,
        @FromCorAccountID AS nvarchar(50) ,
        @ToCorAccountID AS nvarchar(50)

IF isnull(@IsCol01 , 0) <> 0
   BEGIN
         SELECT	@FromAccountID = FromAccountID ,
				@ToAccountID = ToAccountID ,
				@FromCorAccountID = FromCorAccountID,
				@ToCorAccountID = ToCorAccountID
         FROM	AT7908
         WHERE  ReportCode = @ReportCode 
				AND TitleID = @TitleID 
				AND ColID = 1 
				AND GroupID = @GroupID 
				AND DivisionID = @DivisionID
         EXEC AP7906_TIENTIEN @DivisionID , @TranYear , @ReportCode , @GroupID , @TitleID , @OperatorID , @FromAccountID , @ToAccountID , @FromCorAccountID , @ToCorAccountID , 1, @StrDivisionID
   END

IF isnull(@IsCol02 , 0) <> 0
   BEGIN
         SELECT
             @FromAccountID = FromAccountID ,
             @ToAccountID = ToAccountID ,
             @FromCorAccountID = FromCorAccountID,
             @ToCorAccountID = ToCorAccountID
         FROM	AT7908
         WHERE  ReportCode = @ReportCode 
				AND TitleID = @TitleID 
				AND ColID = 2 
				AND GroupID = @GroupID 
				AND DivisionID = @DivisionID
				
         EXEC AP7906_TIENTIEN @DivisionID , @TranYear , @ReportCode , @GroupID , @TitleID , @OperatorID , @FromAccountID , @ToAccountID , @FromCorAccountID , @ToCorAccountID , 2, @StrDivisionID
   END

IF isnull(@IsCol03 , 0) <> 0
   BEGIN
         SELECT
             @FromAccountID = FromAccountID ,
             @ToAccountID = ToAccountID ,
             @FromCorAccountID = FromCorAccountID,
             @ToCorAccountID = ToCorAccountID
         FROM	AT7908
         WHERE	ReportCode = @ReportCode AND TitleID = @TitleID AND ColID = 3 AND GroupID = @GroupID AND DivisionID = @DivisionID
         EXEC AP7906_TIENTIEN @DivisionID , @TranYear , @ReportCode , @GroupID , @TitleID , @OperatorID , @FromAccountID , @ToAccountID , @FromCorAccountID , @ToCorAccountID , 3, @StrDivisionID
   END

IF isnull(@IsCol04 , 0) <> 0
   BEGIN
         SELECT
             @FromAccountID = FromAccountID ,
             @ToAccountID = ToAccountID ,
             @FromCorAccountID = FromCorAccountID,
             @ToCorAccountID = ToCorAccountID
         FROM
             AT7908
         WHERE
             ReportCode = @ReportCode AND TitleID = @TitleID AND ColID = 4 AND GroupID = @GroupID AND DivisionID = @DivisionID
         EXEC AP7906_TIENTIEN @DivisionID , @TranYear , @ReportCode , @GroupID , @TitleID , @OperatorID , @FromAccountID , @ToAccountID , @FromCorAccountID , @ToCorAccountID , 4, @StrDivisionID
   END

IF isnull(@IsCol05 , 0) <> 0
   BEGIN
         SELECT
             @FromAccountID = FromAccountID ,
             @ToAccountID = ToAccountID ,
             @FromCorAccountID = FromCorAccountID,
             @ToCorAccountID = ToCorAccountID
         FROM
             AT7908
         WHERE
             ReportCode = @ReportCode AND TitleID = @TitleID AND ColID = 5 AND GroupID = @GroupID AND DivisionID = @DivisionID
         EXEC AP7906_TIENTIEN @DivisionID , @TranYear , @ReportCode , @GroupID , @TitleID , @OperatorID , @FromAccountID , @ToAccountID , @FromCorAccountID , @ToCorAccountID , 5, @StrDivisionID
   END


IF isnull(@IsCol06 , 0) <> 0
   BEGIN
         SELECT
             @FromAccountID = FromAccountID ,
             @ToAccountID = ToAccountID ,
             @FromCorAccountID = FromCorAccountID,
             @ToCorAccountID = ToCorAccountID
         FROM
             AT7908
         WHERE
             ReportCode = @ReportCode AND TitleID = @TitleID AND ColID = 6 AND GroupID = @GroupID AND DivisionID = @DivisionID
         EXEC AP7906_TIENTIEN @DivisionID , @TranYear , @ReportCode , @GroupID , @TitleID , @OperatorID , @FromAccountID , @ToAccountID , @FromCorAccountID , @ToCorAccountID , 6, @StrDivisionID
   END

IF isnull(@IsCol07 , 0) <> 0
   BEGIN
         SELECT
             @FromAccountID = FromAccountID ,
             @ToAccountID = ToAccountID ,
             @FromCorAccountID = FromCorAccountID,
             @ToCorAccountID = ToCorAccountID
         FROM
             AT7908
         WHERE
             ReportCode = @ReportCode AND TitleID = @TitleID AND ColID = 7 AND GroupID = @GroupID AND DivisionID = @DivisionID
         EXEC AP7906_TIENTIEN @DivisionID , @TranYear , @ReportCode , @GroupID , @TitleID , @OperatorID , @FromAccountID , @ToAccountID , @FromCorAccountID , @ToCorAccountID , 7, @StrDivisionID
   END


IF isnull(@IsCol08 , 0) <> 0
   BEGIN
         SELECT
             @FromAccountID = FromAccountID ,
             @ToAccountID = ToAccountID ,
             @FromCorAccountID = FromCorAccountID,
             @ToCorAccountID = ToCorAccountID
         FROM
             AT7908
         WHERE
             ReportCode = @ReportCode AND TitleID = @TitleID AND ColID = 8 AND GroupID = @GroupID AND DivisionID = @DivisionID
         EXEC AP7906_TIENTIEN @DivisionID , @TranYear , @ReportCode , @GroupID , @TitleID , @OperatorID , @FromAccountID , @ToAccountID , @FromCorAccountID , @ToCorAccountID , 8, @StrDivisionID
   END

IF isnull(@IsCol09 , 0) <> 0
   BEGIN
         SELECT
             @FromAccountID = FromAccountID ,
             @ToAccountID = ToAccountID ,
             @FromCorAccountID = FromCorAccountID,
             @ToCorAccountID = ToCorAccountID
         FROM
             AT7908
         WHERE
             ReportCode = @ReportCode AND TitleID = @TitleID AND ColID = 9 AND GroupID = @GroupID AND DivisionID = @DivisionID
         EXEC AP7906_TIENTIEN @DivisionID , @TranYear , @ReportCode , @GroupID , @TitleID , @OperatorID , @FromAccountID , @ToAccountID , @FromCorAccountID , @ToCorAccountID , 9, @StrDivisionID
   END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

