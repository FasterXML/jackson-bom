Project: jackson-bom / jackson-base

Contains "Bill-of-Materials" for all Jackson components for main component
("jackson-bom"), as well as parent pom ("jackson-base") for Jackson components
themselves. Only former should be extended by anything other than official
Jackson components (core, modules)

------------------------------------------------------------------------
=== Releases (note: only includes patches with actual changes)
------------------------------------------------------------------------

2.13.0 (not yet released)

#39: Configure moditect plugin with `<jvmVersion>11</jvmVersion>`

2.12.0 (29-Nov-2020)

- Add another execution of `maven-replacer-plugin` for "prepare-package" phase
  to help with IDE import.
- Add default settings for `gradle-module-metadata-maven-plugin` (gradle metadata)
- Add default settings for `build-helper-maven-plugin` (LICENSE inclusion)
- Drop `jackson-module-scala_2.10` entry (not released for Jackson 2.12 or later)

2.11.2

- Add missing version for `jackson-datatype-eclipse-collections`
- Add override for `version.plugin.bundle` (for 5.1.1) to help build on JDK 15+

2.11 (26-Apr-2020)

No changes since 2.10

2.10

- Remove `Automatic-Module-Name`, to avoid collision with Moditect-added `module-info`
