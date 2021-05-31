public class SF_pageController {
    
    public Contact con { get;set;}
    public  SF_pageController(){
        con = new Contact();
    }
    
    public void save() {
        insert con;       
        con = new Contact();	 	
    } 
}