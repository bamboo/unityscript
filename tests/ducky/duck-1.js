/*
Hello
*/

import System.Xml;
import System.IO;
import System;

TestXml();

function TestXml( )
{
	var XmlDoc : XmlDocument = new XmlDocument();
	
	var data = 
	"<identity>\n" +
	"	<name>Hello</name>\n" +
	"</identity>\n";

	XmlDoc.LoadXml(data);
	
	var identitiesList : XmlNodeList = XmlDoc.GetElementsByTagName("identity");
		
	/// This works perfectly fine:
	/// for(var N : XmlNode in identitiesList)
    for(var N in identitiesList)
	{
		print(N["name"].InnerText);
	}
}