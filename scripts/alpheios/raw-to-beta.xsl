<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!--
    Copyright 2008-2009 Cantus Foundation
    http://alpheios.net
    
    This file is part of Alpheios.
    
    Alpheios is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    Alpheios is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
  -->
    
    <!--
    Stylesheet to convert <wd> elements in betacode to unicode
  -->
    
    <xsl:output media-type="text/xml" xml:space="preserve" indent="no"/>
    <xsl:include href="uni2betacode.xsl"/>
    
    <xsl:template match="/root">
        <root>
        <xsl:apply-templates />
        </root>
    </xsl:template>
    
    <!-- handle nodes -->
    <xsl:template match="greek">
        <greek>
            <xsl:call-template name="uni-to-beta">
                <xsl:with-param name="a_in" select="text()"/>
                <xsl:with-param name="a_upper" select="false()"/>
            </xsl:call-template>
        </greek>
    </xsl:template>
    <xsl:template match="*">
        <xsl:copy-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>
