using System.Xml.Xsl;

namespace Task1;

public static class XmlToHtml
{
    public static void Transform(string xmlPath, string xsltPath)
    {
        try
        {
            var xslt = new XslCompiledTransform();
            xslt.Load(xsltPath);
            xslt.Transform(xmlPath, "../../../computerParts.html");
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }

        Console.WriteLine("Transformation successful");
    }
}