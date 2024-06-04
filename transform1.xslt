<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    
    <!-- zmienne proste i zlozone-->
    <xsl:variable name="bgColor" select="'#9acd32'"/>
    <xsl:variable name="listStyle" select="'background-color:#9acd32; color:#ffffff; border:1px solid #000000; border-radius:10px;'"/>
    
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
                <link rel="stylesheet" type="text/css" href="stylesheet.css"/>

            </head>
			<body style="background-color: {$bgColor}">
                <nav>
                    <h3>Lista naszych piw</h3>
                    <xsl:element name="ul" >
                        <xsl:attribute name="style">
                            <xsl:value-of select="$listStyle"/>
                        </xsl:attribute>
                        <xsl:apply-templates select="document/beerList/beer[from/craft='yes']" mode="nav">
                            <xsl:sort select="name" order="{$sortOrder}"/>
                        </xsl:apply-templates>
                    </xsl:element>
                </nav>
                
                <main>
                    <h1>PROJEKT 2 - Jakub Sobota</h1>
                    <h2>Nasze piwa</h2>
                    <xsl:apply-templates select="document/beerList/beer[from/craft='yes']" mode="main"/>

                </main>

                <footer>
                    <table>
                        <tr><h2>Zaufane opinie:</h2></tr>
                        <tr>
                            <th>Name</th>
                            <th>Rating</th>
                            <th>Comment</th>
                        </tr>
                        <xsl:for-each select="document/reviewList/review[@Cicerone='yes']">
                          <xsl:sort select="rating"/>
                          <tr>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="rating"/></td>
                            <td><xsl:value-of select="comment"/></td>
                          </tr>
                        </xsl:for-each>
                    </table>
                    
                    
                </footer>
                
			</body>
        </html>
    </xsl:template>

    <!-- beer nav template -->
    <xsl:template match="beer" mode="nav">
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

    <!-- beer main template -->
    <xsl:template match="beer" mode="main">
        <div>
            <h3>
                <xsl:call-template name="id">
                    <xsl:with-param name="beerId" select="@id"/>
                </xsl:call-template>
                Nazywam się 
                <xsl:value-of select="name"/>
            </h3>
            
            <article>
                <p>
                    Mój styl to <xsl:value-of select="style"/><br></br>
                    <xsl:call-template name="temperature"/><br></br>
                    <xsl:call-template name="moc"/><br></br>

                </p>
                <xsl:call-template name="img">
                    
                </xsl:call-template>
            </article>
        </div>
        <br></br>
    </xsl:template>
    <!-- sprawdzenie temperatury -->
    <xsl:template name="temperature">
        <xsl:choose>
            <xsl:when test="servingTemp &lt; 8">
                Jestem najlepsze na zimno: <xsl:value-of select="concat(format-number(servingTemp, '0'), '°')" />C
            </xsl:when>
            <xsl:otherwise>
                Jestem dobre schłodzone do: <xsl:value-of select="concat(format-number(servingTemp, '0'), '°')"/>C
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- sprawdzenie mocy -->
    <xsl:template name="moc">
        <xsl:choose>
            <xsl:when test="abv &lt;= 1">
                Możesz po mnie jechać autem! Mam <xsl:value-of select="format-number(abv * .01,'0.00%')"/>!
            </xsl:when>
            <xsl:when test="abv &lt;= 6">
                Ze mną jest dobra zabawa, ale wołaj Ubera! Mam <xsl:value-of select="format-number(abv * .01,'0.00%')"/>!
            </xsl:when>
            <xsl:otherwise>
                Nie myśl co będzie rano, a na pewno nie wychodź z domu! Mam <xsl:value-of select="format-number(abv * .01,'0.00%')"/>!
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- formatting id number -->
    <xsl:template name="id">
        <xsl:param name="beerId"/>
        <xsl:if test="starts-with($beerId, 'b')">
            <xsl:value-of select="number(substring($beerId, 2))"/>
        </xsl:if>
    </xsl:template>
    <!-- picture template -->
    <xsl:template name="img">
        <img>
            <xsl:attribute name="src">
                <xsl:value-of select="./photo/url"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
                Zdjęcie piwa <xsl:value-of select="./photo/author"/>
            </xsl:attribute>
        </img>
    </xsl:template>
</xsl:stylesheet>