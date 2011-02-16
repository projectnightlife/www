<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" />

<xsl:template match="/">
<Response>
  <data>
    <photos>
	  <xsl:for-each select="//pnobject[@type='image']">
        <photo>
          <id><xsl:value-of select="./@id" /></id>
          <tag>&lt;pnobject type=&quot;image&quot; id=&quot;<xsl:value-of select="./@id" />&quot; /&gt;</tag>
        </photo>
      </xsl:for-each>
    </photos>
    <objects>
      <xsl:for-each select="//pnobject[@type='flash']">
        <object>
          <url><xsl:value-of select="./@url" /></url>
          <width><xsl:value-of select="./@width" /></width>
          <height><xsl:value-of select="./@height" /></height>
          <tag>&lt;pnobject type=&quot;flash&quot; url=&quot;<xsl:value-of select="./@url" />&quot; width=&quot;<xsl:value-of select="./@width" />&quot; height=&quot;<xsl:value-of select="./@height" />&quot; /&gt;</tag>
        </object>
      </xsl:for-each>
    </objects>
    <links>
      <xsl:for-each select="//pnobject[@type='link']">
        <link>
          <url><xsl:value-of select="./@url" /></url>
          <text><xsl:value-of select="./@text" /></text>
          <tag>&lt;pnobject type=&quot;link&quot; url=&quot;<xsl:value-of select="./@url" />&quot; text=&quot;<xsl:value-of select="./@text" />&quot; /&gt;</tag>
        </link>
      </xsl:for-each>
    </links>
  </data>
</Response>  
</xsl:template>

</xsl:stylesheet>

