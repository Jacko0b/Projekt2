<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    
    <!-- zmienne proste i zlozone-->
    <xsl:variable name="bgColor" select="'#9acd32'"/>
    <xsl:variable name="listStyle" select="'background-color:#9acd32; color:#ffffff; border:1px solid #000000; border-radius:10px;'"/>
    <xsl:variable name="counter" select="1"/>

    <xsl:variable name="ulStyle">
        <color>#9acd21</color>
        <fontColor>#ffffff</fontColor>
        <border>1px solid #000000</border>
        <borderRadius>10px</borderRadius>
    </xsl:variable>

    <!-- Definicja parametrów -->
    <xsl:param name="sortOrder" select="'ascending'"/>
    
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
                <nav>
                    <h3>Lista naszych piw</h3>
                    <xsl:element name="ul" >
                        <xsl:attribute name="style">
                            <xsl:value-of select="$listStyle"/>
                        </xsl:attribute>
                        <xsl:apply-templates select="document/beerList/beer">
                            <xsl:sort select="name" order="{$sortOrder}"/>
                        </xsl:apply-templates>
                    </xsl:element>
                </nav>
                
                <main>
                    <h1>PROJEKT 2</h1>
                    <h2>Nasze piwa</h2>
                    <xsl:apply-templates select="document/beerList/beer"/>
                </main>

                <footer>
                
                </footer>
                
			</body>
        </html>
    </xsl:template>

    <!-- beer nav template -->
    <xsl:template match="beer">
        <li>
            <xsl:number value="position()"/>
            <xsl:choose>
                <xsl:when test="@seasonal='true'">
                    <a href="{link}" style="color:red">
                        <xsl:value-of select="concat(name, ' - sezonowe do ', substring(seasonal/to, 6, 2), '/', substring(seasonal/to, 3, 2))"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <a href="{link}" style="color:blue">
                        <xsl:value-of select="name"/>
                    </a> 
                </xsl:otherwise>
            </xsl:choose>
        </li>
    </xsl:template>

    <!-- choosing by id number -->
    <xsl:template match="@id">
        <xsl:attribute name="id">
            <xsl:choose>
                <xsl:when test="starts-with(., 'b')">
                <xsl:value-of select="number(substring(., 2))"/>
                </xsl:when>

            </xsl:choose>
        </xsl:attribute>
        <div></div>
  </xsl:template>
</xsl:stylesheet>