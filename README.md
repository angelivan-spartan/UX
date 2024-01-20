<div id="System UX-logo" align="center">
    <br />
    <img src="https://github.com/angelivan-spartan/UX/blob/master/res/logo/SystemUX.png" alt="System UX Logo" width="210"/>
    <h1>System UX</h1>
    <h3>Unified Operating System</h3>
    <br>
    <h4>“UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity.” ~ Dennis Ritchie</h4>
    <br>
</div>

System UX stands as an internal Linux distribution meticulously crafted by Mier Engineering. Rooted in the Unix philosophy, it was originally designed with a focus on embedded systems and servers, evolving into a versatile platform that caters to a myriad of computing needs.

Engineered to deliver a consistent and reliable operating system, System UX is designed to stay current with updates, providing a unified platform. This initiative aligns with Mier Engineering's commitment to open source and contributing to the broader technology community.

The philosophy of System UX centers around a compact set of packages that meet universal requirements. This design allows for easy customization, enabling users to layer additional packages on top of the common base, tailoring the system to specific workloads. This flexibility is facilitated by a streamlined build system.

Whether deployed as a container, a hypervisor, or a virtual machine host, System UX minimizes disk and memory usage. Its lightweight nature results in faster boot times and a reduced attack surface. By focusing on essential features needed for internal operations, System UX optimizes resource consumption, loading fewer services and reducing potential attack vectors. This emphasis on efficiency and adaptability, in line with the Unix philosophy, reflects our ongoing commitment to excellence in technology within Mier Engineering.



## Common Locations:

| Description | Directory |
| --- | --- |
| Base System and update system for all platforms | "base/" |
| Update Scripts for specific platforms | "scripts/" |
| BAKE Scripts and specific files for system build | "special/" |
| Graphical Resources | "res/" |


## Currently supported plattforms:

| Description | Code Name |
| --- | --- |
| Debian based x86/x64 | "d11" |
| Debian based Windows Subsystem for Linux x64 | "dwsl" |
| Debian based Allwinner H616 arm64 | "oz2" |
| Debian based Broadcom arm32 | "rp32" |
| Debian based x86/x64 v-UX Hypervisor | "p8" |
| Debian based x86/x64 Container instance | "ct" |


# License
System-UX is released under the [MIT License](https://github.com/angelivan-spartan/UX/blob/master/LICENSE).

----
# Conduct

System-UX project adopt the [Open Source Code of Conduct](https://github.com/angelivan-spartan/UX/blob/master/CODE_OF_CONDUCT.md).

