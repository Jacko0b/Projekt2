<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <transformedDocument>
      <reviews>
        <xsl:apply-templates select="document/reviewList/review"/>
      </reviews>
      <beers>
        <xsl:apply-templates select="document/beerList/beer"/>
      </beers>
    </transformedDocument>
  </xsl:template>

  <xsl:template match="review">
    <reviewDetail reviewDate="{@date}">
      <reviewer>
        <name>
          <xsl:value-of select="name"/>
        </name>
        <contact email="{email}">
          <phoneNumber>
            <xsl:value-of select="phone"/>
          </phoneNumber>
        </contact>
      </reviewer>
      <rating>
        <xsl:value-of select="rating"/>
      </rating>
      <feedback>
        <xsl:value-of select="comment"/>
      </feedback>
    </reviewDetail>
  </xsl:template>

  <xsl:template match="beer">
    <beerDetail beerId="{@id}" beerStatus="{@Availability}">
      <beerName>
        <xsl:value-of select="name"/>
      </beerName>
      <breweryInfo>
        <xsl:variable name="breweryName" select="translate(from/brewery/name, ' ', '_')"/>
        <xsl:element name="{$breweryName}">
          <xsl:copy-of select="./from/brewery/@id"/>
        </xsl:element>
        <breweryLocation>
          <xsl:value-of select="from/brewery/location"/>
        </breweryLocation>
        <yearEstablished>
          <xsl:value-of select="from/brewery/yearEstablished"/>
        </yearEstablished>
      </breweryInfo>
        
      <flavour>
        <bitterness>
          <xsl:value-of select="flavourProfile/bitterness"/>
        </bitterness>
        <sweetness>
          <xsl:value-of select="flavourProfile/sweetness"/>
        </sweetness>
        <strength>
          <xsl:value-of select="flavourProfile/strength"/>
        </strength>
      </flavour>
      <xsl:if test="seasonal">
        <seasonalInfo>
          <seasonDetails>
            <xsl:attribute name="{seasonal/holidayname}">
              <xsl:value-of select="'true'"/>
            </xsl:attribute>
            <seasonStart>
              <xsl:value-of select="seasonal/from"/>
            </seasonStart>
            <seasonEnd>
              <xsl:value-of select="seasonal/to"/>
            </seasonEnd>
          </seasonDetails>
        </seasonalInfo>
      </xsl:if>
    </beerDetail>
  </xsl:template>

</xsl:stylesheet>