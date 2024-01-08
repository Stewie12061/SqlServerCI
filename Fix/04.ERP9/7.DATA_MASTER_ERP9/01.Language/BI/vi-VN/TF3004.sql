declare @ID			nvarchar(MAX) 
declare @LanguageID nvarchar(MAX) 			
declare @LanguageValue		nvarchar(MAX) 	
declare @ModuleID		nvarchar(MAX) 	
declare @Deleted	nvarchar(MAX) 		
declare @FormID		nvarchar(MAX) 	

--------------------		
SET @LanguageID = 'vi-VN' 
SET @ModuleID = 'BI';
SET @FormID = 'TF3004';

set @LanguageValue		 = N'Báo cáo so sánh ngân sách kế hoạch và thực tế'	
EXEC ERP9AddLanguage @ModuleID, 'TF3004.Title', @FormID, @LanguageValue, @LanguageID;	

--------------------			
set @LanguageValue		 = N'Đơn vị'	
EXEC ERP9AddLanguage @ModuleID, 'TF3004.DivisionID', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Loại ngân sách'	
EXEC ERP9AddLanguage @ModuleID, 'TF3004.BudgetTypeID', @FormID, @LanguageValue, @LanguageID;
--------------------		
		
set @LanguageValue		 = N'Ngày lập ngân sách'	
EXEC ERP9AddLanguage @ModuleID, 'TF3004.FromDate', @FormID, @LanguageValue, @LanguageID;

--------------------
set @LanguageValue		 = N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3004.ToDate', @FormID, @LanguageValue, @LanguageID;

--------------------
set @LanguageValue		 = N'Kỳ ngân sách'	
EXEC ERP9AddLanguage @ModuleID, 'TF3004.FromMonth', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3004.FromYear', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3004.ToMonth', @FormID, @LanguageValue, @LanguageID;
--------------------		
set @LanguageValue		 = N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3004.ToYear', @FormID, @LanguageValue, @LanguageID;



