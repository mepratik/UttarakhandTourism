import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import org.xml.sax.SAXException;
import java.net.HttpURLConnection;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
public class tempreatureApi {

    URL sendURL;
    StringBuffer sb=new StringBuffer();
    HttpURLConnection sendConnection;
public static void main(String a[]) throws IOException{
	tempreatureApi api=new tempreatureApi();
	//api.makeconnection();
	api.getLat();
}
  
  public void getLat() {
			String lat = null;
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = null;
			try {
				db = dbf.newDocumentBuilder();
			} catch (ParserConfigurationException e) {
				 System.err.println("doccument builder error");
				e.printStackTrace();
			}

			Document dom = null;
			try {
				dom = db.parse("http://api.wunderground.com/api/ff58b2ccce78badf/conditions/q/CA/dehradun.xml");
			} catch (SAXException e) {
				 System.err.println("parse error saxe exception");
				e.printStackTrace();
			} catch (IOException e) {
				 System.err.println("parse error io excetion");
				e.printStackTrace();
			}
			//System.out.println("asdasd");
			Element docEle = dom.getDocumentElement();
			NodeList nl = docEle.getElementsByTagName("Its Working..");
			for (int i = 0; i < nl.getLength(); i++) {
				Element el = (Element) nl.item(i);
				System.out.println("current_observation");
				NodeList nl1 = el.getElementsByTagName("temperature_string");
				Element el2 = (Element) nl1.item(0);
				lat = el2.getFirstChild().getNodeValue();
				//nl1 = el.getElementsByTagName("feelslike_c");
			//	System.out.print(nl1);
				//el2 = (Element) nl1.item(0);
				//lat += "," + el2.getFirstChild().getNodeValue();
				System.out.println("current tempreature of the enterd place is   "+lat);

			}
   }
  public void makeconnection() throws IOException{
	  try {
          
         
          sendURL=new URL("http://words.bighugelabs.com/api/2/ca1b696b60b0fa473c047ce1bacaea28/love/");
         
          sendConnection = (HttpURLConnection) sendURL.openConnection();
	  }catch (UnsupportedEncodingException ex) {
          System.err.println("Message content encoding error");
          System.exit(0);
      }catch (MalformedURLException ex) {
          System.err.println("Sending URL Error");
          System.exit(0);
      }catch (IOException ex) {
         System.err.println("Sending URL Connection Error");
         System.exit(0);
      } 
	  String str;
	 String value[];
	BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(sendConnection.getInputStream()));
      while ((str=bufferedReader.readLine()) != null)
      { 
    	  value=str.split("\\|");
    	  if(value[1]!="ant")
    	  System.out.println(value[2]);
    	  
    	  //StringTokenizer token = new StringTokenizer(str, "|");
    	   // while(token.hasMoreTokens())
    	    //  System.out.println(token.nextToken());
      }
  
  }

}


