IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP8888]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP8888]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Danh sách báo cáo ApproveOnline
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 19/02/2016
 /*-- <Example>
 
 ----*/
 
 CREATE PROCEDURE OOP8888
(
	@DivisionID VARCHAR(50),
	@GroupID NVARCHAR(50),  
    @ReportID NVARCHAR(50),
    @ReportName NVARCHAR(250),
    @ReportNameE NVARCHAR(250),
    @ReportTitle NVARCHAR(250),
    @ReportTitleE NVARCHAR(250),
    @Description NVARCHAR(250),
    @DescriptionE NVARCHAR(250),
    @Type TINYINT,
    @Disabled TINYINT,
    @SQLstring NVARCHAR(4000),
    @Orderby NVARCHAR(200),
    @IsCommon TINYINT
)
AS
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT8888 WHERE ReportID = @ReportID)
	INSERT INTO OOT8888(DivisionID, ReportID, ReportName, ReportNameE, Title, TitleE, [Description], DescriptionE,
		GroupID, [Type], [Disabled], SQLstring, Orderby,IsCommon)
	VALUES (@DivisionID, @ReportID, @ReportName, @ReportNameE, @ReportTitle, @ReportTitleE, @Description, @DescriptionE,
		@GroupID, @Type, @Disabled, @SQLstring, @Orderby, @IsCommon)
		
ELSE UPDATE OOT8888 SET ReportName = @ReportName, ReportNameE = @ReportNameE, Title = @ReportTitle, TitleE = @ReportTitleE,
[Description] = @Description, DescriptionE = @DescriptionE, GroupID = @GroupID, [Type] = @Type, [Disabled] = @Disabled,
SQLstring = @SQLstring, Orderby = @Orderby,IsCommon = @IsCommon
WHERE ReportID = @ReportID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
