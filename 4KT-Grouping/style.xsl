<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- Ключ для группировки городов -->
    <xsl:key name="cityKey" match="item" use="@city"/>

    <!-- Ключ для группировки компаний внутри городов -->
    <xsl:key name="orgKey"
        match="item"
        use="concat(@city, '|', @org)"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Города и компании</title>
            </head>
            <body>

                <h1>Города и компании</h1>

                <ul>
                    <!-- Группировка городов -->
                    <xsl:for-each select="orgs/item[
                        generate-id() =
                        generate-id(key('cityKey', @city)[1])
                    ]">

                        <li>
                            <b>
                                <xsl:value-of select="@city"/>
                            </b>

                            <p>
                                Всего товаров:
                                <xsl:value-of select="count(key('cityKey', @city))"/>
                            </p>

                            <ul>
                                <!-- Группировка компаний внутри города -->
                                <xsl:for-each select="key('cityKey', @city)[
                                    generate-id() =
                                    generate-id(key('orgKey', concat(@city, '|', @org))[1])
                                ]">

                                    <li>
                                        <b>
                                            <xsl:value-of select="@org"/>
                                        </b>

                                        <p>
                                            Всего товаров:
                                            <xsl:value-of select="count(key('orgKey', concat(@city, '|', @org)))"/>
                                        </p>

                                        <ul>
                                            <!-- Вывод товаров компании -->
                                            <xsl:for-each select="key('orgKey', concat(@city, '|', @org))">
                                                <li>
                                                    <xsl:value-of select="@title"/>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </li>

                                </xsl:for-each>
                            </ul>
                        </li>

                    </xsl:for-each>
                </ul>

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>