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
	"<avatar>\n" +
	"	<name>Hello</name>\n" +
	"</avatar>\n" +
	"</identity>\n";

	XmlDoc.LoadXml(data);
	
	var identitiesList : XmlNodeList = XmlDoc.GetElementsByTagName("identity");
		
	/// This works perfectly fine:
	/// for(var N : XmlNode in identitiesList)
    for(var N in identitiesList)
	{
		print(N["avatar"]["name"].InnerText);
	}
}