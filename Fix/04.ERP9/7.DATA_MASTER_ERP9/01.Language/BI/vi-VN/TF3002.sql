declare @ID			nvarchar(MAX) 
declare @LanguageID nvarchar(MAX) 			
declare @LanguageValue		nvarchar(MAX) 	
declare @ModuleID		nvarchar(MAX) 	
declare @Deleted	nvarchar(MAX) 		
declare @FormID		nvarchar(MAX) 	

--------------------
SET @LanguageID = 'vi-VN' 
SET @ModuleID = 'BI';
SET @FormID = 'TF3002';		

set @LanguageValue= N'Báo cáo kế hoạch ngân sách phòng'	
EXEC ERP9AddLanguage @ModuleID, 'TF3002.Title', @FormID, @LanguageValue, @LanguageID;

--------------------		
set @LanguageValue= N'Đơn vị'	
EXEC ERP9AddLanguage @ModuleID, 'TF3002.DivisionID', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue= N'Loại ngân sách'	
EXEC ERP9AddLanguage @ModuleID, 'TF3002.BudgetTypeID', @FormID, @LanguageValue, @LanguageID;
--------------------		
		
set @LanguageValue= N'Ngày lập ngân sách'	
EXEC ERP9AddLanguage @ModuleID, 'TF3002.FromDate', @FormID, @LanguageValue, @LanguageID;

--------------------
set @LanguageValue= N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3002.ToDate', @FormID, @LanguageValue, @LanguageID;

--------------------
set @LanguageValue= N'Kỳ ngân sách'	
EXEC ERP9AddLanguage @ModuleID, 'TF3002.FromMonth', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue= N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3002.FromYear', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue= N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3002.ToMonth', @FormID, @LanguageValue, @LanguageID;
--------------------		
set @LanguageValue= N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3002.ToYear', @FormID, @LanguageValue, @LanguageID;
--------------------	
set @LanguageValue= N'Ngân sách'
EXEC ERP9AddLanguage @ModuleID, 'TF3002.AnaID', @FormID, @LanguageValue, @LanguageID;

