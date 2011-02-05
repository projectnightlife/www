<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" />


<!-- Generic All Rules Match -->
<xsl:template match="/">
  <xsl:value-of select="./text()" />
  <xsl:apply-templates />
</xsl:template>

<!-- Hyperlinks --> 
<xsl:template match="//pnobject[@type='link']">
  <a href="{./@url}" target="_blank">
	<xsl:value-of select="./@text" />
  </a>
</xsl:template>

<!-- text formatting -->
<xsl:template match="//b">
  <b>
	<xsl:value-of select="./text()" />
  </b>
</xsl:template>

<xsl:template match="//i">
  <i>
	<xsl:value-of select="./text()" />
  </i>
</xsl:template>

<xsl:template match="//u">
  <u>
	<xsl:value-of select="./text()" />
  </u>
</xsl:template>

<!-- Standard Images -->
<xsl:template match="//pnobject[@type='image']">
	<img src="http://www.projectnightlife.co.uk/photo/{./@id}/606x450" />
</xsl:template>

<!-- Flash -->
<xsl:template match="//pnobject[@type='flash']">
<object width="{./@width}" height="{./@height}">
	<param name="movie" value="{./@url}"></param>
	<param name="allowFullScreen" value="true"></param>
	<param name="allowscriptaccess" value="always"></param>
    <param name="wmode" value="transparent" />
	<embed src="{./@url}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="{./@width}" height="{./@height}" wmode="transparent"></embed>
</object>
</xsl:template>

<!-- Depreciated for now -->
<!-- YouTube Video -->
<xsl:template match="//object[@type='youtube']">
<object width="{./@width}" height="{./@height}">
	<param name="movie" value="{./@url}"></param>
	<param name="allowFullScreen" value="true"></param>
	<param name="allowscriptaccess" value="always"></param>
    <param name="wmode" value="transparent" />
	<embed src="{./@url}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="{./@width}" height="{./@height}" wmode="transparent"></embed>
</object>
</xsl:template>

<!-- SoundCloud Embed -->
<xsl:template match="//object[@type='soundcloud']">
<object height="{./@height}" width="{./@width}">
	<param name="movie" value="{./@url}"></param>
	<param name="allowscriptaccess" value="always"></param>
    <param name="wmode" value="transparent" />
	<embed allowscriptaccess="always" height="{./@height}" src="{./@url}" type="application/x-shockwave-flash" width="{./@width}" wmode="transparent"></embed>
</object>
<span>
	<a href="{./@captionUrl}">
		<xsl:value-of select="./@caption" />
	</a>
	by
	<a href="{./@authorUrl}">
		<xsl:value-of select="./@author" />
	</a>
</span> 
</xsl:template>

</xsl:stylesheet>

