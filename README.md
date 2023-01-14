# Jackson BOM

This project contains "bill of materials" POM for Jackson dependencies.
For more on concept of BOMs, see:

* [The Bill of Materials in Maven](https://dzone.com/articles/the-bill-of-materials-in-maven)
* [Using Maven’s Bill of Materials (BOM)](https://reflectoring.io/maven-bom/)

But the basic idea is that instead of specifying version explicitly for every Jackson
component, as part of dependency definition, one can use a BOM to get a full, complete
set of consistent versions to use.

## Status

[![Build Status](https://travis-ci.org/FasterXML/jackson-bom.svg)](https://travis-ci.org/FasterXML/jackson-bom)
[![Tidelift](https://tidelift.com/badges/package/maven/com.fasterxml.jackson:jackson-bom)](https://tidelift.com/subscription/pkg/maven-com-fasterxml-jackson-jackson-bom?utm_source=maven-com-fasterxml-jackson-jackson-bom&utm_medium=referral&utm_campaign=readme)

## Usage

There are two ways to use the BOM pom: either as parent pom:

```xml
  <parent>
    <groupId>com.fasterxml.jackson</groupId>
    <artifactId>jackson-bom</artifactId>
    <version>2.14.1</version>
  </parent>
```

or by importing the BOM to get versions via so-called "managed dependencies"
(NOTE: BOM can NOT be used as an explicit dependency; it MUST be either parent pom
or imported in `<dependencyManagement>` section)

```xml
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>com.fasterxml.jackson</groupId>
      <artifactId>jackson-bom</artifactId>
      <version>2.14.1</version>
      <scope>import</scope>
      <type>pom</type>
    </dependency>   
  </dependencies>
</dependencyManagement>
```

Two approaches are same with respect to dependency inclusion; latter ONLY includes dependencies,
former includes many other settings.
Usually latter is preferable, unless component is very closely coupled with core Jackson components.

## Jackson Versioning

### Semantic Versioning

Jackson tries to follow [Semantic Versioning](https://en.wikipedia.org/wiki/Software_versioning#Semantic_versioning) (aka "SemVer")
for its Public API; public methods of types like `ObjectMapper` and `JsonFactory` that calling applications need.
This means that code written against Jackson 2.0.0 that only uses Public API should still work with no changes with Jackson 2.14.0.

Semantic versioning is, however, NOT guaranteed for types considered internal, and in particular customizations by sub-classing is not covered by same guarantees.
In case of Internal API (extension points meant for Jackson core components) Jackson will still try to guarantee compatibility with "adjacent" minor versions: that is, code written against Jackson 2.9.0 should still work against Jackson 2.10.x (and in many cases further, but at least with the "next version").
Deprecation markers are added for internal methods and types where necessary so that if no deprecation warnings are encountered, code should work for next two minor versions.

It is understood that the distinction between "Public" and "Internal" APIs is not always easy to distinguish; Javadocs are used in places to try to make distinction clear.

Having said all that, for most users and most usage Semantic Versioning is maintained.

### "Normal" minor version releases

Most of the time all Jackson components are released using 3-digit version, like `2.14.0`.
If so, there will be, for this version:

1. A full set of all core Jackson components under `FasterXML` Github organization
2. Matching `jackson-bom`

But occasionally there is a need for a "hot fix" -- usually a fix to a security issue (aka "CVE") --
either in-between "full minor releases" or after specific branch has been closed for active
development. In such cases a version of only component affected (most often `jackson-databind`)
is released and there is no full set of components.
Version number will, in such cases, consist of 4 digits like [jackson-databind-2.12.6.1](https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind/2.12.6.1).
Note: the reason for NOT releasing a full set in such cases is both due to effort needed (full set takes multiple hours to release in the optimal case) and to avoid having multiple full sets with very few changes.

Because there is no full set of `2.12.6.1` components -- and there may be 1 or more components with `2.12.6.1` (or we may have `2.12.6.2` and so on), it is not practical to release BOM with that version (both since there may be various numbers of micro-patches over time, and since assumption by users could be there IS a full set), a different version convention is used for these case: use of datestamp version.

As the specific example, `jackson-databind` `2.12.6.1` was released on March 26, 2022, and so the matching bom is [jackson-bom-2.12.6.20220326](https://mvnrepository.com/artifact/com.fasterxml.jackson/jackson-bom/2.12.6.20220326). Some users dislike this longer notation, but it has some specific benefits:

* Version numbers will sort appropriately: `2.12.6.20220326` comes after both `2.12.6` and hypothetical `2.12.6.1`
* Version number gives an idea of release date, wrt time of hot fix(es) included

## Secondary: "base" sub-project

Note that this repo ALSO contains `jackson-base` (see under dir `base/`), which is the intended
parent pom for Jackson core components.
It extends `jackson-bom`, augmenting with settings that
are only/mostly relevant for Jackson components, but not to things that depend on Jackson in general.
Use of `jackson-base` is not recommended for libraries that are not meant to be coupled with Jackson
release cycle and settings.

## Support

### Community support

Jackson components are supported by the Jackson community through mailing lists, Gitter forum,
Github issues. See [Participation, Contributing](../../../jackson#participation-contributing)
for full details.

### Enterprise support

Available as part of the [Tidelift](https://tidelift.com/subscription/pkg/maven-com-fasterxml-jackson-core-jackson-databind) Subscription.

The maintainers of `jackson-bom` and thousands of other packages are working with Tidelift to deliver
commercial support and maintenance for the open source dependencies you use to build your applications.
Save time, reduce risk, and improve code health, while paying the maintainers of the exact dependencies
you use.
[Learn more.](https://tidelift.com/subscription/pkg/maven-com-fasterxml-jackson-jackson-bom?utm_source=maven-com-fasterxml-jackson-jackson-bom&utm_medium=referral&utm_campaign=enterprise&utm_term=repo)
