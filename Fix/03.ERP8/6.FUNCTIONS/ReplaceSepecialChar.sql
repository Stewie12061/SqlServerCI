/****** Object:  UserDefinedFunction [dbo].[ReplaceSepecialChar]    Script Date: 05/12/2011 11:51:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReplaceSepecialChar]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ReplaceSepecialChar]
GO
/****** Object:  UserDefinedFunction [dbo].[ReplaceSepecialChar]    Script Date: 05/12/2011 11:51:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************
'* Edited by: [GS] [Hoàng Phước] [30/07/2010]
'********************************************/
CREATE FUNCTION [dbo].[ReplaceSepecialChar] (@InStr as nvarchar(4000))
RETURNS nvarchar(4000)
AS 
BEGIN

declare @find nvarchar(5)
Declare @replace nvarchar(5)

Set @find = char(39)
Set @replace = char(39)+char(39)
Set @InStr = replace(@InStr,@find,@replace) 

RETURN @InStr

END