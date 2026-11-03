import groovy.xml.XmlSlurper
import groovy.xml.slurpersupport.GPathResult
import groovy.xml.slurpersupport.NodeChild
import java.io.ByteArrayOutputStream

plugins {
    `java-platform`
    `version-catalog`
    `maven-publish`
    //    id("org.gradlex.java-ecosystem-capabilities-base") // only rules
    //    id("org.gradlex.logging-capabilities") // logging extension
}

group = "com.fasterxml.jackson"
version = File("../pom.xml")
    .readText()
    .substringAfter("<groupId>com.fasterxml.jackson<")
    .substringAfter("<version>")
    .substringBefore('<')

javaPlatform {
    allowDependencies()
}

val computeCatalogAndPlatform by tasks.registering(Exec::class) {

    workingDir = projectDir.parentFile
    commandLine("sh", "-c", "./mvnw -B -f pom.xml help:effective-pom")
    standardOutput = ByteArrayOutputStream()

    doLast {
        val output = standardOutput
            .toString()
            // clean output from dirty
            .substringAfter("Effective POMs, after inheritance, interpolation, and profiles are applied:")
            .substringBefore("[INFO]")
            .trim()

        operator fun GPathResult.div(child: String) = children().find { (it!! as NodeChild).name() == child } as GPathResult

        val bom = XmlSlurper().parseText(output).children().first() as GPathResult
        val deps = bom / "dependencyManagement" / "dependencies"
        val map = mutableMapOf<String, String>()
        for (dep in deps.children()) {
            val node = dep as NodeChild
            val g = node / "groupId"
            val a = node / "artifactId"
            val v = node / "version"
            val gav = "$g:$a:$v"

            map["$a"] = gav
            //            println("$a, $gav")

            catalog.versionCatalog { library("$a", gav) }
            dependencies.constraints { api(gav) }
        }

        val bundles = listOf("dataformat", "datatype", "jaxrs", "jakarta-rs", "jr", "module")
        for (bundle in bundles)
            catalog.versionCatalog {
                val bundleAlias = "jackson-$bundle"
                val aliases = map.keys.filter { it.startsWith(bundleAlias) }
                bundle(bundleAlias, aliases)
            }
    }
}

publishing {
    publications {
        create<MavenPublication>("jackson") {
            from(components["javaPlatform"])
        }
    }
}

tasks {
    // dependsOn runs only if the src is successful, finalizedBy not
    generateCatalogAsToml { dependsOn(computeCatalogAndPlatform) }
    val generateMetadataFileForJacksonPublication by getting { dependsOn(computeCatalogAndPlatform) }
    register("generateCatalogAndPlatform") { dependsOn(generateMetadataFileForJacksonPublication, generateCatalogAsToml) }
}