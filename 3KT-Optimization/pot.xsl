
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- Ключи для поиска преподавателей и тем -->
    <xsl:key name="courses-by-teacher" match="teacher" use="."/>
    <xsl:key name="courses-by-keyword" match="keyword" use="."/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Наши курсы</title>
            </head>
            <body>

                <h1>Наши курсы</h1>

                <h3>Курсы, которые читает Борисов И.О.</h3>
                <ul>
                    <xsl:for-each select="key('courses-by-teacher', 'Борисов И.О.')">
                        <li>
                            <xsl:value-of select="../../title"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <h3>Курсы, которые используют XML</h3>
                <ul>
                    <xsl:for-each select="key('courses-by-keyword', 'XML')">
                        <li>
                            <xsl:value-of select="../../title"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <h3>Курсы Борисова И.О. с темой XSLT</h3>
                <ul>
                    <xsl:for-each select="key('courses-by-teacher', 'Борисов И.О.')[../../keywords/keyword = 'XSLT']">
                        <li>
                            <xsl:value-of select="../../title"/>
                        </li>
                    </xsl:for-each>
                </ul>

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
