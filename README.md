# rkt-iozone
![](https://github.com/IvanCherepov/rkt-iozone/blob/master/assets/read.gif)

 [rkt](https://coreos.com/rkt) [iOzone](http://www.iozone.org) container, built using [acbuild](https://github.com/appc/acbuild)

## Rationale
 iOzone is a filesystem benchmark tool. The goal of this mini-project is to create a signed and verified acbuild container that can be run it by rkt. System administrator can easily run rkt-iozone  on any machineby using just one command. 

## Installation

### Dependencies
rkt-iozone requires rkt(v1.1.0 & up) and acbuild.

### Build
1. Grab the source code for `rkt-iozone` by `git clone`ing the source repository:
   ```
   cd ~
   git clone https://github.com/ivancherepov/rkt-iozone
   ```

2. Run the `build-iozone` script from the root source repository directory:
   ```
   ./build-iozone
   ```

3. A `iozone-ubuntu.aci` container will be created that contains the `rkt-iozone`. Run it:
   ```
   sudo ./rkt run --interactive iozone-ubuntu.aci
   ```
## Notes


## Compare EC2 and GCE

 
