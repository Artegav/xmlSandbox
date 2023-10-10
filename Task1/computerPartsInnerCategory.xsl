<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <computerParts>
            <xsl:for-each select="computerParts/category/part">
                <xsl:element name="part" use-attribute-sets="part-attr">
                    <category>
                        <xsl:value-of select="../@name"/>
                    </category>
                    <xsl:copy-of select="name"/>
                    <xsl:copy-of select="price"/>
                    <xsl:if test="capacity">
                        <xsl:copy-of select="capacity"/>
                    </xsl:if>
                </xsl:element>
            </xsl:for-each>
        </computerParts>
    </xsl:template>

    <xsl:attribute-set name="part-attr">
        <xsl:attribute name="quantity">
            <xsl:value-of select="@quantity"/>
        </xsl:attribute>
        <xsl:attribute name="onSale">
            <xsl:value-of select="@onsale"/>
        </xsl:attribute>

    </xsl:attribute-set>
</xsl:stylesheet>