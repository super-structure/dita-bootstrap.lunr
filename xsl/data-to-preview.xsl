<?xml version="1.0" encoding="UTF-8" ?>
<!--
  This file is part of the DITA-OT Bootstrap Lunr Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<xsl:output omit-xml-declaration="yes" indent="no" method="text" />

	<xsl:template match="/">
		<xsl:text>{</xsl:text>
		<xsl:apply-templates select="//topic" />
		<xsl:text>}</xsl:text>
	</xsl:template>

	<xsl:template match="topic">
		<xsl:text>"</xsl:text><xsl:value-of select="generate-id(.)" />
		<xsl:text>": {</xsl:text>

		<xsl:text>"l": "</xsl:text>
		<xsl:value-of select="@href" />
		<xsl:text>",</xsl:text>

		<xsl:text>"t": "</xsl:text>
		<xsl:value-of
      select="replace(replace(@title, '\\', '\\\\'), '&quot;', '\\&quot;')"
    />
		<xsl:text>",</xsl:text>

		<xsl:text>"d": "</xsl:text>
		<xsl:choose>
			<xsl:when test="abstract != ''">
				<xsl:value-of
          select="replace(replace(abstract, '\\', '\\\\'), '&quot;', '\\&quot;')"
        />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>&lt;div class=\"abstract\"&gt;&lt;p class=\"shortdesc\"&gt;</xsl:text>
				<xsl:variable name="SNIPPET">
					<xsl:value-of
            select="replace(replace(substring(text, 0, 275), '&lt;', '&amp;lt;'), '&gt;', '&amp;gt;')"
          />
				</xsl:variable>

				<xsl:value-of
          select="replace(replace(replace(substring($SNIPPET, 0, 275), '\\', '\\\\'), '&quot;', '\\&quot;'), ' \s+', ' ')"
        />
				<xsl:if test="string-length(text) &gt; 275">
					<xsl:text>...</xsl:text>
				</xsl:if>
				<xsl:text>&lt;/p&gt;&lt;/div&gt;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>"</xsl:text>

		<xsl:text>}</xsl:text>
		<xsl:if test="following-sibling::topic">
			<xsl:text>,</xsl:text>
		</xsl:if>
		
	</xsl:template>

</xsl:stylesheet>
