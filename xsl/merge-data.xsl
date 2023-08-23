<?xml version="1.0" ?>
<!--
	This file is part of the DITA Bootstrap Lunr Search plug-in for DITA Open Toolkit.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet
  exclude-result-prefixes="xs"
  version="2.0"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<!-- Defining that this .xsl generates an indented, UTF8-encoded XML file -->
	<xsl:output
    encoding="utf-8"
    indent="yes"
    method="xml"
    omit-xml-declaration="no"
    standalone="yes"
  />
	<xsl:param name="in">.</xsl:param>
	<xsl:param name="extension">.xml</xsl:param>
	<xsl:param name="out">lunr.xml</xsl:param>
	<!--
		XSLT engine only accept file path that start with 'file:/'

		In the code below we ensure that $in parameter that hold input path to
		where the lunr/*.xml files  which have to be merge into single lunr file
		is in a format
	-->
	<xsl:variable name="path">
		<xsl:choose>
			<xsl:when test="not(starts-with($in,'file:')) and not(starts-with($in,'/')) ">
				<xsl:value-of
          select="translate(concat('file:/', $in ,'?select=*.', $extension ,';recurse=yes;on-error=warning'), '\', '/')"
        />
			</xsl:when>
			<xsl:when test="starts-with($in,'/')">
				<xsl:value-of
          select="translate(concat('file:', $in ,'?select=*.', $extension ,';recurse=yes;on-error=warning'), '\', '/')"
        />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
          select="translate(concat($in ,'?select=*.', $extension ,';recurse=yes;on-error=warning'), '\', '/')"
        />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- Copies defined xmlns above for this xsl into a variable -->
	<xsl:variable name="namespaces" select="document('')/*/namespace::*" />
	<!-- Template to once execute generate-svrl template -->
	<xsl:template match="/">
		<xsl:call-template name="generate-data" />
	</xsl:template>
	<!--
		Template that generates the single lunr file by copying contents
		of all lunr files found in directory specified by $path
	-->
	<xsl:template name="generate-data">
		<xsl:element name="topics">
			<xsl:for-each select="collection($path)">
				<!-- xsl:copy-of copies nodes and all their descendants -->
        <xsl:apply-templates
          select="document(document-uri(.))/topics/node()"
          mode="data-output"
        />
				<!--xsl:apply-templates
          select="./topics/node()"
          mode="data-output"
        /-->
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

	<xsl:template match="node()|@*" mode="data-output">
		 <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="data-output" />
        </xsl:copy>
	</xsl:template>
</xsl:stylesheet>
