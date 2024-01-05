IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP8888]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP8888]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Danh sách báo cáo BI
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Khả Vi, Date: 18/12/2017
 ----Modified by Tiểu Mai on 13/06/2018: Sửa table kiểm tra lỗi
 /*-- <Example>
 
 ----*/
 
 CREATE PROCEDURE BP8888
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
    @IsCommon TINYINT, 
	@Mode TINYINT -- 1: Thêm mới 
				-- 0: Sửa
)
AS 
IF @Mode = 1 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM BT8888 WHERE ReportID = @ReportID)
	INSERT INTO BT8888 (APK, DivisionID, ReportID, ReportName, ReportNameE, Title, TitleE, [Description], DescriptionE,
	GroupID, [Type], SQLstring, Orderby, [Disabled], IsCommon)
	VALUES (NEWID(), @DivisionID, @ReportID, @ReportName, @ReportNameE, @ReportTitle, @ReportTitleE, @Description, @DescriptionE,
	@GroupID, @Type, @SQLstring, @Orderby, @Disabled, @IsCommon)
END
ELSE 
BEGIN
	UPDATE BT8888 SET ReportName = @ReportName, ReportNameE = @ReportNameE, Title = @ReportTitle, TitleE = @ReportTitleE, [Description] = @Description, 
	DescriptionE = @DescriptionE, GroupID = @GroupID, [Type] = @Type, SQLstring = @SQLstring, Orderby = @Orderby, [Disabled] = @Disabled, IsCommon = @IsCommon
	WHERE ReportID = @ReportID
END 
	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
