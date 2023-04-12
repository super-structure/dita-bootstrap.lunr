<?xml version="1.0" encoding="utf-8" ?>
<!--
	This file is part of the DITA-OT Favicon Plug-in project.
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

  <xsl:param name="LUNR_CLIENT" select="'lunr-client.js'" />
  <xsl:param name="JS_PATH" select="'js/'" />

	<xsl:template match="/ | @* | node()" mode="processHDF">


    <xsl:variable name="relpath">
      <xsl:choose>
        <xsl:when test="$FILEDIR='.'">
          <xsl:text>.</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select=" replace($FILEDIR,'[^/]+','..')" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <script src="{$relpath}/{$JS_PATH}{$LUNR_CLIENT}" />
    <script src="https://unpkg.com/lunr/lunr.js" />


    <xsl:next-match />  
  </xsl:template>
</xsl:stylesheet>
