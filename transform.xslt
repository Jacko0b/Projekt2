<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    
    <!-- zmienne proste i zlozone-->
    <xsl:variable name="bgColor" select="'#9acd32'"/>
    <xsl:variable name="listStyle" select="'background-color:#9acd32; color:#ffffff; border:1px solid #000000; border-radius:10px;'"/>
    
    <xsl:variable name="ulStyle">
        <color>#9acd21</color>
        <fontColor>#ffffff</fontColor>
        <border>1px solid #000000</border>
        <borderRadius>10px</borderRadius>
    </xsl:variable>

    <!-- glowny szablon -->
    <xsl:output method="html" indent="yes"/>    
    <xsl:template match="/">
        <html>
            <head>
				<meta charset="UTF-8" />
				<title>Projekt2</title>
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />

            </head>
			<body bgcolor="{$bgColor}">
                <h1>PROJEKT 2</h1>
                <h3>Lista naszych piw</h3>
                <xsl:element name="ul" >
                    <xsl:apply-templates select="document/beerList/beer"/>
                </xsl:element>

			</body>
        </html>
    </xsl:template>

    <!-- beer template -->
    <xsl:template match="beer">
        <li>
            <a href="{link}" style="color:blue">
                <xsl:value-of select="name"/>
            </a> 
        </li>
    </xsl:template>

    <!--seasonal beer template -->
    <xsl:template match="beer[@seasonal='true']">
        <li>
            <a href="{link}" style="color:red">
                <xsl:value-of select="concat(name, ' - sezonowe do ', substring(seasonal/to, 6, 2), '/', substring(seasonal/to, 3, 2))"/>
            </a> 
        </li>
    </xsl:template>
</xsl:stylesheet>