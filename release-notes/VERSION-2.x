2.12.0 (29-Nov-2020)

- Add another execution of `maven-replacer-plugin` for "prepare-package" phase
  to help with IDE import.
- Add default settings for `gradle-module-metadata-maven-plugin` (gradle metadata)
- Add default settings for `build-helper-maven-plugin` (LICENSE inclusion)
- Drop `jackson-module-scala_2.10` entry (not released for Jackson 2.12 or later)

2.11.3

- Add missing version for `jackson-datatype-eclipse-collections`

2.11 (26-Apr-2020)

No changes since 2.10

2.10

- Remove `Automatic-Module-Name`, to avoid collision with Moditect-added `module-info`
