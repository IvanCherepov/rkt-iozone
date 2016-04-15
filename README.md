# rkt-iozone
![](https://github.com/IvanCherepov/rkt-iozone/blob/master/assets/read.gif)

 [rkt](https://coreos.com/rkt) [iOzone](http://www.iozone.org) container, built using [acbuild](https://github.com/appc/acbuild)

## Rationale
 iOzone is a filesystem benchmark tool. The goal of this mini-project is to create a signed and verified acbuild container that can be run it by rkt. System administrator can easily run rkt-iozone on any machine by issuing just one command. 

## Installation

### Dependencies
rkt-iozone requires rkt(v1.1.0 & up) and acbuild.

### Prior the build
Modify running script run-iozone.sh according to your needs. Current options are "automatic mode", "optimized test" and "use your own argumensts". You can use -h for help. 

### Build
1. Get the source code for `rkt-iozone` by `git clone`-ing the source repository:
   ```
   git clone https://github.com/ivancherepov/rkt-iozone
   ```

2. Run the `build-iozone` script from the root source repository directory:
   ```
   sh build-iozone.sh
   ```

3. Make an armored detached signature:
   ```
   gpg --armor --output iozone-ubuntu.aci.asc --detach-sign iozone-ubuntu.aci
   ```

4. Make an armored detached signature:
   ```
   gpg --armor --output iozone-ubuntu.aci.asc --detach-sign iozone-ubuntu.aci

5. `iozone-ubuntu.aci` container will be created that contains the `rkt-iozone`. Run it:
   ```
   rkt run --interactive iozone-ubuntu.aci
   ```
## Notes

Choosing of base platform

How to sign, verify and trust the key (coreos requires armored key!)

Using the latest verison of iOzone

## Compare EC2 and GCE

 
