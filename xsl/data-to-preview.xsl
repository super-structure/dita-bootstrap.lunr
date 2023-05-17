<?xml version="1.0" encoding="UTF-8" ?>
<!--
  This file is part of the DITA Bootstrap Lunr Search plug-in for DITA Open Toolkit.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  version="2.0"
>

	<xsl:output omit-xml-declaration="yes" indent="no" method="text" />

  <xsl:function name="dita-ot:escapeQuote" as="xs:string">
    <xsl:param name="input" />
    <xsl:sequence
      select="replace(replace($input, '\\', '\\\\'), '&quot;', '\\&quot;')"
    />
  </xsl:function>

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
		<xsl:value-of select="dita-ot:escapeQuote(@title)" />
		<xsl:text>",</xsl:text>

		<xsl:text>"d": "</xsl:text>
		<xsl:choose>
			<xsl:when test="abstract != ''">
				<xsl:value-of select="replace(dita-ot:escapeQuote(abstract), ' \s+', ' ')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>&lt;div class=\"abstract\"&gt;&lt;p class=\"shortdesc\"&gt;</xsl:text>
				<xsl:variable name="SNIPPET">
					<xsl:value-of
            select="replace(replace(substring(text, 0, 275), '&lt;', '&amp;lt;'), '&gt;', '&amp;gt;')"
          />
				</xsl:variable>

				<xsl:value-of
          select="replace(dita-ot:escapeQuote(substring($SNIPPET, 0, 275)), ' \s+', ' ')"
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
