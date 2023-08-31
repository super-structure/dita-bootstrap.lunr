<?xml version="1.0" encoding="utf-8" ?>
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
  exclude-result-prefixes="xs xhtml dita-ot"
>
  <xsl:import href="plugin:org.dita.xhtml:xsl/xslhtml/dita2htmlImpl.xsl" />

  <xsl:param name="FILENAME" />
  <xsl:param name="FILEDIR" />
  <xsl:param name="OUTEXT" select="'.html'" />

  <xsl:param name="PATH2PROJ">
  <xsl:apply-templates
      select="/processing-instruction('path2project-uri')[1]"
      mode="get-path2project"
    />
  </xsl:param>

  <xsl:variable name="RELATIVE_PATH">
    <!--xsl:value-of select="$PATH2PROJ" -->
    <xsl:value-of select="concat($FILEDIR, '/')" />
    <xsl:call-template name="replace-extension">
      <xsl:with-param name="filename" select="$FILENAME" />
      <xsl:with-param name="extension" select="$OUTEXT" />
    </xsl:call-template>
  </xsl:variable>

  <xsl:template match="/">
    <topics>
      <xsl:apply-templates />
    </topics>
  </xsl:template>

  <xsl:template match="/dita | *[contains(@class, ' topic/topic ')]">

    <xsl:variable name="TITLE">
      <xsl:value-of
        select="replace(*[contains(@class, ' topic/title ')],'&#xA;', ' ')"
      />
    </xsl:variable>
    <xsl:variable name="KEYWORDS">
      <xsl:for-each
        select="descendant::*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/keywords ')]/descendant-or-self::*"
      >
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(text()[1])" />
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="ABSTRACT">
      <xsl:apply-templates
        select="*[contains(@class, ' topic/abstract ')]"
        mode="outofline"
      />
      <!-- get the shortdesc para -->
      <xsl:apply-templates
        select="*[contains(@class, ' topic/shortdesc ')]"
        mode="outofline"
      />
    </xsl:variable>
    <xsl:variable name="TEXT">
         <xsl:value-of
        select="replace(*[contains(@class, ' topic/abstract ')],'&#xA;', ' ')"
      />
         <xsl:text> </xsl:text>
         <xsl:value-of
        select="replace(*[contains(@class, ' topic/shortdesc ')],'&#xA;', ' ')"
      />
         <xsl:text> </xsl:text>
         <xsl:value-of
        select="replace(*[contains(@class, ' topic/body ')],'&#xA;', ' ')"
      />
    </xsl:variable>

    <xsl:variable name="nodestring">
      <xsl:apply-templates select="$ABSTRACT" mode="serialize" />
    </xsl:variable>

    <xsl:element name="topic">
      <xsl:attribute
        name="href"
        select="concat($RELATIVE_PATH, concat('#', dita-ot:generate-html-id(.)))"
      />
      <xsl:attribute name="title" select="$TITLE" />
      <xsl:attribute name="keywords" select="$KEYWORDS" />
      <xsl:element name="abstract">
        <xsl:value-of select="replace($nodestring,'&#xA;', ' ')" />
      </xsl:element>
      <xsl:element name="text">
        <xsl:value-of select="normalize-space($TEXT)"/>
      </xsl:element>
    </xsl:element>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template name="openTag">
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="name()" />
    <xsl:if test="@class">
      <xsl:text disable-output-escaping="yes"> class=&quot;</xsl:text>
      <xsl:value-of select="@class" />
      <xsl:text disable-output-escaping="yes">&quot;</xsl:text>
    </xsl:if>
    <xsl:text>&gt; </xsl:text>
  </xsl:template>

  <xsl:template name="closeTag">
    <xsl:text> &lt;/</xsl:text>
    <xsl:value-of select="name()" />
    <xsl:text>&gt;</xsl:text>
  </xsl:template>

  <xsl:template match="*" mode="serialize">
    <xsl:call-template name="openTag" />
    <xsl:apply-templates mode="serialize" />
    <xsl:call-template name="closeTag" />
  </xsl:template>

  <xsl:template match="*[contains(@class, ' xmlelement')]" mode="serialize">
    <xsl:call-template name="openTag" />
    <xsl:text>&amp;lt;</xsl:text>
    <xsl:apply-templates mode="serialize" />
    <xsl:text>&amp;gt;</xsl:text>
    <xsl:call-template name="closeTag" />
  </xsl:template>

  <xsl:template match="text()" mode="serialize">
    <xsl:value-of
      select="replace(replace(., '^\s*(.+?)\s*$', '$1'), '^ .*$', '')"
    />
  </xsl:template>
</xsl:stylesheet>
