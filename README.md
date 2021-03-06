# rkt-iozone
![](https://github.com/IvanCherepov/rkt-iozone/blob/master/assets/read.gif)

 [rkt](https://coreos.com/rkt) [iOzone](http://www.iozone.org) container, built using [acbuild](https://github.com/appc/acbuild)

## Rationale
 iOzone is a filesystem benchmark tool. The goal of this mini-project is to create a signed and verified acbuild container that can be run by rkt. A sysadmin can easily run rkt-iozone on any machine by issuing just one command. 

## Installation

### Dependencies
rkt-iozone requires rkt(v1.1.0 & up) and acbuild.

### Build
1.  Preparation (can be skipped if defaults work for you): modify running script `run-iozone.sh` accoring to your needs. Current options are "automatic mode", "optimized test" and "use your own arguments". Also, you can Use "-h" for help. 

2. Get the source code for `rkt-iozone`:
   ```
   git clone https://github.com/ivancherepov/rkt-iozone
   ```

3. Run the `build-iozone` script from the root source repository directory:
   ```
   sh build-iozone.sh
   ```

4. [Add keys](https://github.com/coreos/rkt/blob/master/Documentation/signing-and-verification-guide.md#example-usage). 


	a) Make an armored detached signature:
			```
			gpg --armor --output iozone-ubuntu.aci.asc --detach-sign iozone-ubuntu.aci
			```
	
	b) Verify:
   			```
   			gpg --verify iozone-ubuntu.aci.asc  iozone-ubuntu.aci
			```

	c) Capture the public key fingerprint:
   			```
   			gpg --with-fingerprint ./pubkeys.gpg
			```

	d) Remove white spaces and convert to lowercase:
   			```
   			echo "your_pulibc_key_fingerprint" | \ tr -d "[:space:]" | tr '[:upper:]' '[:lower:]'
   			```

   	e) Trust the key for the ivanc/iozone-ubuntuprefix
   			```
   			mkdir -p /etc/rkt/trustedkeys/prefix.d/ivanc/iozone-ubuntu
			mv ./pubkeys.gpg  /etc/rkt/trustedkeys/prefix.d/ivanc/iozone-ubuntu/[result of step d]
   			```

5. Make an armored detached signature:
   ```
   gpg --armor --output iozone-ubuntu.aci.asc --detach-sign iozone-ubuntu.aci
   ```

6. `iozone-ubuntu.aci` container will be created that contains the `rkt-iozone`. Run it:
   ```
   rkt run --interactive iozone-ubuntu.aci
   ```

## Notes
1. Choosing the base platform. The best practice is to choose tightly controlled and extremely minimal image. 

2. Using the latest version of iOzone. We get the latest tarball by curling iOzone website. This is an improvement over the first version where the version was hard-coded.

3. If you decide to skip step 4, you need to add `--insecure-options=image` to your `rkt run` command.

4. TO DO: Benchmark EC2 and GCE.


 
