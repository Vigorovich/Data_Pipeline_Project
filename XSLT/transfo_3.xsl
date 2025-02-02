<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ds="http://www.dsti-food.com/">

<!-- List of course types we want to evaluate -->
<xsl:variable name="course1" select="'Soup'"/>
<xsl:variable name="course2" select="'Salad'"/>
<xsl:variable name="course3" select="'Sandwich'"/>
<xsl:variable name="course4" select="'Main Dish'"/>
<xsl:variable name="course5" select="'Baking'"/>

<xsl:template match="/">
	<!-- Use Recipe course variables -->
	<xsl:variable name="RecipeCourse1" select="ds:Food/ds:recipe[ds:course/@ctref = //ds:courseType/ds:course[ds:name = $course1]/@id]" />
	<xsl:variable name="RecipeCourse2" select="ds:Food/ds:recipe[ds:course/@ctref = //ds:courseType/ds:course[ds:name = $course2]/@id]" />
	<xsl:variable name="RecipeCourse3" select="ds:Food/ds:recipe[ds:course/@ctref = //ds:courseType/ds:course[ds:name = $course3]/@id]" />
	<xsl:variable name="RecipeCourse4" select="ds:Food/ds:recipe[ds:course/@ctref = //ds:courseType/ds:course[ds:name = $course4]/@id]" />
	<xsl:variable name="RecipeCourse5" select="ds:Food/ds:recipe[ds:course/@ctref = //ds:courseType/ds:course[ds:name = $course5]/@id]" />
	<html>
		<h1>What is the average rating of each meal type?</h1>
		<body>
			<!-- Call template for calculation of average rating for course 1 -->
			<h2>The average note of the <xsl:value-of select="$course1"/> dishes is: </h2>
			<p>
				<xsl:variable name="averageNote1">
					<xsl:call-template name="accumulateSums">
						<xsl:with-param name="recipes" select="$RecipeCourse1" />
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="$averageNote1"/>
			</p>
			<!-- Call template for calculation of average rating for course 2 -->
			<h2>The average note of the <xsl:value-of select="$course2"/> dishes is: </h2>
			<p>
				<xsl:variable name="averageNote2">
					<xsl:call-template name="accumulateSums">
						<xsl:with-param name="recipes" select="$RecipeCourse2" />
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="$averageNote2"/>
			</p>
			<!-- Call template for calculation of average rating for course 3 -->
			<h2>The average note of the <xsl:value-of select="$course3"/> dishes is: </h2>
			<p>
				<xsl:variable name="averageNote3">
					<xsl:call-template name="accumulateSums">
						<xsl:with-param name="recipes" select="$RecipeCourse3" />
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="$averageNote3"/>
			</p>
			<!-- Call template for calculation of average rating for course 4 -->
			<h2>The average note of the <xsl:value-of select="$course4"/> dishes is: </h2>
			<p>
				<xsl:variable name="averageNote4">
					<xsl:call-template name="accumulateSums">
						<xsl:with-param name="recipes" select="$RecipeCourse4" />
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="$averageNote4"/>
			</p>
			<!-- Call template for calculation of average rating for course 5 -->
			<h2>The average note of the <xsl:value-of select="$course5"/> dishes is: </h2>
			<p>
				<xsl:variable name="averageNote5">
					<xsl:call-template name="accumulateSums">
						<xsl:with-param name="recipes" select="$RecipeCourse5" />
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="$averageNote5"/>
			</p>
		</body> 
	</html>
</xsl:template>

<!-- Template to recursively calculate and accumulate the sums for each recipe -->
<xsl:template name="accumulateSums">
    <xsl:param name="recipes" />
    <xsl:param name="index" select="1"/>
    <xsl:param name="sum" select="0"/>    
	
 	<xsl:variable name="totalReviews" select="sum($recipes/ds:reviews/ds:numReviews)"/>
 
    <xsl:choose>
		<!-- Recursive case: accumulate the sum for each recipe -->
        <xsl:when test="$index &lt;= count($recipes)"> 
			<xsl:variable name="currentRecipe" select="$recipes[$index]"/>
            <xsl:variable name="currentSum" select="number($currentRecipe/ds:reviews/ds:numReviews) * number($currentRecipe/ds:reviews/ds:averageRating)"/>
			<!-- Recursively call the template with updated index and accumulated sum -->
            <xsl:call-template name="accumulateSums">
					<xsl:with-param name="recipes" select="$recipes" />
                <xsl:with-param name="index" select="$index + 1"/>
                <xsl:with-param name="sum" select="$sum + $currentSum"/>
            </xsl:call-template>
        </xsl:when>
		<!-- Stop recursion when all recipes have been processed -->
        <xsl:otherwise>
				<xsl:value-of select="$sum div $totalReviews"/>
        </xsl:otherwise>
    </xsl:choose>

</xsl:template>

</xsl:stylesheet>
