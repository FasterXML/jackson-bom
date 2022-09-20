# Security Policy

Last Updated: 2022-09-20

## Reporting a Vulnerability

In unlikely event of finding a security vulnerability directly relating to `jackson-bom`
package -- unlikely, as there is no code in this package, just dependencies --
the recommended mechanism for reporting possible security vulnerabilities follows
so-called "Coordinated Disclosure Plan" (see [definition of DCP](https://vuls.cert.org/confluence/display/Wiki/Coordinated+Vulnerability+Disclosure+Guidance)
for general idea). The first step is to file a [Tidelift security contact](https://tidelift.com/security):
Tidelift will route all reports via their system to maintainers of relevant package(s), and start the
process that will evaluate concern and issue possible fixes, send update notices and so on.
Note that you do not need to be a Tidelift subscriber to file a security contact.

## Verifying Artifact signatures

(for more in-depth explanation, see [Apache Release Signing](https://infra.apache.org/release-signing#keys-policy) document)

To verify that any given Jackson artifact has been signed with a valid key, have a look at `KEYS` file of the main Jackson repo:

https://github.com/FasterXML/jackson/blob/master/KEYS

which lists all known valid keys in use.
