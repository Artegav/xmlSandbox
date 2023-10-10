<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <body>
                <h1>Computer Parts</h1>
                <ul border="1">
                    <xsl:for-each select="computerParts/category/part">
                        <li>Category:
                            <xsl:value-of select="../@name"/>
                        </li>
                        <ul>
                            <li>Part Name:
                                <xsl:value-of select="name"/>
                            </li>
                            <li>Price:
                                <xsl:value-of select="price"/>
                            </li>
                            <xsl:if test="capacity">
                                <li>Capacity:
                                    <xsl:value-of select="capacity"/>
                                </li>
                            </xsl:if>
                            <li>Quantity:
                                <xsl:value-of select="@quantity"/>
                            </li>
                            <li>On Sale:
                                <xsl:value-of select="@onsale"/>
                            </li>
                        </ul>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>