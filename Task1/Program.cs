// See https://aka.ms/new-console-template for more information

using System.Xml.XPath;

namespace Task1;

internal static class Program
{
    public static void Main(string[] args)
    {
        #region DomParser

        // var doc = new XmlDocument();
        // doc.PreserveWhitespace = false;
        // try
        // {
        //     doc.Load("computerParts.xml");
        // }
        // catch (FileNotFoundException e)
        // {
        //     Console.WriteLine(e.Message);
        // }
        //
        // XElement root = doc.DocumentElement != null ? XElement.Parse(doc.DocumentElement.OuterXml) : null;
        //
        // foreach (XElement category in root.Elements())
        // {
        //     Console.WriteLine("\t" + category.Name + " : " + category.FirstAttribute.Value + Environment.NewLine);
        //     foreach (var part in category.Elements().Descendants())
        //     {
        //         Console.WriteLine("\t\t" + part.Name + " = " + part.Value + Environment.NewLine);
        //     }
        // }

        #endregion

        XmlToHtml.Transform("computerParts.xml", "../../../computerParts_table.xsl");

        #region XPath Queries
        
        XPathDocument xPathDocument = new XPathDocument(@"../../../computerParts.xml");
        XPathNavigator navigator = xPathDocument.CreateNavigator();

        //	Calculate total price of all products.
        var totalPrice = (double)navigator.Evaluate("sum(descendant::part/price)");
        Console.WriteLine("Total price of all parts: {0}", totalPrice.ToString());

        //  Calculate total price of all parts for each category.
        XPathNodeIterator categories = navigator.Select("descendant::category");
        while (categories.MoveNext())
        {
            XPathNavigator category = categories.Current;
            var categoryPrice = (double)category.Evaluate("sum(descendant::part/price)");
            Console.WriteLine("Total price of all parts in category {0}: {1}",
                category.GetAttribute("name", ""), categoryPrice.ToString());
        }

        //	Calculate total count of all parts.
        var totalCount = (double)navigator.Evaluate("count(descendant::part)");
        Console.WriteLine("Total count of all parts: {0}", totalCount.ToString());

        //	Calculate total count of all products for each category.
        categories = navigator.Select("descendant::category");
        while (categories.MoveNext())
        {
            XPathNavigator category = categories.Current;
            var categoryCount = (double)category.Evaluate("count(descendant::part)");
            Console.WriteLine("Total count of all parts in category {0}: {1}",
                category.GetAttribute("name", ""), categoryCount.ToString());

        }
        
        //	Calculate total count of Intel products.
        var intelCount = (double)navigator.Evaluate("count(descendant::part[contains(name, 'Intel')])");
        Console.WriteLine("Total count of Intel parts: {0}", intelCount.ToString());
        
        //  Calculate total count of AMD products.
        var amdCount = (double)navigator.Evaluate("count(descendant::part[contains(name, 'AMD')])");
        Console.WriteLine("Total count of AMD parts: {0}", amdCount.ToString());
        
        #endregion

    }
}