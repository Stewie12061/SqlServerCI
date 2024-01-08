--- Create by Bảo Thy on 19/02/2016
--- Bổ sung các báo cáo vào danh sách báo cáo OOT8888
DELETE OOT8888
DECLARE
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
------------------------------------------BÁO CÁO CƠM NHÂN VIÊN---------------------------------------------------    
SET @DivisionID = 'CTY' 
SET @ReportID = N'OOR3001'
SET @ReportName = N'Báo cáo cơm nhân viên'
SET @ReportNameE = N'Báo cáo cơm nhân viên'
SET @ReportTitle = N'BÁO CÁO CƠM NHÂN VIÊN'
SET @ReportTitleE = N'BÁO CÁO CƠM NHÂN VIÊN'
SET @Description = N'Báo cáo cơm nhân viên'
SET @DescriptionE = N'Báo cáo cơm nhân viên'
SET @GroupID = N'G01'
SET @Type = 0
SET @IsCommon = 1
SET @Disabled = 0
SET @SQLstring = N''
SET @Orderby = N''
EXEC OOP8888 @DivisionID , @GroupID, @ReportID, @ReportName, @ReportNameE, @ReportTitle, @ReportTitleE, @Description, @DescriptionE,
			@Type, @Disabled, @SQLstring, @Orderby, @IsCommon
			
------------------------------------------BÁO CÁO DANH SÁCH NHÂN VIÊN CHƯA PHÂN CA---------------------------------------------------    
SET @DivisionID = 'CTY' 
SET @ReportID = N'OOR3002'
SET @ReportName = N'Báo cáo nhân viên chưa phân ca'
SET @ReportNameE = N'Báo cáo nhân viên chưa phân ca'
SET @ReportTitle = N'BÁO CÁO NHÂN VIÊN CHƯA PHÂN CA'
SET @ReportTitleE = N'BÁO CÁO NHÂN VIÊN CHƯA PHÂN CA'
SET @Description = N'Báo cáo nhân viên chưa phân ca'
SET @DescriptionE = N'Báo cáo nhân viên chưa phân ca'
SET @GroupID = N'G01'
SET @Type = 0
SET @IsCommon = 1
SET @Disabled = 0
SET @SQLstring = N''
SET @Orderby = N''
EXEC OOP8888 @DivisionID , @GroupID, @ReportID, @ReportName, @ReportNameE, @ReportTitle, @ReportTitleE, @Description, @DescriptionE,
			@Type, @Disabled, @SQLstring, @Orderby, @IsCommon		
			
------------------------------------------BÁO CÁO DANH SÁCH NHÂN VIÊN BẤT THƯỜNG---------------------------------------------------    
SET @DivisionID = 'CTY' 
SET @ReportID = N'OOR3003'
SET @ReportName = N'Báo cáo nhân viên bất thường'
SET @ReportNameE = N'Báo cáo nhân viên bất thường'
SET @ReportTitle = N'BÁO CÁO NHÂN VIÊN BẤT THƯỜNG'
SET @ReportTitleE = N'BÁO CÁO NHÂN VIÊN BẤT THƯỜNG'
SET @Description = N'Báo cáo nhân viên bất thường'
SET @DescriptionE = N'Báo cáo nhân viên bất thường'
SET @GroupID = N'G01'
SET @Type = 0
SET @IsCommon = 1
SET @Disabled = 0
SET @SQLstring = N''
SET @Orderby = N''
EXEC OOP8888 @DivisionID , @GroupID, @ReportID, @ReportName, @ReportNameE, @ReportTitle, @ReportTitleE, @Description, @DescriptionE,
			@Type, @Disabled, @SQLstring, @Orderby, @IsCommon
					