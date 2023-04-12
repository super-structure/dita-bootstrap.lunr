<?xml version="1.0" encoding="UTF-8" ?>
<!--
  This file is part of the DITA-OT Bootstrap Lunr Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<xsl:output omit-xml-declaration="yes" indent="no" method="text" />

	<!--
		Add standard tags based on the ditamap
	-->
	<xsl:template match="/">
		<xsl:text>[</xsl:text>
		<xsl:apply-templates select="//topic" />
		<xsl:text>]</xsl:text>		
	</xsl:template>

	<xsl:template match="topic">
		<xsl:text>{</xsl:text>

		<xsl:text>"id": "</xsl:text>
		<xsl:value-of select="generate-id(.)" />
		<xsl:text>",</xsl:text>

		<xsl:text>"link": "</xsl:text>
		<xsl:value-of select="@href" />
		<xsl:text>",</xsl:text>

		<xsl:text>"t": "</xsl:text>
		<xsl:value-of
      select="replace(replace(@title, '\\', '\\\\'), '&quot;', '\\&quot;')"
    />
		<xsl:text>",</xsl:text>

		<xsl:text>"k": "</xsl:text>
		<xsl:value-of
      select="replace(replace(@keywords, '\\', '\\\\'), '&quot;', '\\&quot;')"
    />
		<xsl:text>",</xsl:text>

		<xsl:text>"d": "</xsl:text>
		<xsl:value-of
      select="replace(replace(replace(abstract, '\\', '\\\\'), '&quot;', '\\&quot;'), ' \s+', ' ')"
    />
		<xsl:text>",</xsl:text>

		<xsl:text>"b": "</xsl:text>
		<xsl:value-of
      select="replace(replace(replace(text, '\\', '\\\\'), '&quot;', '\\&quot;'), ' \s+', ' ')"
    />
		<xsl:text>"</xsl:text>

		<xsl:text>}</xsl:text>
		<xsl:if test="following-sibling::topic">
			<xsl:text>,&#xA;</xsl:text>
		</xsl:if>
		
	</xsl:template>

</xsl:stylesheet>
