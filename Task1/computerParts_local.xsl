<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:f="http://www.fun.org/1999/XSL/Transform">

    <xsl:function name="f:color">
        <xsl:param name="name"/>
        <xsl:choose>
            <xsl:when test="contains($name, 'Intel')">
                <xsl:element name="span">
                    <xsl:attribute name="style">color: blue</xsl:attribute>
                    <xsl:value-of select="$name"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="contains($name, 'AMD')">
                <xsl:element name="span">
                    <xsl:attribute name="style">color: red</xsl:attribute>
                    <xsl:value-of select="$name"/>
                </xsl:element>
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
                <xsl:value-of select="concat(./name, ' [ON SALE!]' )"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="name"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="capacity" name="capacity">
        <xsl:value-of select="capacity"/>
        <xsl:if test="capacity">
            <xsl:text> GB</xsl:text>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>