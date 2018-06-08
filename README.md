# jackson-bom

A "bill of materials" POM for Jackson dependencies, used to enforce a consistent set of versions
across all official (maintained by FasterXML) Jackson components.

NOTE: Does NOT add or include actual dependencies to all components, but rather sets VERSIONS
to use via Maven `<dependencyManagement>` mechanism.

## Usage

There are two ways to use the pom: either as parent pom:

```xml
  <parent>
    <groupId>com.fasterxml.jackson</groupId>
    <artifactId>jackson-bom</artifactId>
    <version>[VERSION]</version>
  </parent>
```
(where `[VERSION]` is version to use like `2.9.6`)


or by importing just the dependencies:

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>com.fasterxml.jackson</groupId>
            <artifactId>jackson-bom</artifactId>
            <version>[VERSION]</version>
            <scope>import</scope>
            <type>pom</type>
        </dependency>   
    </dependencies>
</dependencyManagement>
```

Two approaches are same with respect to dependency inclusion; latter ONLY includes dependencies,
former includes many other settings.
