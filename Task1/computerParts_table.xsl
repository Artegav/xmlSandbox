<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:f="http://www.f.org/1999/XSL/Transform">

    <xsl:attribute-set name="all-products">
        <xsl:attribute name="quantity">
            <xsl:value-of select="count(//part)"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:function name="f:color">
        <xsl:param name="name"/>
        <xsl:choose>
            <xsl:when test="contains($name, 'Intel')">
                <xsl:attribute name="style" select="'color: blue'"/>
            </xsl:when>
            <xsl:when test="contains($name, 'AMD')">
                <xsl:attribute name="style" select="'color: red'"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>

    <xsl:template match="part" name="nameOfPart">
        <xsl:if test="name=''">
            <xsl:message terminate="yes">
                ERROR: Product must contain a name.
            </xsl:message>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="@onsale='true'">
                <xsl:element name="span">
                    <xsl:attribute name="style" select="f:color(name)"/>
                    <xsl:value-of select="concat(./name, ' [ON SALE!]' )"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                    <xsl:attribute name="style" select="f:color(name)"/>
                    <xsl:value-of select="name"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="capacity" name="capacity">
        <xsl:value-of select="capacity"/>
        <xsl:if test="capacity">
            <xsl:text> GB</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="/">
        <html>
            <body>
                <h1>Computer Parts</h1>
                <xsl:element name="products" use-attribute-sets="all-products"/>

                <table border="1">
                    <tr bgcolor="#9acd32">
                        <th bgcolor="white"/>
                        <th>Category</th>
                        <th>Part Name</th>
                        <th>Price</th>
                        <th>Capacity</th>
                        <th>Quantity</th>
                    </tr>
                    <xsl:for-each select="computerParts/category/part">
                        <xsl:sort select="price" order="descending" data-type="number"/>
                        <tr>
                            <td bgcolor="#FFB370">
                                <xsl:number value="position()" format="1. "/>
                            </td>
                            <td>
                                <xsl:value-of select="../@name "/>
                            </td>
                            <td>
                                <xsl:call-template name="nameOfPart"/>
                            </td>
                            <td>
                                <xsl:value-of select="price"/>
                                <xsl:text> $</xsl:text>
                            </td>
                            <td>
                                <xsl:call-template name="capacity"/>
                            </td>
                            <td>
                                <xsl:value-of select="@quantity"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>