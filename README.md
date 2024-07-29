<div id="System UX-logo" align="center">
    <br />
    <img src="https://github.com/angelivan-spartan/UX/blob/master/res/logo/SystemUX.png" alt="System UX Logo" width="210"/>
    <h1>System UX</h1>
    <h3>Unified Operating System</h3>
    <br>
    <h4>“UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity.”</h4>
    <h4> ~ Dennis Ritchie</h4>
    <br>
</div>

System UX is an operating system developed to be performant, secure, and scalable across diverse workloads. Initially focused on embedded systems and servers, it has evolved into a multifaceted platform that meets a wide range of computing needs.

The philosophy of System UX emphasizes simplicity and modularity, using a compact set of packages that meet universal requirements while adhering to UNIX principles. This design facilitates effortless customization, enabling users to layer additional packages on a common base to tailor the system to their specific needs. This flexibility is supported by a streamlined build system and a cross-platform update mechanism.

Whether deployed as an embedded system, container, hypervisor, or edge server, System UX represents a fusion of simplicity and adaptability, designed to operate across a variety of devices regardless of architecture and kernel version.



## Common Locations:

| Description | Directory |
| --- | --- |
| Base System and update system for all platforms | "base/" |
| Update Scripts for specific platforms | "scripts/" |
| BAKE Scripts and specific files for system build | "special/" |
| Graphical Resources | "res/" |


## Currently supported plattforms:

| Description | Code Name | Status |
| --- | --- | --- |
| PC x86/x64 11| "d11" | Current |
| PC x86/x64 12| "d12" | Current |
| WSL2 (Windows Subsystem for Linux) x64 12| "dwsl" | Current |
| H616 Allwinner CPU arm64 11| "oz2" | Current |
| H618 Allwinner CPU arm64 12| "oz3" | Current |
| Broadcom CPU arm32 11| "rp32" | Deprecated-Maintained |
| v-UX Hypervisor x86/x64 12| "p8" | Current |
| Container instance x86/x64 12| "ct" | Current |


# License
System-UX is released under the [MIT License](https://github.com/angelivan-spartan/UX/blob/master/LICENSE).

----
# Conduct

System-UX project adopt the [Open Source Code of Conduct](https://github.com/angelivan-spartan/UX/blob/master/CODE_OF_CONDUCT.md).

