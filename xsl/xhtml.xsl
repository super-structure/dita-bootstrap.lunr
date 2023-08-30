<?xml version="1.0" encoding="utf-8"?>
<!--
	This file is part of the DITA Bootstrap Lunr Search plug-in for DITA Open Toolkit.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet
  version="2.0"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="xs dita-ot"
>

  <xsl:param name="defaultLanguage" select="'en'" as="xs:string"/>
  <xsl:param name="OFFLINE_MODE" select="'no'"/>
  <xsl:param name="LUNR_LANG_SUPPORT" select="'no'"/>
  <xsl:variable name="LANGUAGE_CODE" select="substring($defaultLanguage, 1, 2)"/>

	<xsl:template match="/ | @* | node()" mode="processHDF">


    <xsl:variable name="relpath">
      <xsl:choose>
        <xsl:when test="$FILEDIR='.'">
          <xsl:text>.</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select=" replace($FILEDIR,'[^/]+','..')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <script src="{$relpath}/js/lunr-client.js"/>
    <xsl:choose>
      <xsl:when test="$OFFLINE_MODE='yes'">
        <script src="{$relpath}/js/lunr.js"/>
      </xsl:when>
      <xsl:otherwise>
        <script src="https://unpkg.com/lunr/lunr.js"/>
      </xsl:otherwise>
    </xsl:choose>


    <xsl:message>
      <xsl:value-of select="$LUNR_LANG_SUPPORT"/>
    </xsl:message>
    <xsl:if test="$LUNR_LANG_SUPPORT='yes'">
        <script src="{$relpath}/js/lunr.stemmer.support.js"/>
        <script src="{$relpath}/js/lunr.{$LANGUAGE_CODE}.js"/>
    </xsl:if>

    <xsl:next-match/>  
  </xsl:template>
</xsl:stylesheet>
